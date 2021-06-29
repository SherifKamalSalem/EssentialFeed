//
//  RemoteFeedImage.swift
//  EssentialFeed
//
//  Created by sherif kamal on 29/06/2021.
//

import Foundation

struct RemoteFeedImage: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let url: URL
}
