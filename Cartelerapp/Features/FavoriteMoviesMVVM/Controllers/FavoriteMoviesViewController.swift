//
//  FavoriteMoviesViewController.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  private let viewModel = FavoriteViewModel.shared

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configureTable()
  }

  private func configureTable() {
    tableView.dataSource = self

    tableView.separatorStyle = .none

    let nibs = viewModel.getNibs()
    for nib in nibs {
      tableView.register(nib.0, forCellReuseIdentifier: nib.1)
    }
  }

}

extension FavoriteMoviesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let movie = viewModel.getCellFor(row: indexPath.row)

    if let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.movie.id, for: indexPath) as? MovieCell {
      cell.bind(data: movie)
      cell.delegate = self
      cell.tag = indexPath.row
      return cell
    }

    return UITableViewCell()
  }
}

extension FavoriteMoviesViewController: MovieCellDelegate {
  func toggleFavorite(id: Int, tag: Int) {
    let data = viewModel.getCellFor(row: tag)
      let isFavorite = viewModel.checkIsInFavoriteList(id: data.id)
      if isFavorite {
        viewModel.removeFavorite(id: data.id)
      } else {
        viewModel.addFavorite(movie: data)
      }
    tableView.reloadData()
  }
}
