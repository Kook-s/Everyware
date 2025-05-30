<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<style>
.alarm_img {
	width: 20px;
	height: 20px;
}

.dropdown_menu .dropdown-item {
	display: flex;
	white-space: normal;
	align-items: center;
}

.alarm_content {
	font-size: 12px;
	padding: 0 15px;
	line-height: 14px;
	font-weight: 600;
	flex: 2;
}

.hidden_item {
	display: none !important;
}

.header_nav {
	position: relative !important;
}

.dropdown_menu_content {
	max-height: 350px;
	overflow: auto;
	min-width: 300px;
}

#header_dropdown_header {
	justify-content: space-between;
}

#header_dropdown_header div {
	font-size: 11px;
	font-weight: 600;
	border-radius: 4px;
	padding: 1px 8px;
	cursor: pointer;
}

#header_dropdown_header div:hover {
	border: 1px solid rgba(0, 0, 0, 0.2)
}

.alarm_el {
	padding-right: 3%;
}

.alarm_el:active {
	color: #16181b !important;
	text-decoration: none !important;
	background-color: #f8f9fa !important;
}

.alarm_del {
	position: absolute;
	background: url(/resources/img/xBtnGray.png) no-repeat;
	background-size: 53%;
	width: 16px;
	height: 16px;
	align-self: self-start;
	background-position: center center;
	border-radius: 4px;
	right: 1px;
}

.alarm_del:hover {
	border: 1px solid rgba(0, 0, 0, 0.2)
}

.rest {
	width: 1px;
}

.dropdown_menu_content .dropdown-item.active, .dropdown_menu_content .dropdown-item:active
	{
	color: #fff !important;
	text-decoration: none !important;
	background-color: #fff !important;
}
    #watherBtn {
      display: flex;
    justify-content: flex-end;
    }

    .modal {
      position: absolute;
      width: 100%;
      height: 100%;
      top: 0;
      left: 0;
      display: none;
    }

    .modal_content {
      width: 273px;
    height: 100px;
    border-radius: 10px;
    position: relative;
    top: 0%;
    left: 70%;
    text-align: center;
    box-sizing: border-box;
    line-height: 1.5;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    align-items: center;

    }
    .forecast-container {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: center;
  }

  .forecast-item {
        border-radius: 7px;
    text-align: center;
    width: 118px;
    flex-shrink: 5;
  }

  .forecast-item img {
    width: 66px;
    height: 91px;
  }

  .forecast-item a {
   font-size: 16px;
  }
  .forecast{
    display: flex;
  } 
</style>


<div
	class="preloader flex-column justify-content-center align-items-center"
	style="height: 0px;">
	<img class="animation__shake"
		src="/resources/bootstrap/dist/img/AdminLTELogo.png"
		alt="AdminLTELogo" height="60" width="60" style="display: none;">
</div>
<nav
	class="main-header navbar navbar-expand navbar-white navbar-light header_nav">
	<!-- Left navbar links -->
	<ul class="navbar-nav">
		<li class="nav-item"><a class="nav-link" data-widget="pushmenu"
			href="#" role="button"><i class="fas fa-bars"></i></a></li>
	</ul>

	<!-- Right navbar links -->
	
	<!-- 날씨-->
	<ul class="navbar-nav ml-auto">
		<li class="nav-item dropdown">
  <a class="nav-link" data-toggle="dropdown" href="#" aria-expanded="false">
    <i class="fa-solid fa-cloud" id="weather"></i>
  </a>
  <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right" style="left: inherit; right: 0px; height: 500%; min-width: 580px;">
    <div class="modal">
        <div class="forecast"></div>
    </div>
  </div>
</li>

		<li class="nav-item dropdown dropdown_menu"><a class="nav-link"
			data-toggle="dropdown" href="#" id="alarm_btn"> <i
				class="far fa-bell"></i> <span
				class="badge badge-warning navbar-badge" id="header_alarm_cnt"></span>
		</a>
			<div
				class="dropdown-menu dropdown-menu-lg dropdown-menu-right dropdown_menu_content">
				<div class="dropdown-item dropdown-header"
					id="header_dropdown_header">
					<span>알림</span>
					<div id="readAll">모두읽기</div>
				</div>
			</div></li>

		<li class="nav-item dropdown dropdown_menu" id="logout">
			<form action="/everyware/logout" method="post" id="logoutForm">
				<sec:csrfInput />
			</form> <a class="nav-link" data-toggle="dropdown" href="#" id="alarm_btn">
				<i class="fa-solid fa-door-open"></i>
		</a>
		</li>
		<li class="nav-item"><a class="nav-link" data-widget="fullscreen"
			href="#" role="button"> <i class="fas fa-expand-arrows-alt"></i>
		</a></li>
	</ul>
