//
//  FlightLocationTableViewCell.swift
//  Flight
//
//  Created by Anjali on 5/19/20.
//  Copyright © 2020 Anjali. All rights reserved.
//

import UIKit

class FlightLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iataCodeLabel : UILabel!
    @IBOutlet weak var airportnameLabel : UILabel!
    @IBOutlet weak var locationLabel : UILabel!
    @IBOutlet weak var countryLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
