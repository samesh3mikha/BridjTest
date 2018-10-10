//
//  EventListConfigurator.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/10/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

final class EventListConfigurator {
    
    // MARK: Properties
    
    static let shared = EventListConfigurator()
    
    // MARK: Lifecycle
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(_ viewController: EventListViewController) {
        let presenter = EventListPresenter()
        presenter.display = viewController
        viewController.presenter = presenter
    }
}
