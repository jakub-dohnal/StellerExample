//
//  StoryPresenterImp.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 19/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

class StoryPresenterImp: StoryPresenter {

    let ratio: Double
    let interactor: StoryInteractor

    private(set) var imageData: Data?

    weak var delegate: StoryPresenterDelegate?

    init(ratio: Double, interactor: StoryInteractor) {
        self.ratio = ratio
        self.interactor = interactor
    }

    func loadImage() {
        interactor.loadImage { [weak self] result in
            switch result {
            case .value(let value):
                self?.imageData = value
                self?.didLoadImage()
            case .error(_):
                self?.imageData = nil
                self?.faildLoadImage()
            }
        }
    }
}

private extension StoryPresenterImp {

    func didLoadImage() {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didLoadImage()
        }
    }

    func faildLoadImage() {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.faildLoadImage()
        }
    }
}
