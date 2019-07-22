//
//  StoryCell.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 16/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import UIKit

class StoryCell: RegistrableCell {

    @IBOutlet private weak var storyImageView: UIImageView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    private var viewModel: StoryPresenter?


    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func config(viewModel: StoryPresenter) {
        self.viewModel = viewModel

        startActivity()

        viewModel.delegate = self
        viewModel.loadImage()
    }

    override func prepareForReuse() {
        viewModel?.delegate = nil
        viewModel = nil
        storyImageView.image = nil
    }

    func startActivity() {
        activityIndicatorView.startAnimating()
    }

    func stopActivity() {
        activityIndicatorView.stopAnimating()
    }
}

private extension StoryCell {
    func setupUI() {
        layer.cornerRadius = 5
        layer.borderWidth = 3
        layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
    }
}

extension StoryCell: StoryPresenterDelegate {
    func faildLoadImage() {
        storyImageView.image = UIImage(named: "placeholder")
    }

    func didLoadImage() {
        stopActivity()

        guard let data = viewModel?.imageData, let image = UIImage(data: data) else {
            storyImageView.image = UIImage(named: "placeholder")
            return
        }

        storyImageView.image = image
    }
}
