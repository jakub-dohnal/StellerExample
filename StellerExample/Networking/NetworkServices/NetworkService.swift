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
    var networkDispatcher: NetworkDispatcher { get }
}

extension NetworkService {
    
    func execute<Value>(request: Request, completion: @escaping (Result<Value>) -> Void) where Value: Codable {
        let request = FeedRequest()
        networkDispatcher.execute(request: request, success: { (data, _) in
            // TODO: handle `try` by `do
            let value = try! JSONDecoder().decode(Value.self, from: data)
            completion(Result.value(value))
        }) { (error, _) in
            completion(Result.error(error))
        }
    }
}
