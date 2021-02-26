
//
//  DrawerViewController.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 10/01/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit
import MMDrawerController

class DrawerViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tbDrawer: UITableView!
    
    struct MenuItem {
        var Icon: String
        var Label: String
    }
    
    private var MenuItems: [MenuItem] = [MenuItem(Icon: "home_blue", Label: "Home"),MenuItem(Icon: "currency_blue", Label: "Currencies"),MenuItem(Icon: "training_blue", Label: "Training"),MenuItem(Icon: "schedule_blue", Label: "Schedule"), MenuItem(Icon: "create_flight_blue", Label: "Flight Log"), MenuItem(Icon: "power-button_blue", Label: "Logout"), ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tbDrawer.dataSource = self
        tbDrawer.delegate = self
        
        let profile = self.getProfile()
        
        lblName.text = "\(profile.firstname ?? "") \(profile.lastname ?? "")"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MenuItems.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrawerTableCell") as! DrawerViewCell
        cell.menuLabel.text = MenuItems[indexPath.row].Label
        cell.menuIcon.image = UIImage(named: MenuItems[indexPath.row].Icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        switch(indexPath.row){
            case 0:
                let mainView = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                let centerNav = UINavigationController(rootViewController: mainView)
                appDelegate.centerContainer!.centerViewController = centerNav
                appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break;
            case 1:
                let mainView = self.storyboard?.instantiateViewController(withIdentifier: "MyCurrenciesViewController") as! MyCurrenciesViewController
                let centerNav = UINavigationController(rootViewController: mainView)
                appDelegate.centerContainer!.centerViewController = centerNav
                appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break;
            case 2:
                let mainView = self.storyboard?.instantiateViewController(withIdentifier: "MyTrainingsViewController") as! MyTrainingsViewController
                let centerNav = UINavigationController(rootViewController: mainView)
                appDelegate.centerContainer!.centerViewController = centerNav
                appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break;
            case 3:
                let mainView = self.storyboard?.instantiateViewController(withIdentifier: "MySchedulesViewController") as! MySchedulesViewController
                let centerNav = UINavigationController(rootViewController: mainView)
                appDelegate.centerContainer!.centerViewController = centerNav
                appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break;
            case 4:
                let mainView = self.storyboard?.instantiateViewController(withIdentifier: "CreateFlightViewController") as! CreateFlightViewController
                let centerNav = UINavigationController(rootViewController: mainView)
                appDelegate.centerContainer!.centerViewController = centerNav
                appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break;
            case 5:
                //Logout
                //Got to login
                    self.clearDefaults()
                    self.performSegue(withIdentifier: "sgDrToLogin", sender: self)
                break;
            default:
                let mainView = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                let centerNav = UINavigationController(rootViewController: mainView)
                appDelegate.centerContainer!.centerViewController = centerNav
                appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break;
        
        }
    }
    
}
