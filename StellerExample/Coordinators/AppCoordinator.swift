//
//  AppCoordinator.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 16/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

final class AppCoordinator: Coordinator {

    private let router: Router

    init(router: Router) {
        self.router = router
    }

    func start() {
        showFeed()
    }
}

private extension AppCoordinator {
    func showFeed() {
        let networkDispatcher = NetworkDispatcherImp()
        let networkService = NetworkServiceImp(networkDispatcher: networkDispatcher)
        let interactor = FeedInteractorImp(service: networkService)
        let presenter = FeedPresenterImp(interactor: interactor)
        let vc = FeedViewController(presenter: presenter)

        presenter.routerDelegate = self
        router.presentAsRoot(vc)
    }

    func showStory(storyAt index: Int, from stories: [StoryViewModel]) {
        let presenter = StoriesPresenterImp(selectedStory: index, stories: stories)
        let vc = StoriesViewController(presenter: presenter)
        presenter.routerDelegate = self

        router.present(vc, animated: true, completion: nil)
    }
}

extension AppCoordinator: FeedPresenterRouterDelegate {
    func present(storyAt index: Int, from stories: [StoryViewModel]) {
        showStory(storyAt: index, from: stories)
    }
}

extension AppCoordinator: StoriesRouterDelegate {
    func close() {
        router.dissmiss(animated: true, completion: nil)
    }
}
