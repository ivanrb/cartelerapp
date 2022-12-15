//
//  MovieCell.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import UIKit

protocol MovieCellDelegate: AnyObject {
  func toggleFavorite(id: Int, tag: Int)
}

class MovieCell: UITableViewCell {

  @IBOutlet weak var cellContentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var movieImage: UIImageView!
  @IBOutlet weak var releaseLabel: UILabel!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var scoreView: UIView!
  @IBOutlet weak var scoreLabel: UILabel!

  weak var delegate: MovieCellDelegate!
  var movieID: Int = -1

  override func awakeFromNib() {
    super.awakeFromNib()

    configureUI()
  }

  private func configureUI() {
    selectionStyle = .none

    cellContentView.layer.cornerRadius = 5

    titleLabel.textColor = .white
    releaseLabel.textColor = .lightGray

    favoriteButton.setTitle("", for: .normal)
    favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
    favoriteButton.tintColor = .white

    movieImage.roundCorners(corners: [.topLeft, .bottomLeft],
                            radius: 5)
    cellContentView.backgroundColor = Theme.cellColor

    scoreView.layer.cornerRadius = 20
  }

  func bind(data: MovieData) {
    movieID = data.id
    titleLabel.text = data.title
    releaseLabel.text = data.releaseDate.formatDate

    let imageHandler = ImageHandler()

    var imagePath = ""
    if let poster = data.posterPath {
        imagePath = poster
    } else if let backdrop = data.backdropPath {
        imagePath = backdrop
    }

    if imagePath.isEmpty {
      movieImage.image = UIImage(named: "Logo")
    } else {

      let imageURL = imageHandler.getFullImageUrl(path: imagePath)
      movieImage.downloaded(from: imageURL)
    }

    scoreView.backgroundColor = Theme.getScoreColor(score: data.voteAverage)
    scoreLabel.text = (data.voteAverage * 10).clean

    let fvm = FavoriteViewModel.shared
    let isFavorite = fvm.checkIsInFavoriteList(id: data.id)

    favoriteButton.tintColor = isFavorite ? .yellow : .white

    var imageName = "star"
    if isFavorite {
      imageName += ".fill"
    }

    favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
  }

  @IBAction func toggleFavorite(_ sender: Any) {
    delegate.toggleFavorite(id: movieID, tag: tag)
  }
}
