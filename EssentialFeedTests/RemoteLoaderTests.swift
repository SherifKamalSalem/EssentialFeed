//
//  RemoteLoaderTests.swift
//  EssentialFeedTests
//
//  Created by sherif kamal on 28/05/2021.
//

import XCTest

class RemoteFeedLoader {
    
}

class HTTPClient {
    var requestURL: URL?
}

class RemoteLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestURL)
    }
}
