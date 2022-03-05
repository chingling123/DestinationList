//
//  DestinationViewModel.swift
//  DestinationList
//
//  Created by Erik Nascimento on 05/03/2022.
//

import Foundation

class DestinationViewModel {
    private var data: [PlaceModel]?

    private func fetch() {
        DataFetcher.fetch { [weak self] resultData in
            self?.data = resultData
        }
    }
}

extension DestinationViewModel: DestinationViewModelProtocol {
    var destinations: [PlaceModel]? {
        return self.data
    }
    
    func fetchData() {
        self.fetch()
    }
}
