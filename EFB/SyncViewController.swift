//
//  SyncViewController.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 26/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit
import MMDrawerController
class SyncViewController: BaseViewController {
    
    @IBOutlet weak var prgProgress: UIProgressView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnCancelOutlet: RoundedButton!
    var iscancelled = false;
    var cancelable = false;
    @IBOutlet weak var actWaiting: UIActivityIndicatorView!
    
    var Directories = [EFBDirectory]();
    
    //These are the variables for progress bar;
    var totalFiles = 0;
    var progressUnit = 0.0;
    var progress = 0.0;
    var cntprg = 1;
    @IBAction func btnCancel(_ sender: Any) {
        
        if(cancelable)
        {
            //Nivagate to back to homepage
//            self.performSegue(withIdentifier: "sgStoMain", sender: self)
            self.goToMain()
        }
        else
        {
            disableCancel();
            iscancelled = true;
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
print("its okay")
        // Do any additional setup after loading the view.
        let check = Reachability.isConnected()
        if check == false
        {
            showDialogAlert(title: "No Internect Connection", message: "Make sure your device is connected to the internet", completion: { result in
                //Nivagate to back to homepage
//                self.performSegue(withIdentifier: "sgStoMain", sender: self)
                self.goToMain()
            })
        }
        else
        {
            loadFiles()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Check for internet, if it exists, proceed, if not quite.
        super.viewDidAppear(true)
        print("its okay 1")
        let check = Reachability.isConnected()
        if check == false
        {
            showDialogAlert(title: "No Internect Connection", message: "Make sure your device is connected to the internet", completion: { result in
                //Nivagate to back to homepage
//                self.performSegue(withIdentifier: "sgStoMain", sender: self)
                self.goToMain()
            })
        }
        else
        {
            loadFiles()
        }
    }
    
    private func loadFiles()
    {
        cancelable = false;
        //Get Files from server
        self.disableCancel();
        APIHelper.GetFiles { (directories) -> Void in
            if(directories != nil)
            {
                self.Directories = directories!
                
                DispatchQueue.global(qos: .userInitiated).async {
                    [weak self] in
                    guard let self = self else {
                        return
                    }
                     self.processFolders();
                    self.cancelable = true;
                }
               
            }
            else
            {
                //Remove everything in the EFB Directory
                FileHelper.emptyMainDirectory()
                //if no directory is found, then go back to menu
                self.showDialogAlert(title: "No Files", message: "No file returned from the server", completion: { result in
                    //Nivagate to back to homepage
//                    self.performSegue(withIdentifier: "sgStoMain", sender: self)
                    self.goToMain()
                })
            }
        }
    }
    
    //This function attempts to process the files
    private func processFolders()
    {
        
        //Remove everything in the EFB Directory, this is quite unreasonable, but what can I do?
        FileHelper.emptyMainDirectory()
        
        //First get total files from result
        
        totalFiles = self.getTotalFiles()
        
        if(Directories.count == 0)
        {
            
            //if no directory is found, then go back to menu
            self.showDialogAlert(title: "No Files", message: "No file returned from the server", completion: { result in
                //Nivagate to back to homepage
//                self.performSegue(withIdentifier: "sgStoMain", sender: self)
                self.goToMain()
            })
            return;
        }
        //Calculate loader from the total files
        if(totalFiles > 0)
        {
            progressUnit = Double(1/totalFiles)
        }
        
        //lblStatus.text = "Processing files...."
        var dcount = 0;
        for dir in Directories
        {
            if(iscancelled){
                break;
            }
            dcount += 1;
            let check = FileHelper.createDirectory(directory: dir.DirectoryName)
            //Increment loader
            if (check && totalFiles > 0)
            {
                
                self.processFiles(folder: dir.DirectoryName, files: dir.Files)
               
            }
            
            //If no file is found but some directories are found, after creating the
            //Directories, close the window
            if(totalFiles == 0 && dcount >= Directories.count)
            {
                
                //if no directory is found, then go back to menu
//                self.showDialogAlert(title: "No Files", message: "No file returned from the server", completion: { result in
//                    //Nivagate to back to homepage
//                    self.performSegue(withIdentifier: "sgStoMain", sender: self)
//                })
                //Nivagate to back to homepage
//                self.performSegue(withIdentifier: "sgStoMain", sender: self)
                self.goToMain()
                return;
            }
            
        }
    }
    
    //Download all files for directory
    private func processFiles(folder: String?, files: [EFBFile] )
    {
        DispatchQueue.main.async
        {
                [weak self] in
                self?.enableCancel();
                
        }
        for f in files
        {
            
            if(iscancelled){
                break;
            }
            
            let url = URL (string: f.url!)
            FileDownloader.loadFileSync(url: url!, folder: folder) { (path, error) in
                DispatchQueue.main.async
                {
                    [weak self] in
                    //update label
                
                    //Implement cancel here
                    if(self?.iscancelled == true || self == nil)
                    {
//                        self?.performSegue(withIdentifier: "sgStoMain", sender: self)
                        print("Got to condition")
//                        self?.goToMain()
                        return
                    }
                    
                    
                    let lbl = "Processing file " + String(self!.cntprg) + " of " + String(self!.totalFiles)
                    self?.lblStatus.text = lbl;
                    //Increase progress
                    self?.progress = (self?.progress)! + (self?.progressUnit)!
                    self?.prgProgress.progress = Float((self?.progress)!);
                    self?.cntprg = (self?.cntprg)! + 1

		   //Check if this is the last file and update string accordingly
                    if(self?.cntprg ?? 1 >= self!.totalFiles)
                    {
                        let str = "Sync Complete. " + String(self!.totalFiles) + " total files processed";
                        self?.lblStatus.text = str;
                        print("Got to condition 1")
                        
                        //Change button text
                        //self?.btnCancelOutlet.setTitle("Go Back", for: .normal)
                        //21-01-2020
                        
                        //Nivagate to back to homepage
//                        self?.performSegue(withIdentifier: "sgStoMain", sender: self)
                        
                        self?.goToMain()
                        return;
                    }
                }
               
            }
        }
    }
    
    private func getTotalFiles() -> Int
    {
        var cnt = 0;
        for dir in Directories
        {
            cnt = cnt + dir.Files.count
        }
        return cnt
    }
    
    func disableCancel()
    {
        actWaiting.startAnimating()
        btnCancelOutlet.isEnabled = false;
    }
    func enableCancel()
    {
        actWaiting.stopAnimating()
        btnCancelOutlet.isEnabled = true;
    }
    
    private func goToMain(){
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
      
        appDelegate.startDrawerView()

        
    }
  

}
