//
//  LoadImageDataLoaderTask.swift
//  EssentialFeed
//
//  Created by sherif kamal on 22/08/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

class LoadImageDataTask: FeedImageDataLoaderTask {
    private var completion: ((FeedImageDataLoader.Result) -> Void)?
    
    public init(_ completion: @escaping (FeedImageDataLoader.Result) -> Void) {
        self.completion = completion
    }
    
    func complete(with result: FeedImageDataLoader.Result) {
        completion?(result)
    }
    
    func cancel() {
        preventFurtherCompletions()
    }
    
    private func preventFurtherCompletions() {
        completion = nil
    }
}
