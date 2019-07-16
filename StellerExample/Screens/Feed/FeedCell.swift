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

    func setImage(name: String) {
        storyImageView.image = UIImage(named: name)
    }

    override func prepareForReuse() {
        storyImageView.image = nil
    }
}
