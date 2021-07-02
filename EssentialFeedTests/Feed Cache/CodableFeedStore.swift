//
//  CodableFeedStore.swift
//  EssentialFeedTests
//
//  Created by sherif kamal on 02/07/2021.
//

import XCTest
import EssentialFeed

class CodableFeedStore {
    func retieve(completion: @escaping FeedStore.RetrievalCompletion) {
        completion(.empty)
    }
}
 
class CodableFeedStoreTests: XCTestCase {
    
    func test_retieve_deliversEmptyOnEmptyCache() {
        let sut = CodableFeedStore()
        let exp = expectation(description: "Wait for cache retrieval")
        sut.retieve { result in
            switch result {
            case .empty:
                break
            default:
                XCTFail("Expected empty result, got \(result) instead")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_retieve_hasNoSideEffectsOnEmptyCache() {
        let sut = CodableFeedStore()
        let exp = expectation(description: "Wait for cache retrieval")
        sut.retieve { firstResult in
            sut.retieve { secondResult in
                
                switch (firstResult, secondResult) {
                case (.empty, .empty):
                    break
                default:
                    XCTFail("Expected retieving twice from empty cache to deliver same empty result, got \(firstResult) and \(secondResult) instead")
                }
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}
