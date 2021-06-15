//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by sherif kamal on 12/06/2021.
//

import XCTest
import EssentialFeed

protocol HTTPSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTPSessionTask
}

protocol HTTPSessionTask {
    func resume()
}

class URLSessionHTTPClientTests: XCTestCase {
    
    private struct UnexpectedValuesRepresentation: Error {  }
    
    private class URLSessionHTTPClient {
        private let session: URLSession
        
        init(session: URLSession = .shared) {
            self.session = session
        }
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            session.dataTask(with: url) { _, _, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(UnexpectedValuesRepresentation()))
                }
            }.resume()
        }
    }
    
    override class func setUp() {
        super.setUp()
        URLProtocolStub.startInterceptingRequests()
        
    }
    
    override class func tearDown() {
        super.tearDown()
        URLProtocolStub.stopInterceptingRequests()
    }
    
    func test_getFromURL_performGETRequestWithURL() {
        let exp = expectation(description: "Wait for request")
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, self.makeAnyURL())
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
        }
        URLSessionHTTPClient().get(from: makeAnyURL()) { _ in }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getFromURL_failsOnRequestError() {
        let requestedError = makeAnyNSError()
        let receivedError = resultErrorFor(data: nil, response: nil, error: requestedError)
        XCTAssertEqual((receivedError as NSError?)?.domain, requestedError.domain)
        XCTAssertEqual((receivedError as NSError?)?.code, requestedError.code)
    }
    
    func test_getFromURL_failsOnAllInvalidRepresentationCases() {
        let nonHTTPURLResponse = makeNonHTTPURLResponse()
        let anyHTTPURLResponse = makeAnyHTTPURLResponse()
        let anyError = makeAnyNSError()
        XCTAssertNotNil(resultErrorFor(data: nil, response: nil, error: nil))
        XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse, error: nil))
        XCTAssertNotNil(resultErrorFor(data: nil, response: anyHTTPURLResponse, error: nil))
        XCTAssertNotNil(resultErrorFor(data: makeAnyData(), response: nil, error: nil))
        XCTAssertNotNil(resultErrorFor(data: nil, response: nil, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: nil, response: anyHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: makeAnyData(), response: nonHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: makeAnyData(), response: anyHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: makeAnyData(), response: nonHTTPURLResponse, error: nil))
    }
    
    //MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> URLSessionHTTPClient {
        let sut = URLSessionHTTPClient()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func resultErrorFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) -> Error? {
        let sut = makeSUT(file: file, line: line)
        URLProtocolStub.stub(data: data, response: response, error: error)
        let exp = expectation(description: "Wait for completion")
        var receivedError: Error?
        sut.get(from: makeAnyURL()) { result in
            switch result {
            case let .failure(error):
                receivedError = error
            default:
                XCTFail("Expected failure, get \(result) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        return receivedError
    }
    
    private func makeAnyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }
    
    private func makeAnyNSError() -> NSError {
        return NSError(domain: "any error", code: 1)
    }
    
    private func makeAnyData() -> Data {
        return Data("any bytes".utf8)
    }
    
    private func makeAnyHTTPURLResponse() -> HTTPURLResponse {
        return HTTPURLResponse(url: makeAnyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
    
    private func makeNonHTTPURLResponse() -> URLResponse {
        return URLResponse(url: makeAnyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    }
    
    private class URLProtocolStub: URLProtocol {
        private static var stub: Stub?
        private static var requestObserver: ((URLRequest) -> Void)?
        
        private struct Stub {
            let response: URLResponse?
            let data: Data?
            let error: Error?
        }
        
        static func stub(data: Data?, response: URLResponse?, error: Error? = nil) {
            stub = Stub(response: nil, data: nil, error: error)
        }
        
        static func observeRequests(observer: @escaping (URLRequest) -> Void) {
            requestObserver = observer
        }
        
        static func startInterceptingRequests() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        
        static func stopInterceptingRequests() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            stub = nil
            requestObserver = nil
        }
        
        override class func canInit(with request: URLRequest) -> Bool {
            requestObserver?(request)
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {
            if let error = URLProtocolStub.stub?.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            
            if let data = URLProtocolStub.stub?.data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            if let response = URLProtocolStub.stub?.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        }
        
        override func stopLoading() {}
    }
}
