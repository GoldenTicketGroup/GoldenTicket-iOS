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
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
