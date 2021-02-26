//
//  MainViewController.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 27/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tbDirectories: UITableView!
    private var Directories: [DirectoryVM] = []
    
    
    @IBAction func syncClicked(_ sender: Any) {
        //sgMtoSync
         self.performSegue(withIdentifier: "sgMtoSync", sender: self)
    }
    
    @IBAction func drawerClicked(_ sender: Any) {
        self.toggleDrawer();
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Directories = self.rearrangeDirectory(FileHelper.GetDirectories()) 
        tbDirectories.dataSource = self
        tbDirectories.delegate = self
        
    }
    
    func rearrangeDirectory(_ directories: [DirectoryVM]) -> [DirectoryVM]{
        var result = [DirectoryVM]()
        var tmp: DirectoryVM!; //Hold the pilot record directory temporarily
        for dir in directories{
            if (dir.DirectoryName!.contains("Pilot Record")){
                tmp = dir
                continue
            }
            result.append(dir)
        }
        if(tmp != nil){
            result.append(tmp)
        }
        return result;
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Directories.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clFolder") as! DirectoryViewCell
        cell.txFolderName.text = Directories[indexPath.row].DirectoryName
        let lbl = String(Directories[indexPath.row].Files.count) + " total files"
        cell.txTotalFiles.text = lbl
        //cell.textLabel?.text = Directories[indexPath.row].DirectoryName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "vcFile") as? FileViewController{
            vc.Directory = Directories[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
