//
//  FeedPresenter.swift
//  EssentialFeediOS
//
//  Created by sherif kamal on 13/07/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
 
import Foundation
import EssentialFeed

struct FeedLoadingViewModel {
    let isLoading: Bool
}

protocol FeedLoadingView {
    func display(viewModel: FeedLoadingViewModel)
}

struct FeedViewModel {
    let feed: [FeedImage]
}

protocol FeedView {
    func display(viewModel: FeedViewModel)
}

final class FeedPresenter {
    typealias Observer<T> = (T) -> Void
    private let feedLoader: FeedLoader
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    var view: FeedView?
    var loadingView: FeedLoadingView?
    
    func loadFeed() {
        loadingView?.display(viewModel: FeedLoadingViewModel(isLoading: true))
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.view?.display(viewModel: FeedViewModel(feed: feed))
            }
            self?.loadingView?.display(viewModel: FeedLoadingViewModel(isLoading: false))
        }
    }
}
