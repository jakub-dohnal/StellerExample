//
//  FeedPresenter.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

protocol FeedPresenterDelegate: class {
    func feedLoaded(stories: [StoryViewModel])
    func feedLoadFailed(errorMessage: String)
}

protocol FeedPresenter: class {
    func reload()
    var delegate: FeedPresenterDelegate? { get set }
}