</nav>
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
  $(()=>{
	  $("#logout").on("click", function(){
		  $("#logoutForm").submit();
	  })
	  
		
		
	  const alarmBtn = $("#alarm_btn")
	  
	  getAlarmList(alarmCountModify)
    		  
	  
	  
	  
	  $("#readAll").on("click",function(e){
		  e.preventDefault()
		  e.stopPropagation()
		  $.ajax({
	    	  url: '/everyware/alarm/removeAll',
	    	  type: 'post',
	    	  contentType: 'application/json',
	    	  beforeSend : function(xhr){
	  			  xhr.setRequestHeader(window.messengerCsrf,window.messengerCsrfToken);
	  	  	  },
	    	  success: function(res) {
	    		 if(res.res=="OK"){
	    			$("#header_dropdown_header span").text("0 Notifications")
	    			$('.dropdown_menu_content').children().slice(1).remove();
	    			$("#header_alarm_cnt").text(0)
	    			$("#header_alarm_cnt").css("display","none")
	    		 }
	    	  },
	    	  error: function(xhr, status, error) {
	    	    console.log("error :"+status)
	    	  }
	    });
	  })
	  
	  
    		  
	  $(".dropdown_menu_content").on("click",'.alarm_del',function(e){
		  e.stopPropagation()
		  e.preventDefault()
		  var el = $(this).parents(".alarm_el")
		  var alarmId = $(this).parents(".alarm_el").attr("id")
		  $.ajax({
	    	  url: '/everyware/alarm/remove',
	    	  type: 'post',
	    	  data:JSON.stringify({alarmId:alarmId}),
	    	  contentType: 'application/json',
	    	  beforeSend : function(xhr){
	  			  xhr.setRequestHeader(window.messengerCsrf,window.messengerCsrfToken);
	  	  	  },
	    	  success: function(res) {
	    		 if(res.res=="OK"){
	    			 $(".dropdown_menu_content #"+alarmId).remove()
	    			 el.remove()
	    			 var pcnt = $("#header_alarm_cnt").text()
	    			 pcnt=parseInt(pcnt)-1
	    			 if(pcnt>0){
	    				 $("#header_alarm_cnt").text(pcnt)
	    			 }else{
	    				 $("#header_alarm_cnt").text(pcnt)
	    				 $("#header_alarm_cnt").hide()
	    			 }
	    			 var ncnt=$("#header_dropdown_header span").text().split(" ")[0];
	    			 ncnt = parseInt(ncnt)-1
	    			 $("#header_dropdown_header span").text(ncnt+" Motifications")
	    			 var selectedElements = $(".dropdown_menu_content .al:not(.hidden_mark)");
	    			 console.log("zz")
	    			 console.log(selectedElements.length)
	    			 if(selectedElements.length<3){
	    				 var hiddenMark = $(".dropdown_menu_content .hidden_mark");
	    				 if(hiddenMark.length>0){
	    					 hiddenMark.eq(0).removeClass("hidden_mark");
	    					 hiddenMark.eq(0).removeClass("hidden_item");
	    					 hiddenMark.eq(1).removeClass("hidden_mark");
	    					 hiddenMark.eq(1).removeClass("hidden_item");
	    				 }
	    			 }
	    		 }
	    	  },
	    	  error: function(xhr, status, error) {
	    	    console.log("error :"+status)
	    	  }
	    });
	  })
	  
	  $(".dropdown_menu").on("click","#see_more",function(e){
		  e.preventDefault()
		  e.stopPropagation()
		  if($(this).text()=="See All Notifications"){
			  $(".hidden_mark").removeClass("hidden_item")
		  	  $(this).text("See Three Notifications")
		  }else if($(this).text()=="See Three Notifications"){
			  $(".hidden_mark").addClass("hidden_item")
		  	  $(this).text("See All Notifications")
		  }
		  
	  })
	  
	  alarmBtn.on("click",function(){
		  
		  if(!$(".dropdown_menu").hasClass("show")){
			  console.log( $('.dropdown_menu').children())
			  getAlarmList(alarmListAdd)
		  }
		  
	  })
	  
	  
	  
	  $(".dropdown_menu_content").on("click","#unread_alarm",function(e){
		  e.preventDefault()
		  $(".msgBtn").click()
	  })
	  
	  
	  $(".dropdown_menu_content").on("click",".alarm_el",function(e){
		  e.preventDefault()
		  var alarmId = $(this).attr("id")
		  var url = $(this).attr("href")
		  $.ajax({
	    	  url: '/everyware/alarm/remove',
	    	  type: 'post',
	    	  data:JSON.stringify({alarmId:alarmId}),
	    	  contentType: 'application/json',
	    	  beforeSend : function(xhr){
	  			  xhr.setRequestHeader(window.messengerCsrf,window.messengerCsrfToken);
	  	  	  },
	    	  success: function(res) {
	    		 if(res.res=="OK"){
	    			 location.href=url
	    		 }
	    	  },
	    	  error: function(xhr, status, error) {
	    	    console.log("error :"+status)
	    	  }
	    });
		  
	  })
	  
	  
	  
  })
  
  
  function getTimeDifferenceString(data) {
  var targetTime = new Date(data)
  var currentTime = new Date();
  var timeDifference = currentTime - targetTime;

  var minutes = Math.floor(timeDifference / (1000 * 60));
  var hours = Math.floor(timeDifference / (1000 * 60 * 60));
  var days = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
  if(minutes<0){
	  minutes=0
  }
  if (minutes < 60) {
    return `\${minutes}분 전`;
  } else if (hours < 24) {
    return `\${hours}시간 전`;
  } else if (days <= 3) {
    return `\${days}일 전`;
  } else {
    // 3일 이상 차이나면 기본 날짜 포맷을 사용하거나 다른 형태로 처리할 수 있습니다.
    // 이 예제에서는 날짜 객체의 toLocaleDateString 메서드를 사용하여 기본 날짜 형식으로 변환합니다.
    return targetTime.toLocaleDateString();
  }
}
  
  
  function alarmCountModify(res){

	  var alarmCnt=0;
		  if(res.messageUnreadCount>0){
			  alarmCnt++;
		  }
		  alarmCnt+=res.alarmList.length
		  if(alarmCnt==0){
			  $("#header_alarm_cnt").hide()
		  }else{
			  $("#header_alarm_cnt").show() 
		  }
		  
		  $("#header_alarm_cnt").text(alarmCnt)
  }
  function getAlarmList(callback){
	  $.ajax({
    	  url: '/everyware/alarm/alarmList',
    	  type: 'post',
    	  contentType: 'application/json',
    	  beforeSend : function(xhr){
  			  xhr.setRequestHeader(window.messengerCsrf,window.messengerCsrfToken);
  	  	  },
    	  success: function(res) {
    		  
			if(typeof callback != "undefined"){
				callback(res)
			}
    		  
    	  },
    	  error: function(xhr, status, error) {
    	    console.log("error :"+status)
    	  }
    });
  }
  
  function alarmListAdd(res){
	  $('.dropdown_menu_content').children().slice(1).remove();
	  var alarmCnt=0;
	  if(res.messageUnreadCount>0){
		  alarmCnt++;
	  }
	  alarmCnt+=res.alarmList.length
	  if(alarmCnt==0){
		  $("#header_alarm_cnt").hide()
	  }else{
		  $("#header_alarm_cnt").show() 
	  }
	  
	  $("#header_dropdown_header span").text(alarmCnt+" Notifications")
	  $("#header_alarm_cnt").text(alarmCnt)
	 var rowCount=0
		 if(res.messageUnreadCount>0){
		  
		  var time = getTimeDifferenceString(res.lastMessage.msgCrtDt)
		  var hiddenOpt = ""
		  var row = `<div class="dropdown-divider\${hiddenOpt}" id="unread_alarm"></div>
	          <a href="#" class="al dropdown-item\${hiddenOpt}" id="unread_alarm">
	            <img class="alarm_img" src="/resources/img/알람-메신저.png"> <div class="alarm_content">\${res.messageUnreadCount} 개의 안읽은 메세지가 존재합니다.</div>
	            <span class="float-right text-muted text-sm">\${time}</span>
	            <div class='rest'></div>
	          </a>`
	      $(".dropdown_menu_content").append(row)
	      rowCount++;
	  }
	  
	  $.each(res.alarmList,function(i,v){
		  if(v.alarmType==1){
			  console.log(v)
			  var time = getTimeDifferenceString(v.crtDt)
			  var hiddenOpt = ""
			  if(rowCount>2){
			  	hiddenOpt=" hidden_item hidden_mark"
			  }
			  
			  var profile ="/resources/img/basicProfile.png"
			  if(v.sender.empProfile!=null){
				  profile = "/everyware/mypage/thumbnail?empId="+v.sender.empId
			  }
			  var row = `<div class="dropdown-divider\${hiddenOpt}" id="\${v.alarmId}"></div>
	    		          <a href="\${v.urlAddr}" class="al alarm_el dropdown-item\${hiddenOpt}" id="\${v.alarmId}">
	    		            <img class="alarm_img" src="\${profile}"> <div class="alarm_content">\${v.sender.empName} 님으로 부터 메일이 도착하였습니다.</div>
	    		            <span class="float-right text-muted text-sm">\${time}</span>
	    		          	<div class='alarm_del'></div>
	    		          	<div class='rest'></div>
	    		          </a>`
	    	$(".dropdown_menu_content").append(row)
	    		          
		  }else if(v.alarmType==7){
			  console.log(v)
			  var time = getTimeDifferenceString(v.crtDt)
			  var hiddenOpt = ""
			  if(rowCount>2){
				  	hiddenOpt=" hidden_item hidden_mark"
				  }
			  var row = `<div class="dropdown-divider\${hiddenOpt}" id="\${v.alarmId}"></div>
		          <a href="\${v.urlAddr}" class="al alarm_el dropdown-item\${hiddenOpt}" id="\${v.alarmId}">
		            <img class="alarm_img" src="/resources/img/알람-캘린더.png"> <div class="alarm_content">'\${v.sndrNm}'이 등록되었습니다. </div>
		            <span class="float-right text-muted text-sm">\${time}</span>
		            <div class='alarm_del'></div>
		            <div class='rest'></div>
		          </a>`
		      $(".dropdown_menu_content").append(row)
		  }else if(v.alarmType==8){
			  console.log(v)
			  var time = getTimeDifferenceString(v.crtDt)
			  var hiddenOpt = ""
			  if(rowCount>2){
				  	hiddenOpt=" hidden_item hidden_mark"
				  }
			  var row = `<div class="dropdown-divider\${hiddenOpt}" id="\${v.alarmId}"></div>
		          <a href="\${v.urlAddr}" class="al alarm_el dropdown-item\${hiddenOpt}" id="\${v.alarmId}">
		            <img class="alarm_img" src="/resources/img/알람-캘린더.png"> <div class="alarm_content">'\${v.sndrNm}'이 변경되었습니다. </div>
		            <span class="float-right text-muted text-sm">\${time}</span>
		            <div class='alarm_del'></div>
		            <div class='rest'></div>
		          </a>`
		      $(".dropdown_menu_content").append(row)
		  }else if(v.alarmType==9){
			  console.log(v)
			  var time = getTimeDifferenceString(v.crtDt)
			  var hiddenOpt = ""
			  if(rowCount>2){
				  	hiddenOpt=" hidden_item hidden_mark"
				  }
			  var row = `<div class="dropdown-divider\${hiddenOpt}" id="\${v.alarmId}"></div>
		          <a href="\${v.urlAddr}" class="al alarm_el dropdown-item\${hiddenOpt}" id="\${v.alarmId}">
		            <img class="alarm_img" src="/resources/img/알람-캘린더.png"> <div class="alarm_content">'\${v.sndrNm}' 일정의 수행인원으로 등록되었습니다. </div>
		            <span class="float-right text-muted text-sm">\${time}</span>
		            <div class='alarm_del'></div>
		            <div class='rest'></div>
		          </a>`
		      $(".dropdown_menu_content").append(row)
		  }
		  rowCount++;
	  })
	  
	  
	  if(alarmCnt>3){
		  var seeMore = `<div class="dropdown-divider"></div>
	    		          <a href="#" id="see_more" class="dropdown-item dropdown-footer">See All Notifications</a>
	    			        </div>`
		  $(".dropdown_menu_content").append(seeMore)
	  }
	  
  }
  
  // 날씨
  $(function () {
	 
	
      $("#weather").click(function () {
        $(".modal").fadeIn();

        $(document).ready(function () {
          function convertTime() {
            var now = new Date();

            var month = now.getMonth() + 1;
            var date = now.getDate();

            return month + "월" + date + "일";
          }

          var currentTime = convertTime();
          $(".nowtime").append(currentTime);
        });

       $.getJSON(
          "https://api.openweathermap.org/data/2.5/forecast?q=Daejeon,kr&appid=46b55a9f61cc588200575a3dda8e3069&units=metric",
          function (ForecastResult) {
            var forecastData = ForecastResult.list;
            var forecastHtml = "";

            for (var i = 0; i < 5; i ++) {
              var forecastDate = new Date(forecastData[i].dt * 1000);
              var day = forecastDate.getDate();
              var month = forecastDate.getMonth() + 1;
              var time  = forecastDate.getHours();
              var weatherIconUrl =
                "http://openweathermap.org/img/wn/" +
                forecastData[i].weather[0].icon +
                ".png";

              forecastHtml +=
                '<div class="forecast-item" id="weatherdiv">' +
                  '<img src="' +
                weatherIconUrl +
                '" alt="' +
                forecastData[i].weather[0].description +
                '"/>' +
                "<a>" + "<br>"+
                month + "월 " +
                day + "일" +
                "<br>"+
                time + "시" +
                "</a>" +
                "<br>"+
                "<a>" +
                "최대기온: " + forecastData[i].main.temp_max + "°C" +
                "</a>" +
                "</div>";
            }
            $(".forecast").html(forecastHtml);
          }
        );
      });

      $(".modal_content").click(function () {
        $(".modal").fadeOut();
      });
    });
  
  </script>