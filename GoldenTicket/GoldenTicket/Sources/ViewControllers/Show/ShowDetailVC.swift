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
    
    //응모하기 뷰
    @IBOutlet weak var checkView: CustomView!
    @IBOutlet weak var fillView: UIView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var applyButton: CustomButton!
    
    //좋아요 버튼
    @IBOutlet weak var likeButton: UIButton!
    
    //응모하기 뷰에서 시간선택 창 만들기
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    //스크롤뷰
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    // drop list 테스트용 데이터
    var timeList = ["오후 4 : 00", "오후 5 : 00", "오후 6 : 00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 테스트용 더미 데이터 세팅해두기.
        setContent()
        setData()
        
        //poster image customize
        posterImage.makeRounded(cornerRadius: 10)
        
        //drop button
        btnDrop.layer.cornerRadius = 20
        btnDrop.layer.borderWidth = 1
        btnDrop.layer.borderColor = UIColor.maize.cgColor
        btnDrop.layer.masksToBounds = true
        
        // 응모하기 뷰 그림자주기
        
        checkView.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        //checkView.roundCorners(corners: [.topRight, .topLeft], radius: 20)
        checkView.makeRounded(cornerRadius: 20)
        checkView.layer.masksToBounds = false
        
        //drop table view 숨기기
        tblView.isHidden = true
        //tblviw corner radius
        tblView.makeRounded(cornerRadius: 8)
        
        // fillViewButton corner radius 설정해주기
        fillView.layer.cornerRadius = 22
        
        // dataSource 지정해주기
        actorCollectionView.dataSource = self
        
        //scroll view delegate
        scrollView.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let index = tblView.indexPathForSelectedRow {
            tblView.deselectRow(at: index, animated: true)
        }
    }
    
    @IBAction func onClickDropButton(_ sender: Any) {
        if tblView.isHidden {
            animate(toggle: true)
        } else {
            animate(toggle: false)
        }
    }
    
    func animate(toggle: Bool) {
        if toggle{
            UIView.animate(withDuration: 0.3) {
                self.tblView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.tblView.isHidden = true
            }
        }
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
    
    // 메인 화면으로 돌아가는 backButton 함수
    @IBAction func backButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // 좋아요 버튼 누를 시 fill heart.
    @IBAction func onClickedLikeButton(_ sender: Any) {
        
        let liked: Bool = true
        
        if(liked) {
            likeButton.setImage(UIImage(named: "btLikeInfo" ), for: UIControl.State.normal)
        }
        
    }

    // 응모하기 창에서 화살표 버튼 클릭시 drawer 올리기.
    @IBAction func checkUpButton(_ sender: UIButton) {
        if fillView.transform == .identity {
            UIView.animate(withDuration: 1, animations: {
                self.fillView.transform = CGAffineTransform(scaleX: 0, y: 0)
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
    
    // 응모하기 버튼 클릭 시 drawer 올리기.
    @IBAction func applyButtonAction(_ sender: UIButton) {
        
        if fillView.transform == .identity {
            UIView.animate(withDuration: 1, animations: {
                self.fillView.transform = CGAffineTransform(scaleX: 0, y: 0)
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
    
    // scroll시 응모하기 뷰 내리고 올리기
    func showMenuView() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            
            self.checkView.transform = CGAffineTransform(translationX: 0, y: 248)
        })
        
        self.view.layoutIfNeeded()
    }
    func hideMenuView() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.checkView.transform = .identity
        })
        
        self.view.layoutIfNeeded()
    }
    
    
    @IBAction func selectShow(_ sender: Any) {
        let storyboardLottery = UIStoryboard(name: "Lottory", bundle: nil)
        let dvc = storyboardLottery.instantiateViewController(withIdentifier: "waitLottery")
        present(dvc, animated: true)
    }
    
}

// 스크롤시 응모하기 뷰 올리고 내리기
extension ShowDetailVC : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yVelocity = scrollView.panGestureRecognizer .velocity(in: scrollView).y
        
        if yVelocity > 0 {
            print("up")
            hideMenuView()
            
        } else if yVelocity < 0 {
            print("down")
            showMenuView()
        }
        
    }
}


// 배우 정보 collection view datasource
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
// 배우 정보 더미데이터로 테스트하기.
extension ShowDetailVC {
    
    func setData() {
        let actor1 = Actor(image: "imgCasting01", name: "카이", casting: "유다 벤허")
        let actor2 = Actor(image: "imgCasting02", name: "문종원", casting: "메셀라")
        let actor3 = Actor(image: "imgCasting03", name: "김지우", casting: "에스더")
        let actor4 = Actor(image: "imgCasting04", name: "이병준", casting: "퀸터스")
        
        actorList = [actor1, actor2, actor3, actor4]
    }

}

extension ShowDetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = timeList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        btnDrop.setTitle("\(timeList[indexPath.row])", for: .normal)
        animate(toggle: false)
    }
    
}
