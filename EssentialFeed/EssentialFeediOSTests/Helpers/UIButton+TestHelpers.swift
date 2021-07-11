//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by sherif kamal on 11/07/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit

private extension UIButton {
    func simulateTap() {
        allTargets.forEach({ target in
            actions(forTarget: target,
                    forControlEvent: .touchUpInside)?
                .forEach { (target as NSObject).perform(Selector($0)) }
        })
    }
}
