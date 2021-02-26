//
//  MyCalenderViewController.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 04/02/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit
import FSCalendar

protocol MyCalenderDelegate {
    func datePicked(date: String)
}

class MyCalenderViewController: UIViewController {
    
    var delegate: MyCalenderDelegate?
    @IBOutlet weak var fsCalender: FSCalendar!
    @IBAction func btnDoneClicked(_ sender: Any) {
        if(fsCalender.selectedDate == nil){
            return;
        }
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/dd/yyyy"
        
        self.delegate?.datePicked(date: dateFormat.string(from: fsCalender.selectedDate!))
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    static let identifier = "MyCalenderViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    static func showCalender(parentView: UIViewController){
        
        //Create Reference for self
        if let calenderView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MyCalenderViewController.identifier) as? MyCalenderViewController {
            calenderView.modalPresentationStyle = .custom
            calenderView.modalTransitionStyle = .crossDissolve
            
            //Set delegate
            calenderView.delegate = parentView as? MyCalenderDelegate
            //Present from parent
            parentView.present(calenderView, animated: true)
            
        }
    }
}
