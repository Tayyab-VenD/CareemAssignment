//
//  URL+Query.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 29/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

extension URL {
    init?(base: URL, path: String, parameters: [String: String?]) {
        var items: [URLQueryItem] = []
        for (key, value) in parameters {
            if let value = value {
                items.append(URLQueryItem(name: key, value: value))
            }
        }

        var components = URLComponents(url: base, resolvingAgainstBaseURL: true)
        components?.path.append(path)
        components?.queryItems = items

        if let url = components?.url  {
            self = url
        } else {
            return nil
        }
    }
}
