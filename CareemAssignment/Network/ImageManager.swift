//
//  ImageManager.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

enum PosterSize : String {
    case w92
    case w185
    case w500
    case w780
}

class ImageManager {

    let configuration: APIConfiguration

    init(_ configuration: APIConfiguration) {
        self.configuration = configuration
    }

    func posterURL(from imagePath: String, with posterSize: PosterSize) -> URL? {
        return configuration.imageURL.appendingPathComponent("/\(posterSize.rawValue)/\(imagePath)")
    }
}
