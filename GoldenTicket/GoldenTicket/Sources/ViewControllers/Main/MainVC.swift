//
//  MainVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 30/06/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit
import Hero
import SideMenu
import Kingfisher

class MainVC: UIViewController {
    
    @IBOutlet var userName: UILabel!
    var showIdx: Int?
    
    //홈 공연 상세 정보에 필요한 outlet
    @IBOutlet weak var showCollectionView: UICollectionView!
    
    //응모내역 보여주기에 대한 뷰
    @IBOutlet weak var lotteryCollectionView: UICollectionView!
    @IBOutlet weak var firstLotteryView: UIView!
    @IBOutlet weak var firstTimeLabel: UILabel!
    
    @IBOutlet weak var firstLotteryCheckButton: UIButton!
    
    @IBOutlet weak var secondLotteryView: UIView!
    @IBOutlet weak var secondTimeLabel: UILabel!
    @IBOutlet weak var secondLotteryCheckButton: UIButton!
    
    @IBOutlet weak var lotteryLeftButton: UIButton!
    @IBOutlet weak var lotteryRightButton: UIButton!
    
    
    let formatter = DateFormatter()
    let userCalender = Calendar.current;
    let requestedComponent : Set<Calendar.Component> = [
        Calendar.Component.month,
        Calendar.Component.day,
        Calendar.Component.hour,
        Calendar.Component.minute,
        Calendar.Component.second
    ]
    
    //응모한 공연 나오는지 테스트를 위한 더미데이터.
    struct Lottery {
        var showTitle : String?
        init (title : String) {
            self.showTitle = title
        }
    }
    var lotteryList : [Lottery] = [Lottery(title: "옥탑방 고양이"), Lottery(title: "뮤지컬 캣츠")]
    
    //콘텐츠 페이지로 넘어가는 버튼
    @IBOutlet weak var monthShowButton: UIButton!
    
    @IBOutlet weak var monthMusicalButton: UIButton!
    
    //검색창으로 넘어가는 버튼
    @IBOutlet weak var searchButton: UIButton!
    
    var showList : [Show] = []
    var showDetailList : [ShowDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 세팅하기.
        setShowData()
        setupSideMenu()

        //
        secondLotteryView.isHidden = true
        lotteryLeftButton.isHidden = true
        firstLotteryCheckButton.isHidden = true
        secondLotteryCheckButton.isHidden = true
        
        showCollectionView.dataSource = self
        showCollectionView.delegate = self
        
        // 로그인한 사용자 이름으로 메인 label 반영
        let user = UserDefaults.standard
        
        // 저장된 값을 꺼내어 각 컨트롤에 적용
        self.userName.text = user.string(forKey: "name")
        
        
        // 월 공연, 월 뮤지컬, 검색버튼 customize
        monthShowButton.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        monthMusicalButton.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        searchButton.makeRounded(cornerRadius: 20)
        searchButton.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 3)
        
