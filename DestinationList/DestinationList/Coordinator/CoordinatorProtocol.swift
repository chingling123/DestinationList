//
//  CoordinatorProtocol.swift
//  DestinationList
//
//  Created by Erik Nascimento on 08/03/2022.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
