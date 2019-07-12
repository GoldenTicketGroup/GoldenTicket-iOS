//
//  TicketDataThreeVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 13/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class TicketDataThreeVC: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var ticketView: UIImageView!
    
    @IBOutlet weak var ticketBottomView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // navigationBar clear 하게 setting 하기.
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        // ticketView Image 에 그림자 설정해주기
        ticketView.layer.masksToBounds = false
        ticketView.layer.shadowOffset = CGSize(width: 0, height: 3)
        ticketView.layer.shadowRadius = 6
        ticketView.layer.shadowOpacity = 0.35
        
        
        // bottomticketImage 에 그림자 설정해주기 - extension 파일사용
        ticketBottomView.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
