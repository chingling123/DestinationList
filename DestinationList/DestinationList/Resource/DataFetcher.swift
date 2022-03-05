//
//  DataFetcher.swift
//  DestinationList
//
//  Created by Erik Nascimento on 05/03/2022.
//

import Foundation

class DataFetcher {
    static func fetch(completion: @escaping ([PlaceModel]?) -> Void) {
        guard let data = FileLoader.loadData() else {
            completion(nil)
            return
        }
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            formatter.dateFormat = "dd/MM/yyyy"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            return Date()
        })
        do {
            let masterData = try decoder.decode([PlaceModel].self, from: data)
            completion(masterData)
        } catch {
            completion(nil)
        }
    }
}
