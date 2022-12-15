//
//  MovieDetailViewModel.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 15/12/22.
//

import Foundation

class MovieDetailViewModel {

  private let movieInfo: MovieData
  private var movieModel: MovieDetail?

  init(movieInfo: MovieData) {
    self.movieInfo = movieInfo
    movieModel = nil
  }

  func getTitle() -> String {
    movieInfo.title
  }

  func getImagePath() -> String {
    let imageHandler = ImageHandler()

    var imagePath = ""
    if let poster = movieInfo.posterPath {
      imagePath = poster
    } else if let backdrop = movieInfo.backdropPath {
      imagePath = backdrop
    }

    return imagePath
  }

  func getImageUrl(path: String) -> String {
    let imageHandler = ImageHandler()
    return imageHandler.getFullImageUrl(path: path)
  }

  func getOverview() -> String {
    guard let movieModel else { return "" }
    return movieModel.overview
  }

}

extension MovieDetailViewModel {
  func fetchMovieDetail() async throws {
    let moviesHandler = MoviesHandler()
    do {
      let result = try await moviesHandler.getMovieDetailFor(id: movieInfo.id)
      movieModel = result
    } catch {
      throw error
    }
  }
}
