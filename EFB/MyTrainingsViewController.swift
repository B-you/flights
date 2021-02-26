//
//  MyTrainingsViewController.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 11/01/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit

class MyTrainingsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var tbTraining: UITableView!
    
    @IBAction func drawerClicked(_ sender: Any) {
        self.toggleDrawer();
    }
    private var MyTrainings: [MyTraining] = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        tbTraining.dataSource = self
        tbTraining.delegate = self
        getTrainings()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyTrainings.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clTraining") as! TrainingViewCell;
        let mt = MyTrainings[indexPath.row]
        cell.ItemType.text = mt.type
        cell.DueDate.text = "Due: \(self.formatDate(mt.due!))  Days Remaining: \(mt.daystildue ?? "" )"
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {}
    
    private func getTrainings(){
        tbTraining.showActivityIndicator();
        
        APIHelper.GetMyTrainings { (trainings) -> Void in
            if(trainings != nil){
                self.MyTrainings = trainings!
                
                DispatchQueue.main.async {
                    self.tbTraining.reloadData()
                    self.tbTraining.hideActivityIndicator()
                }
            }
            else{
                DispatchQueue.main.async {
                    self.tbTraining.hideActivityIndicator()
                }
            }
        }
    }
    
    
}
