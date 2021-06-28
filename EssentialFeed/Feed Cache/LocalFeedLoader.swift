//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by sherif kamal on 28/06/2021.
//

import Foundation

public final class LocalFeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date
    
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    private func save(_ items: [FeedItem], completion: @escaping (Error?) -> Void) {
        store.deleteCachedFeed { [weak self] error in
            guard let self = self else { return }
            if let cacheDeletionrror = error {
                completion(cacheDeletionrror)
            } else {
                self.cache(items, with: completion)
            }
        }
    }
    
    //MARK: - Helper
    private func cache(_ items: [FeedItem], with completion: @escaping (Error?) -> Void) {
        self.store.insert(items, self.currentDate()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
}
