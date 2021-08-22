//
//  HTTPClientTaskWrapper.swift
//  EssentialFeed
//
//  Created by sherif kamal on 22/08/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public final class HTTPClientTaskWrapper: FeedImageDataLoaderTask {
    private var completion: ((FeedImageDataLoader.Result) -> Void)?
    
    var wrapped: HTTPClientTask?
    
    init(_ completion: @escaping (FeedImageDataLoader.Result) -> Void) {
        self.completion = completion
    }
    
    func complete(with result: FeedImageDataLoader.Result) {
        completion?(result)
    }
    
    public func cancel() {
        preventFurtherCompletions()
        wrapped?.cancel()
    }
    
    private func preventFurtherCompletions() {
        completion = nil
    }
}
