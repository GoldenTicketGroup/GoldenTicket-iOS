# GoldenTicket
* 당일 공연 추첨식 예매 서비스
> '골든티켓'은 공연 티켓 응모 서비스 입니다. 당일 남은 좌석에 대한 응모를 통해 당첨자는 가장 저렴한 가격에 공연을 관람할 수 있습니다. 
> 오늘 응모 가능한 공연을 둘러보고 행운을 경험해보세요.

* 개발 기간
> 2019.06.22 ~ 2019.07.13

<br />

# GoldenTicket Group Github
- [Server](https://github.com/GoldenTicketGroup/GoldenTicketServer) : 황재석, 최민경, 윤희성 
- [Android](https://github.com/GoldenTicketGroup/GoldenTicket_Android) : 김강희, 김민경, 한선민, 전성은 

<br />

서비스 work flow
---------------
<div>
<img width="1438" src="https://user-images.githubusercontent.com/49272528/61115181-e09a4100-a4cc-11e9-9bc5-75d3461e4387.png">
</div>
<br />

앱 아이콘
------------
![GoldenTicketIcon](https://user-images.githubusercontent.com/49272528/61025745-8f1a8500-a3ec-11e9-8e5a-ae246f2a9bbc.png)

스크린 샷
------------
<img width="200" src="https://user-images.githubusercontent.com/49272528/61114387-31a93580-a4cb-11e9-87c7-9c0d8f36a43c.jpg"> <img width="200" src="https://user-images.githubusercontent.com/49272528/61114394-34a42600-a4cb-11e9-8e99-cb94600c7725.jpg"> <img width="200" src="https://user-images.githubusercontent.com/49272528/61114404-366de980-a4cb-11e9-976c-ef5b14e2c39e.jpg"> <img width="200" src="https://user-images.githubusercontent.com/49272528/61114414-3b329d80-a4cb-11e9-9ff6-710f7a257625.jpg">


개발 환경
------------
1. Swift 버전
> * 5.0.1
2. 사용한 라이브러리
> * Alamofire 4.8.2
> * Kingfisher 4.10.1
> * Hero
> * SwiftOrigin 1.7.0
> * SideMenu
> * TextFieldEffects

기능 소개
------------
|  <center>기능</center> |  <center>개발 여부</center> |  <center> 기타 사항 </center> |
|:--------:|:--------:|:--------:|
|<center> 로그인/회원가입 </center> | <center> ○ </center> |<center> 로그아웃, 회원정보 수정까지 구현 완료 </center>|
|<center> 홈 공연정보 보여주기 </center> | <center> ○ </center> |<center> </center> |
|<center> 공연 상세 정보 보여주기 </center> | <center> ○ </center> |<center> </center> |
|<center> 응모하기 </center> | <center> ○ </center> |<center>  </center> |
|<center> 응모한 공연 시간 정보 보여주기 </center> | <center> ○ </center> |<center>  </center> |
|<center> 당첨 확인 </center> | <center> ○ </center> |<center>  </center> |
|<center> 관심있는 공연 설정 </center> | <center> ○ </center> |<center>  </center> |
|<center> 알림 (관심있는 공연 / 당첨확인) </center> | <center> X : 개발자 계정이 없어 apns 이용 불가 </center> |<center> </center> |
|<center> 검색 </center> | <center> ○ </center> |<center>일반 텍스트 검색, 해쉬태그 검색</center> |

문제점과 해결 방법 report
------------
### **문제1**. 
- alamofire 비동기화로 인해서 서버 통신이 진행 중일때 데이터를 nil 값을 받아오는 경우가 발생할 수 있다.

<br />

###  **해결**. 
- 서버 통신할 때 데이터 갱신은 반드시 통신 함수 안에서 진행해야 한다.  

<br/>

  * 예시 1.  
  ![prob1](https://user-images.githubusercontent.com/49272528/61109580-33213080-a4c0-11e9-9aac-c301215780cf.png)
  공연 상세 페이지의 데이타를 셋팅하는 collection view에서 서버를 통해 데이터 셋팅하는 함수 setDetailData를 호출만 하고  
  ![prob2](https://user-images.githubusercontent.com/49272528/61109587-374d4e00-a4c0-11e9-8e2b-966e346c5cee.png)
  setDetailData 함수 안에서 dvc의 셀의 데이타를 셋팅한다.
  
  <br/>
  
  * 예시 2.  
  ![prob3](https://user-images.githubusercontent.com/49272528/61109592-3a483e80-a4c0-11e9-8c16-4326803b4c60.png)
  타이머 역시 viewDidload에 선언하고 통신 함수를 호출하는 방식으로 진행하였더니 시간 데이타에 nil이 들어오기 때문에 통신하는 코드 안에 선언하여 해결하였다.

<br />

### **문제2**. 
- response의 result가 Json으로 decode할 수 없을 때 해결을 위해 시도했던 방법들  

### **해결1**. 
- 코더블이 적절히 value를 casting해오지 못하는 경우가 있기 때문에 서버 네이밍과 동일하게 수정한다.  
  ![prob4](https://user-images.githubusercontent.com/49272528/61109594-3c120200-a4c0-11e9-8355-9762cd89e183.png)
  
### **해결2**.  
  1. print(type(of: result))로 디코드를 시도하는 value의 타입을 찍어보고  
  2. print(error.localizedDescription로 에러를 출력해보고  
  3. debugPrint(error)로 어떤 키가 missing된 건 아닌지 확인한다. 이 과정에서 response data handler, chained response handlers 사용 방법을 참고했다.  
  
  > * 참고 URL : [Alamofire/Documentation/Usage.md](https://github.com/Alamofire/Alamofire/blob/master/Documentation/Usage.md)
  
   1. Response Data Handler
  ```swift
    Alamofire.request("https://httpbin.org/get").responseData { response in
       debugPrint("All Response Info: \(response)")
  
       if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
       	print("Data: \(utf8Text)")
      }
  }
  ``` 
  
  <br/>
  
   2. Chained Response Handlers
  ```swift
    Alamofire.request("https://httpbin.org/get")
       .responseString { response in
           print("Response String: \(response.result.value)")
       }
       .responseJSON { response in
           print("Response JSON: \(response.result.value)")
       }
  ``` 
  
  <br />
  
### **문제3**. 
- 서버에서 이미지 통신 후 오토레이아웃이 무너지는 문제점

  [예시 화면]
  
  <img width="400" src="https://user-images.githubusercontent.com/49272528/61109648-5f3cb180-a4c0-11e9-86e8-bc93f04e4e5f.png">
  
### **해결**. 
- 서버 이미지 속성의 width, height 값의 최소 공약수를 구하여 UIImage의 규격 셋팅을 한다.
  
  <img width="300" src="https://user-images.githubusercontent.com/49272528/61109657-6237a200-a4c0-11e9-9629-478debb7bdbc.png">
  
<br />

### **문제4**. 
- 공연 상세 뷰의 셀 이미지가 두번째 클릭부터 로드 되는 문제점

### **해결**. 
- dvc의 image 속성을 UIImageView?가 아닌 UIImage?로 선언하여 해결했다. 따라서 이미지 url 메소드 불러올 때도 kingfisher의 imageFromURL을 사용하지 않고 직접 image URL을 받아 UIImage에 대응해주었다.

<br />

  [문제4 해결이미지]
  
  <img width="600" src="https://user-images.githubusercontent.com/49272528/61113684-bdba5d80-a4c9-11e9-9aec-01f2457c92ff.png">
  
  [문제4-1 해결이미지]
  
  <img width="600" src="https://user-images.githubusercontent.com/49272528/61110952-60231280-a4c3-11e9-89e5-548a3316f109.png">

<br/>

팀원 소개
------------
* 팀원1 : 안재은<br>
> SOPT 24기 appjam에서 '골든티켓' 이라는 서비스로 두 번째 iOS 애플리케이션 개발을 하게되었습니다.<br />
> 좋은 팀원들 만나 많이 성장 할 수 있었습니다. 골든티켓 파이팅 !! <br />

* 팀원2 : 황수빈<br>
> 졸리다.. (19.07.10.) <br />
> 생각 이상으로 사용자 입장에서 플로우를 디테일하게 고민해보는 시간이었고 <br />
> SOPT 24기 YB로 앱잼에 참여하면서 들어왔던 8번의 세미나를 종합하고 발전하는 기회였습니다.<br />
<br />
