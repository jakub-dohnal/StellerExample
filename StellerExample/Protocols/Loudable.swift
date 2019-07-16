//
//  Loudable.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 16/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import UIKit

protocol Loudable: class {
    static var nibName: String { get }
}

extension Loudable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
