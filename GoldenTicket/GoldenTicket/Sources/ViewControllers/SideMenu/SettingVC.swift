//
//  SettingVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 07/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class SettingVC: UITableViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigationBar clear 하게 setting 하기.
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        // 로그인한 사용자 이름으로 메인 label 반영
        let user = UserDefaults.standard
        
        // 저장된 값을 꺼내어 각 컨트롤에 적용
        self.userName.text = user.string(forKey: "name")
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.backgroundView?.backgroundColor = UIColor.white
            header.textLabel?.textColor = UIColor.blueGrey
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
