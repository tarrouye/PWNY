//
//  PassHashResult.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import Foundation

struct PassHashResult: Decodable {
    let suffix: String
    let count: Int

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        suffix = try container.decode(String.self)
        count = try container.decode(Int.self)
    }
}
