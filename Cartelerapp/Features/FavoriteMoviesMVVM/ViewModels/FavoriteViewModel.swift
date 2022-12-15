//
//  FavoriteViewModel.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 15/12/22.
//

import UIKit.UINib

class FavoriteViewModel {

  static let shared = FavoriteViewModel()

  private var favoriteList: [MovieData] = []

  func getNibs() -> [UINib: String] {
    let movieCellNib = UINib(nibName: MovieListCell.movie.nib, bundle: nil)

    let nibs = [movieCellNib: MovieListCell.movie.id]

    return nibs
  }

  func getCellFor(row: Int) -> MovieData {
    return favoriteList[row]
  }

  func addFavorite(movie: MovieData) {
    favoriteList.append(movie)
  }

  func removeFavorite(id: Int) {
    guard let index = getIndexOf(movie: id) else { return }
    favoriteList.remove(at: index)
  }

  private func getIndexOf(movie id: Int) -> Int? {
    return favoriteList.firstIndex(where: {$0.id == id})
  }

  var count: Int {
    return favoriteList.count
  }

  func getMovieFor(row: Int) -> MovieData {
    return favoriteList[row]
  }

  func checkIsInFavoriteList(id: Int) -> Bool {
    return favoriteList.firstIndex(where: {$0.id == id }) != nil
  }
}
