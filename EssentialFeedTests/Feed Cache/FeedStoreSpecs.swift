//
//  FeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by sherif kamal on 03/07/2021.
//

import Foundation

protocol FeedStoreSpecs {
    func test_retieve_deliversEmptyOnEmptyCache()
    func test_retieve_hasNoSideEffectsOnEmptyCache()
    func test_retieve_deliversFoundValueOnNonEmptyCache()
    func test_retieve_hasNoSideEffectsOnNonEmptyCache()
    func test_insert_overridesPreviouslyInsertedCacheValues()
    func test_delete_hasNoSideEffectsOnEmptyCache()
    func test_delete_emptiesPreviouslyInsertedCache()
    func test_storeSideEffects_runSerially()
}

protocol FailableRetrieveFeedStoreSpecs: FeedStoreSpecs {
    func test_retieve_deliversFailureONRetrievalError()
    func test_retieve_hasNoSideEffectsOnFailure()
}

protocol FailableInsertFeedStoreSpecs: FeedStoreSpecs {
    func test_insert_deliversErrorOnInsertionError()
    func test_insert_hasNoSideEffectsOnInsertionError()
}
 
protocol FailableDeleteFeedStoreSpecs: FeedStoreSpecs {
    func test_delete_deliversErrorOnDeletionError()
    func test_delete_hasNoSideEffectsOnDeletionError()
}

typealias FailableFeedStore = FailableRetrieveFeedStoreSpecs & FailableInsertFeedStoreSpecs & FailableDeleteFeedStoreSpecs
