//
//  FactCell.swift
//  NationFacts
//
//  Created by Lourdusamy, Sagaya Martin Luther King (Cognizant) on 01/05/19.
//  Copyright © 2019 Lourdusamy, Sagaya Martin Luther King (Cognizant). All rights reserved.
//

import UIKit

class FactCell: UITableViewCell {
  //Facts title text
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    //Dynamically calculate size
    label.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(label)

    label.textColor = UIColor.black
    label.font = UIFont.systemFont(ofSize: StyleManager.getMediumFont())
    return label
  }()

  //Facts description text
  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    //Dynamically calculate size
    label.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(label)

    label.textColor = UIColor.darkGray
    label.font = UIFont.systemFont(ofSize: StyleManager.getSmallFont())
    label.numberOfLines = Constants.defaultLines
    return label
  }()

  //Facts image
  lazy var factImageView: UIImageView = {
    let imageView = UIImageView()
    //Dynamically calculate size
    imageView.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(imageView)

    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = Constants.imageRadius
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  // MARK: - Initialize - methods

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupInitialView()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupInitialView()
    setupConstraints()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
  }

  private func setupInitialView() {
    self.selectionStyle = .none
  }

  func setup() {
    self.titleLabel.text = "Fact Title"
    self.descriptionLabel.text = "Place holder text for the text description"
    self.factImageView.image = #imageLiteral(resourceName: "placeholderImage")

    setNeedsLayout()
  }

  // MARK: - Setup Constraints

  private func setupConstraints() {

    let stackView = UIStackView(arrangedSubviews: [factImageView, titleLabel, descriptionLabel])
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.alignment = .fill
    stackView.spacing = Constants.cellPadding
    stackView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(stackView)

    //autolayout the stack view - pin  up left  right  down
    let viewsDictionary = ["stackView": stackView]
    let stackViewH = NSLayoutConstraint.constraints(
       //horizontal constraint for left and right side
      withVisualFormat: "H:|-\(Constants.cellPadding)-[stackView]-\(Constants.cellPadding)-|",
      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
      metrics: nil,
      views: viewsDictionary)
    let stackViewV = NSLayoutConstraint.constraints(
      //vertical constraint for top and bottom
      withVisualFormat: "V:|-\(Constants.cellPadding)-[stackView]-\(Constants.cellPadding)-|",
      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
      metrics: nil,
      views: viewsDictionary)
    contentView.addConstraints(stackViewH)
    contentView.addConstraints(stackViewV)

    //Flexible height for description lablel
    descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
  }
}
