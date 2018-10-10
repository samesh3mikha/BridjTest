//
//  Events+Decodable.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/10/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

extension Events: Decodable {
    private enum CodingKeys: String, CodingKey {
        case events
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        events = try container.decode([Event].self, forKey: .events)
    }
}

extension Events.Event: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case date
        case availableSeats
        case price
        case venue
        case labels
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(String.self, forKey: .date)
        availableSeats = try container.decode(Int.self, forKey: .availableSeats)
        price = try container.decode(Decimal.self, forKey: .price)
        venue = try container.decode(String.self, forKey: .venue)
        labels = try container.decode([String].self, forKey: .labels)
    }
}
