//
//  StoryViewModelImp.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 19/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

class StoryViewModelImp: StoryViewModel {

    let ratio: Double

    weak var delegate: StoryViewModelDelegate?

    private let dispatcher: NetworkDispatcher
    private let coverURL: URL
    private var imageTask: URLSessionDataTask?
    private(set) var imageData: Data?

    init(coverURL: URL, ratio: Double, dispatcher: NetworkDispatcher) {
        self.coverURL = coverURL
        self.ratio = ratio
        self.dispatcher = dispatcher
    }

    func loadImage() {
        guard let imageTask = imageTask else {
            self.imageTask = fetchImage()
            return
        }

        switch imageTask.state {
        case .running:
            break
        case .suspended:
            imageTask.resume()
        case .canceling:
            self.imageTask = fetchImage()
        case .completed:
            imageData != nil ?
                didLoadImage(data: imageData)
            :   (self.imageTask = fetchImage())
        @unknown default:
            self.imageTask?.cancel()
            self.imageTask = fetchImage()
        }
    }

    private func fetchImage() -> URLSessionDataTask? {
        return dispatcher.execute(request: coverURL, success: { [weak self] (data, _) in
            self?.didLoadImage(data: data)
        }) { [weak self] (error, response) in
            self?.didLoadImage(data: nil)
        }
    }

    private func didLoadImage(data: Data?) {
        self.imageData = data
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didLoadImage()
        }
    }

    private func faildLoadImage() {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.faildLoadImage()
        }
    }
}
