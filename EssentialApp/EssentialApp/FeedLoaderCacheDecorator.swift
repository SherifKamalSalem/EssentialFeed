//
//  FeedLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by sherif kamal on 27/08/2021.
//

import Foundation
import EssentialFeed

public class FeedLoaderCacheDecorator: FeedLoader {
    private let decoratee: FeedLoader
    private let cache: FeedCache
    public init(decoratee: FeedLoader, cache: FeedCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            completion(result.map({ feed in
                self?.cache.saveIgnoreingResult(feed)
                return feed
            }))
        }
    }
}

private extension FeedCache {
    func saveIgnoreingResult(_ feed: [FeedImage]) {
        save(feed) { _ in }
    }
}
