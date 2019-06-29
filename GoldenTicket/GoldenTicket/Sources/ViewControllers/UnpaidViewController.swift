//
//  UnpaidViewController.swift
//  GoldenTicket
//
//  Created by 황수빈 on 30/06/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class UnpaidViewController: UIViewController {

    @IBOutlet var ticketImgView: UIImageView!
    @IBOutlet var ticketView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ticketImgView.layer.masksToBounds = false;
        ticketImgView.layer.shadowOffset = CGSize(width: 0, height: 3);
        ticketImgView.layer.shadowRadius = 6;
        ticketImgView.layer.shadowOpacity = 0.35;
        
        ticketView.layer.masksToBounds = false;
        ticketView.layer.shadowOffset = CGSize(width: 0, height: 0);
        ticketView.layer.shadowRadius = 6;
        ticketView.layer.shadowOpacity = 0.16;
    }
    
}
