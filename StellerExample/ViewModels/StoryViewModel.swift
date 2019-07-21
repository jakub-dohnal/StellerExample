//
//  StoryViewModel.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

protocol StoryViewModelDelegate: class {
    func didLoadImage()
    func faildLoadImage()
}

protocol StoryViewModel: class {
    var ratio: Double { get }
    var imageData: Data? { get }
    var delegate: StoryViewModelDelegate? { get set }

    func loadImage()
}
