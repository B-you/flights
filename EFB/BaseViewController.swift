//
//  BaseViewController.swift
//  Country
//
//  Created by Mario Kovacevic on 09/05/16.
//  Copyright © 2016 Brommko, LLC. All rights reserved.

import Foundation
import Async
import Toast_Swift
import pop
import SwiftyUserDefaults
import MMDrawerController
import ObjectMapper
//import MaterialKit

class BaseViewController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
//        toggleDrawer()
    }
    
    func viewControllerForPresentingModalView() -> UIViewController {
        return self
    }
    
    /**
     If you want to shake your UITextField, just sent it in this method with message. Message will be shown like Toast.
     
     - Parameter textFieldu:    UITextField to shake.
     - Parameter messsage:      String to show like Toast.
     */
    func shake(textField:UITextField, messsage:String) {
        Async.main{
            let shake = POPSpringAnimation(propertyNamed: kPOPLayerPositionX)
            shake?.springBounciness = 20
            shake?.velocity = NSNumber(value: 3000)
            textField.layer.pop_add(shake, forKey: "shakePassword")
        }
        //JLToast.makeText(messsage).show()
        self.view.makeToast(messsage);
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func showDialogAlert(title: String, message: String, completion: @escaping ((Bool) -> Void)){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
            completion(true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setDefaults(pilot: Pilot)
    {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "efblogged")
        defaults.set(pilot.apikey, forKey: "efbKey")
        defaults.set(pilot.pilotid, forKey: "efbPilotID")
        defaults.set(pilot.custid, forKey: "efbOperatorID")
        defaults.set(pilot.toJSONString(), forKey: "efbPilotObject")
    }
    
    /**
     This is an example of MKTextField Material design component. Modify the method if you have your own design
     
     - Parameter textField:    MKTextField
     - Parameter placeholder:  String to set as placeholder
     */
    func setupTextFields(textField:UITextField, placeholder:String){
        // No border, no shadow, floatingPlaceholderEnabled
//        textField.textColor = UIColor.white
//        textField.layer.borderColor = UIColor.clearColor.CGColor
//        textField.floatingPlaceholderEnabled = true
//        textField.floatingLabelTextColor = UIColor(hex: 0xe4fde1)
//        textField.placeholder = placeholder
//        textField.tintColor = UIColor.whiteColor()
//        textField.cornerRadius = 0
//        textField.bottomBorderEnabled = true
//        textField.bottomBorderColor = UIColor.whiteColor()
//        textField.bottomBorderWidth = CGFloat(0.5)
//        textField.bottomBorderHighlightWidth = CGFloat(1.0)
//        textField.attributedPlaceholder = NSAttributedString(string:placeholder, attributes:[NSForegroundColorAttributeName: UIColor(hex: 0xe4fde1)])
    }
    
    func toggleDrawer(){
        print("hello")
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
        print("hello 1")
    }
    
    func clearDefaults(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "efblogged")
        defaults.removeObject(forKey: "efbKey")
        defaults.removeObject(forKey: "efbPilotID")
        defaults.removeObject(forKey: "efbOperatorID")
        defaults.removeObject(forKey: "efbPilotObject")
        
    }
    
    func getProfile() -> Pilot{
        let defaults = UserDefaults.standard
        let raw =  defaults.string(forKey: "efbPilotObject")
        var pilot: Pilot?
        pilot = Mapper<Pilot>().map(JSONString: raw!)
        return pilot!
    }
    
    //Load Flight data needed for create file
    func getFlightData(){
        APIHelper.GetFlightData { (data) -> Void in
            if(data != nil){
                DataHelper.flightLogData = data
            }
            else{
                //Create Temporary Data
                let fl = FlightLogData()
                fl.Aircrafts = []
                fl.CrewPositions = []
                fl.Currencies = []
                fl.LegTypes = []
                DataHelper.flightLogData = fl
            }
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM-dd-yyyy"
        
        
        let formated = dateFormat.string(from: date)
        return formated
    }
    
    func formatTime(_ date: Date) -> String {
        
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        let formated = timeFormat.string(from: date)
        return formated
    }
}
