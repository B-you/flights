//
//  LoginViewController.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 24/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit
import Toast_Swift

class LoginViewController: BaseViewController {

    @IBOutlet weak var txEmail: UITextField!
    @IBOutlet weak var txPassword: UITextField!
    @IBOutlet weak var btnSignIn: RoundedButton!
    @IBOutlet weak var loadingBar: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if(!validate())
        {
            return;
        }
        
        let email = String(txEmail.text!)
        let pass = String(txPassword.text!)
        startAnimation();
        APIHelper.SignIn(email: email, password: pass, onCompletion: { (Pilot) -> Void in
            if(Pilot != nil)
            {
                
                //Set defaults
                self.setDefaults(pilot: Pilot!)
                
                //Set helper value
                APIHelper.token = Pilot?.apikey;
                APIHelper.pilotid = Pilot?.pilotid
                APIHelper.operatorid = Pilot?.custid
                
                
                self.getFlightData()
                
                self.stopAnimation()
                
                //Navigate to sync page
                self.performSegue(withIdentifier: "sgLtoSync", sender: self)
            }
            else
            {
                self.stopAnimation()
                self.view.makeToast("Unable to login, please check your credentials and try again")
            }
        })
    }
    
    func startAnimation()
    {
        
        btnSignIn.isEnabled = false;
        loadingBar.startAnimating();
    }
    
    func stopAnimation()
    {
        
        btnSignIn.isEnabled = true;
        loadingBar.stopAnimating()
    }
    
    func validate() -> Bool{
        
        if self.txEmail.text!.isEmpty {
            self.shake(textField: self.txEmail, messsage: "Please enter email!")
            //self.stopButtonLoader()
            return false;
        }
        if(self.txPassword.text!.isEmpty)
        {
            self.shake(textField: self.txPassword, messsage: "Please enter password!")
            //self.stopButtonLoader()
            return false;
        }
        
        return true;
    }
    
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
