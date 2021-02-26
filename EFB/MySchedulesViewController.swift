//
//  MySchedulesViewController.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 11/01/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit

class MySchedulesViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tbSchedules: UITableView!
    
    @IBAction func drawerClicked(_ sender: Any) {
        self.toggleDrawer();
    }
    private var MySchedules: [MySchedule] = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        tbSchedules.dataSource = self
        tbSchedules.delegate = self
        getSchedules()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return CGFloat(140)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MySchedules.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clSchedule") as! ScheduleViewCell;
        
        let sch = MySchedules[indexPath.row]
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM-dd-yyyy"
        
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        
        let outDate = dateFormat.string(from: sch.leg_out_time!)
        let outTime = timeFormat.string(from: sch.leg_out_time!)
        let inTime = timeFormat.string(from: sch.leg_in_time!)
        
        cell.From.text = "From: " + sch.departure_airport!
        cell.To.text = "To: "+sch.arrival_airport!
        cell.Date.text = "Date: \(outDate) Leaving Time: \(outTime) Arrival Time: \(inTime)"
        cell.Aircraft.text = sch.aircrafttailnumber
        cell.Note.text = sch.notes
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {}
    
    private func getSchedules(){
        tbSchedules.showActivityIndicator();
        
        APIHelper.GetMySchedules{ (schedules) -> Void in
            if(schedules != nil){
                self.MySchedules = schedules!
                DispatchQueue.main.async {
                    self.tbSchedules.reloadData()
                    self.tbSchedules.hideActivityIndicator()
                }
//                DispatchQueue.global(qos: .userInitiated).async {
//                    [weak self] in
//                    guard let self = self else {
//                        return
//                    }
//                    self.tbSchedules.reloadData()
//                    self.tbSchedules.hideActivityIndicator()
//                }
            }
            else{
                DispatchQueue.main.async {
                    self.tbSchedules.hideActivityIndicator()
                }
            }
        }
    }
    
    
}

