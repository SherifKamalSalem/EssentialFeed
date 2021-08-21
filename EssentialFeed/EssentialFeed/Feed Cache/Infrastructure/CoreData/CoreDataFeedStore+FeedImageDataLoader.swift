//
//  CoreDataFeedStore+FeedImageDataLoader.swift
//  EssentialFeed
//
//  Created by sherif kamal on 21/08/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

extension CoreDataFeedStore: FeedImageDataStore {
    
    public func insert(_ data: Data, for url: URL, completion: @escaping (FeedImageDataStore.InsertionResult) -> Void) {
        perform { context in
            guard let image = try? ManagedFeedImage.first(with: url, in: context) else { return }
            
            image.data = data
            try? context.save()
        }
    }
    
    public func retrieve(dataForURL url: URL, completion: @escaping (FeedImageDataStore.RetrievalResult) -> Void) {
        perform { context in
            completion(FeedImageDataStore.RetrievalResult {
                return try ManagedFeedImage.first(with: url, in: context)?.data
            })
        }
    }
}
