//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by sherif kamal on 27/05/2021.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
