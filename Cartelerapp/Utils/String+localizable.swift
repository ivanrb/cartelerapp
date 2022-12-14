//
//  String+localizable.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import Foundation

extension String {
  var localizable: String {
    return NSLocalizedString(self, comment: "")
  }
}
