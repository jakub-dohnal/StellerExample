//
//  Reusable.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 16/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var identifier: String { get }
    static var nibName: String { get }
}

extension Reusable where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }

    static var nibName: String {
        return String(describing: self)
    }
}
