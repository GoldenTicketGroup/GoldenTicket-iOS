//
//  ContentsVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 04/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class ContentsVC: UIViewController {
    
    @IBOutlet weak var goInfoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goInfoButton.layer.cornerRadius = 20
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
