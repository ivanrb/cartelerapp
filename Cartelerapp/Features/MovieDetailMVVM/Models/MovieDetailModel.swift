//
//  MovieDetailModel.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 15/12/22.
//

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable {
//    let adult: Bool
//    let backdropPath: String
//    let belongsToCollection: JSONNull?
//    let budget: Int
//    let genres: [Genre]
//    let homepage: String
//    let id: Int
//    let imdbID, originalLanguage, originalTitle, overview: String
//    let popularity: Double
//    let posterPath: String
//    let productionCompanies: [ProductionCompany]
//    let productionCountries: [ProductionCountry]
//    let releaseDate: String
//    let revenue, runtime: Int
//    let spokenLanguages: [SpokenLanguage]
//    let status, tagline, title: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int
  let overview: String

    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case belongsToCollection = "belongs_to_collection"
//        case budget, genres, homepage, id
//        case imdbID = "imdb_id"
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview, popularity
//        case posterPath = "poster_path"
//        case productionCompanies = "production_companies"
//        case productionCountries = "production_countries"
//        case releaseDate = "release_date"
//        case revenue, runtime
//        case spokenLanguages = "spoken_languages"
//        case status, tagline, title, video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
      case overview
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
