//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by sherif kamal on 12/07/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit
import EssentialFeed

public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let refreshController = FeedRefreshViewController(feedLoader: feedLoader)
        let feedController = FeedViewController(refreshController: refreshController)
        refreshController.onRefresh = { [weak feedController] feed in
            feedController?.tableModel = feed.map { feed in
                FeedImageCellController(model: feed, imageLoader: imageLoader)
            }
        }
        return feedController
    }
}
