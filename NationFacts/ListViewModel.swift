//
//  ListViewModel.swift
//  NationFacts
//
//  Created by Lourdusamy, Sagaya Martin Luther King (Cognizant) on 01/05/19.
//  Copyright © 2019 Lourdusamy, Sagaya Martin Luther King (Cognizant). All rights reserved.
//

import UIKit

//
// To get the facts list changes, used observer design pattern
//
class ListViewModelObservables {
  //Observable  model objects for the Facts list changes
  let title = Observable<String>(value: Constants.loadingText)
  let isServiceFailed = Observable<Bool>(value: false)
  let isTableViewHidden = Observable<Bool>(value: false)
  let sectionViewModels = Observable<SectionViewModel>(value: SectionViewModel(rowViewModels: []))
  var serviceError: NSError?
}

class ListViewModel: NSObject {
  let factsQueryService: FactsQueryProrocol
  let observables: ListViewModelObservables

  init(observables: ListViewModelObservables = ListViewModelObservables(),
       geoFactsService: FactsQueryProrocol = FactsQueryService()) {
    self.observables = observables
    self.factsQueryService = geoFactsService
  }

  func start() {
    observables.isServiceFailed.value = false
    observables.isTableViewHidden.value = true
    observables.title.value = Constants.loadingText
    factsQueryService.getFactsList(from: ConfigurationManager.shared.environment.urlEndPoint,
                                   success: { [weak self] (factsData) in
                                    self?.observables.isTableViewHidden.value = false

                                    guard let factsData = factsData else {
                                      self?.observables.title.value = ""
                                      return
                                    }
                                    if let title = factsData.title,
                                      let rowCount = factsData.rows?.count {
                                      self?.observables.title.value = title
                                      if rowCount > 0 {
                                        self?.buildViewModels(factsData: factsData)
                                      }
                                    }
      },
                                   failure: { [weak self] (error) in
                                    if error != nil {
                                      self?.observables.isServiceFailed.value = true
                                      self?.observables.title.value = ""
                                      self?.observables.serviceError = error
                                      return
                                    }
    })
  }

  // MARK: - Data source

  // Arrange the sections/row view model and caregorize by date
  func buildViewModels(factsData: FactsData) {
    var sectionTable = [RowViewModel]()

    if let factsList = factsData.rows {
      sectionTable = getFactsCellViewModel(factsList: factsList)
      self.observables.sectionViewModels.value = converToSectionViewModel(sectionTable)
    }
  }

  //get fact cell view model for talble view rows
  func getFactsCellViewModel(factsList: [FactsRecord]) -> [RowViewModel] {
    var sectionTable = [RowViewModel]()

    for fact in factsList {
      let title = fact.title ?? ""
      let desc = fact.description ?? ""
      var imageUrl: URL?
      if let imageHref = fact.imageHref {
        imageUrl = URL(string: imageHref)
      }
      let factCellviewModel = FactCellViewModel(title: title, desc: desc, imageUrl: imageUrl)
      sectionTable.append(factCellviewModel)
    }

    return sectionTable
  }

  // Convert the row viewmodels into section viewmodels
  private func converToSectionViewModel(_ sectionTable: [RowViewModel]) -> SectionViewModel {
    return SectionViewModel(rowViewModels: sectionTable)
  }
}

extension ListViewModel: UITableViewDelegate {

}

extension ListViewModel: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionViewModel = observables.sectionViewModels.value
    return sectionViewModel.rowViewModels.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let sectionViewModel = observables.sectionViewModels.value
    let rowViewModel = sectionViewModel.rowViewModels[indexPath.row]

    let cell = tableView.dequeueReusableCell(withIdentifier: FactCell.cellIdentifier(), for: indexPath)
    if let cell = cell as? FactCell {
      cell.setup(viewModel: rowViewModel)
    }
    cell.layoutIfNeeded()
    return cell
  }
}
