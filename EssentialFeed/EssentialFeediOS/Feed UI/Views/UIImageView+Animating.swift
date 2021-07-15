//
//  UIImageView+Animating.swift
//  EssentialFeediOS
//
//  Created by sherif kamal on 15/07/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageAnimated(_ newImage: UIImage?) {
        image = newImage
        guard newImage != nil else { return }
        alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
}
