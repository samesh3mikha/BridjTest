//
//  Events.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/10/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

struct Events {
    let events: [Event]
    
    struct Event {
        let name: String
        
        let date: String
        
        let availableSeats: Int
        
        let price: Decimal
        
        let venue: String
        
        let labels: [String]
    }
}
