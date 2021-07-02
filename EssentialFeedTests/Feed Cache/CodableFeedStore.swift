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
}
