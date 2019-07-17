//
//  StoriesResponse.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

struct StoriesResponse: Codable {
    let stories: [StoryResponse]

    enum CodingKeys: String, CodingKey {
        case stories = "data"
    }
}
