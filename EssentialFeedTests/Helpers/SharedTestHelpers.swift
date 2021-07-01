//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by sherif kamal on 01/07/2021.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "https//any-url.com")!
}
