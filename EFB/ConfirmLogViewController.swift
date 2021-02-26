//
//  ConfirmLogViewController.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 16/01/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit

protocol ConfirmDelegate {
    func doCreateLeg()
}

class ConfirmLogViewController: UIViewController {

    static let identifier = "ConfirmLogViewController"
    var delegate: ConfirmDelegate?
    var verifyResponse: VerifyResponse! 
    
    @IBOutlet weak var dialogBoxView: UIView!
    @IBOutlet weak var imgCurrency: UIImageView!
    @IBOutlet weak var imgQuals: UIImageView!
    @IBOutlet weak var imgLimit: UIImageView!
    @IBOutlet weak var imgMaintenance: UIImageView!
    @IBOutlet weak var imgAvailable: UIImageView!
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func okClicked(_ sender: Any) {
        self.delegate?.doCreateLeg()
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //Add overlay to the view to give focus to dialog box
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        
        //Add border radius to the view
        dialogBoxView.layer.cornerRadius = 6.0
        dialogBoxView.layer.borderWidth = 0.0
        dialogBoxView.layer.borderColor = UIColor(named:"dialogBoxGray")?.cgColor
        
        //Set Images
        var name = verifyResponse?.Currency == true ? "verified" : "delete"
        imgCurrency.image = UIImage(named: name)
        
        name = verifyResponse?.Medical == true ? "verified" : "delete"
        imgQuals.image = UIImage(named: name)
        
        name = verifyResponse?.hourlimit == true ? "verified" : "delete"
        imgLimit.image = UIImage(named: name)
        
        name = verifyResponse?.Available == true ? "verified" : "delete"
        imgAvailable.image = UIImage(named: name)
        
        name = verifyResponse?.Check == true ? "verified" : "delete"
        imgMaintenance.image = UIImage(named: name)
    }
    
    static func showPopup(parentView: UIViewController, verifyResponse: VerifyResponse){
        
        //Create Reference for self
        if let confirmView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ConfirmLogViewController.identifier) as? ConfirmLogViewController {
            confirmView.modalPresentationStyle = .custom
            confirmView.modalTransitionStyle = .crossDissolve
            
            //Set delegate
            confirmView.delegate = parentView as? ConfirmDelegate
            confirmView.verifyResponse = verifyResponse
            
            //Present from parent
            parentView.present(confirmView, animated: true)
            
        }
    }
    



}
