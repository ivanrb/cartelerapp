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

  init(apiKey: String, page: Int) {
    let localeId = Locale.current.identifier
    region = String(localeId.dropLast(3))
    language = localeId
    api_key = apiKey
    self.page = page
  }
}

class MoviesHandler {

  private let baseURL = "https://api.themoviedb.org/3/"
  private let nowPlayingURL = "movie/now_playing"

  private var apiKey: String {
    guard let filePath = Bundle.main.path(forResource: "API_keys", ofType: "plist") else {
      fatalError("Couldn't find file 'API_keys.plist'.")
    }

    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'API_keys.plist'.")
    }

    if value.starts(with: "_") {
      fatalError("Set an API key")
    }

    return value
  }

  func getMovies(page: Int) async throws -> MovieModel {

    let params = MovieParams(apiKey: apiKey, page: page)

    let url = baseURL + nowPlayingURL

    print("URL -> \(url)")
    print("Params -> \(params)")
    
    let request = AF.request(url, parameters: params)
    let response = await request.serializingDecodable(MovieModel.self).response
    switch response.result {
    case .success(let movies):
      return movies
    case .failure(let error):
      throw error
    }
  }

}
