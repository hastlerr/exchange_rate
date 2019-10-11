//
//  FirstCurrencyTableViewController.swift
//  TestProject
//
//  Created by Avaz on 11/10/19.
//  Copyright © 2019 HASL LLC. All rights reserved.
//

import UIKit

class FirstCurrencyTableViewController: UITableViewController {

    private let screanTitle = "First currency"
    var oldRateId: String?

    var currencies: [Currency]!{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerXib()
        loadCurrencies()

    }

    func setupUI() {
        title = screanTitle
    }
    
    func registerXib(){
        self.tableView.register(CurrencyTableViewCell.nib, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
    }

    
    func loadCurrencies() {
        currencies = FileManager.shared.getCurrencies()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as! CurrencyTableViewCell
        return cell.setupCellWith(currency: currencies![indexPath.row])
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.createVC(storyboard: .Main, controllerType: SecondCurrencyTableViewController.self)
        vc.currencies = currencies
        vc.oldRateId = oldRateId
        vc.firstCurrency = currencies[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}
