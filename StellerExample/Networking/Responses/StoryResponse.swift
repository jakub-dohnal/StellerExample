//
//  StoryResponse.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

struct StoryResponse: Codable {
    let coverSrc: String
    let aspectRatio: String

    enum CodingKeys: String, CodingKey {
        case coverSrc = "cover_src"
        case aspectRatio = "aspect_ratio"
    }
}
