//
//  FeedCell.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 16/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import UIKit

class FeedCell: RegistrableCell {

    @IBOutlet private weak var storyImageView: UIImageView!
    private var imageTask: URLSessionDataTask?

    func config(viewModel: StoryViewModel) {
        imageTask = storyImageView.image(remoteURL: viewModel.coverURL)

        backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        layer.cornerRadius = 5
    }

    override func prepareForReuse() {
        imageTask?.cancel()
        storyImageView.image = nil
    }
}
