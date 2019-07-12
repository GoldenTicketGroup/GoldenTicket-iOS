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
    
    var artistList : [Artist] = []
    var posterList : [Poster] = []
    var timeList : [Schedule] = []
    
    // 배열이 아님!!!! 배열 아냐!!!!!
    var showDetail : ResponseShow!
    
    var showIdx : Int?
    var selectedRowText : String?
    var selectedRow : Int?
    
    
    @IBOutlet weak var onlyTwo: UIView!
    
    @IBOutlet weak var alarmMessage: UILabel!
    
    // 배우들을 보여주는 collection view.
    @IBOutlet weak var actorCollectionView: UICollectionView!

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var showTitle: UILabel!
    
    @IBOutlet weak var showBeforePriceLabel: UILabel!
    
    @IBOutlet weak var showAfterPriceLabel: UILabel!
    
    @IBOutlet weak var showTimeLabel: UILabel!
    
    @IBOutlet weak var showLocationLabel: UILabel!
    
    @IBOutlet weak var showDetailCollectionView: UICollectionView!
    
    var checkisLiked : Int?     // 좋아요가 체크 되어있나요? 0: 아니요. 1: 예
    var available : Int?        // 응모가 가능한지 체크하고 싶다.
    var cnt = 0                 // draw_available 계산

    // InterestedVC 에서 storyboard로 전달 받는 dvc outlet
    var backImg : UIImage?
    var posterI : UIImage?
    var showN: String?
    var beforeP : String?
    var afterP : String?
    var showT : String?
    var showL : String?
    var detailP : UIImageView?
    var checkisL : Int?
    var a : Int?
    
    //SearchVC 에서 storyboard 로 전달 받는 dvc outlet
    var backImageS : UIImage?
    var posterIS : UIImage?
    var showNS: String?
    var beforePS : String?
    var afterPS : String?
    var showTS : String?
    var showLS : String?
    var detailPS : UIImageView?
    var checkisLS : Int?
    var aS : Int?

    //응모하기 뷰
    @IBOutlet weak var checkView: CustomView!
    @IBOutlet weak var fillView: UIView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var applyButton: CustomButton!
    // 응모가 불가할때 띄우는 뷰
    @IBOutlet weak var nonValiableView: UIView!
    @IBOutlet weak var messageView: UIView!
    
    //좋아요 버튼
    @IBOutlet weak var likeButton: UIButton!
    
    //응모하기 뷰에서 시간선택 창 만들기
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    //스크롤뷰
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //응모 불가할 때 띄우는 메세지 뷰 customize
        messageView.makeRounded(cornerRadius: 20)
        messageView.isHidden = true

        alarmMessage.makeRounded(cornerRadius: 20)
        
        setInterested()
        setSearchContent()
        
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

        if checkisLiked == 1 {
            // 좋아요 되어있어야 함
            likeButton.isSelected = true
//            let btnImage = UIImage(named: "iconLikeFill")
//            self.likeButton.setImage(btnImage , for: .normal)
        }
        else {
            likeButton.isSelected = false
//            let btnNoImage = UIImage(named: "iconLikeNoFill")
//            self.likeButton.setImage(btnNoImage, for: .normal)
        }
        
        onlyTwo.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let idx = self.showIdx else { return }
        print("showIdx \(idx)")
        ShowService.shared.showDetail(showIdx: idx) {
            [weak self]
            data in
            
            guard let `self` = self else { return }
            switch data {
                
            case .success(let res):
                
                self.showDetail = res as! ResponseShow
                
                self.backgroundImage.imageFromUrl(self.showDetail.data.background_image, defaultImgPath: "https://sopt24server.s3.ap-northeast-2.amazonaws.com/backimg_benhur_info.jpg")
                self.posterImage.imageFromUrl(self.showDetail.data.image_url, defaultImgPath: "https://sopt24server.s3.ap-northeast-2.amazonaws.com/poster_main_benhur.jpg")
                self.showTitle.text = self.showDetail.data.name
                self.showBeforePriceLabel.text = self.showDetail.data.original_price
                self.showAfterPriceLabel.text = self.showDetail.data.discount_price
                self.showTimeLabel.text = self.showDetail.data.duration
                self.showLocationLabel.text = self.showDetail.data.location
                
                self.checkisLiked = self.showDetail.data.is_liked
                
                // 2. Poster Struct
                self.posterList = self.showDetail.data.poster!
                // 2. Actor Struct
                self.artistList = self.showDetail.data.artist!
                
                self.showDetailCollectionView.reloadData()
                self.actorCollectionView.reloadData()
                self.tblView.reloadData()
                
                // status 200일 때
                if self.showDetail.status == 200 {
                    // 응모할 수 있는 경우
                    // 다음 시간표 리스트로 스케줄 서버 통신 받아온 데이터 넘기기
                    
                    // 스케줄이 아예 빈 배열인 경우 ==> "응모 가능한 시간이 아닙니다"
                    if self.showDetail.data.schedule!.count == 0 {
                        //self.simpleAlert(title: "죄송합니다.", message: "응모 가능한 시간이 없습니다.")
                        self.alarmMessage.text = "응모 가능한 시간이 없습니다"
                        self.onlyTwo.isHidden = false
                    }
                    else {
                        // 스케줄이 아예 빈 배열은 아님
                        for idx in 0 ..< self.showDetail.data.schedule!.count {
                            if self.showDetail.data.schedule![idx].draw_available == 1 {
                                self.cnt += 1
                            }
                        }
                        if self.cnt == 0 {
                            // 응모불가능
                            
                        }
                        else {
                            // 응모가능
                            self.timeList = self.showDetail.data.schedule!
                            return
                        }
                        // 모든 draw_available 이 다 0일 때
                        //self.simpleAlert(title: "죄송합니다.", message: "응모 가능한 시간이 아닙니다.")
                        self.alarmMessage.text = "응모 가능한 시간이 아닙니다."
                        self.onlyTwo.isHidden = false
                    }
                }
                else if self.showDetail.status == 204 {
                    // 이미 응모한 공연을 또 응모

                    //self.simpleAlert(title: "죄송합니다.", message: "이미 응모한 공연입니다.")
                    self.alarmMessage.text = "이미 응모한 공연입니다."
                    self.onlyTwo.isHidden = false

                    // self.simpleAlert(title: "죄송합니다.", message: "이미 응모한 공연입니다.")

                }
                else if self.showDetail.status == 205 {
                    // 이미 사용자가 두번 응모한 경우
                    //self.simpleAlert(title: "죄송합니다.", message: "응모는 하루에 두 번까지 가능합니다.")
                    self.onlyTwo.isHidden = false
                }
                
            case .requestErr(let message):
                self.simpleAlert(title: "공연 상세 조회 실패", message: "\(message)")
                
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                self.simpleAlert(title: "공연 상세 조회 실패", message: "네트워크 상태를 확인해주세요.")
            }
        }
    }
    
    /* 어떻게 하면 선택된 cell 값의 title을 얻어올 수 있을까? */
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
//    func setContent() {
//
//        backgroundImage.image = backgroundImg
//        posterImage.image = posterImg
//        showTitle.text = showName
//        showBeforePriceLabel.text = showBeforePrice
//        showAfterPriceLabel.text = showAfterPrice
//        showTimeLabel.text = showTime
//        showLocationLabel.text = showLocation
//    }
    
    func setInterested() {
        backgroundImage.image = backImg
        posterImage.image = posterI
        showTitle.text = showN
        showBeforePriceLabel.text = beforeP
        showAfterPriceLabel.text = afterP
        showTimeLabel.text = showT
        showLocationLabel.text = showL
    }
    
    func setSearchContent() {
        backgroundImage.image = backImageS
        posterImage.image = posterIS
        showTitle.text = showNS
        showBeforePriceLabel.text = beforePS
        showAfterPriceLabel.text = afterPS
        showTimeLabel.text = showTS
        showLocationLabel.text = showLS
    }
    

    // 메인 화면으로 돌아가는 backButton 함수
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 좋아요 버튼 누를 시 fill heart.
    @IBAction func onClickedLikeButton(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        guard let idx = self.showIdx else { return }
        
        // 선택되어 있으면
        if sender.isSelected {
            print("좋아요")
            
            // 좋아요 통신
            LikeService.shared.pickLike(idx) {
                [weak self]
                data in
                
                guard let `self` = self else { return }
                switch data {
                    
                // 매개변수에 어떤 값을 가져올 것인지
                case .success(let res):
                    sender.isSelected = true   // 버튼 선택 안된걸로 바꿈
                    
                case .requestErr(let message):
                    self.simpleAlert(title: "좋아요 추가 실패", message: "\(message)")
                    
                case .pathErr:
                    print(".pathErr")
                    
                case .serverErr:
                    print(".serverErr")
                    
                case .networkFail:
                    self.simpleAlert(title: "좋아요 추가 실패", message: "네트워크 상태를 확인해주세요.")
                }
            }
        }
            
        else {
            print("좋아요 취소")
            
            // 좋아요 통신
            LikeService.shared.pickNoLike(idx) {
                [weak self]
                data in
                
                guard let `self` = self else { return }
                //print("data : \(data)")
                switch data {
                    
                // 매개변수에 어떤 값을 가져올 것인지
                case .success(let res):
                    sender.isSelected = false
                    
                case .requestErr(let message):
                    self.simpleAlert(title: "좋아요 추가 실패", message: "\(message)")
                    
                case .pathErr:
                    print(".pathErr")
                    
                case .serverErr:
                    print(".serverErr")
                    
                case .networkFail:
                    self.simpleAlert(title: "좋아요 추가 실패", message: "네트워크 상태를 확인해주세요.")
            }
        }
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
    
    
    // timeTable 선택 완료 이후 응모하기 <잠깐!> 창으로 넘어가는 스토리 보드 연결
    @IBAction func selectShow(_ sender: Any) {
        let storyboardLottery = UIStoryboard(name: "Lottory", bundle: nil)
        let dvc = storyboardLottery.instantiateViewController(withIdentifier: "waitLottery") as! LotteryInVC

        // 잠깐! 스토리 보드로 선택된 테이블 인덱스 넘기기
        
        self.timeList = self.showDetail.data.schedule!
        dvc.scheduleIdx = selectedRow
        present(dvc, animated: true)
    }
    
}

// 스크롤시 응모하기 뷰 올리고 내리기
extension ShowDetailVC : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yVelocity = scrollView.panGestureRecognizer .velocity(in: scrollView).y
        
        if yVelocity > 0 {
            hideMenuView()
            
        } else if yVelocity < 0 {
            showMenuView()
        }
    }
}


