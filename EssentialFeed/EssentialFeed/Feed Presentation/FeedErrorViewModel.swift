//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by sherif kamal on 07/08/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public struct FeedErrorViewModel {
    public let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
