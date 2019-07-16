//
//  Router.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 16/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import UIKit

protocol Router {
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
}
