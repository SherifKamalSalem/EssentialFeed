//
//  RemoteFeedImage.swift
//  EssentialFeed
//
//  Created by sherif kamal on 29/06/2021.
//

import Foundation
internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}

