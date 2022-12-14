//
//  ImageHandler.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import Alamofire
import UIKit.UIImage

class ImageHandler {

  private var imagesBaseURL = "https://image.tmdb.org/t/p/"
  private var size = "original"

  func getFullImageUrl(path: String) -> String {
    return imagesBaseURL + size + path
  }

}

extension UIImageView {
  func downloaded(from url: String, contentMode mode: ContentMode = .scaleAspectFill) {
    contentMode = mode
    AF.download(url).responseData { response in
      if let data = response.value {
        let image = UIImage(data: data)
        DispatchQueue.main.async {
          self.image = image
        }
      }
    }
  }
}
