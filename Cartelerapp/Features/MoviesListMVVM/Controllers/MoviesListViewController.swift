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
    cancelSearch()
    fetchData()
  }

  @objc private func showSearch() {
    let searchBar = UISearchBar()
    searchBar.delegate = self
    searchBar.sizeToFit()
    searchBar.becomeFirstResponder()

    parent?.navigationItem.titleView = searchBar

    parent?.navigationItem.leftBarButtonItem = nil
    parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(cancelSearch))
  }

  @objc private func cancelSearch() {
    parent?.navigationItem.titleView = nil
    parent?.navigationItem.leftBarButtonItem = nil
    parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(showSearch))
  }

  private func configureTable() {
    tableView.dataSource = self
    tableView.delegate = self

    tableView.separatorStyle = .none

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

  func fetchSearch(query: String) {
    Task {
      do {
        viewModel.resetList()
        try await viewModel.fetchSearch(query: query)
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
      movieCell.tag = indexPath.row
      movieCell.delegate = self
      return movieCell
    }

    return cell
  }
}

extension MoviesListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let cell = viewModel.getCellFor(row: indexPath.row)

    if cell.isLoadMoreCell {
      fetchData()
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let info = viewModel.getCellFor(row: indexPath.row)

    if let movieInfo = info.movieData {
      let detailViewModel = MovieDetailViewModel(movieInfo: movieInfo)
      let detailVC = MovieDetailViewController(viewModel: detailViewModel)

      self.navigationController?.pushViewController(detailVC, animated: true)
    }
  }

}

extension MoviesListViewController: MovieCellDelegate {
  func toggleFavorite(id: Int, tag: Int) {
    let favoriteViewModel = FavoriteViewModel.shared

    let movie = viewModel.getCellFor(row: tag)
    if var data = movie.movieData {
      let isFavorite = favoriteViewModel.checkIsInFavoriteList(id: data.id)
      viewModel.updateCellFor(row: tag, with: data)
      if isFavorite {
        favoriteViewModel.removeFavorite(id: data.id)
      } else {
        favoriteViewModel.addFavorite(movie: data)
      }
    }
    tableView.reloadRows(at: [IndexPath(row: tag, section: 0)], with: .none)
  }
}

extension MoviesListViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print(searchText)
    if searchText.count >= 3 {
      fetchSearch(query: searchText)
    }
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}
