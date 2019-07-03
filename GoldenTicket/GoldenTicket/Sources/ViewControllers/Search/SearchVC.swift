//
//  SearchVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 30/06/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import Hero

class SearchVC: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.attributedPlaceholder = NSAttributedString(string: "    어떤 공연을 찾고 계신가요?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.peach])
                
        //텍스트 필드 customize.

        searchField.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 2)
        searchField.makeRounded(cornerRadius: 22)
        searchField.layer.masksToBounds = false
    }
    

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
