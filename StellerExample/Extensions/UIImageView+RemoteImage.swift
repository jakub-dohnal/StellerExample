//
//  UIImageView+RemoteImage.swift
//  StellerExample
//
//  Created by Jakub Dohnal on 17/07/2019.
//  Copyright © 2019 Jakub Dohnal. All rights reserved.
//

import UIKit

extension UIImageView {

    func image(remoteURL: URL) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: remoteURL) { (data, response, error) -> Void in
            guard let data = data else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
            }
        }
        task.resume()
        return task
    }
}