        // count down timer에 필요한 함수들
        let timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timePrinter1), userInfo: nil, repeats: true)
        let timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timePrinter2), userInfo: nil, repeats: true)
        
        timer1.fire()
        timer2.fire()
    } // viewDidLoad
    
    
    // 화면이 새로 뜨면 회원 정보 새로 불러오기
    override func viewWillAppear(_ animated: Bool) {
        
        // 수정한 회원 정보의 이름일 수도 있다.
        let user = UserDefaults.standard
        self.userName.text = user.string(forKey: "name")
    }
    
    
    // 응모한 공연이 있을 시 남은 시간을 보여주는 뷰에 팔요한 시간 계산기, timer
    func timeCalculator(dateFormat: String, endTime: String, startTime: Date = Date()) -> DateComponents {
        formatter.dateFormat = dateFormat
        let _startTime = startTime
        let _endTime = formatter.date(from: endTime)
        
        let timeDifference = userCalender.dateComponents(requestedComponent, from: _startTime, to: _endTime!)
        return timeDifference
    }
    
    //첫번째 응모한 공연에 대한 시간 프린터
    @objc func timePrinter1() -> Void {
        // 시간 보여주기
        //setTimeLabel()
        let time = timeCalculator(dateFormat: "MM/dd/yyyy hh:mm:ss", endTime: "07/07/2019 04:30:30") //endTime 에 timeLabel 이런식으로 변수 넣어주기
        
        let sec = time.second!
        let min = time.minute!
        let h = time.hour!
        
        var second = "\(time.second!)"
        var minute = "\(time.minute!)"
        var hour = "\(time.hour!)"
        
        if sec < 10 {
            second = "0" + second
        } else {}
        if min < 10 {
            minute = "0" + minute
        } else {
            
        }
        if h < 10 {
            hour = "0" + hour
        }
        
        firstTimeLabel.text = hour + " : " + minute + " : " + second
        
        if sec <= 0 && min <= 0 && sec <= 0 {
            firstLotteryCheckButton.isHidden = false
            firstTimeLabel.isHidden = true
        }
    }
    
    //두번째 응모한 공연에 대한 시간 프린터
    @objc func timePrinter2() -> Void {
        
        // 시간 보여주기
        let time = timeCalculator(dateFormat: "MM/dd/yyyy hh:mm:ss " + "a", endTime: "07/11/2019 04:18:30 " + "p")
        
        let sec = time.second!
        let min = time.minute!
        let h = time.hour!
        
        var second = "\(time.second!)"
        var minute = "\(time.minute!)"
        var hour = "\(time.hour!)"
        
        if sec < 10 {
            second = "0" + second
        } else {}
        if min < 10 {
            minute = "0" + minute
        } else {
            
        }
        if h < 10 {
            hour = "0" + hour
        }
        
        secondTimeLabel.text = hour + " : " + minute + " : " + second
        
        if sec <= 0 && min <= 0 && sec <= 0 {
            secondLotteryCheckButton.isHidden = false
            secondTimeLabel.isHidden = true
        }
    }
    
    // 왼쪽 버튼 클릭시 뷰 이동
    @IBAction func leftButton(_ sender: Any) {
        let visibleItems: NSArray = self.lotteryCollectionView.indexPathsForVisibleItems as NSArray
        
        var minItem: NSIndexPath = visibleItems.object(at: 0) as! NSIndexPath
        for itr in visibleItems {
            
            if minItem.row > (itr as AnyObject).row {
                minItem = itr as! NSIndexPath
            }
        }
        
        let nextItem = NSIndexPath(row: minItem.row - 1, section: 0)
        self.lotteryCollectionView.scrollToItem(at: nextItem as IndexPath, at: .left, animated: true)
        
        lotteryLeftButton.isHidden = true
        lotteryRightButton.isHidden = false
        
        secondLotteryView.isHidden = true
        firstLotteryView.isHidden = false
    }
    
    // 오른쪽 버튼 누를 시 뷰 이동
    @IBAction func rightButton(_ sender: Any) {
        let visibleItems: NSArray = self.lotteryCollectionView.indexPathsForVisibleItems as NSArray
        
        var minItem: NSIndexPath = visibleItems.object(at: 0) as! NSIndexPath
        for itr in visibleItems {
            
            if minItem.row > (itr as AnyObject).row {
                minItem = itr as! NSIndexPath
            }
        }
        
        let nextItem = NSIndexPath(row: minItem.row + 1, section: 0)
        self.lotteryCollectionView.scrollToItem(at: nextItem as IndexPath, at: .left, animated: true)
        
        lotteryLeftButton.isHidden = false
        lotteryRightButton.isHidden = true
        
        firstLotteryView.isHidden = true
        secondLotteryView.isHidden = false
    }
    
    
    // 티켓 버튼 누를 시 당첨된 티켓 / 당첨 되지 않았다는 뷰를 보여주는 함수.
    @IBAction func showTicket(_ sender: Any) {
        
        let storyboardNone = UIStoryboard.init(name: "NoTicket", bundle: nil)
        let dvcN = storyboardNone.instantiateViewController(withIdentifier: "NoTicket")
        present(dvcN, animated: true)
    }
    
    @IBAction func onClickSearchButton(_ sender: Any) {
        let storyboardSearch = UIStoryboard.init(name: "Search", bundle: nil)
        guard let dvc = storyboardSearch.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else {
            return
        }
        present(dvc, animated: true)
    }
    
    // side Menu bar 의 제스쳐를 지정해주는 함수.
    func setupSideMenu() {
        
        // Side Menu 의 애니메이션을 지정
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        
        // Side Menu 의 이펙트를 지정
        SideMenuManager.default.menuBlurEffectStyle = nil
        
        // Side Menu 가 보일 때 기존 ViewController 의 투명도
        SideMenuManager.default.menuAnimationFadeStrength = 0.5
        // Side Menu 의 투명도
        SideMenuManager.default.menuShadowOpacity = 0.3
        // Side Menu 가 보일 때 기존 ViewController 의 크기
        SideMenuManager.default.menuAnimationTransformScaleFactor = 1
        // Side Menu 의 Width
        SideMenuManager.default.menuWidth = 311
        // Side Menu 의 Status Bar 에 대한 침범 여부를 결정
        SideMenuManager.default.menuFadeStatusBar = false
        
    }
    
    
    @IBAction func monthShow(_ sender: Any) {
        
        let storyboardContent = UIStoryboard.init(name: "Contents", bundle: nil)
        let dvc = storyboardContent.instantiateViewController(withIdentifier: "contentsVC")
        present(dvc, animated: true)
        
    }
    
    @IBAction func monthMusical(_ sender: Any) {
        
        let storyboardContent = UIStoryboard.init(name: "Contents", bundle: nil)
        let dvc = storyboardContent.instantiateViewController(withIdentifier: "contents2")
        present(dvc, animated: true)
    }
    
    
}

