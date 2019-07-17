//
//  NetworkDispatcher.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

class NetworkDispatcher {

    typealias Failure = (Error, HTTPURLResponse?) -> ()
    typealias Success = (Data, HTTPURLResponse?) -> ()

    let timeoutInterval: TimeInterval = 10

    @discardableResult
    func execute(request: Request, success: @escaping Success, failure: @escaping Failure) -> URLSessionDataTask  {
        let urlRequest = URLRequest(url: request.url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeoutInterval)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let httpResponse = response as? HTTPURLResponse

            if let error = error {
                failure(error, httpResponse)
            } else {
                success(data ?? Data(), httpResponse)
            }
        }

        dataTask.resume()
        return dataTask
    }
}
