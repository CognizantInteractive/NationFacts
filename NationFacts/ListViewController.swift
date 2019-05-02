//
//  ListViewController.swift
//  NationFacts
//
//  Created by Lourdusamy, Sagaya Martin Luther King (Cognizant) on 30/04/19.
//  Copyright © 2019 Lourdusamy, Sagaya Martin Luther King (Cognizant). All rights reserved.
//

import UIKit

//
// ListViewController to display the content (including image, title and description) in a table
//
class ListViewController: UIViewController {

  lazy var viewModel: ListViewModel = {
    return ListViewModel()
  }()

  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.delegate = self.viewModel
    tableView.dataSource = self.viewModel
    //Dynamically calculate size
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.estimatedRowHeight = Constants.estimatedRowHeight
    tableView.rowHeight = UITableView.automaticDimension

    view.addSubview(tableView)

    //autolayout the table view - pin 0 up 0 left 0 right 0 down
    let viewsDictionary = ["stackView": tableView]
    let tableViewH = NSLayoutConstraint.constraints(
      withVisualFormat: "H:|-0-[stackView]-0-|",  //horizontal constraint 0 points from left and right side
      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
      metrics: nil,
      views: viewsDictionary)
    let tableViewV = NSLayoutConstraint.constraints(
      withVisualFormat: "V:|-30-[stackView]-30-|", //vertical constraint 0 points from top and bottom
      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
      metrics: nil,
      views: viewsDictionary)
    view.addConstraints(tableViewH)
    view.addConstraints(tableViewV)

    tableView.register(FactCell.self, forCellReuseIdentifier: FactCell.cellIdentifier())
    return tableView
  }()

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    //Dynamically calculate size
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor.black
    label.font = UIFont.boldSystemFont(ofSize: StyleManager.getTitleFont())
    NSLayoutConstraint.activate([label.heightAnchor.constraint(equalToConstant: Constants.titleHeight)])
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
  }
}
