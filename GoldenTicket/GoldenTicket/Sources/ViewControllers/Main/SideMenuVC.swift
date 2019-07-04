//
//  SideMenuVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 02/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import Hero
import SideMenu

class SideMenuVC: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        
        guard SideMenuManager.default.menuBlurEffectStyle == nil else {return}
        
        // 스크롤 되지 않고 고정되게 하기위해.
        tableView.isScrollEnabled = false
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell
        
        cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell
        
        if indexPath.row == 1 {
            let storyboardWin = UIStoryboard.init(name: "WinList", bundle: nil)
            guard let dvc1 = storyboardWin.instantiateViewController(withIdentifier: "WinList") as? WinTicketsVC else{
                return
            }
            present(dvc1, animated: true)
            //navigationController?.pushViewController(dvc1, animated: true)
        }
        else if indexPath.row == 2 {
            let storyboardInterested = UIStoryboard.init(name: "Interested", bundle: nil)
            guard let dvc2 = storyboardInterested.instantiateViewController(withIdentifier: "InterestedVC") as? InterestedVC else {
                return
            }
            present(dvc2, animated: true)
        }
        else if indexPath.row == 6 {
            let storyboardQuestion = UIStoryboard.init(name: "Question", bundle: nil)
            guard let dvc5 = storyboardQuestion.instantiateViewController(withIdentifier: "QuestionVC") as? QuestionVC else {
                return
            }
            present(dvc5, animated: true)
        }
    }
    

    @IBAction func buttonClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}



