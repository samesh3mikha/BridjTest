//
//  EvenListUseCase.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/10/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

protocol EvenListUseCaseProviding {
    func getEventList(useCaseFailureCallback: @escaping UseCaseFailureCallback,
                      useCaseSuccesCallback: @escaping UseCaseSuccesCallback<Events>)
}

final class EvenListUseCase: EvenListUseCaseProviding, DataToDomainMapping {
    
    // MARK: - Properties

    let eventListService: EventListRepository
    
    // MARK: - Lifecycle

    init() {
        eventListService = EventListService()
    }
    
    // MARK: - Protocol EvenListUseCaseProviding

    func getEventList(useCaseFailureCallback: @escaping UseCaseFailureCallback,
                      useCaseSuccesCallback: @escaping UseCaseSuccesCallback<Events>) {
        eventListService.getEventList { responseData, error in
            do {
                let events: Events = try self.domainModelFor(data: responseData, error: error)
                useCaseSuccesCallback(events)
            } catch {
                useCaseFailureCallback(error)
            }
        }
    }
}
