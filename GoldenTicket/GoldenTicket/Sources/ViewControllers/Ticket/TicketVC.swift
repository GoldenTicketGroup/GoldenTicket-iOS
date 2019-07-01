//
//  TicketVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 02/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class TicketVC: UIViewController {

    @IBOutlet weak var ticketBottomView: UIImageView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // bottomticketImage 에 그림자 설정해주기 - extension 파일사용
        ticketBottomView.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
    }
    
    //backBtn 누르면 main 화면으로 돌아가도록.
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //확인버튼 누르면 main 화면으로 돌아가도록.
    @IBAction func checkButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // x 버튼 누르면 main 화면으로 돌아가도록.
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
