//
//  TutorialMidVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 11/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class TutorialMidVC: UIViewController {

    @IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func swipeAction(_ sender: Any) {
        if swipeRecognizer.direction == .right {
           print("true")
        }
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
