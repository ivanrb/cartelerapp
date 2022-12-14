//
//  LoadMoreCell.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import UIKit

class LoadMoreCell: UITableViewCell {

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  override func awakeFromNib() {
    super.awakeFromNib()

    activityIndicator.startAnimating()
  }

}
