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
    private var presentedViewController: UIViewController?

    init(window: UIWindow) {
        self.window = window
        self.presentedViewController = window.rootViewController
    }

    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        presentedViewController?.present(viewController, animated: animated, completion: completion)
        presentedViewController = viewController
    }
}
