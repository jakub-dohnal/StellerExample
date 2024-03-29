//
//  FeedPresenterImp.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

class FeedPresenterImp: FeedPresenter {

    let interactor: FeedInteractor

    weak var delegate: FeedPresenterDelegate?
    weak var routerDelegate: FeedPresenterRouterDelegate?

    var stories: [StoryPresenter] = []

    init(interactor: FeedInteractor) {
        self.interactor = interactor
    }

    func reload() {
        interactor.getStories { [weak self] result in
            switch result {
            case .value(let response):
                self?.handleSuccessLoadStories(response: response)
            case .error(let error):
                self?.handleFailureLoadStories(error: error)
            }
        }
    }

    func present(storyAt index: Int) {
        routerDelegate?.present(storyAt: index, from: stories)
    }
}

private extension FeedPresenterImp {
    func handleSuccessLoadStories(response: StoriesResponse) {
        let stories = response.stories.compactMap { story -> StoryPresenter? in
            guard
                let url = URL(string: story.coverSrc),
                let ratio = story.aspectRatio.ratio
                else { return nil }
            let dispatcher = NetworkDispatcherImp()
            let interactor = StoryInteractorImp(coverURL: url, dispatcher: dispatcher)
            return StoryPresenterImp(ratio: ratio, interactor: interactor)
        }
        self.stories = stories
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.feedDidLoad()
        }
    }

    func handleFailureLoadStories(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.feedLoadFailed(errorMessage: error.localizedDescription)
        }
    }
}
