//
//  String.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

extension String {
    var ratio: Double? {
        let rationValues = self.split(separator: ":").compactMap { Double($0) }.filter { $0 != 0 }
        if rationValues.count == 1 {
            return rationValues.first
        } else if rationValues.count >= 2 {
            return rationValues[0] / rationValues[1]
        }
        return nil
    }
}
