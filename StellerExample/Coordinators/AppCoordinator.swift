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
        let networkService = NetworkService(networkDispatcher: networkDispatcher)
        let interactor = FeedInteractorImp(service: networkService)
        let presenter = FeedPresenterImp(interactor: interactor)
        let vc = FeedViewController(presenter: presenter)
        router.presentAsRoot(vc)
    }
}
