//
//  XCTestMemoryLeakTrackingHelper.swift
//  EssentialFeedTests
//
//  Created by sherif kamal on 15/06/2021.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock {[weak instance] in
            XCTAssertNil(instance, "instance should be deallocated, Potential memory leak.", file: file, line: line)
        }
    }
}
