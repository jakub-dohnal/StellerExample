//
//  NetworkServiceImp.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 21/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

struct NetworkServiceImp: NetworkService {
    let networkDispatcher: NetworkDispatcher

    func fetch<Value>(request: Request, completion: @escaping (Result<Value>) -> Void) where Value: Codable {
        let request = FeedRequest()
        networkDispatcher.execute(request: request, success: { (data, _) in
            do {
                let value = try JSONDecoder().decode(Value.self, from: data)
                completion(Result.value(value))
            } catch(let error) {
                completion(Result.error(error))
            }
        }) { (error, _) in
            completion(Result.error(error))
        }
    }
}
