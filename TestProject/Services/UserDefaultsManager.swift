//
//  UserDefaultsManager.swift
//  TestProject
//
//  Created by Avaz on 11/11/19.
//  Copyright © 2019 HASL LLC. All rights reserved.
//

import UIKit

class UserDefaultsManager {
    public static let shared = UserDefaultsManager()
    private init() {}
    fileprivate let key = "EXCHANGE_RATES_USER_DEFAULTS"
        
    func set(rate: ExchangeRate)  {
        var rates = getExchangeRates()
        rates.append(rate)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(rates), forKey: key)

    }
    
    func getExchangeRates() -> [ExchangeRate] {
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            if let savedRates = try? PropertyListDecoder().decode(Array<ExchangeRate>.self, from: data){
                return savedRates.sorted{ $0.rateID > $1.rateID }
            }
        }
        return []
    }
    
    func set(rates: [ExchangeRate]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(rates), forKey: key)
    }
    
    func removeRate(id: String) {
        var arr = getExchangeRates()
        arr.removeAll { (rate) -> Bool in
            rate.rateID == id
        }
        set(rates: arr)
    }
    
    func update(rate: ExchangeRate, id: String)  {
        removeRate(id: id)
        set(rate: rate)
    }
   
}
