//
//  MoviesListViewModelTests.swift
//  CartelerappTests
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import XCTest
@testable import Cartelerapp

final class MoviesListViewModelTests: XCTestCase {

  var sut: MoviesListViewModel!

    override func setUpWithError() throws {
      try super.setUpWithError()
      sut = MoviesListViewModel()
    }

    override func tearDownWithError() throws {
      sut = nil
      try super.tearDownWithError()
    }

  func testGetNibs() {
    let nibs = sut.getNibs()

    XCTAssertEqual(nibs.count, 2, "Nibs count error")
  }

}
