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
    let stories: [StoryViewModel]

    init(selectedStory: Int, stories: [StoryViewModel]) {
        self.selectedStory = selectedStory
        self.stories = stories
    }

    func close() {
        routerDelegate?.close()
    }
}
