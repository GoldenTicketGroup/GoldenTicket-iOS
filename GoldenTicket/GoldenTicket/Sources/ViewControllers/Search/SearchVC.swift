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

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var searchView: UIView!
    
    var searchShowList : [SearchShow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.isHidden = true
        
        searchField.attributedPlaceholder = NSAttributedString(string: "어떤 공연을 찾고 계신가요?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.peach])
                
        //텍스트 필드 customize.

        searchView.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 2)
        searchView.makeRounded(cornerRadius: 22.5)
        searchView.layer.masksToBounds = false
    }
    

    @IBAction func backButton(_ sender: Any) {
        // 우선적으로 검색 기록이 남아있는경우 dismiss 해주기
        if collectionView.isHidden == false {
            searchField.text = ""
            collectionView.isHidden = true
        } else {
            let storyboardMain = UIStoryboard.init(name: "Main", bundle: nil)
            let goBack = storyboardMain.instantiateViewController(withIdentifier: "MainVC")
            
            present(goBack, animated: true)
        }
    }
    
    
    @IBAction func goSearch(_ sender: Any) {
        
        guard let searchWord = searchField.text else { return }
        
        if searchField.text ==  searchWord {
            
            SearchService.shared.searchShow(searchWord) {
                data in
                // guard let 'self' = self else {return}
                
                print(searchWord)
                
                switch data {
                case .success(let res) :
                    
                    self.searchShowList = res as! [SearchShow]
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                    
                case .requestErr(let message):
                    self.simpleAlert(title: "실패", message: "\(message)")
                    self.collectionView.isHidden = true
                case .pathErr:
                    print(".pathErr")
                    self.collectionView.isHidden = true
                case .serverErr:
                    print(".serverErr")
                    self.collectionView.isHidden = true
                case .networkFail:
                    self.simpleAlert(title: "불러오기 실패", message: "네트워크 상태를 확인해주세요.")
                    self.collectionView.isHidden = true
                }
            }
            
        }
    }
    
    //취소 버튼 누를시 입력 취소
    @IBAction func cancleButton(_ sender: Any) {
        searchField.text = ""
    }
    
    //추천 검색어 누를시 해당 검색어에 대한 공연정보 업로드 - 서버와 통신으로 해당 컬렉션뷰 띄우기
    //print 는 제대로 눌러지는지 테스트용
    @IBAction func recSearchButton(_ sender: UIButton) {
        
        guard let keyword = sender.titleLabel?.text else {return}
        print(keyword)
        
        if sender.titleLabel?.text == keyword {
            SearchService.shared.keywordSearch(keyword) {
                data in
                switch data {
                case .success(let res) :
                    
                    self.searchShowList = res as! [SearchShow]
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                    
                case .requestErr(let message):
                    self.simpleAlert(title: "실패", message: "\(message)")
                    self.collectionView.isHidden = true
                case .pathErr:
                    print(".pathErr")
                    self.collectionView.isHidden = true
                case .serverErr:
                    print(".serverErr")
                    self.collectionView.isHidden = true
                case .networkFail:
                    self.simpleAlert(title: "불러오기 실패", message: "네트워크 상태를 확인해주세요.")
                    self.collectionView.isHidden = true
                }
            }
        }
    }
    
    
}

extension SearchVC : UICollectionViewDataSource
{
    
    // UICollectionView 에 얼마나 많은 아이템을 담을 지 설정합니다.
    // 현재는 likeList 배열의 count 갯수 만큼 반환합니다.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        print(searchShowList.count)
        return searchShowList.count
    }
    
    // 각 index 에 해당하는 셀에 데이터를 주입합니다.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCVCell
        let show = searchShowList[indexPath.row]
        
        cell.showImage.imageFromUrl(show.image_url, defaultImgPath: "https://sopt24server.s3.ap-northeast-2.amazonaws.com/poster_benhur_info.jpg")
        
        return cell
    }
}



extension SearchVC : UICollectionViewDelegateFlowLayout
{
    // Collection View Cell 의 width, height 를 지정할 수 있습니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width: CGFloat = (view.frame.width - 21) / 2
        let height: CGFloat = 236

        return CGSize(width: width, height: height)
    }
}
