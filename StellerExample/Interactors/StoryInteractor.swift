//
//  StoryInteractor.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 22/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

protocol StoryInteractor {
    func loadImage(completion: @escaping (Result<Data>) -> Void)
}
