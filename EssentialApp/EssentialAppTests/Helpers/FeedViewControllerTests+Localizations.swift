//
//  FeedViewControllerTests+Localizations.swift
//  EssentialFeediOSTests
//
//  Created by sherif kamal on 16/07/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import EssentialFeed
import UIKit
import XCTest

extension FeedUIIntegrationTests {
    func localized(_ key :String, file: StaticString = #file, line: UInt = #line) -> String {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table \(table)", file: file, line: line)
        }
        return value
    }
}
