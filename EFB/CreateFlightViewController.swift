//
//  CreateFlightViewController.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 12/01/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit
import iOSDropDown
import Toast_Swift
import MMDrawerController

class CreateFlightViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, ConfirmDelegate, UITextFieldDelegate, MyCalenderDelegate {
    var mytextfields: [UITextField] = []
    @IBOutlet weak var scMain: UIScrollView!
    //Drop down data
    private var optionCrewPosition: [String] = [];
    private var optionCrewPositionId: [Int] = [];
    private var optionCurrency: [String] = [];
    private var optionAircraft: [String] = [];
    private var optionAircraftId: [Int] = [];
    private var optionLegType: [String] = [];
    private var optionLegTypeId: [Int] = [];
    private var optionNoOfTimes: [String] = [];
    
    
    //Selected Values
    private var verifyLimit: VerifyLimit!
    private var saveLeg: SaveLegModel!
    
    //Table rows
    private var currencyRows: Int = 1;
    private var legRows: Int = 1;
    
    //Outlet
    
   
    @IBOutlet weak var txDateOut: UITextField!
    @IBAction func dtOutStartEditing(_ sender: Any) {
        
        MyCalenderViewController.showCalender(parentView: self)
        txDateOut.endEditing(true)
//        mytextfields[2].becomeFirstResponder()
    }
    @IBOutlet weak var drpCrewPosition: DropDown!
    
    @IBOutlet weak var drpAircraft: DropDown!
    
    @IBOutlet weak var txStartMaint: UITextField!
    @IBAction func startMaintChanged(_ sender: UITextField) {
        calculateMaintTotal()
    }
    
    @IBOutlet weak var txEndMaint: UITextField!
    @IBAction func endMaintChanged(_ sender: UITextField) {
        calculateMaintTotal()

    }
    
    @IBOutlet weak var txTotalTime: UITextField!
    
    @IBOutlet weak var swMaintStatus: CustomSwitch!
    
    @IBOutlet weak var txNotes: UITextField!
    @IBOutlet weak var loadingBar: UIActivityIndicatorView!
    
    
    @IBOutlet weak var tbCurrency: UITableView!
    @IBOutlet weak var tbLeg: UITableView!
    @IBAction func drawerClicked(_ sender: Any) {
        
        self.toggleDrawer();
    }
    
    //Currency buttons
    @IBAction func btnAddCurrency(_ sender: Any) {
        //Add row and update height
        currencyRows += 1
        self.tbCurrency.reloadData()
        tbCurrency.adjustHeight(60)
        self.adjustScroll(60)
    }
    @IBAction func btnDeleteCurrency(_ sender: Any) {
        if(currencyRows > 1){
            currencyRows -= 1
            self.tbCurrency.reloadData()
            tbCurrency.adjustHeight(-60)
            self.adjustScroll(-60)
        }
    }
    
    //Leg Buttons
    @IBAction func btnAddLeg(_ sender: Any) {
        legRows += 1
        self.tbLeg.reloadData()
        tbLeg.adjustHeight(120)
        self.adjustScroll(120)
    }
    @IBAction func btnDeleteLeg(_ sender: Any) {
        if(legRows > 1){
            legRows -= 1
            self.tbLeg.reloadData()
            tbLeg.adjustHeight(-120)
            self.adjustScroll(120)
        }
    }
    
    
    @IBOutlet weak var btnSubmitWeak: RoundedButton!
    @IBAction func btnSubmit(_ sender: Any) {
        if(parseForm()){
            doVerifyLimit()
        }
        
    }
    @objc func nextbtnresign(_ sender : UITextField) {
        print("hi")
//        if txEndMaint == sender {
//            txEndMaint.becomeFirstResponder()
//        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scMain.contentSize = CGSize(width: scMain.contentSize.width, height: view.frame.size.height + 200)
    }
    
   
  
//    @objc func keyboardWillChangeNotification(notification : Notification) {
//
//      let keyboardrect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
//
//        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
//
//
//
//            bottomLayout.constant = keyboardrect!.height
//            view.setNeedsLayout()
//
//        } else {
//
//
//            bottomLayout.constant = 108
//            view.setNeedsLayout()
//
//        }
//
//
//
//    }
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        self.initializeVariable()
        self.loadDropDown()
        
        
        tbCurrency.dataSource = self
        tbCurrency.delegate = self
        
        
        tbLeg.dataSource = self
        tbLeg.delegate = self
        
