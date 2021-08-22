//
//  RemoteFeedImageDataLoader.swift
//  EssentialFeedTests
//
//  Created by sherif kamal on 19/08/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public class RemoteFeedImageDataLoader: FeedImageDataLoader {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case invalidData
        case connectivity
    }
    
    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        let task = HTTPClientTaskWrapper(completion)
        task.wrapped = client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            task.complete(with: result
                            .mapError { _ in Error.connectivity }
                            .flatMap { (data, response) in
                                let isValidResponse = response.statusCode == 200 && !data.isEmpty
                                return isValidResponse ? .success(data) : .failure(Error.invalidData)
                            })
        }
        return task
    }
}
