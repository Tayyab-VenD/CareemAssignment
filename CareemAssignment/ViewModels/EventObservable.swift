//
//  EventObservable.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 25/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

protocol EventObservable {

    associatedtype Event

    func on(_ observer: @escaping (Event) -> Void)
}
