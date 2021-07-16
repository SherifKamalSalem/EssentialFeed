//
//  FeedPresenter.swift
//  EssentialFeediOS
//
//  Created by sherif kamal on 13/07/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
 
import Foundation
import EssentialFeed

protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView {
    func display(viewModel: FeedViewModel)
}

final class FeedPresenter {
    private let view: FeedView
    private let loadingView: FeedLoadingView
    
    init(view: FeedView, loadingView: FeedLoadingView) {
        self.view = view
        self.loadingView = loadingView
    }
    
    static var title: String {
        return NSLocalizedString("FEED_VIEW_TITLE",
                                 tableName: "Feed",
                                 bundle: Bundle(for: FeedPresenter.self),
                                 comment: "Title for the feed view")
    }
    
    func didStartLoadingFeed() {
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    func didFinishLoadingFeed(with feed: [FeedImage]) {
        view.display(viewModel: FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    func didFinishLoading(with error: Error) {
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
}
