//
//  MovieDetailViewController.swift
//  Cartelerapp
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

  @IBOutlet weak var movieImageView: UIImageView!
  @IBOutlet weak var transparentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewText: UITextView!

  private let viewModel: MovieDetailViewModel!

  init(viewModel: MovieDetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
    fetchDetail()
  }

  private func fetchDetail() {
    Task {
      do {
        try await viewModel.fetchMovieDetail()
        overviewText.text = viewModel.getOverview()
      } catch {
        print(error.localizedDescription)
      }
    }
  }

  private func configureUI() {
    transparentView.backgroundColor = .black
    transparentView.layer.opacity = 0.7
    setImage()
    titleLabel.textColor = .white
    titleLabel.text = viewModel.getTitle()

    self.navigationController?.navigationBar.tintColor = .white
  }

  private func setImage() {
    let imagePath = viewModel.getImagePath()

    if imagePath.isEmpty {
      movieImageView.image = UIImage(named: "Logo")
    } else {
      let imageURL = viewModel.getImageUrl(path: imagePath)
      movieImageView.downloaded(from: imageURL)
    }
  }

}
