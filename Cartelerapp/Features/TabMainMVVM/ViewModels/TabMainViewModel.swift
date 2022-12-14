//
//  TabMainViewModel.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import UIKit.UIViewController

struct TabMainItem {
  let viewController: UIViewController
  let title: String
  let icon: UIImage?
  let selectedIcon: UIImage?
}

class TabMainViewModel {

  private let items: [TabMainItem]

  init() {
    items = [
      TabMainItem(viewController: MoviesListViewController(),
                  title: "movies".localizable,
                  icon: UIImage(systemName: "popcorn"),
                  selectedIcon: UIImage(systemName: "popcorn.fill")),
      TabMainItem(viewController: FavoriteMoviesViewController(),
                  title: "favorites".localizable,
                  icon: UIImage(systemName: "star"),
                  selectedIcon: UIImage(systemName: "star.fill"))
    ]
  }

  func getControllers() -> [UIViewController] {
    var controllers: [UIViewController] = []

    for tabItem in items {
      let icon = UITabBarItem(title: tabItem.title,
                              image: tabItem.icon,
                              selectedImage: tabItem.selectedIcon)
      tabItem.viewController.tabBarItem = icon
      controllers.append(tabItem.viewController)
    }

    return controllers
  }

}
