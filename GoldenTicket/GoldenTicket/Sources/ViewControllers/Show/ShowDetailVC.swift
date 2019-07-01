//
//  ShowDetailVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 01/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class ShowDetailVC: UIViewController {

    var backgroundImg : UIImage?
    var posterImg : UIImage?
    var showName : String?
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var showTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setContent()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setContent() {
        backgroundImage.image = backgroundImg
        posterImage.image = posterImg
        showTitle.text = showName
    }

}
