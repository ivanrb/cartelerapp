//
//  TabMainViewController.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import UIKit

class TabMainViewController: UITabBarController {

  private let viewModel = TabMainViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.viewControllers = viewModel.getControllers()
  }

}
