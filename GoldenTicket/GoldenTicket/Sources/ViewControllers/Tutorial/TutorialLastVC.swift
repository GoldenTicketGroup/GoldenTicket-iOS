//
//  TutorialLastVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 08/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

class TutorialLastVC: UIViewController {

    @IBOutlet weak var ticketSample: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ticketSample.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 3)
    }
}
