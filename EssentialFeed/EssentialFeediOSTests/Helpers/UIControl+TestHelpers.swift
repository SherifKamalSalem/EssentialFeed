//
//  UIControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by sherif kamal on 11/07/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
