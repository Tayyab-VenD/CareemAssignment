//
//  MovieResultCell.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 23/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation
import SDWebImage
import UIKit

class MovieResultCell : UITableViewCell {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!

    var viewModel: MovieResultViewModel! {
        didSet {
            posterImageView.sd_setImage(with: viewModel.posterURL)
            nameLabel.text = viewModel.title
            releaseDateLabel.text = viewModel.releaseDate
            overviewLabel.text = viewModel.overview
        }
    }
}
