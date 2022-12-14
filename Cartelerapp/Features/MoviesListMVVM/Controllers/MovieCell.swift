//
//  MovieCell.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import UIKit

class MovieCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    selectionStyle = .none
  }

  func bind(data: MovieData) {
    titleLabel.text = data.title
  }

}
