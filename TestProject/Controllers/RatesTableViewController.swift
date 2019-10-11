//
//  RatesTableViewController.swift
//  TestProject
//
//  Created by Avaz on 11/10/19.
//  Copyright © 2019 HASL LLC. All rights reserved.
//

import UIKit

class RatesTableViewController: UITableViewController {
    
    private let screanTitle = "Rates"
    var rates = [ExchangeRate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        setupUI()
        clearNavigationController()
        loadRatesFromUserDefaults()
        updateRatesFromServer()
    }
    
    func registerXib(){
        self.tableView.register(RateTableViewCell.nib, forCellReuseIdentifier: RateTableViewCell.identifier)
    }
    
    func clearNavigationController() {
        if let navController = navigationController{
            let range = 0 ..< navController.viewControllers.count - 1
            navController.viewControllers.removeSubrange(range)
        }
    }
    
    func loadRatesFromUserDefaults(){
        rates = UserDefaultsManager.shared.getExchangeRates()
    }
    
    func updateRatesFromServer() {
        var updatedRates = [ExchangeRate]()
        let downloadGroup = DispatchGroup()
        let _ = DispatchQueue.global(qos: .userInitiated)
        
        DispatchQueue.concurrentPerform(iterations: rates.count) { index in
            var rate = rates[index]
            downloadGroup.enter()
            ApiClient.shared.requestRate(base: rate.baseAbreviature , rate: rate.rateAbreviature) {(result) in
                switch result {
                case .success(let rateValue):
                    rate.rateValue = rateValue
                    updatedRates.append(rate)
                case .failure(let error):
                    print("Failed to request: \(error)")
                }
                downloadGroup.leave()
            }
            
            downloadGroup.notify(queue: DispatchQueue.main) { [weak self] in
                self?.rates = updatedRates.sorted{$0.rateID < $1.rateID}
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
            }
            
        }
    }
    
    func setupUI() {
        title = screanTitle
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }
    
    @objc func refresh(sender:AnyObject){
        updateRatesFromServer()
    }
    
    @IBAction func addCurrency(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard.createVC(storyboard: .Main, controllerType: FirstCurrencyTableViewController.self)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RateTableViewCell.identifier, for: indexPath) as! RateTableViewCell
        
        return cell.setupCellWith(rate: rates[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.createVC(storyboard: .Main, controllerType: FirstCurrencyTableViewController.self)
        vc.oldRateId = rates[indexPath.row].rateID
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            UserDefaultsManager.shared.removeRate(id: rates[indexPath.row].rateID)
            rates.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
