//
//  RateTableViewCell.swift
//  TestProject
//
//  Created by Avaz on 11/10/19.
//  Copyright © 2019 HASL LLC. All rights reserved.
//

import UIKit

class RateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var baseName: UILabel!
    @IBOutlet weak var baseAbr: UILabel!
    @IBOutlet weak var rateName: UILabel!
    @IBOutlet weak var rateValue: UILabel!
    
     func setupCellWith(rate: ExchangeRate) -> RateTableViewCell {
        baseName.text = rate.baseName
        baseAbr.text = "1 \(rate.baseAbreviature)"
        rateName.text = "\(rate.rateName) • \(rate.rateAbreviature)"
        rateValue.text = String(format: "%.2f", rate.rateValue)
        
        return self
    }

    
}
