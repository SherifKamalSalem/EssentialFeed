//
//  UIImage+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by sherif kamal on 11/07/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

private extension UIImage {
    static func make(withColor color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
