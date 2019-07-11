//
//  LotteryInVC.swift
//  GoldenTicket
//
//  Created by 황수빈 on 11/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class LotteryInVC: UIViewController {

    var scheduleIdx : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func lotteryBtn(_ sender: UIButton) {
        
        guard let idx = self.scheduleIdx else { return }
        print("scheduleIdx \(scheduleIdx!)")
        
        LotteryService.shared.lotteryIn(scheduleIdx: idx) {
            [weak self]
            data in
            
            guard let `self` = self else { return }
            //print("data : \(data)")
            switch data {
                
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                print("응모 성공")
                
            case .requestErr(let message):
                self.simpleAlert(title: "응모 실패", message: "\(message)")
                
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                self.simpleAlert(title: "응모 실패", message: "네트워크 상태를 확인해주세요.")
            }
        }
    }

}
