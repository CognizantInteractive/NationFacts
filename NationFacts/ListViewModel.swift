//
//  ListViewModel.swift
//  NationFacts
//
//  Created by Lourdusamy, Sagaya Martin Luther King (Cognizant) on 01/05/19.
//  Copyright © 2019 Lourdusamy, Sagaya Martin Luther King (Cognizant). All rights reserved.
//

import UIKit

class ListViewModel: NSObject {
}

extension ListViewModel: UITableViewDelegate {

}

extension ListViewModel: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FactCell.cellIdentifier(), for: indexPath)
    if let cell = cell as? FactCell {
      cell.setup()
    }
    cell.layoutIfNeeded()
    return cell
  }
}
