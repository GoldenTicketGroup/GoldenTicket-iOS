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

    @IBOutlet var userName: UILabel!
    
    @IBOutlet weak var winCount: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        
        guard SideMenuManager.default.menuBlurEffectStyle == nil else {return}
        
        // 스크롤 되지 않고 고정되게 하기위해.
        tableView.isScrollEnabled = false
        
        // 로그인한 사용자 이름으로 메인 label 반영
        let user = UserDefaults.standard
        
        // 저장된 값을 꺼내어 각 컨트롤에 적용
        self.userName.text = user.string(forKey: "name")
        
        let storyboardWin = UIStoryboard.init(name: "WinList", bundle: nil)
        guard let dvc1 = storyboardWin.instantiateViewController(withIdentifier: "WinList") as? WinTicketsVC else{
            return
        }
        let dvc2 = storyboardWin.instantiateViewController(withIdentifier: "WinList") as! WinTicketsVC
        print(dvc2.winList.count)
        print(dvc1.winList.count)
        
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
        else if indexPath.row == 4 {
            let storyboardNotice = UIStoryboard.init(name: "Notice", bundle: nil)
            guard let dvc3 = storyboardNotice.instantiateViewController(withIdentifier: "noticeVC") as? NoticeViewController else {
                return
            }
            present(dvc3, animated: true)
        }
        else if indexPath.row == 5 {
            let storyboardSetting = UIStoryboard.init(name: "Setting", bundle: nil)
            let dvc4 = storyboardSetting.instantiateViewController(withIdentifier: "settingVC")
            present(dvc4, animated: true)
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
    
    @IBAction func editButton(_ sender: Any) {
        
        let storyboardEdit = UIStoryboard.init(name: "EditInfo", bundle: nil)
        
        let dvc = storyboardEdit.instantiateViewController(withIdentifier: "EditVC")
        
        present(dvc, animated: true)
        
    }
}



