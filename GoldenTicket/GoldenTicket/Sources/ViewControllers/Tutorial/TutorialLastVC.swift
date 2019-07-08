//
//  TutorialLastVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 08/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class TutorialLastVC: UIViewController {

    @IBOutlet weak var ticketSample: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ticketSample.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 3)
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
