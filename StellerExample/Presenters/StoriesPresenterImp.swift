//
//  StoriesPresenterImp.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 19/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

class StoriesPresenterImp: StoriesPresenter {
    weak var routerDelegate: StoriesRouterDelegate?

    let selectedStory: Int
    let stories: [StoryPresenter]

    init(selectedStory: Int, stories: [StoryPresenter]) {
        self.selectedStory = selectedStory
        self.stories = stories
    }

    func close() {
        routerDelegate?.close()
    }
}
