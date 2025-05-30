<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
.space-evenly{
	justify-content: space-evenly;
}
.search_div label{
	width: 60px;
}
#total,#img_total{
font-size: 12px;
    color: gray;
    margin-left: 10px;
}
.sender_profile{
	    width: 30px;
    height: 30px;
    border-radius: 100%;
}
.span_date{
	font-size: 12px;
	display: block;
}
.sender_profile_container{
	display: flex;
}
.active{
	background: aliceblue;
	
}
.chat_img{
	width: 90%;
	height: 180px;
	display: inline-block;
}
.img_a{
	text-align: center;
	padding-top: 5%;
}
.plain{
	text-overflow: ellipsis;
    white-space: nowrap;
    width: 90%;
    overflow: hidden;
    margin: 0 5%;
    font-size: 12px;
    text-align: left;
}
.imgPage{
	display: none;
}
.download_btn{
	margin-left: 5%;
}
#modal_back{
	position: fixed;
	background: rgba(0,0,0,0.5);
    top: 0;
    width: 100%;
    height: 100%;
    left: 0;
    z-index: 1038;
    display: none;
}
.chat_modal{
position: fixed;
  top: 50%;
  left: 50%;
  background: white;
  z-index: 1038;
  transform: translate(-50%, -50%);
  padding: 0;
}
.modal_container{
	margin: 0;
}
.direct-chat-messages{
	height: 500px;
}
.modal_footer_btn{
	justify-content: flex-end;
}
#exit{
	background: cadetblue;
    border: none;
    border-radius: 5px;
}
.direct-chat-timestamp{
	font-size: 11px;
}
.modal_content{
	padding: 10px 20px;
}
.cur_msg .direct-chat-text::before,.cur_msg .direct-chat-text::after {
    border: solid transparent;
    border-right-color: cadetblue;
    content: " ";
    height: 0;
    pointer-events: none;
    position: absolute;
    right: 100%;
    top: 15px;
    border-width: 5px;
    margin-top: -5px;
    width: 0;
}
.cur_msg .direct-chat-text{
	background: cadetblue;
    border-color: cadetblue;
}
</style>
<section class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1>메신저 관리</h1>
			</div>
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">메신저 관리</li>
				</ol>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->
