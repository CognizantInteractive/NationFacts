//
//  UIKit+Extensions.swift
//  NationFacts
//
//  Created by Lourdusamy, Sagaya Martin Luther King (Cognizant) on 01/05/19.
//  Copyright © 2019 Lourdusamy, Sagaya Martin Luther King (Cognizant). All rights reserved.
//

import UIKit

///
/// UITableViewCell extension
///
/// - cellIdentifier: returns cellIdentfier string
///
public extension UITableViewCell {
  /// Generated cell identifier derived from class name
  public static func cellIdentifier() -> String {
    return String(describing: self)
  }
}
