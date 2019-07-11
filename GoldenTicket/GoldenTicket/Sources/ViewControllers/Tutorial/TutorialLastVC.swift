//
//  TutorialLastVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 08/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

class TutorialLastVC: UIViewController {

    @IBOutlet weak var ticketSample: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ticketSample.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 3)
        
//        if connectedToNetwork() {
//
//        } else {
//            let storyboardNetwork = UIStoryboard.init(name: "NetworkCheck", bundle: nil)
//            let network = storyboardNetwork.instantiateViewController(withIdentifier: "networkCheck")
//            present(network, animated: true)
//        }
        
    }
    
    
    
//    func connectedToNetwork() -> Bool {
//
//
//            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
//
//            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//
//            zeroAddress.sin_family = sa_family_t(AF_INET)
//
//
//
//            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
//
//                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
//
//                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
//
//                }
//
//            }
//
//
//
//            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
//
//            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
//
//                return false
//
//            }
//
//
//
//            /* Only Working for WIFI
//
//             let isReachable = flags == .reachable
//
//             let needsConnection = flags == .connectionRequired
//
//
//
//             return isReachable && !needsConnection
//
//             */
//
//
//
//            // Working for Cellular and WIFI
//
//            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
//
//            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//
//            let ret = (isReachable && !needsConnection)
//
//
//
//            return ret
//
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
