//
//  MoviesHandler.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import Alamofire

struct MovieParams: Encodable {
  let region: String
  let language: String
  let api_key: String
  let page: Int

  init(page: Int) {
    let localeId = Locale.current.identifier
    region = String(localeId.dropLast(3))
    language = localeId
    api_key =  Utils.getValueFromPList(name: "Handler-Info", key: "API_KEY")
    self.page = page
  }
}

struct SearchMovieParams: Encodable {
  let region: String
  let language: String
  let api_key: String
  let page: Int
  let query: String

  init(page: Int, query: String) {
    let localeId = Locale.current.identifier
    region = String(localeId.dropLast(3))
    language = localeId
    api_key =  Utils.getValueFromPList(name: "Handler-Info", key: "API_KEY")
    self.page = page
    self.query = query
  }
}

struct MovieDetailParams: Encodable {
  let language: String = Locale.current.identifier
  let api_key: String = Utils.getValueFromPList(name: "Handler-Info", key: "API_KEY")
}

class MoviesHandler {

  private var baseURL = Utils.getValueFromPList(name: "Handler-Info", key: "BASE_URL")

  private let nowPlayingURL = "movie/now_playing"
  private let movieDetailURL = "movie"
  private let movieSearchURL = "search/movie"

  func getMovies(page: Int) async throws -> MovieModel {

    let params = MovieParams(page: page)

    let url = baseURL + nowPlayingURL

    let request = AF.request(url, parameters: params)
    let response = await request.serializingDecodable(MovieModel.self).response
    switch response.result {
    case .success(let movies):
      return movies
    case .failure(let error):
      throw error
    }
  }

  func searchMovie(page: Int, query: String) async throws -> MovieModel {
    let params = SearchMovieParams(page: page, query: query)

    let url = baseURL + movieSearchURL

    let request = AF.request(url, parameters: params)
    let response = await request.serializingDecodable(MovieModel.self).response
    switch response.result {
    case .success(let movies):
      return movies
    case .failure(let error):
      throw error
    }
  }

  /*
  func getMovieDetailFor(id: Int) async throws -> MovieData {

    let params = MovieDetailParams()

    let url = baseURL + movieDetailURL + String(id)

    let request = AF.request(url, parameters: params)
    let response = await request.serializingDecodable(MovieModel.self).response
    switch response.result {
    case .success(let movies):
      return movies
    case .failure(let error):
      throw error
    }
  }*/

}
