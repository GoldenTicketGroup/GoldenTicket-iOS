//
//  NoTicketVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 05/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class NoTicketVC: UIViewController {

    @IBOutlet weak var goShowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
