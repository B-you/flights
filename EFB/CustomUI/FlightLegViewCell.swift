//
//  FlightLegViewCell.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 13/01/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit
import iOSDropDown
import JMMaskTextField_Swift

class FlightLegViewCell: UITableViewCell {

    @IBOutlet weak var drpLegType: DropDown!
    @IBOutlet weak var txFrom: UITextField!
    @IBOutlet weak var txTo: UITextField!
    
    @IBOutlet weak var txOut: UITextField!
    @IBAction func outChanged(_ sender: JMMaskTextField) {
        calculatedBlock()
    }
    
    @IBOutlet weak var txIn: UITextField!
    @IBAction func inChanged(_ sender: JMMaskTextField) {
        calculatedBlock()
    }

    @IBOutlet weak var swLanded: CustomSwitch!
    @IBAction func landedChanged(_ sender: Any) {
        calculatedBlock()
    }
    
    
    @IBOutlet weak var txBlock: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func calculatedBlock(){
        let out  = txOut.text
        let lin = txIn.text
        if(out == "" || lin == ""){
            txBlock.text = ""
            return
        }
        //Split min and secods
        let hout = Int(out!.components(separatedBy: ":")[0])!
        let mout =  Int(out!.components(separatedBy: ":")[1])!
        
        var hin = Int(lin!.components(separatedBy: ":")[0])!
        var min =  Int(lin!.components(separatedBy: ":")[1])!
        
        
        if(mout > min){
            hin = hin - 1
            min = min + 60
        }
        let nday = swLanded.isOn
        if(nday == true){
            hin = hin + 24
        }
        //Calculate Block
        let hblock = hin - hout
        let mblock = min - mout
        let block = (hblock < 10 ? "0\(hblock)" : String(hblock) )+":"+(mblock < 10 ? "0\(mblock)" : String(mblock) )
        print(block)
        txBlock.text = block
    }

}
