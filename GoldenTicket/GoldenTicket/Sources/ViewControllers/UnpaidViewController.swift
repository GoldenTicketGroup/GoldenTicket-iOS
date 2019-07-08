//
//  UnpaidViewController.swift
//  GoldenTicket
//
//  Created by 황수빈 on 30/06/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class UnpaidViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet var ticketImgView: UIImageView!
    @IBOutlet var ticketView: UIImageView!
    
    // var height: CGFloat = CGRectGetHeight(self.myView.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigationBar clear 하게 setting 하기.
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        ticketImgView.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 3
        )
        ticketView.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 3)
    }
    
    @IBAction func backButton(_ sender: Any) {
        let storyboardMain = UIStoryboard.init(name: "Main", bundle: nil)
        let main = storyboardMain.instantiateViewController(withIdentifier: "MainVC")
        present(main, animated: true)
    }
}
