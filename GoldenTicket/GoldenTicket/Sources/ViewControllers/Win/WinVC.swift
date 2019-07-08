//
//  WinVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 08/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import SwiftGifOrigin
import SwiftOverlayShims

class WinVC : UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = UIImage.gif(name: "win")
        
        do {
            let imageData = try Data(contentsOf: Bundle.main.url(forResource: "win", withExtension: "gif")!)
            self.imageView.image = UIImage.gif(data: imageData)
            
        } catch {
            print(error)
        }
        
    }
}
