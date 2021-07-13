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
        let presenter = FeedPresenter(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(presenter: presenter)
        let feedController = FeedViewController(refreshController: refreshController)
        presenter.loadingView = WeakRefVirtualProxy<FeedRefreshViewController>(refreshController)
        presenter.view = FeedImageAdapter(controller: feedController, imageLoader: imageLoader)
        return feedController
    }
}

private final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: FeedLoadingView where T: FeedLoadingView {
    func display(isLoading: Bool) {
        object?.display(isLoading: isLoading)
    }
}

private final class FeedImageAdapter: FeedView {
    private weak var controller: FeedViewController?
    private let imageLoader: FeedImageDataLoader
    
    init(controller: FeedViewController, imageLoader: FeedImageDataLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
        
    }
    
    func display(feed: [FeedImage]) {
        controller?.tableModel = feed.map { feed in
            FeedImageCellController(viewModel: FeedImageViewModel(model: feed, imageLoader: imageLoader, imageTransformer: UIImage.init))
        }
    }
}