</section>
<section class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3">
				<div class="sticky-top mb-3">
					<div id="external-events">
					<div class="card small_menu">
			            <div class="card-header">
			              <h3 class="card-title">메신저 관리</h3>
			              <div class="card-tools">
			                <button type="button" class="btn btn-tool" data-card-widget="collapse">
			                  <i class="fas fa-minus"></i>
			                </button>
			              </div>
			            </div>
			            <div class="card-body p-0">
			              <ul class="nav nav-pills flex-column calendar_dept_list">
			              	<li class="nav-item active">
			                  <a href="#" class="nav-link" id="0">
			                  	<div class="icon_name">
			                  		 <ion-icon name="file-tray-outline"></ion-icon><span>채팅 로그 조회</span>
			                  	</div>
			                  </a>
			                </li>
			              	<li class="nav-item">
			                  <a href="#" class="nav-link" id="0">
			                  	<div class="icon_name">
			                  		 <ion-icon name="file-tray-outline"></ion-icon><span>이미치 로그 조회</span>
			                  	</div>
			                  </a>
			                </li>
			              </ul>
			            </div>
			            <!-- /.card-body -->
			          </div>
					</div>
					
				</div>
			</div>
			<!-- /.col -->
			<div class="col-md-9">
				<div class="card chatPage">
				<div class="card-header">
					<h3 class="card-title">Fixed Header Table</h3>
						<div class="card-tools">
							<div class="input-group input-group-sm" style="width: 150px;">
							</div>
						</div>
					</div>
		
					<div class="card-body search_div">
						<div class="row space-evenly">
							<div class="form-group col-sm-4">
								<div class="row">
									<label for="name" class="col-form-label">방제목</label>
									<div class="col">
										<input type="text" class="form-control" id="roomName"
										placeholder="RoomName"	>
									</div>
								</div>
							</div>
							<div class="form-group col-sm-4">
								<div class="row">
									<label for="name" class="col-form-label">보낸이</label>
									<div class="col">
										<input type="text" class="form-control" id="name"
											placeholder="Sender">
									</div>
								</div>
							</div>
						</div>
						<div class="row space-evenly">
							<div class="form-group col-sm-4">
								<div class="row">
									<label for="name" class="col-form-label">날짜</label>
									<div class="input-group col">
									<div class="input-group-prepend">
									<span class="input-group-text">
									<i class="far fa-calendar-alt"></i>
									</span>
									</div>
									<input type="text" class="form-control float-right" id="reservation">
									</div>
								</div>
							</div>
							<div class="form-group col-sm-4">
								<div class="row">
									<label for="name" class="col-form-label">내용</label>
									<div class="col">
										<input type="text" class="form-control" id="content"
										placeholder="Content"	>
									</div>
								</div>
							</div>
						</div>
						<div class="row space-evenly">
							<div class="col-sm-4">
								<label for="name" class="col-form-label"></label>
								<div class="col">
								</div>
							</div>
							<div class="col-sm-4">
								<div class="row">
									<label for="search_btn" class="col-form-label"></label>
									<div class="col">
										<button type="button" class="btn btn-default" id="search_btn">검색</button>
										<button type="button" class="btn btn-default" id="reset_btn">리셋</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.card -->
				<div class="card chatPage">
					<div class="card-header">
						<h3 class="card-title">검색 결과 <span id="total">전체 3건</span></h3>
						<div class="card-tools">
							<div class="input-group input-group-sm" style="width: 150px;">
								<div class="input-group-append">
									<select class="form-control" id="orderSel">
										<option>날짜 내림차순</option>
										<option>날짜 오름차순</option>
									</select>
								</div>
							</div>
						</div>
					</div>
		
					<div class="card-body table-responsive p-0" style="height: 400px;">
						<table class="table table-head-fixed text-nowrap result_table">
							<thead>
								<tr>
									<th>방 제목</th>
									<th>보낸이</th>
									<th>내용</th>
									<th>구분</th>
									<th>날짜</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
					<div class="card-footer">
						
					</div>
				</div>
				<div class="card imgPage" id="imgPage">
				<div class="card-header">
					<h3 class="card-title">Fixed Header Table</h3>
						<div class="card-tools">
							<div class="input-group input-group-sm" style="width: 150px;">
							</div>
						</div>
					</div>
		
					<div class="card-body search_div">
						<div class="row space-evenly">
							<div class="form-group col-sm-4">
								<div class="row">
									<label for="name" class="col-form-label">방제목</label>
									<div class="col">
										<input type="text" class="form-control" id="img_roomName"
										placeholder="RoomName"	>
									</div>
								</div>
							</div>
							<div class="form-group col-sm-4">
								<div class="row">
									<label for="name" class="col-form-label">보낸이</label>
									<div class="col">
										<input type="text" class="form-control" id="img_name"
											placeholder="Sender">
									</div>
								</div>
							</div>
						</div>
						<div class="row space-evenly">
							<div class="form-group col-sm-4">
								<div class="row">
									<label for="name" class="col-form-label">날짜</label>
									<div class="input-group col">
									<div class="input-group-prepend">
									<span class="input-group-text">
									<i class="far fa-calendar-alt"></i>
									</span>
									</div>
									<input type="text" class="form-control float-right" id="reservation2">
									</div>
								</div>
							</div>
							<div class="form-group col-sm-4">
								<div class="row">
									<label for="fileName" class="col-form-label">파일명</label>
									<div class="col">
										<input type="text" class="form-control" id="fileName"
											placeholder="FileName">
									</div>
								</div>
							</div>
						</div>
						<div class="row space-evenly">
							<div class="col-sm-4">
								<label for="name" class="col-form-label"></label>
								<div class="col">
								</div>
							</div>
							<div class="col-sm-4">
								<div class="row">
									<label for="img_search_btn" class="col-form-label"></label>
									<div class="col">
										<button type="button" class="btn btn-default" id="img_search_btn">검색</button>
										<button type="button" class="btn btn-default" id="img_reset_btn">리셋</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.card -->
				<div class="card imgPage" id="imgPage">
					<div class="card-header">
						<h3 class="card-title">검색 결과 <span id="img_total">전체 3건</span></h3>
						<div class="card-tools">
							<div class="input-group input-group-sm" style="width: 150px;">
								<div class="input-group-append">
									<select class="form-control" id="img_orderSel">
										<option>날짜 내림차순</option>
										<option>날짜 오름차순</option>
									</select>
								</div>
							</div>
						</div>
					</div>
		
					<div class="card-body table-responsive p-0" style="height: 400px;">
						<div id="result_div">
							<div class="col-3 float-left img_div">
						        <div class="card card-blog card-plain">
						          <div class="position-relative">
						            <a class="d-block blur-shadow-image img_a">
						              <img src="/resources/img/Anne-Marie(앤마리)-2002.jpg" alt="img-blur-shadow" class="img-fluid border-radius-lg chat_img">
						            </a>
						          <div class="colored-shadow"></div></div>
						          <div class="card-body px-1 pt-3">
						          	<p class="plain">방제목: 안녕들하십니까?</p>
						            <p class="plain">전송자: 변정민</p>
									<p class="plain">파일명: 스크린샷 2023-03-08 193548.png</p>
									<p class="plain">파일크기: 0.78KB</p>
									<p class="plain">전송일자: 2023/07/05</p>
									<button type="button" class="btn bg-gradient-primary btn-sm download_btn"><ion-icon name="document-outline"></ion-icon>다운로드</button>
						          </div>
						        </div>
						      </div>
						      <div class="col-3 float-left">
						        <div class="card card-blog card-plain">
						          <div class="position-relative">
						            <a class="d-block blur-shadow-image">
						              <img src="/resources/img/Anne-Marie(앤마리)-2002.jpg" alt="img-blur-shadow" class="img-fluid border-radius-lg chat_img">
						            </a>
						          <div class="colored-shadow" style="background-image: url(&quot;../../assets/img/bg5.jpg&quot;);"></div></div>
						          <div class="card-body text-center px-1 pt-3">
						            <p class="mb-2 text-sm">Private Room • 1 Guests • 1 Sofa</p>
						            <a href="javascript:;">
						              <h5>
						                Single room in the center of the city
						              </h5>
						            </a>
						            <p>
						              As Uber works through a huge amount of internal management turmoil, the company is also consolidating and rationalizing more of its international business.
						            </p>
						            <button type="button" class="btn bg-gradient-primary btn-sm">From / Night</button>
						          </div>
						        </div>
						      </div>
						</div>
					</div>
					<div class="card-footer">
						
					</div>
				</div>
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.container-fluid -->
</section>


