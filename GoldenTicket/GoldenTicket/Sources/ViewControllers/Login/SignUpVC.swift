//
//  SignUpVC.swift
//  GoldenTicket
//
//  Created by 황수빈 on 04/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet var superView: UIView!
    @IBOutlet var whiteView: UIImageView!
    
    // 키보드 제스처를 위한 stack view y축 constraint
    @IBOutlet var stackYcenter: NSLayoutConstraint!
    
    // 회원가입 시 받아야하는 유저 정보
    @IBOutlet var userName: UITextField!
    @IBOutlet var userEmail: UITextField!
    @IBOutlet var userPhone: UITextField!
    @IBOutlet var userPasswd: UITextField!
    @IBOutlet var checkPasswd: UITextField!
    
    // 비밀번호 확인 uiView
    @IBOutlet var checkView: UIView!
    
    // 이메일로 회원가입
    @IBOutlet var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initGestureRecognizer()
        
        // 흰색 뷰에 그림자를 추가
        whiteView.layer.masksToBounds = false
        whiteView.layer.shadowOpacity = 1
        whiteView.layer.shadowRadius = 6
        whiteView.layer.shadowColor = UIColor.black16.cgColor
        whiteView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    // 키보드 제어하는 메소드 호출
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {   //delegate method
        if textField == self.userName {
            textField.resignFirstResponder()
            self.userEmail.becomeFirstResponder()   // ID 입력 후 비번으로 이동
        }
        else if textField == self.userEmail {
            textField.resignFirstResponder()
            self.userPhone.becomeFirstResponder()         // 비번 입력 후 이름으로 이동
        }
        else if textField == self.userPhone {
            textField.resignFirstResponder()
            self.userPasswd.becomeFirstResponder()         // 비번 입력 후 이름으로 이동
        }
        else if textField == self.userPasswd {
            textField.resignFirstResponder()
            self.checkPasswd.becomeFirstResponder()         // 비번 입력 후 이름으로 이동
        }
        textField.resignFirstResponder()
        return true
    }
    
    
    // 뒤로 가기 버튼
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 회원 가입 버튼
    @IBAction func signupBtn(_ sender: Any) {
        guard let name = userName.text else { return }
        guard let email = userEmail.text else { return }
        guard let phone = userPhone.text else { return }
        guard let password = userPasswd.text else { return }
        guard let check = checkPasswd.text else { return }
        
        // 비밀번호와 비밀번호 확인이 일치하지 않는다면
        if password != check {
            // 흔드는 효과를 준다.
            checkView.shake()
            return
        }
        else {
            // 통신을 시도합니다.
            AuthService.shared.signup(name, email, phone, password) {
                data in
                
                switch data {
                    
                // 매개변수에 어떤 값을 가져올 것인지
                case .success(let token):
                    print("회원가입 성공")
                    // 회원가입 완료 후에는 로그인 페이지로 이동
                    self.dismiss(animated: true, completion: nil)
                    
                case .requestErr(let message):
                    self.simpleAlert(title: "회원가입 실패", message: "\(message)")
                    
                case .pathErr:
                    print(".pathErr")
                    
                case .serverErr:
                    print(".serverErr")
                    
                case .networkFail:
                    self.simpleAlert(title: "회원가입 실패", message: "네트워크 상태를 확인해주세요.")
                }
            }
        }
    }
}

// 키보드 때문에 가려지지 않게 조정하는 extension
extension SignUpVC: UIGestureRecognizerDelegate {
    
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
        self.userPasswd.resignFirstResponder()
        self.checkPasswd.resignFirstResponder()
    }
    
    
    func gestureRecognizer(_ gestrueRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: userName))! || (touch.view?.isDescendant(of: userEmail))! || (touch.view?.isDescendant(of: userPhone))! || (touch.view?.isDescendant(of: userPasswd))! || (touch.view?.isDescendant(of: checkPasswd))!{
            
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
            self.stackYcenter.constant = -keyboardHeight/5
        })
        
        self.view.layoutIfNeeded()
    }
    
    // keyboard가 사라질 때 어떤 동작을 수행
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            
            // 원래대로 돌아가도록
            self.emailLabel.alpha = 1.0
            self.stackYcenter.constant = -20
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
