//
//  CurrencyTableViewCell.swift
//  TestProject
//
//  Created by Avaz on 11/11/19.
//  Copyright © 2019 HASL LLC. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var abr: UILabel!
    
    func setupCellWith(currency: Currency) -> CurrencyTableViewCell {
        name.text = currency.name
        abr.text = currency.abreviature
        return self
    }
    
}
