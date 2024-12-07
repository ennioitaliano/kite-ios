//
//  NetworkErrorDataModel.swift
//  Kite
//
//  Created by Ennio Italiano on 12/05/24.
//

import Foundation

struct NetworkErrorDataModel: Error, Decodable, Equatable {
    let detail: String?

    enum CodingKeys: String, CodingKey {
        case detail
    }
}
