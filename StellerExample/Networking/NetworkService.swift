//
//  NetworkService.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

enum Result<Value> {
    case value(Value)
    case error(Error)
}

protocol NetworkService {
    func fetch<Value>(request: Request, completion: @escaping (Result<Value>) -> Void) where Value: Codable
}
