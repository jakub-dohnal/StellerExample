//
//  StoriesPresenter.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 19/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

protocol StoriesRouterDelegate: class {
    func close()
}

protocol StoriesPresenter {
    func close()

    var stories: [StoryViewModel] { get }
    var selectedStory: Int { get }
    var routerDelegate: StoriesRouterDelegate? { get set }
}
