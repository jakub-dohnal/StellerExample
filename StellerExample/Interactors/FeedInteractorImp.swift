//
//  FeedInteractorImp.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

struct FeedInteractorImp: FeedInteractor {

    let service: NetworkService

    func getStories(completion: @escaping (Result<StoriesResponse>) -> Void) {
        let request = FeedRequest()
        service.fetch(request: request, completion: completion)
    }
}
