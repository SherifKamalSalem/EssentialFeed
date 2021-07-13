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
    var view: FeedView?
    var loadingView: FeedLoadingView?
    
    func didStartLoadingFeed() {
        loadingView?.display(viewModel: FeedLoadingViewModel(isLoading: true))
    }
    
    func didFinishLoadingFeed(with feed: [FeedImage]) {
        view?.display(viewModel: FeedViewModel(feed: feed))
        loadingView?.display(viewModel: FeedLoadingViewModel(isLoading: false))
    }
    
    func didFinishLoading(with error: Error) {
        loadingView?.display(viewModel: FeedLoadingViewModel(isLoading: false))
    }
}
