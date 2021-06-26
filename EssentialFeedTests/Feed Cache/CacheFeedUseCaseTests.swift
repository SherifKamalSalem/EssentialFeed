//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by sherif kamal on 26/06/2021.
//

import XCTest
import EssentialFeed

class FeedStore {
    var deleteCacheCallCount = 0
    
    func deleteCachedFeed() {
        deleteCacheCallCount += 1
    }
}

class LocalFeedLoader {
    private let store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }
    
    func save(_ items: [FeedItem]) {
        store.deleteCachedFeed()
    }
}

class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation() {
        let (_, store) = makeSUT()
        XCTAssertEqual(store.deleteCacheCallCount, 0)
    }
    
    func test_save_requestCacheDeletion() {
        let (sut, store) = makeSUT()
        let items = [uniqueItem(), uniqueItem()]
        sut.save(items)
        
        XCTAssertEqual(store.deleteCacheCallCount, 1)
    }

    //MARK: - Helpers
    
    private func makeSUT() -> (sut: LocalFeedLoader, store: FeedStore) {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)
        return (sut: sut, store: store)
    }
    
    private func uniqueItem() -> FeedItem {
        return FeedItem(id: UUID(), description: "any", location: "any", imageURL: anyURL())
    }
    
    private func anyURL() -> URL {
        return URL(string: "https//any-url.com")!
    }
}
