//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by sherif kamal on 28/06/2021.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = ((Error?) -> Void)
    typealias InsertionCompletion = ((Error?) -> Void)

    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    func insert(_ items: [LocalFeedItem], _ timestamp: Date, completion: @escaping InsertionCompletion)
}