        scMain.delegate = self
        scMain.contentSize = CGSize(width: scMain.contentSize.width, height: view.frame.size.height + 400)
       
        txEndMaint.delegate = self
        txDateOut.delegate = self
        txNotes.delegate = self
//        textFieldFrom.delegate = self
        self.mytextfields.append(txEndMaint)
        self.mytextfields.append(txDateOut)
        self.mytextfields[0].becomeFirstResponder()
//        txEndMaint.becomeFirstResponder()
       
//        self.mytextfields.append(txEndMaint)
//        self.mytextfields.append(txEndMaint)
//        self.mytextfields.append(txEndMaint)
//        self.mytextfields[0].addDoneButtonToKeyboard()
//        txEndMaint.addDoneButtonToKeyboard(myAction:  #selector(getter: txDateOut.isFirstResponder))
    }
    
    private func adjustScroll(_ addh: CGFloat){
        
        scMain.contentSize = CGSize(width: scMain.contentSize.width, height: scMain.contentSize.height + addh+200) //CGSize( scMain.contentSize.width, scMain.contentSize.height + addh)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    private func loadDropDown(){
        //Crew Position
        for cp in (DataHelper.flightLogData!.CrewPositions){
            optionCrewPosition.append(cp.type!)
            optionCrewPositionId.append(Int(cp.id!)!)
        }
        drpCrewPosition.optionArray = optionCrewPosition
        drpCrewPosition.optionIds = optionCrewPositionId
        drpCrewPosition.didSelect{(text,index,id) in
            self.verifyLimit.drpCrewPosition = String(id)
        }
        //Default
        if(optionCrewPosition.count > 0){
            drpCrewPosition.selectedIndex = 0
            drpCrewPosition.text = optionCrewPosition[0]
            self.verifyLimit.drpCrewPosition = String(optionCrewPositionId[0])
        }
        
        
        //Aircraft
        for ac in (DataHelper.flightLogData!.Aircrafts){
            optionAircraft.append(ac.aircrafttailnumber!)
            optionAircraftId.append(Int(ac.id!)!)
        }
        drpAircraft.optionArray = optionAircraft
        drpAircraft.optionIds = optionAircraftId
        drpAircraft.didSelect{(text,index,id) in
            self.verifyLimit.drpAircraft = String(id)
            self.txStartMaint.text = DataHelper.flightLogData!.Aircrafts[index].startmaintenence
        }
        
        
//        Default
        if(optionAircraft.count > 0){
            drpAircraft.selectedIndex = 0
            drpAircraft.text = optionAircraft[0]
            self.verifyLimit.drpAircraft = String(optionAircraftId[0])
            self.txStartMaint.text = DataHelper.flightLogData!.Aircrafts[0].startmaintenence
        }
        
        //Currency
        for cr in (DataHelper.flightLogData!.Currencies){
            optionCurrency.append(cr.type!)
        }
        
        //No of times
        for i in 0...9{
            optionNoOfTimes.append(String(i))
        }
        
        
        //LegTypes
        for lg in (DataHelper.flightLogData!.LegTypes){
            optionLegType.append(lg.legtype!)
            optionLegTypeId.append(Int(lg.id!)!)
        }
    }
    
    //Initialize the post varaibles
    private func initializeVariable(){
        verifyLimit = VerifyLimit()
        verifyLimit.txCurrencies = []
        verifyLimit.txPilotCPS = []
        
        saveLeg = SaveLegModel()
        saveLeg.pilots = []
        saveLeg.legs = []
        saveLeg.currencies = []
    }
    
    
    //Table Stuffs
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == tbCurrency){
            return CGFloat(60)
        } else {
            return CGFloat(120)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tbCurrency){
            return currencyRows
        } else {
            return legRows
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if (tableView == tbLeg){
            let cell = tableView.dequeueReusableCell(withIdentifier: "clFlightLeg") as! FlightLegViewCell;
            cell.drpLegType.optionArray = optionLegType
            cell.drpLegType.optionIds = optionLegTypeId
            
            
            if(optionLegType.count > 0){
                cell.drpLegType.selectedIndex = 0
                cell.drpLegType.text = optionLegType[0]
            }
            cell.txTo.delegate = self
            cell.txFrom.delegate = self
            cell.txIn.delegate = self
            cell.txOut.delegate = self
            self.mytextfields.append(cell.txFrom)
            self.mytextfields.append(cell.txTo)
            self.mytextfields.append(cell.txOut)
            self.mytextfields.append(cell.txIn)
//            self.mytextfields.append(cell.drpNumber)
                self.mytextfields.append(txNotes)
            print("my text field.count is \(self.mytextfields.count)")
            
            
            return cell
//            let cell = tableView.dequeueReusableCell(withIdentifier: "clFlightCurrency") as! FlightCurrencyViewCell
//
//            cell.drpCurrency.optionArray = optionCurrency
//            cell.drpNumber.optionArray = optionNoOfTimes
//
//            //Default
//            if(optionCurrency.count > 0){
//                cell.drpCurrency.selectedIndex = 0
//                cell.drpCurrency.text = optionCurrency[0]
//            }
//            cell.drpNumber.delegate = self
////            if self.mytextfields.count == 5 {
////            self.mytextfields.append(cell.drpNumber)
////                self.mytextfields.append(txNotes)
////            }
////            print("my text field.count is \(self.mytextfields.count)")
//            return cell;
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "clFlightCurrency") as! FlightCurrencyViewCell

            cell.drpCurrency.optionArray = optionCurrency
            cell.drpNumber.optionArray = optionNoOfTimes

            //Default
            if(optionCurrency.count > 0){
                cell.drpCurrency.selectedIndex = 0
                cell.drpCurrency.text = optionCurrency[0]
            }
//            cell.drpNumber.delegate = self
//            self.mytextfields.append(cell.drpNumber)
//            if self.mytextfields.count == 5 {
//            self.mytextfields.append(cell.drpNumber)
//                self.mytextfields.append(txNotes)
//            }
//            print("my text field.count is \(self.mytextfields.count)")
            return cell;
            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "clFlightLeg") as! FlightLegViewCell;
