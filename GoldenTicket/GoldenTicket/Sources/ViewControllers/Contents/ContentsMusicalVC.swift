//
//  ContentsMusicalVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 07/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class ContentsMusicalVC: UIViewController {
    @IBOutlet weak var goInfoButton1: UIButton!
    @IBOutlet weak var goInfoButton2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goInfoButton1.makeRounded(cornerRadius: 20)
        goInfoButton2.makeRounded(cornerRadius: 20)
    }

    @IBAction func cancleButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
