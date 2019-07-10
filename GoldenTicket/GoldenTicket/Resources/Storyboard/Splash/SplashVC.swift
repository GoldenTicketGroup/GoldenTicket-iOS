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
        
        perform(#selector(SplashVC.showTutorial), with: nil, afterDelay: 2.1)
        
    }
    @objc func showTutorial() {
        let token = UserDefaults.standard
        if token.string(forKey: "token") != nil {
            // 토큰이 있는 경우 바로 메인으로 이동
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let tutorial = storyboard.instantiateViewController(withIdentifier: "MainVC")
            present(tutorial, animated: true)
        }
        else {
            // 토큰이 없는 경우 튜토리얼로 이동
            let storyboard = UIStoryboard.init(name: "Tutorial", bundle: nil)
            let tutorial = storyboard.instantiateViewController(withIdentifier: "tutorial")
            present(tutorial, animated: true)
        }
    }
}
