//
//  NetworkDispatcherImp.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 21/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation


class NetworkDispatcherImp: NetworkDispatcher {
    var timeoutInterval: TimeInterval = 10

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
