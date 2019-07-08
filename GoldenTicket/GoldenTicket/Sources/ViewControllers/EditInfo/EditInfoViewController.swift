//
//  EditInfoViewController.swift
//  GoldenTicket
//
//  Created by 황수빈 on 06/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class EditInfoViewController: UIViewController {

    @IBOutlet var navigationBar: UINavigationBar!
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var userEmail: UITextField!
    @IBOutlet var userPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // navigationBar clear 하게 setting 하기.
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        // 이름
        let user = UserDefaults.standard
        self.userName.text = user.string(forKey: "name")
        
        // 이메일
        self.userEmail.text = user.string(forKey: "email")
        
        // 전화번호
        self.userPhone.text = user.string(forKey: "phone")
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func editInfo(_ sender: UIButton) {
        
        
        /* 서버의 유저 정보를 수정하는 메소드 */
        guard let name = userName.text else { return }
        guard let email = userEmail.text else { return }
        guard let phone = userPhone.text else { return }
        
        // 비밀번호와 비밀번호 확인이 일치하지 않는다면
        if name == "" || email == "" || phone == ""{
             self.simpleAlert(title: "회원 정보를 입력하세요.", message: "")
            return
        }
        else {
            // 통신을 시도합니다.
            AuthService.shared.editInfo(name, email, phone) {
                data in
                
                switch data {
                    
                // 매개변수에 어떤 값을 가져올 것인지
                case .success(let data):
                    print("회원정보 수정 성공")
                    
                    // DataClass 에서 받은 유저 정보 반환
                    let user_data = data as! DataClass
                    
                    // 사용자의 토큰, 이름, 이메일, 전화번호 받아오기
                    let token = user_data.token
                    UserDefaults.standard.set(token, forKey: "token")
                    UserDefaults.standard.set(user_data.name, forKey: "name")
                    UserDefaults.standard.set(user_data.email, forKey: "email")
                    UserDefaults.standard.set(user_data.phone, forKey: "phone")
                    
                    // 회원가입 완료 후에는 로그인 페이지로 이동
                    self.dismiss(animated: true, completion: nil)
                    
                case .requestErr(let message):
                    self.simpleAlert(title: "회원 정보 수정 실패", message: "\(message)")
                    
                case .pathErr:
                    print(".pathErr")
                    
                case .serverErr:
                    print(".serverErr")
                    
                case .networkFail:
                    self.simpleAlert(title: "회원가입 실패", message: "네트워크 상태를 확인해주세요.")
                }
            }
        }// else
        
        
    }// func
}
