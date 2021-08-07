//
//  FeedPresenter.swift
//  EssentialFeed
//
//  Created by sherif kamal on 07/08/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public struct FeedLoadingViewModel {
    public let isLoading: Bool
}

public struct FeedViewModel {
    public let feed: [FeedImage]
}

public protocol FeedView {
    func display(viewModel: FeedViewModel)
}

public protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

public final class FeedPresenter {
    private let view: FeedView
    private let errorView: FeedErrorView
    private let loadingView: FeedLoadingView

    public init(view: FeedView, loadingView: FeedLoadingView, errorView: FeedErrorView) {
        self.view = view
        self.errorView = errorView
        self.loadingView = loadingView
    }
    
    public static var title: String {
        
        return NSLocalizedString("FEED_VIEW_TITLE",
                                 tableName: "Feed",
                                 bundle: Bundle(for: FeedPresenter.self),
                                 comment: "Title for the feed view")
    }
    
    public var feedLoadError: String {
        return NSLocalizedString("FEED_VIEW_CONNECTION_ERROR",
                                 tableName: "Feed",
                                 bundle: Bundle(for: FeedPresenter.self),
                                 comment: "Error message displayed when we can't load the image feed from the server")
    }
    
    public func didStartLoadingFeed() {
        errorView.display(.noError)
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoadingFeed(with feed: [FeedImage]) {
        view.display(viewModel: FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    public func didFinishLoading(with error: Error) {
        errorView.display(.error(message: feedLoadError))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
}

public protocol FeedErrorView {
    func display(_ viewModel: FeedErrorViewModel)
}

public struct FeedErrorViewModel {
    public let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
