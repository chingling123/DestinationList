//
//  DestinationDataSource.swift
//  DestinationList
//
//  Created by Erik Nascimento on 05/03/2022.
//

import Foundation
import UIKit

class DestinationDataSource: NSObject, UITableViewDataSource {
    var destinations: [PlaceModel]?
    
    init(data: [PlaceModel]?) {
        self.destinations = data
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PlaceTableViewCell else { return UITableViewCell() }
        if let hasData = destinations?[indexPath.row] {
            cell.configure(item: hasData)
        }
        return cell
    }
}