<div id=modal_back>
	<div class="col-8 chat_modal">
		<div class="card direct-chat direct-chat-primary modal_container">
			<div class="card-header ui-sortable-handle" style="cursor: move;">
				<h3 class="card-title modal_header">Direct Chat</h3>
				<div class="card-tools">
					<button type="button" class="btn btn-tool modal_close_btn">
						<i class="fas fa-times"></i>
					</button>
				</div>
			</div>
			
			<div class="card-body">
			
			<div class="direct-chat-messages modal_content">
			
			<div class="direct-chat-msg">
			<div class="direct-chat-infos clearfix">
			<span class="direct-chat-name float-left">Alexander Pierce</span>
			<span class="direct-chat-timestamp float-right">23 Jan 2:00 pm</span>
			</div>
			
			<img class="direct-chat-img" src="dist/img/user1-128x128.jpg" alt="message user image">
			
			<div class="direct-chat-text">
			Is this template really for free? That's unbelievable!
			</div>
			
			</div>
			<hr>
			
			<div class="direct-chat-msg">
			<div class="direct-chat-infos clearfix">
			<span class="direct-chat-name float-right">Sarah Bullock</span>
			<span class="direct-chat-timestamp float-left">23 Jan 2:05 pm</span>
			</div>
			
			<img class="direct-chat-img" src="dist/img/user3-128x128.jpg" alt="message user image">
			
			<div class="direct-chat-text">
			You better believe it!
			</div>
			
			</div>
			
			
			<div class="direct-chat-msg">
			<div class="direct-chat-infos clearfix">
			<span class="direct-chat-name float-left">Alexander Pierce</span>
			<span class="direct-chat-timestamp float-right">23 Jan 5:37 pm</span>
			</div>
			
			<img class="direct-chat-img" src="dist/img/user1-128x128.jpg" alt="message user image">
			
			<div class="direct-chat-text">
			Working with AdminLTE on a great new app! Wanna join?
			</div>
			
			</div>
			
			
			<div class="direct-chat-msg right">
			<div class="direct-chat-infos clearfix">
			<span class="direct-chat-name float-right">Sarah Bullock</span>
			<span class="direct-chat-timestamp float-left">23 Jan 6:10 pm</span>
			</div>
			
			<img class="direct-chat-img" src="dist/img/user3-128x128.jpg" alt="message user image">
			
			<div class="direct-chat-text">
			I would love to.
			</div>
			
			</div>
			
			</div>
			
			
			
			
			</div>
			
			<div class="card-footer">
			<form action="#" method="post">
			<div class="input-group modal_footer_btn">
			<span class="input-group-append">
			<button type="button" class="btn btn-primary modal_close_btn" id="exit">나가기</button>
			</span>
			</div>
			</form>
			</div>
			
			</div>
		</div>
