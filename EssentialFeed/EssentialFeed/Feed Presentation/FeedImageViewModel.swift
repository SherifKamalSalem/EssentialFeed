//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by sherif kamal on 07/08/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public struct FeedImageViewModel<Image> {
    public let description: String?
    public let location: String?
    public let image: Image?
    public let isLoading: Bool
    public let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}
