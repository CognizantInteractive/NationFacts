//
//  NationFactsTests.swift
//  NationFactsTests
//
//  Created by Lourdusamy, Sagaya Martin Luther King (Cognizant) on 30/04/19.
//  Copyright © 2019 Lourdusamy, Sagaya Martin Luther King (Cognizant). All rights reserved.
//

import XCTest
@testable import NationFacts

class NationFactsTests: XCTestCase {
  var listViewController: ListViewController!

  override func setUp() {
    super.setUp()
    listViewController = ListViewController()
    listViewController.initBinding()
  }

  override func tearDown() {
    listViewController = nil
    super.tearDown()
  }

  func testListViewController() {
    listViewController.observables.serviceError = NSError(domain: "Test Error", code: 401, userInfo: nil)
    listViewController.showServiceFailedAlert()
    let errorCode = listViewController.observables.serviceError
    XCTAssert(errorCode?.code == 401, "Test Service Error")
  }
}
