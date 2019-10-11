//
//  FileManager.swift
//  TestProject
//
//  Created by Avaz on 11/10/19.
//  Copyright © 2019 HASL LLC. All rights reserved.
//

import UIKit

class FileManager: NSObject {
    
    public static let shared = FileManager()
    private override init() {}
    private var currencies: [Currency]?
    
    func getCurrencies() -> [Currency] {
        if let currencies = currencies{
            return currencies
        } else {
            return  loadCurrencies()
        }
    }
    
    private func loadCurrencies() -> [Currency] {
        var currenciesText = ""
        let path = Bundle.main.path(forResource: "Currencies", ofType: "txt")
        do {
            currenciesText = try String(contentsOfFile: path!, encoding: .utf8)
        } catch {
            print("Failed to read from: \(path ?? "")")
            return []
        }
        var currencies = [Currency]()
        let lines = currenciesText.components(separatedBy: "\n").map {$0.components(separatedBy: " - ")}
        for line in lines{
            currencies.append(Currency(name: line[1], abreviature: line[0]))
        }
        return currencies
    }

}
