//
//  NoTicketVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 05/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import SwiftGifOrigin
import SwiftOverlayShims

class NoTicketVC: UIViewController {

    @IBOutlet weak var goShowButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.imageView.image = UIImage.gif(name: "noTicket")
        
        do {
            let imageData = try Data(contentsOf: Bundle.main.url(forResource: "noTicket", withExtension: "gif")!)
            self.imageView.image = UIImage.gif(data: imageData)
            
        } catch {
            print(error)
        }
        // Do any additional setup after loading the view.
        goShowButton.layer.cornerRadius = 17.5
        goShowButton.layer.masksToBounds = true
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goShow(_ sender: Any) {
        let storyboardSearch = UIStoryboard.init(name: "Search", bundle: nil)
        let dvc = storyboardSearch.instantiateViewController(withIdentifier: "SearchVC")
        present(dvc, animated: true)
    }
    
}
