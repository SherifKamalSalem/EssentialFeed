//
//  FeedCachePolicy.swift
//  EssentialFeed
//
//  Created by sherif kamal on 01/07/2021.
//

import Foundation

internal final class FeedCachePolicy {
    private init() { }
    
    static private let calendar = Calendar(identifier: .gregorian)
    
    static private var maxCacheAgeInNumbers: Int {
        return 7
    }
    
    static func validate(_ timestamp: Date, against date: Date) -> Bool {
        guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCacheAgeInNumbers, to: timestamp) else { return false }
        return date < maxCacheAge
    }
}
