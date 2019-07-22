//
//  FeedPresenter.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

protocol FeedPresenterDelegate: class {
    func feedDidLoad()
    func feedLoadFailed(errorMessage: String)
}

protocol FeedPresenterRouterDelegate: class {
    func present(storyAt: Int, from: [StoryPresenter])
}

protocol FeedPresenter: class {
    func reload()
    func present(storyAt: Int)

    var stories: [StoryPresenter] { get }
    var delegate: FeedPresenterDelegate? { get set }
    var routerDelegate: FeedPresenterRouterDelegate? { get set }
}


