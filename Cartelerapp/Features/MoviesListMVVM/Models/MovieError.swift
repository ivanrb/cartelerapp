//
//  MovieError.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import Foundation

enum MovieError: Error {
case missingData
case networkError
case unexpectedError(error: Error)
}

extension MovieError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .missingData:
      return "missing_data_error".localizable
    case .networkError:
      return "network_error".localizable
    case .unexpectedError(error: let error):
      return error.localizedDescription.localizable
    }
  }
}
