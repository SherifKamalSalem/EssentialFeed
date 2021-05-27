//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by sherif kamal on 27/05/2021.
//

import Foundation

protocol FeedLoader {
    func load(completion: @escaping (Result<[FeedItem], Error>) -> Void)
}
