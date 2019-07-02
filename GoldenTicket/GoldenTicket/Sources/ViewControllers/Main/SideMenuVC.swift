//
//  SideMenuVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 02/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuVC: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        guard SideMenuManager.default.menuBlurEffectStyle == nil else {return}
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell
        
        cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
        
        return cell
        
    }

    @IBAction func buttonClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
