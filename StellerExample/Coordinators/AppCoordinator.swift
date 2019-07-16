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
        let vc = FeedViewController(stories: Array(repeating: "mockStory", count: 20))
        router.presentAsRoot(vc)
    }
}
