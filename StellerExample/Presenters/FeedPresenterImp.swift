//
//  FeedPresenterImp.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

class FeedPresenterImp: FeedPresenter {

    let service: FeedNetworkService

    weak var delegate: FeedPresenterDelegate?

    init(service: FeedNetworkService) {
        self.service = service
    }

    func reload() {
        service.getStories { [weak self] result in
            switch result {
            case .value(let response):
                self?.handleSuccessLoadStories(response: response)
            case .error(let error):
                self?.handleFailureLoadStories(error: error)
            }
        }
    }
}

private extension FeedPresenterImp {
    func handleSuccessLoadStories(response: StoriesResponse) {
        let storiesViewModels = response.stories.compactMap { story -> StoryViewModel? in
            guard
                let url = URL(string: story.coverSrc),
                let ratio = story.aspectRatio.ratio
                else { return nil }
            return StoryViewModel(coverURL: url, ratio: ratio)
        }
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.feedLoaded(stories: storiesViewModels)
        }
    }

    func handleFailureLoadStories(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.feedLoadFailed(errorMessage: error.localizedDescription)
        }
    }
}
