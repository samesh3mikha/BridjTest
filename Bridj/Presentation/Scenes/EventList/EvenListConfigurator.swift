//
//  EvenListConfigurator.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/10/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation

final class EvenListConfigurator {
    
    // MARK: Properties
    
    static let shared = EvenListConfigurator()
    
    // MARK: Lifecycle
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(_ viewController: EvenListViewController) {
        let presenter = EvenListPresenter()
        presenter.display = viewController
        viewController.presenter = presenter
    }
}
