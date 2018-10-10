//
//  EvenListPresenter.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/10/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

protocol EvenListPresenting {
    func makeInitialSetup()
    
    func viewDidLoad()
}

final class EvenListPresenter: EvenListPresenting {
    
    /// The view that conforms to the EventListDisplay protocol
    weak var display: EventListDisplay?

    /// The use case to fetch event list
    var evenListUseCase: EvenListUseCaseProviding

    // MARK: - Lifecycle
    
    init() {
        self.evenListUseCase = EvenListUseCase()
    }
    
    // MARK: - Protocol EvenListPresenting
    
    func makeInitialSetup() {
        display?.setTitle("Events")
    }
    
    func viewDidLoad() {
        evenListUseCase.getEventList(useCaseFailureCallback: { error in
            print(error.localizedDescription)
        }, useCaseSuccesCallback: { events in
            let displayItems = self.eventListDisplayItems(eventList: events)
            DispatchQueue.main.async {
                self.display?.displayItems(displayItems)
            }
        })
    }
    
    // MARK: - Private Helpers
    
    private func eventListDisplayItems(eventList: Events) -> [EventListDisplayItem] {
        // Filter the events with available seats
        let bookableEvents: [Events.Event] = self.evenListUseCase.filterBookableEvents(eventList.events)
        // Sort the events chronologically
        let sortedEvents: [Events.Event] = self.evenListUseCase.sortEventsChronologically(bookableEvents)
        
        // Bookable seats section
        let sortedEventsDisplayItems: [EventListCellDisplayItem] = eventCellDisplayItems(events: sortedEvents)
        let sortedEventList = EventListDisplayItem(sectionTitle: "Events with seats available",
                                                     events: sortedEventsDisplayItems)
        // Plays section
        let plays: [Events.Event] = self.evenListUseCase.filterPlaysFromTheEvents(sortedEvents)
        let playsDisplayItems: [EventListCellDisplayItem] = eventCellDisplayItems(events: plays)
        let playsList = EventListDisplayItem(sectionTitle: "Plays",
                                             events: playsDisplayItems)
        return [sortedEventList, playsList]
    }
    
    private func eventCellDisplayItems(events: [Events.Event]) -> [EventListCellDisplayItem] {
        return events.map { event in
            EventListCellDisplayItem(name: event.name,
                                     venue: event.venue,
                                     price: String(format: "$%.1f", event.price))
        }
    }
}
