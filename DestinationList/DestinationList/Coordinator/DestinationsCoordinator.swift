//
//  DestinationsCoordinator.swift
//  DestinationList
//
//  Created by Erik Nascimento on 08/03/2022.
//

import UIKit

class DestinationsCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ViewController(viewModel: DestinationViewModel(), coordinator: self)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func goDetails(place: PlaceModel) {
        let vc = DetailViewController(place: place)
        self.navigationController.modalPresentationStyle = .custom
        self.navigationController.pushViewController(vc, animated: true)
    }
}
