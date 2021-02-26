//
//  FileViewController.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 29/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit
import PDFKit

class FileViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UIDocumentInteractionControllerDelegate {
    
    var documentInteractionController: UIDocumentInteractionController!
    @IBOutlet weak var tbFile: UITableView!
    var Directory =  DirectoryVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tbFile.dataSource = self;
        tbFile.delegate = self;
        self.title = Directory.DirectoryName
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Directory.Files.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clFile") as! FileViewCell;
        cell.flFileName.text = Directory.Files[indexPath.row].FileName
        cell.lbDescription.text = (Directory.Files[indexPath.row].LastUpdatedString ?? "") + " " + (Directory.Files[indexPath.row].FileSize ?? "")
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let url = URL(fileURLWithPath: Directory.Files[indexPath.row].FullPath!)
        self.documentInteractionController = UIDocumentInteractionController(url: url)

        self.documentInteractionController.delegate = self;

        //self.documentInteractionController.present
        let rect = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)

        self.documentInteractionController.presentOpenInMenu(from: rect, in: self.view!, animated: true);

//        openPDF(url: url);
    }
    
    func openPDF(url: URL)
    {
        let pdoc = PDFDocument (url: url);
        let pv = PDFView(frame: self.view.bounds);
        self.view.addSubview(pv);
        pv.autoScales = true;
        pv.document = pdoc;
        
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController
    {
        return self;
    }
    
}
