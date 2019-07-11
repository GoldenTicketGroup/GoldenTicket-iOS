//
//  TicketVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 02/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import Hero

class TicketVC: UIViewController {

    @IBOutlet var ticketView: UIImageView!
    @IBOutlet weak var ticketBottomView: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var okButton: CustomButton!
    
    // 당첨티켓 outlet 선언
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var seatLabel: UILabel!
    var isPaid : Int?
    var ticketIdx : Int?
    var todayTicket : WinTicket!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        okButton.layer.cornerRadius = 18
        
        // 좋아요 통신
        TicketService.shared.todayTicket() {
            [weak self]
            data in
            
            guard let `self` = self else { return }
            
            switch data {
                
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                print("오늘 티켓 조회 성공")
                
                self.todayTicket = res as! WinTicket
                self.dateLabel.text = self.todayTicket.date
                self.titleLabel.text = self.todayTicket.name
                self.priceLabel.text = self.todayTicket.price
                self.locationLabel.text = self.todayTicket.location
                self.timeLabel.text = self.todayTicket.running_time
                self.seatLabel.text = self.todayTicket.seat_type
                
            case .requestErr(let message):
                self.simpleAlert(title: "오늘 티켓 조회 실패", message: "\(message)")
                
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                self.simpleAlert(title: "오늘 티켓 조회 실패", message: "네트워크 상태를 확인해주세요.")
            }
        }
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
