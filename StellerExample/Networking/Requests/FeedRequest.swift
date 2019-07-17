//
//  FeedRequest.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import Foundation

struct FeedRequest: Request {
    let url = URL(string: "https://api.steller.co/v1/users/76794126980351029/stories")!
}
