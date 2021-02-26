//
//  LoginViewController.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 24/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import SwiftKeychainWrapper
import EAIntroView

class IntroViewController : BaseViewController, EAIntroDelegate {
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myActivityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if ( Defaults.hasKey( DefaultsKey<String?>("efblogged") ) ) {
            //Load Defaults
            self.loadNecessaryDefaults()
            self.getFlightData()
            
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.startDrawerView()
            
            
            //self.performSegue(withIdentifier: "sgItoSync", sender: self)
        } else if ( Defaults.hasKey( DefaultsKey<String?>("efbFirst") ) ) {
            performSegue(withIdentifier: "sgLogin", sender: self)
        } else{
            self.showIntroWithCrossDissolve()
        }
    }
    
    func loadNecessaryDefaults()
    {
        let defaults = UserDefaults.standard
        
        APIHelper.token = defaults.string(forKey: "efbKey")
        APIHelper.pilotid = defaults.string(forKey: "efbPilotID")
        APIHelper.operatorid = defaults.string(forKey: "efbOperatorID")
    }
    
    /**
     EAIntroView
     
     Highly customizable drop-in solution for introduction views.
     */
    func showIntroWithCrossDissolve(){
        self.myActivityIndicator.stopAnimating()
        self.myActivityIndicator.isHidden = true
        
        let rootView = self.view
        
        let page1: EAIntroPage = EAIntroPage()
        page1.title = "myFlightData EFB"
        page1.desc = "View and download folders and files shared by your operator. "
        page1.titleIconView = UIImageView(image: UIImage(named: "air1"))
        
        let page2: EAIntroPage = EAIntroPage()
        page2.title = "myFlightData"
        page2.desc = "An electronic records system and aviation regulatory compliance program. You control the data, we do the calculations"
        page2.titleIconView = UIImageView(image: UIImage(named: "air2"))
        
        let page3: EAIntroPage = EAIntroPage()
        page3.title = "myFlightData"
        page3.desc = "Fast, easy, accurate, aviation record-keeping. Automated pilot and aircraft checks; know before you go. Keep your mind on flying instead of doing paperwork and reports."
        page3.titleIconView = UIImageView(image: UIImage(named: "air3"))
        
        
        let intro: EAIntroView = EAIntroView(frame: (rootView?.bounds)!, andPages: [page1, page2, page3])
        intro.delegate = self
        intro.show(in: rootView, animateDuration: 0.3)
        intro.showSkipButtonOnlyOnLastPage = false
        intro.swipeToExit = false
        intro.skipButtonSideMargin = 50
        
    }
    
    /**
     If skip is pressed or swipe to exit is enabled, this method will get triggered
     */
    func introDidFinish(_ introView: EAIntroView!, wasSkipped: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "efbFirst")
        performSegue(withIdentifier: "sgLogin", sender: self)
    }
    
}
