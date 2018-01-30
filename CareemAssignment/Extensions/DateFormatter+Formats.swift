//
//  DateFormatter+Formats.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 29/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

extension DateFormatter {

    convenience init(withEnglishFormat dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
        self.timeZone = TimeZone(secondsFromGMT: 0)
        self.locale = Locale(identifier: "en_US_POSIX")
    }

    static var commonDisplayFormat : DateFormatter {
        return DateFormatter(withEnglishFormat: "MMM d, yyyy")
    }

    static var commonWebFormat : DateFormatter {
        return DateFormatter(withEnglishFormat: "yyyy-MM-dd")
    }
}
