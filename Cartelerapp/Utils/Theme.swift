//
//  Theme.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import UIKit

struct Theme {

  static var cellColor: UIColor = UIColor(red: 3/255, green: 37/255, blue: 65/255, alpha: 1)

  static func getScoreColor(score: Double) -> UIColor {
    switch score {
    case 0...3.3: return .systemRed
    case 3.3...6.6: return .systemOrange
    case 6.6...10: return .systemGreen
    default: return .systemGray
    }
  }

}
