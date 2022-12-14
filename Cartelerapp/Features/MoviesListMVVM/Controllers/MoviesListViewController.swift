//
//  MoviesListViewController.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import UIKit

class MoviesListViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func goToDetail(_ sender: Any) {
    let viewController = MovieDetailViewController()
    self.navigationController?.pushViewController(viewController,
                                                  animated: true)
  }
}
