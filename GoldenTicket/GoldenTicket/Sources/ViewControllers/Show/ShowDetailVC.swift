//
//  ShowDetailVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 01/07/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import Hero


class ShowDetailVC: UIViewController {

    
    // 배우들을 보여주는 collection view.
    @IBOutlet weak var actorCollectionView: UICollectionView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var showTitle: UILabel!
    
    @IBOutlet weak var showBeforePriceLabel: UILabel!
    
    @IBOutlet weak var showAfterPriceLabel: UILabel!
    
    @IBOutlet weak var showTimeLabel: UILabel!
    
    @IBOutlet weak var showLocationLabel: UILabel!

    @IBOutlet weak var showDetailImage: UIImageView!
    
    // detail view에 필요한 정보들.
    var backgroundImg : UIImage?
    var posterImg : UIImage?
    var showName : String?
    var showBeforePrice : String?
    var showAfterPrice : String?
    var showTime : String?
    var showLocation : String?
    var showDetail : UIImage?
    
    // 더미 데이터로 넣을 배우 리스트
    var actorList : [Actor] = []
    
    @IBOutlet weak var checkView: CustomView!
    
    @IBOutlet weak var fillView: UIView!
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var applyButton: CustomButton!
    
    @IBOutlet weak var checkShadowView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 테스트용 더미 데이터 세팅해두기.
        setContent()
        setData()
        
        
        // 응모하기 뷰 그림자주기

        
        // fillViewButton corner radius 설정해주기
        fillView.layer.cornerRadius = 22
        
        // dataSource 지정해주기
        actorCollectionView.dataSource = self
    }
    
    // 메인 화면으로 돌아가는 backButton 함수
    @IBAction func backButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // 나타낼 데이터들 지정해주기
    func setContent() {
        backgroundImage.image = backgroundImg
        posterImage.image = posterImg
        showTitle.text = showName
        showBeforePriceLabel.text = showBeforePrice
        showAfterPriceLabel.text = showAfterPrice
        showTimeLabel.text = showTime
        showLocationLabel.text = showLocation
        showDetailImage.image = showDetail
    }
    
    @IBAction func checkUpButton(_ sender: UIButton) {
        if fillView.transform == .identity {
            UIView.animate(withDuration: 1, animations: {
                self.fillView.transform = CGAffineTransform(scaleX: 22, y: 22)
                self.checkView.transform = CGAffineTransform(translationX: 0, y: -93)
                self.checkButton.transform = CGAffineTransform(rotationAngle: self.radians(180))
                self.applyButton.transform = CGAffineTransform(translationX: 0, y: 600)
            }) {(true) in
                
            }
        } else {
            UIView.animate(withDuration: 1, animations: {
                self.fillView.transform = .identity
                self.checkView.transform = .identity
                self.checkButton.transform = .identity
                self.applyButton.transform = .identity
            }) {(true) in
                
            }
        }
        
    }
    
    // 버튼 애니메이션이 제대로 180 도 회전되도록 지정해주기
    func radians(_ degrees: Double) -> CGFloat {
        return CGFloat(degrees * .pi / degrees)
    }
    
    @IBAction func applyButtonAction(_ sender: UIButton) {
        
        if fillView.transform == .identity {
            UIView.animate(withDuration: 1, animations: {
                self.fillView.transform = CGAffineTransform(scaleX: 22, y: 22)
                self.checkView.transform = CGAffineTransform(translationX: 0, y: -93)
                self.checkButton.transform = CGAffineTransform(rotationAngle: self.radians(180))
                self.applyButton.transform = CGAffineTransform(translationX: 0, y: 600)
            }) {(true) in
                
            }
        } else {
            UIView.animate(withDuration: 1, animations: {
                self.fillView.transform = .identity
                self.checkView.transform = .identity
                self.checkButton.transform = .identity
                self.applyButton.transform = .identity
            }) {(true) in
                
            }
        }
        
    }
    
    

}

extension ShowDetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return actorList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCVCell", for: indexPath) as! ActorCVCell
        
        let actor = actorList[indexPath.row]
        
        cell.actorImage.image = actor.actorImage
        cell.actorName.text = actor.actorName
        cell.castingName.text = actor.castingName
        
        return cell
    }
    
    
}

extension ShowDetailVC {
    
    func setData() {
        let actor1 = Actor(image: "imgCasting01", name: "카이", casting: "유다 벤허")
        let actor2 = Actor(image: "imgCasting02", name: "문종원", casting: "메셀라")
        let actor3 = Actor(image: "imgCasting03", name: "김지우", casting: "에스더")
        let actor4 = Actor(image: "imgCasting04", name: "이병준", casting: "퀸터스")
        
        actorList = [actor1, actor2, actor3, actor4]
    }

}
