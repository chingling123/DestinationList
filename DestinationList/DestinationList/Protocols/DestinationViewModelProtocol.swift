//
//  DestinationViewModelProtocol.swift
//  DestinationList
//
//  Created by Erik Nascimento on 05/03/2022.
//

import Foundation

protocol DestinationViewModelProtocol: AnyObject {
    var datasource: DestinationDataSource? { get }
    func fetchData()
}
