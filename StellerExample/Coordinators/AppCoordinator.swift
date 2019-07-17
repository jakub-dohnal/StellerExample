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
        let networkDispatcher = NetworkDispatcher()
        let service = FeedService(networkDispatcher: networkDispatcher)
        let presenter = FeedPresenterImp(service: service)
        let vc = FeedViewController(presenter: presenter)
        router.presentAsRoot(vc)
    }
}
