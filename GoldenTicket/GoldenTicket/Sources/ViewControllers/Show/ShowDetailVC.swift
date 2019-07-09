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
    
    var actorList : [Artist] = []
    var timeList : [Schedule] = []
    var showIdx : Int?
    var selectedRow : String?
    
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
    
    
    // MainVC 에서 storyboard로 전달 받는 dvc outlet
    var backgroundImg : UIImageView?
    var posterImg : UIImageView?
    var showName : String?
    var showBeforePrice : String?
    var showAfterPrice : String?
    var showTime : String?
    var showLocation : String?
    var detailPoster : UIImageView?
    
    // MainVC 에서 storyboard로 전달 받는 actor 변수 선언
    var serverActorImage : UIImageView?
    var serverActorName : String?
    var serverCastingName : String?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 테스트용 더미 데이터 세팅해두기.
        setContent()
        // setActorData()
        
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
            
            
            // 선택된 테이블의 cell의 index 값으로 cell title 얻어오기
            self.selectedRow = tblView.cellForRow(at: index)?.textLabel!.text
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
        
        backgroundImage.image = backgroundImg?.image
        posterImage.image = posterImg?.image
        showTitle.text = showName
        showBeforePriceLabel.text = showBeforePrice
        showAfterPriceLabel.text = showAfterPrice
        showTimeLabel.text = showTime
        showLocationLabel.text = showLocation
        showDetailImage.image = detailPoster?.image
    }
    
    // 메인 화면으로 돌아가는 backButton 함수
    @IBAction func backButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // 좋아요 버튼 누를 시 fill heart.
    @IBAction func onClickedLikeButton(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            // 관심있는 공연에 추가되어있음
        }
        else {
            // 관심있는 공연에서 삭제함
        }
        
    }

    // 응모하기 창에서 화살표 버튼 클릭시 drawer 올리기.
    @IBAction func checkUpButton(_ sender: UIButton) {
        
        // setTimeData() 여기서 서버에서 받아온 타입 리스트 설정
        
        if fillView.transform == .identity {
            UIView.animate(withDuration: 1, animations: {
                self.fillView.transform = CGAffineTransform(scaleX: 0, y: 0)
                self.checkView.transform = CGAffineTransform(translationX: 0, y: -93)
                self.checkButton.transform = CGAffineTransform(rotationAngle: self.radians(180))
                self.applyButton.transform = CGAffineTransform(translationX: 0, y: 600)
            }) {(true) in
                
            }
        } else {
            tblView.isHidden = true
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
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            
            self.checkView.transform = CGAffineTransform(translationX: 0, y: 248)
        })
        
        self.view.layoutIfNeeded()
    }
    func hideMenuView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
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


/* Artist, Schedule 은 통신 해야 함 */



// 배우 정보 collection view datasource
extension ShowDetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return actorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCVCell", for: indexPath) as! ActorCVCell
        
        let actor = actorList[indexPath.row]
        
        cell.actorImage.image = serverActorImage?.image
        cell.actorName.text = serverActorName
        cell.castingName.text = serverCastingName
        
        return cell
    }
    
}


extension ShowDetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let timeArray = timeList[indexPath.row]
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.maize
        cell.selectedBackgroundView = backgroundView
        
        cell.textLabel!.text = timeArray.time
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 인덱스의 값의 타이틀이 보여지는 코드
        btnDrop.setTitle("\(selectedRow!)", for: .normal)
        animate(toggle: false)
    }
    
}
