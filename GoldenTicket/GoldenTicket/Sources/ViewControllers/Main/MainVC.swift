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

class MainVC: UIViewController {
    
    @IBOutlet var userName: UILabel!
    
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
    var showDetailList : [Detail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //더미 데이터들 세팅하기.
        setShowData()
        setDetailData()
        setupSideMenu()

        //
        secondLotteryView.isHidden = true
        lotteryLeftButton.isHidden = true
        firstLotteryCheckButton.isHidden = true
        secondLotteryCheckButton.isHidden = true
        
        showCollectionView.dataSource = self
        showCollectionView.delegate = self
        
        // 월 공연, 월 뮤지컬, 검색버튼 customize
        monthShowButton.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        monthMusicalButton.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        searchButton.makeRounded(cornerRadius: 20)
        searchButton.dropShadow(color: UIColor.black16, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        
        // count down timer에 필요한 함수들
        let timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timePrinter1), userInfo: nil, repeats: true)
        let timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timePrinter2), userInfo: nil, repeats: true)
        
        timer1.fire()
        timer2.fire()
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
        let time = timeCalculator(dateFormat: "MM/dd/yyyy hh:mm:ss a", endTime: "07/06/2019 12:30:30 p")
        
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
        let time = timeCalculator(dateFormat: "MM/dd/yyyy hh:mm:ss a", endTime: "07/06/2019 09:18:30 p")
        
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
        
//        let storyboardWin = UIStoryboard.init(name: "WinTicket", bundle: nil)
//        guard let dvc = storyboardWin.instantiateViewController(withIdentifier: "TicketVC") as? TicketVC else{
//            return
//        }
//        present(dvc, animated: true)
        
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
            
            cell.showImage.image = show.showImage
            cell.showLocation.text = show.showLocation
            cell.showTime.text = show.showTime
            cell.showTitle.text = show.showTitle
            
            return cell
        } else {
            let lotteryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "lotteryCell", for: indexPath) as! LotteryCheckCell
            let lottery = lotteryList[indexPath.row]
            
            lotteryCell.lotteryShowTitle.text = lottery.showTitle
            
            return lotteryCell
        }
    }
}
extension MainVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dvc = storyboard?.instantiateViewController(withIdentifier: "ShowDetailVC") as! ShowDetailVC
        
        let show = showDetailList[indexPath.row]
        
        dvc.backgroundImg = show.backgroundImage
        dvc.posterImg = show.posterImage
        dvc.showName = show.showTitle
        //dvc.showPrice = show.showPrice
        dvc.showBeforePrice = show.showBeforePrice
        dvc.showAfterPrice = show.showAfterPrice
        dvc.showTime = show.showTime
        dvc.showLocation = show.showLocation
        dvc.showDetail = show.showDetailImage
        
        present(dvc, animated: true)
        //navigationController?.pushViewController(dvc, animated: true)
    }
}


// 테스트용 더미 데이터 세팅.
extension MainVC {
    func setShowData() {
        
        let show1 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainKill")
        let show2 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainBenhur")
        let show3 = Show(title: "뮤지컬 위키드", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainWicked")
        let show4 = Show(title: "뮤지컬 벤허", time: "17:00 ~ 19:00", location: "혜화 소극장", showName: "posterMainBenhur")
        showList = [show1, show2, show3, show4]
    }
    
    func setDetailData() {
        
        let showD1 = Detail(background: "backImgInfo", poster: "posteKillMeNowInfo", title: "뮤지컬 벤허", time: "2019.06.15 17:00~19:00", bprice: "150,000", aprice: "20,000", location: "블루스퀘어 인터파크홀", detail: "longMusicalInfo")
        let showD2 = Detail(background: "backImgInfoKillMeNow", poster: "posteKillMeNowInfo", title: "뮤지컬 킬미나우", time: "2019.06.15 17:00~19:00", bprice: "150,000", aprice: "10,000", location: "예술의 전당", detail: "longInfoKillMeNow")
        
        showDetailList = [showD1, showD2, showD2, showD1]
    }
}
