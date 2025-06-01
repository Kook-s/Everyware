![EverywareLogo](https://github.com/Kook-s/Everyware/blob/main/doc/EveryWare%20Logo(color).png) 

- **주 제** : Groupware
- **제작 기간** : 2023.06.21 - 2023.08.14 
- **팀원 구성** : 신국현, 변정민, 전지혜, 김지완, 이수진
  <br>

# 💻 프로젝트
EveryWare는 기업 내 협업과 업무 효율을 극대화하기 위해 개발된 통합 그룹웨어 플랫폼입니다.
사용자의 역할(사원, 관리자, 외부 협력자 등)과 조직 환경에 따라 기능을 유연하게 커스터마이징할 수 있어, 각기 다른 업무 흐름에 최적화된 경험을 제공합니다.

기능별 모듈은 독립성과 확장성을 고려하여 설계되었고, 관리자와 일반 사용자가 각자의 권한에 맞는 기능만 사용할 수 있도록 접근 제어가 적용되어 있습니다.
또한, 직관적인 화면 구성과 쉬운 사용성을 통해 빠른 적응과 높은 업무 몰입을 지원하며, 유지보수성과 향후 기능 확장까지 고려한 구조로 구현되었습니다.
<br>

# 🚀 팀원 역할
| **신국현** : PL                               | **변정민** : TA                            | **전지혜** : DA                       | **김지완** : UA                       | **이수진** : AA                           |
|----------------------------------------|-------------------------------------|--------------------------------|--------------------------------|------------------------------------|
| 클라우드<br/>화상채팅<br/>안사관리<br/>지문인식<br/>결제 | 메신저<br/>일정관리<br/>알람<br/>이메일<br/>로그인 | 전자결재<br/>조직도<br/>주소록<br/>예약 관리 | 쪽지<br/>게시판 관리<br/>마이페이지<br/>날씨 | 근태관리<br/>휴가관리<br/>설문<br/>Todo List |
<br>

# 🛠️ 개발 환경
<div>
    <img src="https://img.shields.io/badge/Spring-6DB33F?style=flat-square&logo=Spring&logoColor=white"/>
    <img src="https://img.shields.io/badge/Java-F7DF1E?style=flat-square"/>
    <img src="https://img.shields.io/badge/Node.js-339933?style=flat-square&logo=Node.js&logoColor=white"/>
    <img src="https://img.shields.io/badge/HTML5-E34F26?style=flat-square&logo=HTML5&logoColor=ffffff"/>
    <img src="https://img.shields.io/badge/CSS-1572B6?style=flat-square&logo=CSS3&logoColor=ffffff"/>
    <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=JavaScript&logoColor=ffffff"/>
<br>
    <img src="https://img.shields.io/badge/Oracle-F80000?style=flat-square&logo=Oracle&logoColor=white"/>
    <img src="https://img.shields.io/badge/Tomcat-FCC624?style=flat-square&logo=apachetomcat&logoColor=white"/>
    <img src="https://img.shields.io/badge/jQuery-0769AD?style=flat-square&logo=jQuery&logoColor=white"/> 
    <img src="https://img.shields.io/badge/subversion-809CC9?style=flat-square&logo=subversion&logoColor=ffffff"/> 
</div>
<br>

# 🏛️ Architecture
![3-Tire-Architecture](https://github.com/Kook-s/Everyware/blob/main/doc/3-Tire-Architecture.png)
<br>

## 패키지 구조
```
├── java
│   └── kr
│       └── or
│           └── everyware
│              ├── admin
│              ├── everysolution
│              ├── everyware
│              ├── login
│              ├── security
│              ├── test
│              └── util
├── resources
│   ├── META-INF
│   ├── log4j.xml
│   └── sqlmap
│       ├── admin
│       ├── alarm
│       ├── blank_SQL.xml
│       ├── board
│       ├── calendar
│       ├── calendar_ad
│       ├── chat
│       ├── chat_ad
│       ├── cloud
│       ├── cmnt
│       ├── contact
│       ├── document
│       ├── everysolution
│       ├── facility
│       ├── fileattachment
│       ├── fingerhr
│       ├── login
│       ├── mail
│       ├── mail_ad
│       ├── mypage
│       ├── suvy
│       ├── todo
│       ├── vacation
│       ├── work
│       ├── workGroup
│       └── workYear
└── webapp
    ├── WEB-INF
    │   ├── classes
    │   ├── mybatisAlias
    │   ├── spring
    │   ├── views
    │   └── web.xml
    └── resources
        ├── assets
        ├── bootstrap
        ├── ckeditor
        ├── css
        ├── img
        ├── js
        ├── jstree
        └── video
```
<br>

# 🗓️ 개발 기간 및 작업 시간
| 2023    |   6월   |     |     |     | 7월 |||     | 8월 |     |     |    |
|:--------|:------:|:---:|:---:|:---:|:----:|:----:|:----:|:---:|:----:|:---:|:---:|:--:|
| 주차      |  1주차   | 2주차 | 3주차 | 4주차 | 1주차 | 2주차 | 3주차 | 4주차 | 1주차 | 2주차 | 3주차 | 4주차 |
| 수행 계획서  |   ✅    |  ✅  |     |     |    |     |     |     |    |     |     |    ||
| 요구사항 정의 |   ✅    |  ✅  |  ✅  |     |    |     |     |     |    |     |     ||
| 테이블 설계  |        |  ✅  |  ✅  |  ✅  |    |     |     |     |    |     |     ||
| 화면 설계   |        |     |     |  ✅  | ✅   |     |     |     |    |     |     ||
| 기능 개발   |        |     |     |     | ✅   |  ✅   |  ✅   |  ✅  | ✅   |     |     |    |
| 테스트     |        |     |     |     |    |     |     |     |  ✅  |  ✅  |     |    |
<br>

# ERD
![3-Tire-Architecture](https://github.com/Kook-s/Everyware/blob/main/doc/ERD.png)
<br>

# 📑 Document
### **[최종 산출물](https://github.com/Kook-s/Everyware/blob/main/doc/document)**
<br>

# 🖥️ UI
![UI_01](https://github.com/Kook-s/Everyware/blob/main/doc/ui/01.png)
![UI_02](https://github.com/Kook-s/Everyware/blob/main/doc/ui/02.png)
![UI_03](https://github.com/Kook-s/Everyware/blob/main/doc/ui/03.png)
![UI_04](https://github.com/Kook-s/Everyware/blob/main/doc/ui/04.png)
![UI_05](https://github.com/Kook-s/Everyware/blob/main/doc/ui/05.png)
![UI_06](https://github.com/Kook-s/Everyware/blob/main/doc/ui/06.png)
![UI_07](https://github.com/Kook-s/Everyware/blob/main/doc/ui/07.png)
![UI_08](https://github.com/Kook-s/Everyware/blob/main/doc/ui/08.png)
![UI_09](https://github.com/Kook-s/Everyware/blob/main/doc/ui/09.png)




