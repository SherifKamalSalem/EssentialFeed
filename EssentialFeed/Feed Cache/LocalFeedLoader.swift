//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by sherif kamal on 28/06/2021.
//

import Foundation

private final class FeedCachePolicy {
    private init() { }
    
    static private let calendar = Calendar(identifier: .gregorian)
    
    static private var maxCacheAgeInNumbers: Int {
        return 7
    }
    
    static func validate(_ timestamp: Date, against date: Date) -> Bool {
        guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCacheAgeInNumbers, to: timestamp) else { return false }
        return date < maxCacheAge
    }
}

public final class LocalFeedLoader {
    private let currentDate: () -> Date
    private let store: FeedStore
    
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
} 

extension LocalFeedLoader {
    public typealias SaveResult = Error?
    
    public func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void) {
        store.deleteCachedFeed { [weak self] error in
            guard let self = self else { return }
            if let cacheDeletionrror = error {
                completion(cacheDeletionrror)
            } else {
                self.cache(feed, with: completion)
            }
        }
    }
    
    //MARK: - Helper
    private func cache(_ feed: [FeedImage], with completion: @escaping (SaveResult) -> Void) {
        self.store.insert(feed.toLocal(), self.currentDate()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
}
    
extension LocalFeedLoader: FeedLoader {
    public typealias LoadResult = LoadFeedResult
     
    public func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .found(feed, timestamp) where FeedCachePolicy.validate(timestamp, against: self.currentDate()):
                completion(.success(feed.toModels()))
            case .found, .empty:
                completion(.success([]))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    public func validateCache() {
        store.retrieve { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.store.deleteCachedFeed { _ in }
            case let .found(_, timestamp) where !FeedCachePolicy.validate(timestamp, against: self.currentDate()):
                self.store.deleteCachedFeed { _ in }
            case .empty, .found: break
            }
        }
    }
}

private extension Array where Element == FeedImage {
    func toLocal() -> [LocalFeedImage] {
        return map { LocalFeedImage(
            id: $0.id, description: $0.description,
            location: $0.location, url: $0.url) }
    }
}

private extension Array where Element == LocalFeedImage {
    func toModels() -> [FeedImage] {
        return map { FeedImage(
            id: $0.id, description: $0.description,
            location: $0.location, url: $0.url) }
    }
}
