//
//  MyCurrenciesViewController.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 11/01/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit

class MyCurrenciesViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate{
    
    private var MyCurrencies: [MyTraining] = [];
    @IBOutlet weak var tbCurrencies: UITableView!
    @IBAction func menuClicked(_ sender: Any) {
        self.toggleDrawer();
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tbCurrencies.dataSource = self
        tbCurrencies.delegate = self
        getCurrencies()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyCurrencies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clCurrency") as! CurrencyViewCell;
        let mc = MyCurrencies[indexPath.row]
        cell.currencyName.text = mc.type
        cell.dueDate.text = "Due: \(self.formatDate(mc.due!))  Remaining Days: \(mc.daystildue ?? "" )"
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {}
    
    private func getCurrencies(){
        tbCurrencies.showActivityIndicator();
        
        APIHelper.GetMyCurrencies { (currencies) -> Void in
            if(currencies != nil){
                self.MyCurrencies = currencies!
                
                DispatchQueue.main.async {
                    self.tbCurrencies.reloadData()
                    self.tbCurrencies.hideActivityIndicator()
                }
            }
            else{
                DispatchQueue.main.async {
                    self.tbCurrencies.hideActivityIndicator()
                }
            }
        }
    }
    
    
}
