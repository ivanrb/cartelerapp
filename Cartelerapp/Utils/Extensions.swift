//
//  String+localizable.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import UIKit

extension String {
  var localizable: String {
    return NSLocalizedString(self, comment: "")
  }

  var formatDate: String {

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    if let dt = dateFormatter.date(from: self) {
      let localFormatter = DateFormatter()
      localFormatter.locale = .current
      localFormatter.dateStyle = .medium
      return localFormatter.string(from: dt)
    }

    return self

  }
}

extension UIView {

  func roundCorners(corners: UIRectCorner, radius: CGFloat) {

    DispatchQueue.main.async {
      let path = UIBezierPath(roundedRect: self.bounds,
                              byRoundingCorners: corners,
                              cornerRadii: CGSize(width: radius, height: radius))
      let maskLayer = CAShapeLayer()
      maskLayer.frame = self.bounds
      maskLayer.path = path.cgPath
      self.layer.mask = maskLayer
    }
  }
}

extension Double {
  var clean: String {
    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
  }
}
