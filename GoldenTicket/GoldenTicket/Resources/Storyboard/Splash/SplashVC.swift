//
//  SplashVC.swift
//  GoldenTicket
//
//  Created by 황수빈 on 06/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import SwiftGifOrigin
import SwiftOverlayShims

class SplashVC: UIViewController {

    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = UIImage.gif(name: "mainLogo")

        do {
            let imageData = try Data(contentsOf: Bundle.main.url(forResource: "mainLogo", withExtension: "gif")!)
            self.imageView.image = UIImage.gif(data: imageData)
            
        } catch {
            print(error)
        }
        
        perform(#selector(SplashVC.showLogin), with: nil, afterDelay: 2.1)
        
    }
    @objc func showLogin() {
        let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
        let login = storyboard.instantiateViewController(withIdentifier: "loginVC")
        present(login, animated: true)
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


