//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by sherif kamal on 14/07/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}
