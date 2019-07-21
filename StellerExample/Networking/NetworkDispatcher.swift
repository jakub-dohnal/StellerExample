//
//  NetworkDispatcher.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {

    typealias Failure = (Error, HTTPURLResponse?) -> ()
    typealias Success = (Data, HTTPURLResponse?) -> ()

    @discardableResult
    func execute(request: Request, success: @escaping Success, failure: @escaping Failure) -> URLSessionDataTask
}