</div>




<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.0/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.39.0/js/tempusdominus-bootstrap-4.min.js" integrity="sha512-k6/Bkb8Fxf/c1Tkyl39yJwcOZ1P4cRrJu77p83zJjN2Z55prbFHxPs9vN7q3l3+tSMGPDdoH51AEU8Vgo1cgAA==" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.39.0/css/tempusdominus-bootstrap-4.min.css" integrity="sha512-3JRrEUwaCkFUBLK1N8HehwQgu8e23jTH4np5NHOmQOobuC4ROQxFwFgBLTnhcnQRMs84muMh0PnnwXlPq5MGjg==" crossorigin="anonymous" />
<script type="text/javascript">
$(()=>{
	
	var gridDiv = $("#table")
	var chatObj = {
		roomName:null,
		sender:null,
		sdate:getOneYearsAgo(),
		edate:getNextDayWithMoment(getToday()),
		content:null,
		isLately:"날짜 내림차순",
		page:1
	}
	var imgObj = {
		roomName:null,
		sender:null,
		sdate:getOneYearsAgo(),
		edate:getNextDayWithMoment(getToday()),
		isLately:"날짜 내림차순",
		fileName:null,
		page:1
	}
	var chatFlag=true;
	
	var modalCloseBtn = $(".modal_close_btn")
	
	getChatList(chatObj,fillTable)
	
	modalCloseBtn.on("click",function(){
		$("#modal_back").css("display","none")
	})
	
	$(document).on("click",".result_table tbody tr,.img_div",function(e){
	
		const target = e.target;
	    if (target.classList.contains('download_btn') || target.classList.contains('chat_img')) {
	  	
	    } else {
		   $("#modal_back").css("display","block")
		   var msgId = this.id
		   $.ajax({
				  url: '/everyware/admin/chat/roomLog', // 요청을 보낼 URL
				  method: 'post', // HTTP 메서드 (GET, POST 등)
				  data: JSON.stringify({msgId:msgId}),
				  beforeSend : function(xhr){
					  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			  	  },
			  	  contentType: 'application/json; charset=utf-8',
				  success: function(response) {
					 $(".modal_header").text(response[0].roomNm)
					 $(".modal_content").empty()
					 
					 $.each(response,function(i,v){
						 var curMsgId=""
						 if(msgId==v.msgId){
							 curMsgId=" cur_msg"
						 }
						 var msgCn=""
						 
						 if(v.msgType==2){
							 msgCn=v.msgCn
						 }else if(v.msgType==1){
							 //여기 이미지메세지일경우 해야됨
							 msgCn=`<a class="d-block blur-shadow-image room_img_a" href="/everyware/chat/originChatImgRead/\${v.msgId}" target='_blank'>
					              		<img src="/everyware/chat/chatImgRead/\${v.msgId}" alt="img-blur-shadow" class="img-fluid border-radius-lg room_chat_img">
						            </a>`
						 }
						 
						 var profile ="/resources/img/basicProfile.png"
						 if(v.employee.empProfile!=null){
							profile = "/everyware/mypage/thumbnail?empId="+v.employee.empId
						 }
						 
						 var row = `<div class="direct-chat-msg\${curMsgId}">
									<div class="direct-chat-infos clearfix">
									<span class="direct-chat-name float-left">\${v.employee.empName}</span>
									<span class="direct-chat-timestamp float-right">\${dateFormat2(v.msgCrtDt)}</span>
									</div>
									
									<img class="direct-chat-img" src="\${profile}" alt="message user image">
									
									<div class="direct-chat-text">
									\${msgCn}
									</div>
									</div>
									<hr>`
						  $(".direct-chat-messages").append(row)
					 })
					 
					 setTimeout(() => {
						 var curMsg = document.querySelector(".cur_msg")
						 var parent = document.querySelector(".modal_content")
						 const scroll = curMsg.getBoundingClientRect().top- parent.getBoundingClientRect().top +parent.scrollTop;
						 parent.scrollTop=scroll
					}, 100);
					 
				  },
				  error: function(xhr, status, error) {
					alert("메일전송 실패")
				  }
				});
	    }
	})
	
	
	$(document).on("click",".pagination a",function(e){
		e.preventDefault()
		var page = $(this).data("page")
		if(chatFlag){
			chatObj.page=page
			getChatList(chatObj,fillTable)
		}else{
			imgObj.page=page
			getImgChatList(imgObj,fillImgTable)
		}
	})
	
	$(".small_menu").on("click","li",function(e){
		e.preventDefault()
		$(".small_menu li").removeClass("active")
		$(this).addClass("active")
		if($("a",this).text().trim()=="채팅 로그 조회"){
			$("#reset_btn").click()
			chatFlag=true;
			pageToggle()
		}else{
			$("#img_reset_btn").click()
			chatFlag=false;
			pageToggle()
		}
	})
	
	
	$("#search_btn").on("click",function(){
		var name = $("#name").val()
		var roomName = $("#roomName").val()
		var date = $("#reservation").val()
		var content = $("#content").val()
		var sdate = date.substr(0,10)
		var edate = date.substr(13,23)

		edate = getNextDayWithMoment(edate)
		
		chatObj.roomName=roomName;
		chatObj.sender = name
		chatObj.content=content;
		chatObj.sdate=sdate;
		chatObj.edate=edate;
		chatObj.page=1;
		
		getChatList(chatObj,fillTable)
	})
	
	
	$("#img_search_btn").on("click",function(){
		var name = $("#img_name").val()
		var roomName = $("#img_roomName").val()
		var date = $("#reservation2").val()
		var content = $("#img_content").val()
		var sdate = date.substr(0,10)
		var edate = date.substr(13,23)
		var fileName = $("#fileName").val()

		edate = getNextDayWithMoment(edate)
		
		imgObj.roomName=roomName;
		imgObj.sender = name
		imgObj.content=content;
		imgObj.sdate=sdate;
		imgObj.edate=edate;
		imgObj.fileName=fileName
		imgObj.page=1;
		
		getImgChatList(imgObj,fillImgTable)
	})
	
	$("#reset_btn").on("click",function(){
		$("#name").val("")
		$("#roomName").val("")
		$("#reservation").val(getOneYearsAgo()+" ~ "+getToday())
		$("#content").val("")
		
		chatObj.roomName="";
		chatObj.sender =""
		chatObj.content="";
		chatObj.sdate=getOneYearsAgo();
		chatObj.edate= getNextDayWithMoment(getToday());
		chatObj.page=1;
		getChatList(chatObj,fillTable)
	})
	$("#img_reset_btn").on("click",function(){
		$("#img_name").val("")
		$("#img_roomName").val("")
		$("#reservation2").val(getOneYearsAgo()+" ~ "+getToday())
		$("#img_content").val("")
		$("#fileName").val("")
		
		imgObj.fileName="";
		imgObj.roomName="";
		imgObj.sender =""
		imgObj.content="";
		imgObj.sdate=getOneYearsAgo();
		imgObj.edate = getNextDayWithMoment(getToday());
		imgObj.page=1;
		getImgChatList(imgObj,fillImgTable)
	})
	
	$("#orderSel").on("change",function(){
		chatObj.isLately=$(this).val()
		getChatList(chatObj,fillTable)
	})
	$("#img_orderSel").on("change",function(){
		imgObj.isLately=$(this).val()
		getImgChatList(imgObj,fillImgTable)
	})
	
	
	$("#reservation").daterangepicker({
		   locale: {
			    "separator": " ~ ",                     // 시작일시와 종료일시 구분자
			    "format": 'YYYY/MM/DD',     // 일시 노출 포맷
			    "applyLabel": "확인",                    // 확인 버튼 텍스트
			    "cancelLabel": "취소",                   // 취소 버튼 텍스트
			    "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
			    "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
			    },
			    autoApply: false, 
			    startDate: moment().subtract(1, 'year'),
			    endDate: new Date(),
			    drops: "auto"
	})
	$("#reservation2").daterangepicker({
		   locale: {
			    "separator": " ~ ",                     // 시작일시와 종료일시 구분자
			    "format": 'YYYY/MM/DD',     // 일시 노출 포맷
			    "applyLabel": "확인",                    // 확인 버튼 텍스트
			    "cancelLabel": "취소",                   // 취소 버튼 텍스트
			    "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
			    "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
			    },
			    autoApply: false, 
			    startDate: moment().subtract(1, 'year'),
			    endDate: new Date(),
			    drops: "auto"
	})
	
	function getImgChatList(obj,callback){
		console.log(obj)
		$.ajax({
			  url: '/everyware/admin/chat/imgChatList', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: JSON.stringify(obj),
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	  contentType: 'application/json; charset=utf-8',
			  success: function(response) {
				  if(typeof callback !="undefined"){
					  callback(response)
				  }
				 
			  },
			  error: function(xhr, status, error) {
				alert("메일전송 실패")
			  }
			});
	}
	
	function getChatList(obj,callback){
		$.ajax({
			  url: '/everyware/admin/chat/chatList', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: JSON.stringify(obj),
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	  contentType: 'application/json; charset=utf-8',
			  success: function(response) {
				  if(typeof callback !="undefined"){
					  callback(response)
				  }
				 
			  },
			  error: function(xhr, status, error) {
				alert("메일전송 실패")
			  }
			});
	}
	
	function fillImgTable(response){
		var total = "전체 "+response.totalRecord+"건"
		$("#img_total").text(total)
		$("#result_div").empty()
		
		$.each(response.dataList,function(i,v){
			var date = dateFormat(v.msgCrtDt)
			
			
			var el = `<div class="col-3 float-left img_div" id="\${v.msgId}">
				        <div class="card card-blog card-plain">
				          <div class="position-relative">
				            <a class="d-block blur-shadow-image img_a" href="/everyware/chat/originChatImgRead/\${v.msgId}" target='_blank'>
				              <img src="/everyware/chat/chatImgRead/\${v.msgId}" alt="img-blur-shadow" class="img-fluid border-radius-lg chat_img">
				            </a>
				          <div class="colored-shadow"></div></div>
				          <div class="card-body px-1 pt-3">
				          	<p class="plain">방제목: \${v.roomNm}</p>
				            <p class="plain">전송자: \${v.empName}</p>
							<p class="plain">파일명: \${v.fileNm}</p>
							<p class="plain">파일크기: \${convertFileSize(v.fileSz)}</p>
							<p class="plain">전송일자: \${date}</p>
							<a href="/everyware/mail/filedownload/?atchFileNo=\${v.atchFileNo}&atchFileSeq=\${v.atchFileSeq}" class="btn bg-gradient-primary btn-sm download_btn"><ion-icon name="document-outline"></ion-icon>다운로드</a>
				          </div>
				        </div>
				      </div>`
				      $("#result_div").append(el)
		})
		 $(".imgPage .card-footer").html(response.pagingHTML)
	}
	
	function fillTable(response){
		var total = "전체 "+ response.totalRecord+"건"
		 $("#total").text(total)
		 $(".result_table tbody").empty()
		 
		 $.each(response.dataList,function(i,v){
			 var date = dateFormat2(v.msgCrtDt)
			 var image = "텍스트"
			 var content=`\${v.msgCn}`
			 if(v.msgType==1){
				 image=`이미지`
				 content="<사진>"
			 }
			 var profile ="/resources/img/basicProfile.png"
			 if(v.empProfile!=null){
				profile = "/everyware/mypage/thumbnail?empId="+v.empId
			 }
			 var tr=`<tr id=\${v.msgId}>
				 	<td>\${v.roomNm}</td>
					<td>
						<div class="sender_profile_container">
							<img src="\${profile}" class="sender_profile">
							<div class="sender_profile_container">
								<div class="sender_name">\${v.empName}</div>
							</div>
						</div>
					</td>
					<td>\${content}</td>
					<td>\${image}</td>
					<td><span class="span_date">\${date}</span></td>
				</tr>`
				 $(".result_table tbody").append(tr)
		 })
		  $(".chatPage .card-footer").html(response.pagingHTML)
		
	}
	
	function pageToggle(){
		if(chatFlag){
			$(".imgPage").fadeOut(200)
			setTimeout(() => {
				$(".chatPage").fadeIn(200)
			}, 200);
			
		}else{
			$(".chatPage").fadeOut(200)
			setTimeout(() => {
				$(".imgPage").fadeIn(200)
			}, 200);
		}
	}
})
function dateFormat(time) {
  const dateObj = new Date(time);

  // 년, 월, 일 추출
  const year = dateObj.getFullYear();
  const month = String(dateObj.getMonth() + 1).padStart(2, '0');
  const day = String(dateObj.getDate()).padStart(2, '0');

  // 시간 추출
  let hours = dateObj.getHours();
  const minutes = dateObj.getMinutes();

  // 오전/오후 구분 및 시간 조정
  const meridiem = hours >= 12 ? '오후' : '오전';
  hours = hours % 12 || 12;

  // 최종 문자열 생성
  const formattedTime = `\${year}/\${month}/\${day} \${meridiem}\${String(hours).padStart(2, '0')}:\${String(minutes).padStart(2, '0')}`;
  return formattedTime;
}	
function dateFormat2(data){
//입력된 날짜 문자열을 Date 객체로 변환합니다.
	var date = new Date(data);
	
	//연도, 월, 일, 시간, 분을 추출합니다.
	var year = date.getFullYear();
	var month = date.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
	var day = date.getDate();
	var hours = date.getHours();
	var minutes = date.getMinutes();
	
	//월과 일이 한 자리 수일 경우 앞에 0을 붙입니다.
	var formattedMonth = (month < 10 ? "0" : "") + month;
	var formattedDay = (day < 10 ? "0" : "") + day;
	
	// 2023년 7월 15일 (화) 오전 12시 25분와 같은 형태
	var formattedDateString = `\${year}년 \${formattedMonth}월 \${formattedDay}일 (\${getDayOfWeekString(date)})<br> \${getAMPMString(hours)} \${getFormattedHours(hours)}시 \${getFormattedMinutes(minutes)}분`;
	
	return formattedDateString
}
//요일을 문자열로 반환하는 함수
function getDayOfWeekString(date) {
const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
return daysOfWeek[date.getDay()];
}

