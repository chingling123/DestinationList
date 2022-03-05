//
//  DestinationViewModel.swift
//  DestinationList
//
//  Created by Erik Nascimento on 05/03/2022.
//

import Foundation

class DestinationViewModel {
    private var dataSource: DestinationDataSource?
    
    private func fetch() {
        DataFetcher.fetch { [weak self] resultData in
            self?.dataSource = DestinationDataSource(data: resultData)
        }
    }
}

extension DestinationViewModel: DestinationViewModelProtocol {
    var datasource: DestinationDataSource? {
        return dataSource
    }

    func fetchData() {
        self.fetch()
    }
}
