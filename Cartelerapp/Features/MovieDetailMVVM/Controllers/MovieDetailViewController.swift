//
//  MovieDetailViewController.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!

  var movieInfo: MovieData!

  override func viewDidLoad() {
    super.viewDidLoad()

    titleLabel.text = movieInfo.title
  }

}
