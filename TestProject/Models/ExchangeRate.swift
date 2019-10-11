 //
 //  ExchangeRate.swift
 //  TestProject
 //
 //  Created by Avaz on 11/10/19.
 //  Copyright © 2019 HASL LLC. All rights reserved.
 //
 
 import UIKit
 
 struct ExchangeRate: Codable {
    let rateID: String
    let baseName: String
    let baseAbreviature: String
    
    let rateName: String
    let rateAbreviature: String
    var rateValue: CGFloat
 }