/* Artist, Schedule 은 통신 해야 함 */

// 배우 정보 collection view datasource
extension ShowDetailVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.showDetailCollectionView {
            return posterList.count
        }
        return artistList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.showDetailCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowDetailCVCell", for: indexPath) as! ShowDetailCVCell
            
            let poster = posterList[indexPath.row]
            
            cell.posterImage.imageFromUrl(poster.image_url, defaultImgPath: "https://sopt24server.s3.ap-northeast-2.amazonaws.com/long_info_benhur_01.jpg")
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCVCell", for: indexPath) as! ActorCVCell
            
            // Want to get Actor Collection Cell
            let actor = artistList[indexPath.row]
            
            cell.actorImage.imageFromUrl(actor.image_url, defaultImgPath: "https://sopt24server.s3.ap-northeast-2.amazonaws.com/img_casting_01.jpg")
            cell.actorName.text = actor.name
            cell.castingName.text = actor.role
            
            return cell
        }
    }
}

extension ShowDetailVC : UICollectionViewDelegateFlowLayout {
    // collection view cell의 width, height 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let width : CGFloat = view.frame.width
        let height : CGFloat = view.frame.height - 2
        
        return CGSize(width: width, height: height)
    }
    // 수직 방향에서의 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    //수평방향에서의 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // 섹션 내부의 여백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        self.selectedRowText = timeList[indexPath.row].time
        self.selectedRow = timeList[indexPath.row].schedule_idx
        
        btnDrop.setTitle("\(selectedRowText!)", for: .normal)
        animate(toggle: false)
    }
}
