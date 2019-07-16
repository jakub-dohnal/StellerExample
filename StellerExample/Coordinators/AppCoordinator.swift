//
//  AppCoordinator.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 16/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

final class AppCoordinator: Coordinator {
    let router: Router

    init(router: Router) {
        self.router = router
    }

    func start() {
        showFeed()
    }
}

private extension AppCoordinator {
    func showFeed() {
        let storyViewModel = StoryViewModel(
            coverURL: URL(
                string: "https://d2rbodpj0xodc.cloudfront.net/stories/1593487551547574230/2b9ad3b0-f95e-4584-b556-66b9942a9cf5-640x960.jpeg"
            )!
        )
        let stories = Array(repeating: storyViewModel, count: 2000)
        let vc = FeedViewController(stories: stories)
        router.presentAsRoot(vc)
    }
}
