//
//  QuestionVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 02/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import Hero

class QuestionVC: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // navigationBar clear 하게 setting 하기.
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
    }
    
    //back button 누르면 main 화면으로 돌아가도록.
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
