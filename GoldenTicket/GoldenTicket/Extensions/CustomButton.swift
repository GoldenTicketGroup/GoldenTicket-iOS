//
//  CustomButton.swift
//  GoldenTicket
//
//  Created by 안재은 on 28/06/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 22
        
    }
    
}
