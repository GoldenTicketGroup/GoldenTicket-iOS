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
    @IBOutlet var contraintsY: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 흰색 뷰에 그림자를 추가
        whiteView.layer.masksToBounds = false
        whiteView.layer.shadowOpacity = 1
        whiteView.layer.shadowRadius = 6
        whiteView.layer.shadowColor = UIColor.black16.cgColor
        whiteView.layer.shadowOffset = CGSize(width: 0, height: 0)

        let heightSize = superView.frame.size.height
        // self.myView.frame.size.height
        contraintsY.constant = heightSize * 0.98
    }
}
