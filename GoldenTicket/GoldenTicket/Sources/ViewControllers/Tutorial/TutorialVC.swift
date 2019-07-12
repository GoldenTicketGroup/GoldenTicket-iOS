//
//  TutorialVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 08/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController {

    @IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    
    @IBOutlet weak var tutorialPoster: UIImageView!
    
    @IBOutlet weak var tutorialBottom: UIImageView!
    
    @IBOutlet weak var tutorialButtonImg: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tutorialPoster.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 3)
        tutorialBottom.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 3)
        
        swipeRecognizer.direction = .left
        tutorialButtonImg.makeRounded(cornerRadius: 14)
    }
    

    /*
    // 추가해야할 부분
     앱을 처음 사용하는 사용자가 아닐 때에는 tutorial을 유저 flag에 따라 보이고, 안 보이고 처리해야함
    }
    */

}
