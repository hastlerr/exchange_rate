//
//  SecondCurrencyTableViewController.swift
//  TestProject
//
//  Created by Avaz on 11/10/19.
//  Copyright © 2019 HASL LLC. All rights reserved.
//

import UIKit

class SecondCurrencyTableViewController: UITableViewController {
  
    private let screanTitle = "Second currency"
    var oldRateId: String?

    var currencies: [Currency]!
    var firstCurrency: Currency!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerXib()
    }

    func setupUI() {
        title = screanTitle
    }
    
    func registerXib(){
        self.tableView.register(CurrencyTableViewCell.nib, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
    }
    
    func saveRate(secondCurrency: Currency) {
        let rate = ExchangeRate(rateID: "\(firstCurrency.abreviature)\(secondCurrency.abreviature)",
            baseName:firstCurrency.name,
            baseAbreviature: firstCurrency.abreviature,
            rateName: secondCurrency.name,
            rateAbreviature: secondCurrency.abreviature,
            rateValue: 0)
        
        if let id = oldRateId{
            UserDefaultsManager.shared.update(rate: rate, id: id)
        } else {
            UserDefaultsManager.shared.set(rate: rate)
        }
    }
    
    func goToRates() {
        let vc = UIStoryboard.createVC(storyboard: .Main, controllerType: RatesTableViewController.self)
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as! CurrencyTableViewCell
        return cell.setupCellWith(currency: currencies![indexPath.row])
    }
    
    // MARK: - Table view data delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondCurrency = currencies[indexPath.row]
        saveRate(secondCurrency: secondCurrency)
        goToRates()
    }

    

}