//오전/오후를 문자열로 반환하는 함수
function getAMPMString(hours) {
return hours < 12 ? "오전" : "오후";
}

//시간을 12시간 형식으로 변환하는 함수
function getFormattedHours(hours) {
const formattedHours = hours % 12;
return formattedHours === 0 ? 12 : formattedHours;
}

//분을 두 자리 수로 변환하는 함수
function getFormattedMinutes(minutes) {
return minutes < 10 ? "0" + minutes : minutes;
}
function convertFileSize(sizeInKB) {
	  if (sizeInKB < 1024) {
	    return sizeInKB + ' KB';
	  } else if (sizeInKB < 1024 * 1024) {
	    const sizeInMB = (sizeInKB / 1024).toFixed(2);
	    return sizeInMB + ' MB';
	  } else {
	    const sizeInGB = (sizeInKB / (1024 * 1024)).toFixed(2);
	    return sizeInGB + ' GB';
	  }
	}	
function getOneYearsAgo(){
	// 현재 날짜를 가져옵니다.
	var today = new Date();

	// 1년 전의 날짜를 계산합니다.
	var oneYearAgo = new Date(today);
	oneYearAgo.setFullYear(today.getFullYear() - 1);

	// 년, 월, 일을 가져옵니다.
	var year = oneYearAgo.getFullYear();
	var month = String(oneYearAgo.getMonth() + 1).padStart(2, '0'); // 0부터 시작하므로 +1을 해줍니다. 두 자리로 맞춥니다.
	var day = String(oneYearAgo.getDate()).padStart(2, '0'); // 두 자리로 맞춥니다.

	// "yyyy/mm/dd" 형식으로 1년 전의 날짜를 생성합니다.
	var formattedDate = `\${year}/\${month}/\${day}`;

	return formattedDate;
}
function getToday(){
	// 현재 날짜를 가져옵니다.
	var today = new Date();

	// 년, 월, 일을 가져옵니다.
	var year = today.getFullYear();
	var month = String(today.getMonth() + 1).padStart(2, '0'); // 0부터 시작하므로 +1을 해줍니다. 두 자리로 맞춥니다.
	var day = String(today.getDate()).padStart(2, '0'); // 두 자리로 맞춥니다.

	// "yyyy/mm/dd" 형식으로 날짜를 생성합니다.
	var formattedDate = `\${year}/\${month}/\${day}`;

	return formattedDate;
}
function getNextDayWithMoment(inputDate) {
	  var nextDate = moment(inputDate, "YYYY/MM/DD").add(1, 'days').format("YYYY/MM/DD");
	  return nextDate;
	}
</script>
