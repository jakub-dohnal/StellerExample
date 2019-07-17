//
//  FeedInteractor.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

protocol FeedInteractor {
    func getStories(completion: @escaping (Result<StoriesResponse>) -> Void)
}
