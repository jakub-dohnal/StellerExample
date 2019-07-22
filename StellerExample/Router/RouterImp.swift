//
//  RouterImp.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 16/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import UIKit

final class RouterImp: Router {

    private let window: UIWindow
    private var viewControllerStack: [UIViewController]

    init(window: UIWindow) {
        self.window = window

        if let viewController = window.rootViewController {
            self.viewControllerStack = [viewController]
        } else {
            self.viewControllerStack = []
        }
    }

    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewControllerStack.last?.present(viewController, animated: animated, completion: completion)
        viewControllerStack.append(viewController)
    }

    func presentAsRoot(_ viewController: UIViewController) {
        window.rootViewController = viewController
        viewControllerStack = [viewController]
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        viewControllerStack.last?.dismiss(animated: animated, completion: completion)
        _ = viewControllerStack.popLast()
    }
}
