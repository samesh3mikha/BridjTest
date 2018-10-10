//
//  DetailedTableViewCell.swift
//  Bridj
//
//  Created by samesh swongamikha on 10/10/18.
//  Copyright © 2018 samesh swongamikha. All rights reserved.
//

import UIKit

final class DetailedTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var detailLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    // MARK: - Publicb Heplers
        
    public func configure(for displayItem: EventListCellDisplayItem) {
        titleLabel.text = displayItem.name
        detailLabel.text = displayItem.venue
        descriptionLabel.text = displayItem.price
    }

}
