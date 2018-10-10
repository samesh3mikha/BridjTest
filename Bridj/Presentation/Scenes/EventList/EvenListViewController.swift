//
//  EvenListViewController.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/9/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import Foundation
import UIKit

protocol EventListDisplay: class {
    func setTitle(_ title: String)
    
    func displayItems(_ items: [EventListDisplayItem])
}

final class EvenListViewController: UIViewController, EventListDisplay, UITableViewDataSource, UITableViewDelegate {

    /// The presenter object conforming to EvenListPresenting, to perform the actions of the scene
    var presenter: EvenListPresenting!

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    
    private var displayItems: [EventListDisplayItem] = []

    let cellIdentifier: String = "DetailedTableViewCell"

    // MARK: - Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        super.init(nibName: nil, bundle: Bundle(for: EvenListViewController.self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EvenListConfigurator.shared.configure(self)
        registerReusableTableViewCells()
        presenter.makeInitialSetup()
        presenter.viewDidLoad()
    }
    
    // MARK: - EventListDisplay
    
    func setTitle(_ title: String) {
        self.navigationItem.title = title
    }
    
    func displayItems(_ items: [EventListDisplayItem]) {
        displayItems = items
        tableView.reloadData()
    }

    // MARK: - TableView Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionDisplayItem = displayItemForSection(at: section)
        return sectionDisplayItem.sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionDisplayItem = displayItemForSection(at: section)
        return sectionDisplayItem.events.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = displayItemForCell(at: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? DetailedTableViewCell else {
                                                                fatalError("Unable to dequeu cell `DetailedTableViewCell`")
        }
        cell.configure(for: item)
        return cell
    }
    
    // MARK: - TableView Delegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - Private Helpers
    
    private func registerReusableTableViewCells() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: cellIdentifier)
    }

    private func displayItemForSection(at section: Int) -> EventListDisplayItem {
        return displayItems[section]
    }

    private func displayItemForSectionHeader(at section: Int) -> String {
        let sectionDisplayItem: EventListDisplayItem = displayItemForSection(at: section)
        return sectionDisplayItem.sectionTitle
    }
    
    private func displayItemForCell(at indexPath: IndexPath) -> EventListCellDisplayItem {
        let sectionDisplayItem: EventListDisplayItem = displayItemForSection(at: indexPath.section)
        return sectionDisplayItem.events[indexPath.row]
    }

}
