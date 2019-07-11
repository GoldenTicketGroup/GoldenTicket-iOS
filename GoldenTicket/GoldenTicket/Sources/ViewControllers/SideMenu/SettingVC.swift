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
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell
        
        if indexPath.section == 1 && indexPath.row == 2 {
            
            let alert = UIAlertController(title:"로그아웃 하시겠습니까?",message: "",preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                
                let urlString: String = APIConstants.LoginURL
                guard let requestURL = URL(string: urlString) else { return }
                var request = URLRequest(url: requestURL)
                request.httpMethod = "POST"
                let session = URLSession.shared
                let task = session.dataTask(with: request) { (responseData, response, responseError) in
                    guard responseError == nil else { return }
                }
                task.resume()
                
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let loginView = storyboard.instantiateViewController(withIdentifier: "loginVC")
                self.present(loginView, animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            
            // UserDefaults.standard.removePersistentDomain(forName: "token")
            UserDefaults.standard.set(nil, forKey: "token")
            let token = UserDefaults.standard
//            let dictionary = defaults.dictionaryRepresentation()
//            dictionary.keys.forEach {key in
//                defaults.removeObject(forKey: "token")
//            }
            
            self.present(alert, animated: true)
            // token 삭제해도 nil이 아닌 쓰레기 값이 들어감
        }
    }
}