//            cell.drpLegType.optionArray = optionLegType
//            cell.drpLegType.optionIds = optionLegTypeId
//
//
//            if(optionLegType.count > 0){
//                cell.drpLegType.selectedIndex = 0
//                cell.drpLegType.text = optionLegType[0]
//            }
//            cell.txTo.delegate = self
//            cell.txFrom.delegate = self
//            cell.txIn.delegate = self
//            cell.txOut.delegate = self
//            self.mytextfields.append(cell.txFrom)
//            self.mytextfields.append(cell.txTo)
//            self.mytextfields.append(cell.txOut)
//            self.mytextfields.append(cell.txIn)
//            self.mytextfields.append(cell.drpNumber)
//                self.mytextfields.append(txNotes)
//            print("my text field.count is \(self.mytextfields.count)")
//
//
//            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {}
    
    func calculateMaintTotal(){
        let st = txStartMaint.text
        let ed = txEndMaint.text
        
        if(st == "" || ed == ""){
            txTotalTime.text = ""
            return
        }
        let tot = Float(ed!)! - Float(st!)!
       
        txTotalTime.text = String(tot)
    }
    
    //Parse the form and create the objects form verify and save
    func parseForm () -> Bool {
        let pilotid = APIHelper.pilotid
        let operatorid = APIHelper.operatorid
        let s_maint = txStartMaint.text
        let e_maint = txEndMaint.text
        let total = txTotalTime.text
        let m_status = swMaintStatus.isOn
        let d_out = txDateOut.text
        
        //Get All the currencies
        var currencies : [CurrencyPost] = []
        for cell in tbCurrency.visibleCells as! [FlightCurrencyViewCell]{
            let c = cell.drpCurrency.text
            let n = cell.drpNumber.text
            if(c != "" && n != ""){
                let cur = CurrencyPost()
                cur.pilot = pilotid
                cur.currency = c
                cur.number = n
                currencies.append(cur)
            }
        }
        
        //Get Pilot Legs
        var legs : [LegPost] = []
        for pc in tbLeg.visibleCells as! [FlightLegViewCell]{
            let f  = pc.txFrom.text
            let t  = pc.txTo.text
            let out = pc.txOut.text
            let lin = pc.txIn.text
            let nd = pc.swLanded.isOn
            let bl = pc.txBlock.text
            if(f != "" && t != "" && out != "" && lin != "" && pc.drpLegType.text != "" ){
                
                let lt = DataHelper.flightLogData!.LegTypes.first(where: {$0.legtype == pc.drpLegType.text })!.id
                
                let leg = LegPost()
                leg.from = f
                leg.to = t
                leg.out = out
                leg.in = lin
                leg.next_day = nd
                leg.block = bl
                leg.type = lt
                legs.append(leg)
            }
            
            
        }
        let note = txNotes.text
        
        //Do some verification
        if(verifyLimit.drpCrewPosition == nil || verifyLimit.drpAircraft == "" || legs.count == 0){
            self.view.makeToast("Please check your input. Select crew position, aircraft and at least a leg")
            return false
        }
        
        //Okay, so we build the verification object here
        verifyLimit.request_pilot = pilotid
        verifyLimit.request_operator = operatorid
        let pcps = PilotCPS()
        pcps.pilot = pilotid
        pcps.cpos = verifyLimit.drpCrewPosition
        verifyLimit.txPilotCPS = []
        verifyLimit.txPilotCPS.append(pcps)
        verifyLimit.txMaintType = ""
        verifyLimit.txCurrencies = currencies
        verifyLimit.drpPerformed = "0"
        verifyLimit.drpPerformedNVG = "0"
        verifyLimit.dtOutTime = d_out
        verifyLimit.txStartMaint = s_maint
        verifyLimit.txEndMaint = e_maint
        verifyLimit.txtACTT = total
        
        //Leg 1
        verifyLimit.drpLegType1 = legs[0].type
        verifyLimit.txFrom1 = legs[0].from
        verifyLimit.txTo1 = legs[0].to
        verifyLimit.tmOut1 = legs[0].out
        verifyLimit.tmIn1 = legs[0].in
        verifyLimit.chNDay1 = legs[0].next_day
        verifyLimit.txBlock1 = legs[0].block
        
        if(legs.count > 1){
            verifyLimit.drpLegType2 = legs[1].type
            verifyLimit.txFrom2 = legs[1].from
            verifyLimit.txTo2 = legs[1].to
            verifyLimit.tmOut2 = legs[1].out
            verifyLimit.tmIn2 = legs[1].in
            verifyLimit.chNDay2 = legs[1].next_day
            verifyLimit.txBlock2 = legs[1].block
        }
        verifyLimit.txTotalCycles = String(legs.count)
        verifyLimit.txNotes = note
        
        
        //Build Save leg object
        saveLeg.request_pilot = pilotid
        saveLeg.request_operator = operatorid
        saveLeg.aircraft = verifyLimit.drpAircraft
        saveLeg.out_time = d_out
        saveLeg.notes = note
        saveLeg.performed = "0"
        saveLeg.performed_nvg = "0"
        saveLeg.start_maint = s_maint
        saveLeg.end_maint = e_maint
        saveLeg.actt = total
        saveLeg.descripancy = ""
        saveLeg.ret_service = ""
        saveLeg.maint_status = m_status
        saveLeg.maint_type = ""
        saveLeg.total_cycles = String(legs.count)
        saveLeg.legs = legs
        saveLeg.currencies = currencies
        saveLeg.pilots = verifyLimit.txPilotCPS
        
        return true
    }
    
    
    func startAnimation()
    {
        
        btnSubmitWeak.isEnabled = false;
        loadingBar.startAnimating();
    }
    
    func stopAnimation()
    {
        
        btnSubmitWeak.isEnabled = true;
        loadingBar.stopAnimating()
    }
    
    func doVerifyLimit(){
        startAnimation();
        APIHelper.VerifyLimit(data: self.verifyLimit, onCompletion: { (verifyResponse) -> Void in
            if(verifyResponse != nil)
            {
                self.stopAnimation()
                self.showConfirm(verifyResponse!)
            }
            else
            {
                self.stopAnimation()
                self.view.makeToast("Unable to check flight data, please try again")
            }
        })
    }
    
    func showConfirm(_ verifyResponse: VerifyResponse) -> Void {
        ConfirmLogViewController.showPopup(parentView: self, verifyResponse: verifyResponse)
    }
    
    //Delegates
    func datePicked(date: String){
        txDateOut.text = date
    }
    func doCreateLeg(){
        //Perfor action here
        startAnimation()
        APIHelper.SaveLeg(data: self.saveLeg, onCompletion: { (saveLegResponse) -> Void in
            
            
            self.stopAnimation()
            if(saveLegResponse != nil)
            {
                if(saveLegResponse?.Check == true){
                    
                    //Alert and go to schedules
                    self.showDialogAlert(title: "Success", message: "Flight log(s) created successfully", completion: { (res) in
                        
                        //Go to schedules
                        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        let mainView = self.storyboard?.instantiateViewController(withIdentifier: "MySchedulesViewController") as! MySchedulesViewController
                        let centerNav = UINavigationController(rootViewController: mainView)
                        appDelegate.centerContainer!.centerViewController = centerNav
                        appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                    })
                }else{
                    self.view.makeToast(saveLegResponse?.Message)
                }
            }
            else
            {
                self.view.makeToast("Error occurred while submitting flight log, please try again")
            }
        })
    }
    
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Make sure the field has non-nil text
        if textField == mytextfields[4] {
        if let text = textField.text {
            // Check if the text length has reached max limit
            if text.count > 4 {
                // Get index of field from fields array
                if let index =  mytextfields.index(of: textField) {
                    // Make sure it's not the last field in the array else return false
                    if index <  mytextfields.count-1 {
                        // Make the next field in the array become first responder if it's text is non-nil and it's text's character count is less than desired max
                        if  mytextfields[index+1].text != nil &&  mytextfields[index+1].text!.count < 4 {
                            mytextfields[index+1].becomeFirstResponder()
                        } else {
                            return false
                        }
                    } else {
                        return false
                    }
                }
            }
        }
        }
        if textField == mytextfields[0] {
        if let text = textField.text {
            // Check if the text length has reached max limit
            if text.count > 5 {
                // Get index of field from fields array
                if let index =  mytextfields.index(of: textField) {
                    // Make sure it's not the last field in the array else return false
                    if index <  mytextfields.count-1 {
                        // Make the next field in the array become first responder if it's text is non-nil and it's text's character count is less than desired max
                        if  mytextfields[index+1].text != nil &&  mytextfields[index+1].text!.count < 5 {
                            self.view.endEditing(true)
                            mytextfields[index+1].becomeFirstResponder()
                        } else {
                            return false
                        }
                    } else {
                        return false
                    }
                }
            }
        }
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let index = mytextfields.index(of: textField) {
            let nextindex = index + 1
            let lastindex = mytextfields.count - 1
            if nextindex <= lastindex {
                mytextfields[nextindex].becomeFirstResponder()
                
            }
        }
//        if textField == mytextfields[4] {
//            if textField.text?.count == 4 {
//
//            }
//
//
//        }
        if textField == mytextfields[6] {
            textField.resignFirstResponder()
//            mytextfields[4].resignFirstResponder()

        }
//        if textField == mytextfields[5] {
//            textField.resignFirstResponder()
//            self.view.endEditing(true)
//
//        }
        return true
    }
    
}
extension UITextField{

 func addDoneButtonToKeyboard(myAction:Selector?){
//    func addDoneButtonToKeyboard(){
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    doneToolbar.barStyle = UIBarStyle.default

    let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)
//        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(removedone))


    var items = [UIBarButtonItem]()
    items.append(flexSpace)
    items.append(done)

    doneToolbar.items = items
    doneToolbar.sizeToFit()

    self.inputAccessoryView = doneToolbar
 }
    @objc func removedone () {
        self.resignFirstResponder()
       
//        self.becomeFirstResponder()
//        nextbtn()
//        MyCalenderViewController.showCalender(parentView: CreateFlightViewController)
    }
//    func nextbtn() {
//        self.becomeFirstResponder()
//    }
}
