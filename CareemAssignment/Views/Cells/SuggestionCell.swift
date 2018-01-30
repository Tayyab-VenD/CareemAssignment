//
//  SuggestionCell.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation
import UIKit

class SuggestionCell : UITableViewCell {

    @IBOutlet private weak var suggestionLabel: UILabel!

    var viewModel: SuggestionViewModel! {
        didSet {
            suggestionLabel.text = viewModel.suggestion
        }
    }
}
