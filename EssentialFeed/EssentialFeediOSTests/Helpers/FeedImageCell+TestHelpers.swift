//
//  FeedImageCell+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by sherif kamal on 11/07/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
import UIKit
import EssentialFeediOS

extension FeedImageCell {
    func simulateRetryAction() {
        feedImageRetryButton.simulate(event: .touchUpInside)
    }

    var isShowingLocation: Bool {
        return !locationContainer.isHidden
    }
    
    var isShowingImageLoadingIndicator: Bool {
        return feedImageContainer.isShimmering
    }

    var isShowingRetryAction: Bool {
        return !feedImageRetryButton.isHidden
    }

    var locationText: String? {
        return locationLabel.text
    }
    
    var descriptionText: String? {
        return descriptionLabel.text
    }
    
    var renderedImage: Data? {
        return feedImageView.image?.pngData()
    }
}
