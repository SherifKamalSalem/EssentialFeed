//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by sherif kamal on 26/06/2021.
//

import XCTest

class FeedStore {
    var deleteCacheCallCount = 0
}

class LocalFeedLoader {
    
    init(store: FeedStore) {
        
    }
}

class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        let _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deleteCacheCallCount, 0)
    }

}