extension MainVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.showCollectionView {
        return showList.count
        }
        return lotteryList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.showCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainShowCell", for: indexPath) as! MainShowCell
            
            let show = showList[indexPath.row]
            
            // kingfisher로 url 통해서 이미지 불러오기
            // cell.MainShowCell의 아웃렛 이름 = show(모델).swift.서버 이름
            cell.showImage.imageFromUrl(show.image_url, defaultImgPath: "https://sopt24server.s3.ap-northeast-2.amazonaws.com/1562055837775.jpg")
            cell.showLocation.text = show.location
            cell.showTime.text = show.running_time
            cell.showTitle.text = show.name
            
            
            return cell
            
        }
        else {
            let lotteryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "lotteryCell", for: indexPath) as! LotteryCheckCell
            let lottery = lotteryList[indexPath.row]
            
            lotteryCell.lotteryShowTitle.text = lottery.showTitle
            
            return lotteryCell
        }
    }
}

extension MainVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // let showDetail = showDetailList[indexPath.row]
        // self.showIdx = showDetail.show_idx
        // 임시로 인덱스 지정
        self.showIdx = 20
        // data setting
        self.setDetailData()
    }
}


// 테스트용 더미 데이터 세팅.
extension MainVC {
    func setShowData() {
        
        ShowService.shared.showHome() {
            [weak self]
            data in
            
            guard let `self` = self else { return }
            
            switch data {
                
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                
                self.showList = res as! [Show]
                self.showCollectionView.reloadData()
                
            case .requestErr(let message):
                self.simpleAlert(title: "메인 공연 조회 실패", message: "\(message)")
                
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                self.simpleAlert(title: "메인 공연 조회 실패", message: "네트워크 상태를 확인해주세요.")
            }
        }
    }
    
    func setDetailData() {
        
        guard let idx = self.showIdx else { return }
        
        // print("idx : \(idx)")
        ShowService.shared.showDetail(showIdx: idx) {
            [weak self]
            data in
            
            guard let `self` = self else { return }
            //print("data : \(data)")
            switch data {
                
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                
                // 배열이 아니라서 배열로 받을 필요가 없었음
                // self.showDetailList = res as! [ShowDetail]
                // print("any data",self.showDetailList)
                
                // 1. 공연 하나에 대한 정보만 받아오면 된다.
                let showDetail = res as! ShowDetail
                let dvc = self.storyboard?.instantiateViewController(withIdentifier: "ShowDetailVC") as! ShowDetailVC
                
                // 2. ShowDetail Struct
                dvc.posterImg = UIImageView()
                // posterImg가 있을 때 imageFromUrl을 호출하는데, 초기화 안된 상태이고 nil이니까 초기화를 해줘야 한다.
                dvc.posterImg!.imageFromUrl(showDetail.image_url, defaultImgPath: "https://sopt24server.s3.ap-northeast-2.amazonaws.com/poster_main_benhur.jpg")
                dvc.showName = showDetail.name
                dvc.showLocation = showDetail.location
                dvc.showTime = showDetail.duration
                dvc.showBeforePrice = showDetail.original_price
                dvc.showAfterPrice = showDetail.discount_price
                
                print("showDetail is liked \(showDetail.is_liked)")
                
                // image URL 얻어오기
                let imageUrlString = showDetail.background_image
                let imageUrl = URL(string: imageUrlString)!
                let imageData = try! Data(contentsOf: imageUrl)
                let image = UIImage(data: imageData)
                
                dvc.backgroundImg = image
                
                // 다음 시간표 리스트로 스케줄 서버 통신 받아온 데이터 넘기기
                dvc.timeList = showDetail.schedule!
                self.present(dvc, animated: true)
                self.navigationController?.pushViewController(dvc, animated: true)
                
                
                // 2. Poster Struct
                let poster = showDetail.poster
                dvc.posterList = poster!

                // 2. Actor Struct
                let artistDetail = showDetail.artist
                // let artistDetail = res as! [Artist]
                
                // dvc에 있는 배우들 리스트에 서버 통신해서 꽂아주기
                dvc.artistList = artistDetail!
                
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
}
