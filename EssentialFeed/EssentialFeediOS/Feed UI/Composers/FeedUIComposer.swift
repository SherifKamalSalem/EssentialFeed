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
        let feedViewModel = FeedViewModel(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(viewModel: feedViewModel)
        let feedController = FeedViewController(refreshController: refreshController)
        feedViewModel.onFeedLoad = adaptFeedToControllers(forwordingTo: feedController, loader: imageLoader)
        return feedController
    }
    
    private static func adaptFeedToControllers(forwordingTo controller: FeedViewController, loader: FeedImageDataLoader) -> ([FeedImage]) -> Void {
        return { [weak controller] feed in
            controller?.tableModel = feed.map { feed in
                FeedImageCellController(viewModel: FeedImageViewModel(model: feed, imageLoader: loader))
            }
        }
    }
}
