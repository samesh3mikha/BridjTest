//
//  EvenListRequestComponent.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/10/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

struct EvenListRequestComponent: ServiceRequestComponet {
    var method: HttpMethod {
        return .get
    }
    
    var path: String {
        return "/bridj-coding-challenge/events.json"
    }
}
