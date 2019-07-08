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

         initGestureRecognizer()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
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
                    
                // data가 nil이니까 서버는 갔다왔고 ==> 수정 됨
                case .success(let data):
                    print("회원정보 수정 성공")
                    
                    // UserDefaults 값만 수정해주면 ok
                    UserDefaults.standard.set(name, forKey: "name")
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(phone, forKey: "phone")
                    
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

extension EditInfoViewController: UIGestureRecognizerDelegate {
    
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        view.addGestureRecognizer(textFieldTap)
    }
    
    // 다른 위치 탭했을 때 키보드 없어지는 코드
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.userName.resignFirstResponder()
        self.userEmail.resignFirstResponder()
        self.userPhone.resignFirstResponder()
    }
    
    
    func gestureRecognizer(_ gestrueRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: userName))! || (touch.view?.isDescendant(of: userEmail))! || (touch.view?.isDescendant(of: userPhone))! {
            
            return false
        }
        return true
    }
    
    // keyboard가 보여질 때 어떤 동작을 수행
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight: CGFloat // 키보드의 높이
        
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        // animation 함수
        // 최종 결과물 보여줄 상태만 선언해주면 애니메이션은 알아서 발생한다.
        // duration은 간격
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            
            // +로 갈수록 y값이 내려가고 -로 갈수록 y값이 올라간다.
            // self.viewYcenter.constant = -keyboardHeight/2
            //self.stackYcenter.constant = -keyboardHeight/5
        })
        
        self.view.layoutIfNeeded()
    }
    
    // keyboard가 사라질 때 어떤 동작을 수행
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            
            // 원래대로 돌아가도록
            //self.stackYcenter.constant = -20
            // self.viewYcenter.constant = -30
        })
        
        self.view.layoutIfNeeded()
    }
    
    
    // observer
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
