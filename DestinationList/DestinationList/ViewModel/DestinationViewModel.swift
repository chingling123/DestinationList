//
//  DestinationViewModel.swift
//  DestinationList
//
//  Created by Erik Nascimento on 05/03/2022.
//

import Foundation

class DestinationViewModel {
    private var ds: DestinationDataSource?
    private var selectedIndexPath: IndexPath?
    
    private func fetch() {
        DataFetcher.fetch { [weak self] resultData in
            self?.ds = DestinationDataSource(data: resultData)
        }
    }
}

extension DestinationViewModel: DestinationViewModelProtocol {
    var indexPath: IndexPath? {
        get {
            return selectedIndexPath
        }
        set {
            selectedIndexPath = newValue
        }
    }
    var dataSource: DestinationDataSource? {
        return ds
    }

    func fetchData() {
        self.fetch()
    }
}
