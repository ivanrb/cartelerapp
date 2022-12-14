//
//  MoviesListViewModel.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import UIKit.UINib

enum MovieListCell {
  case movie
  case loadMore

  var nib: String {
    switch self {
    case .movie: return "MovieCell"
    case .loadMore: return "LoadMoreCell"
    }
  }

  var id: String {
    switch self {
    case .movie: return "MovieCellID"
    case .loadMore: return "LoadMoreCellID"
    }
  }
}

struct MovieListItem {
  let cellID: String
  let movieData: MovieData?

  init(movie: MovieData) {
    cellID = MovieListCell.movie.id
    movieData = movie
  }

  init(loadMore: Bool = true) {
    cellID = MovieListCell.loadMore.id
    movieData = nil
  }
}

class MoviesListViewModel {

  private var moviesList: [MovieListItem] = []
  private var error: MovieError?
  private var currentPage = 1

  func getNibs() -> [UINib: String] {
    let movieCellNib = UINib(nibName: MovieListCell.movie.nib, bundle: nil)
    let loadMoreCellNib = UINib(nibName: MovieListCell.loadMore.nib, bundle: nil)

    let nibs = [movieCellNib: MovieListCell.movie.id,
             loadMoreCellNib: MovieListCell.loadMore.id]

    return nibs
  }

  var count: Int { return moviesList.count }

  func getCellFor(row: Int) -> MovieListItem {
    return moviesList[row]
  }
}

extension MoviesListViewModel {
  func fetch() async throws {
    let moviesHandler = MoviesHandler()
    do {
      let result = try await moviesHandler.getMovies(page: currentPage)
      setMovies(movies: result.results)
    } catch {
      throw error
    }
  }

  private func setMovies(movies: [MovieData]) {
    for movie in movies {
      moviesList.append(MovieListItem(movie: movie))
    }
  }
}
