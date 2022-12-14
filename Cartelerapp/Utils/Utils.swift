//
//  Utils.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import Foundation

class Utils {

  static func getValueFromPList(name resource: String, key: String) -> String {
    guard let filePath = Bundle.main.path(forResource: resource, ofType: "plist") else {
      fatalError("Couldn't find file '\(resource).plist'.")
    }

    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: key) as? String else {
      fatalError("Couldn't find key '\(key)' in '\(resource).plist'.")
    }

    if value.starts(with: "_") {
      fatalError("Set an API key")
    }

    return value
  }

}
