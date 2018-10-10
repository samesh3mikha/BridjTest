//
//  EventListCellDisplayItem.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/10/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

struct EventListDisplayItem {
    let sectionTitle: String
    
    let events: [EventListCellDisplayItem]
}

struct EventListCellDisplayItem {
    
    let name: String
    
    let venue: String

    let price: String    
}
