//
//  EventListUseCase.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/10/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

protocol EventListUseCaseProviding {
    func getEventList(useCaseFailureCallback: @escaping UseCaseFailureCallback,
                      useCaseSuccesCallback: @escaping UseCaseSuccesCallback<Events>)
    
    func filterBookableEvents(_ events: [Events.Event]) -> [Events.Event]

    func sortEventsChronologically(_ events: [Events.Event]) -> [Events.Event]

    func filterPlaysFromTheEvents(_ events: [Events.Event]) -> [Events.Event]
}

final class EventListUseCase: EventListUseCaseProviding, DataToDomainMapping {
    
    // MARK: - Properties

    let eventListService: EventListRepository
    
    // MARK: - Lifecycle

    init() {
        eventListService = EventListService()
    }
    
    // MARK: - Protocol EventListUseCaseProviding

    func getEventList(useCaseFailureCallback: @escaping UseCaseFailureCallback,
                      useCaseSuccesCallback: @escaping UseCaseSuccesCallback<Events>) {
        eventListService.getEventList { responseData, error in
            do {
                let eventList: Events = try self.domainModelFor(data: responseData, error: error)
                useCaseSuccesCallback(eventList)
            } catch {
                useCaseFailureCallback(error)
            }
        }
    }
    
    func filterBookableEvents(_ events: [Events.Event]) -> [Events.Event] {
        return events.filter { $0.availableSeats > 0 }
    }
    
    func sortEventsChronologically(_ events: [Events.Event]) -> [Events.Event] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let chronologicalEvents: [Events.Event] = events.sorted(by: {
            if let date0: Date = dateFormatter.date(from: $0.date), let date1: Date = dateFormatter.date(from: $1.date) {
                return date0 > date1
            }
            return false
        })
        return chronologicalEvents
    }
    
    func filterPlaysFromTheEvents(_ events: [Events.Event]) -> [Events.Event] {
        return events.filter { $0.labels.contains("play") }
    }
}
