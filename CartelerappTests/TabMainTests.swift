//
//  TabMainTests.swift
//  CartelerappTests
//
//  Created by Iván Rodríguez Barrasa on 14/12/22.
//

import XCTest
@testable import Cartelerapp

final class TabMainTests: XCTestCase {

  var sut: TabMainViewModel!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = TabMainViewModel()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func testGetViewControllers() {
    let viewControllers = sut.getControllers()

    XCTAssertEqual(viewControllers.count, 2, "Count main tab view controllers error")
  }

}
