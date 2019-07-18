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

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func config(viewModel: StoryViewModel) {
        imageTask = storyImageView.image(remoteURL: viewModel.coverURL)
        storyImageView.image = UIImage(named: "placeholder")
    }

    override func prepareForReuse() {
        imageTask?.cancel()
        storyImageView.image = nil
    }
}

private extension FeedCell {
    func setupUI() {
        layer.cornerRadius = 5
        layer.borderWidth = 3
        layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
    }
}
