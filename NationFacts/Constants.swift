//
//  Constants.swift
//  NationFacts
//
//  Created by Lourdusamy, Sagaya Martin Luther King (Cognizant) on 30/04/19.
//  Copyright © 2019 Lourdusamy, Sagaya Martin Luther King (Cognizant). All rights reserved.
//

import Foundation

struct Constants {
  enum ErrorDomain {
    static let invalidRequest = "Invalid Request"
    static let invalidData = "Invalid Data"
    static let serviceError = "Network Error"
  }

  enum Status {
    static let success = 200
    static let invalidRequest = 400
    static let invalidResponse = 404
  }

  enum ErrorMessage {
    static let invalidRequest = "Request is invalid, Please verify the request."
    static let invalidData = "Response invalid, please try after some time."
    static let serviceError = "Network Service failed, please try after some time."
  }
}
