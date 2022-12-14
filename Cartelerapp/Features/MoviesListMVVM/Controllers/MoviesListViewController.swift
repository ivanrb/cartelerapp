//
//  MoviesListViewController.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import UIKit

class MoviesListViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  private let viewModel = MoviesListViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()

    configureTable()

    fetchData()
  }

  private func configureTable() {
    tableView.dataSource = self

    let nibs = viewModel.getNibs()
    for nib in nibs {
      tableView.register(nib.0, forCellReuseIdentifier: nib.1)
    }
  }

  func fetchData() {
    Task {
      do {
        try await viewModel.fetch()
        tableView.reloadData()
      } catch {
        print(error.localizedDescription)
      }
    }
  }

}

extension MoviesListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = viewModel.getCellFor(row: indexPath.row)

    let cell = tableView.dequeueReusableCell(withIdentifier: item.cellID, for: indexPath)

    if let movieCell = cell as? MovieCell, let data = item.movieData {
      movieCell.bind(data: data)
      return movieCell
    }

    return cell
  }
}
