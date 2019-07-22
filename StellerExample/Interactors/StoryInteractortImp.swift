//
//  StoryInteractortImp.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 22/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

class StoryInteractorImp: StoryInteractor {

    let coverURL: URL

    private let dispatcher: NetworkDispatcher
    private var imageTask: URLSessionDataTask?
    private var imageData: Data?

    init(coverURL: URL, dispatcher: NetworkDispatcher) {
        self.coverURL = coverURL
        self.dispatcher = dispatcher
    }

    func loadImage(completion: @escaping (Result<Data>) -> Void) {
        guard let imageTask = imageTask else {
            fetchImage(completion: completion)
            return
        }

        switch imageTask.state {
        case .running:
            break
        case .suspended:
            imageTask.resume()
        case .canceling:
            fetchImage(completion: completion)
        case .completed:
            guard let imageData = imageData else {
                fetchImage(completion: completion)
                break
            }
            completion(Result.value(imageData))
        @unknown default:
            self.imageTask?.cancel()
            fetchImage(completion: completion)
        }
    }

    private func fetchImage(completion: @escaping (Result<Data>) -> Void) {
        self.imageTask = dispatcher.execute(request: coverURL, success: { [weak self] (data, _) in
            self?.imageData = data
            completion(Result.value(data))
        }) { (error, _) in
            completion(Result.error(error))
        }
    }

}
