//
//  FeedViewControllerTests.swift
//  EssentialFeediOSTests
//
//  Created by sherif kamal on 09/07/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest

final class FeedViewController {
    private let loader: FeedViewControllerTests.LoaderSpy
    
    init(loader: FeedViewControllerTests.LoaderSpy) {
        self.loader = loader
    }
}

final class FeedViewControllerTests: XCTestCase {

    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCallCount, 0)
    }

    class LoaderSpy {
        private(set) var loadCallCount = 0
    }
}
