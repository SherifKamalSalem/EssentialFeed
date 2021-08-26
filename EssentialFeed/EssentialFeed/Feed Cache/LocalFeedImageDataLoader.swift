//
//  LocalFeedImageDataLoader.swift
//  EssentialFeed
//
//  Created by sherif kamal on 20/08/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public final class LocalFeedImageDataLoader: FeedImageDataLoader {
    public typealias LoadResult = FeedImageDataLoader.Result

    public enum SaveError: Error {
        case failed
    }
    
    public enum LoadError: Swift.Error {
        case failed
        case notFound
    }
    
    private let store: FeedImageDataStore
    
    public init(store: FeedImageDataStore) {
        self.store = store
    }
    
    public func loadImageData(from url: URL, completion: @escaping (LoadResult) -> Void) -> FeedImageDataLoaderTask {
        let task = LoadImageDataTask(completion)
        store.retrieve(dataForURL: url) { [weak self] result in
            guard self != nil else { return }
            task.complete(with: result
                            .mapError { _ in LoadError.failed }
                            .flatMap { data in
                                data.map { .success($0) } ?? .failure(LoadError.notFound)
                            })
        }
        return task
    }
}

extension LocalFeedImageDataLoader {
    public typealias SaveResult = Result<Void, Swift.Error>
    
    public func save(_ data: Data, for url: URL, completion: @escaping (SaveResult) -> Void) {
        store.insert(data, for: url) { [weak self] result in
            guard self != nil else { return }
            completion(result.mapError { _ in SaveError.failed }
            )
        }
    }
}
