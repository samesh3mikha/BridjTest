//
//  EvenListService.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/10/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

protocol EventListRepository {
    func getEventList(serviceRequestCompletionCallback: @escaping ServiceRequestCompletionCallback)
}

final class EventListService: EventListRepository, ServiceRequestHandler {
    
    func getEventList(serviceRequestCompletionCallback: @escaping ServiceRequestCompletionCallback) {
        let evenListRequestComponent = EvenListRequestComponent()
        performServiceRequest(evenListRequestComponent) { responseData, error in
            serviceRequestCompletionCallback(responseData, error)
        }
    }
}
