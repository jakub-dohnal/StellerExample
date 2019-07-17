//
//  FeedNetworkService.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

struct FeedNetworkService: NetworkService {

    let networkDispatcher: NetworkDispatcher

    func getStories(completion: @escaping (Result<StoriesResponse>) -> Void) {
        let request = FeedRequest()
        execute(request: request, completion: completion)
    }
}
