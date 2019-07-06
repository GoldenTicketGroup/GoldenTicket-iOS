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
    
    @IBOutlet weak var searchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.attributedPlaceholder = NSAttributedString(string: "어떤 공연을 찾고 계신가요?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.peach])
                
        //텍스트 필드 customize.

        searchView.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 2)
        searchView.makeRounded(cornerRadius: 22.5)
        searchView.layer.masksToBounds = false
    }
    

    @IBAction func backButton(_ sender: Any) {
        let storyboardMain = UIStoryboard.init(name: "Main", bundle: nil)
        let goBack = storyboardMain.instantiateViewController(withIdentifier: "MainVC")
        
        present(goBack, animated: true)
    }
    
    
    @IBAction func goSearch(_ sender: Any) {
        if searchField.text == "뮤지컬" {
            print("제대로 입력됨.")
        } else {
            return
        }
    }
    
    //취소 버튼 누를시 입력 취소
    @IBAction func cancleButton(_ sender: Any) {
        searchField.text = ""
    }
    
    //추천 검색어 누를시 해당 검색어에 대한 공연정보 업로드 - 서버와 통신으로 해당 컬렉션뷰 띄우기
    //print 는 제대로 눌러지는지 테스트용
    @IBAction func recSearchButton(_ sender: UIButton) {
        
        switch sender.titleLabel?.text {
        case "판타지":
            print("판타지")
            break
        case "로맨스":
            print("로맨스")
            break
        case "창작뮤지컬":
            print("창작뮤지컬")
            break
        case "대학로":
            print("대학로")
            break
        case "라이선스":
            print("라이선스")
            break
        case "블루스퀘어":
            print("블루스퀘어")
            break
        case "관객참여형":
            print("관객참여형")
            break
        case "내한공연":
            print("내한공연")
            break
        case "세종문화회관":
            print("세종문화회관")
            break
        case "코미디":
            print("코미디")
            break
        default:
            print("로맨스")
            break
        }
        
        
    }
    
    
}
