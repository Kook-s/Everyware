<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
.my-swal {
  z-index: 99999;
}
.tagify{    
  width: 87.3%;
  max-width: 700px;
  background: rgba(white, .8);
  max-height:100px;
  overflow-y: auto;
  overflow-x: hidden;
}

/* Suggestions items */
.tagify__dropdown.users-list .tagify__dropdown__item{
    padding: .5em .7em;
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 0 1em;
    grid-template-areas: "avatar name"
                         "avatar email";
}

.tagify__dropdown.users-list .tagify__dropdown__item:hover .tagify__dropdown__item__avatar-wrap{
    transform: scale(1.2);
}

.tagify__dropdown.users-list .tagify__dropdown__item__avatar-wrap{
    grid-area: avatar;
    width: 36px;
    height: 36px;
    border-radius: 50%;
    overflow: hidden;
    background: #EEE;
    transition: .1s ease-out;
}

.tagify__dropdown.users-list img{
    width: 100%;
    vertical-align: top;
}

.tagify__dropdown.users-list strong{
    grid-area: name;
    width: 100%;
    align-self: center;
}

.tagify__dropdown.users-list span{
    grid-area: email;
    width: 100%;
    font-size: .9em;
    opacity: .6;
}

.tagify__dropdown.users-list .tagify__dropdown__item__addAll{
    border-bottom: 1px solid #DDD;
    gap: 0;
}


/* Tags items */
.tagify__tag{
    white-space: nowrap;
}

.tagify__tag:hover .tagify__tag__avatar-wrap{
    transform: scale(1.6) translateX(-10%);
}

.tagify__tag .tagify__tag__avatar-wrap{
    width: 16px;
    height: 16px;
    white-space: normal;
    border-radius: 50%;
    background: silver;
    margin-right: 5px;
    transition: .12s ease-out;
}

.tagify__tag img{
    width: 100%;
    vertical-align: top;
    pointer-events: none;
}
#new-event-content{
	resize: none;
}
.calendar_dept_list .active{
	background: #e6f3ff
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
#calendar_modal{
position: fixed;
  top: 50%;
  left: 50%;
  min-width: 50%;
  min-height: 80%;
  background: white;
  z-index: 1038;
  transform: translate(-50%, -50%);
}
#calendar_modal_header{
	border-bottom: rgba(0,0,0,0.15) 1.5px solid;
	padding: 20px;
}
#calendar_modal_header h5{
	font-weight: bold;
}
#calendar_modal_content{
	padding: 30px;
	padding-bottom: 10px;
}
#calendar_modal_footer{
	padding: 20px 30px;
    border-top: rgba(0,0,0,0.15) 1.5px solid;
    min-height: 83px;
}
#calendar_modal_footer button{
	float: right;
	margin-left: 10px;
	border: none;
	color: white;
	border-radius: 10px;
	padding: 6px 25px;
	background: cadetblue;
}
#calendar_modal_content label{
	width: 70px;
	vertical-align: top;
	font-weight: normal;
}
#calendar_modal_content input[type=datetime-local]{
	width: 185px;
    height: 25px;
}
#sdate{
	margin-right: 10px !important;
}
#edate{
	margin-left: 10px !important;
}
#type{
	background: rgba(0,0,0,0.1);
	color: white;
	display: inline-block;
	margin-top: 10px;
	margin-bottom: 10px;
	padding: 5px 15px;
}
#calendar_modal_content input[type=text],#calendar_modal_content textarea, #calendar_modal_content label{
	margin: 10px 0;
}
#calendar_modal_content input[type=text]{
	width: 87.4%;
	border: 1px solid rgba(0,0,0,0.1);
}
#calendar_modal_content input:focus{
	outline: none;
    border: 1px solid rgb(128, 159, 255);
}
#calendar_modal_content input[type=text]{
	border-top: none;
	border-left: none;
	border-right: none;
	border-bottom: 1px solid rgba(0,0,0,0.1);
}
#calendar_modal_content input[type=text]:focus {
  outline: none;
  border-bottom: 1px solid rgb(128, 159, 255);
}
#calendar_modal_content textarea{
	width: 87.4%;
	resize: none;
	border: 1px solid rgba(0,0,0,0.1)
}
#calendar_modal_content textarea:focus{
	outline: 1px solid rgb(128, 159, 255);
}
.schdl_type{
	margin-left: 25px!important;
	margin-top: 17px!important;
}
#calendar_modal_content input[type=radio] {
  margin-top:6px;
}
#deptSel{
	margin: 13px 0;
	display: none;
}
.deptSel{
	margin: 13px 0;
	display: none;
}
#color-chooser{
	    margin: 10px 0;
    padding-top: calc(0.375rem + 1px);
    padding-bottom: calc(0.375rem + 1px);
}
.date_group{
	margin: 10px 0;
    padding-top: calc(0.375rem + 1px);
    padding-bottom: calc(0.375rem + 1px);
}
#color-chooser a i{
	transform 0.3s ease
}
.fc .fc-daygrid-day-number {
	color: black;
}
.fc .fc-col-header-cell-cushion {
	color: black;
}
</style>
<section class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1>캘린더</h1>
			</div>
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">캘린더</li>
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
					<div class="card">
			            <div class="card-header">
			              <h3 class="card-title">부서별 일정</h3>
			
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
			                  		 <ion-icon name="file-tray-outline"></ion-icon><span>전체부서</span>
			                  	</div>
			                  </a>
			                </li>
			              	<c:if test="${not empty departmentList }">
								<c:forEach items="${departmentList }" var="dept">
					              	<li class="nav-item">
					                  <a href="#" class="nav-link" id="${dept.deptId }">
					                  	<div class="icon_name">
					                  		 <ion-icon name="file-tray-outline"></ion-icon><span>${dept.deptNm }</span>
					                  	</div>
					                  </a>
					                </li>
				             	</c:forEach>
							</c:if>
			              </ul>
			            </div>
			            <!-- /.card-body -->
			          </div>
					</div>
					
				</div>
			</div>
			<!-- /.col -->
			<div class="col-md-9">
				<div class="card card-primary">
					<div class="card-body p-0">
						<!-- THE CALENDAR -->
						<div id="calendar">
							
						</div>
					</div>
					<!-- /.card-body -->
				</div>
				<!-- /.card -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.container-fluid -->
</section>
<div id=modal_back>
	<div id="calendar_modal">
		<div id="calendar_modal_header">
			<h5>일정 등록</h5>
		</div>
		<div id="calendar_modal_content">
			<form>
				<input type="hidden" id="scheduleId">
				<div class="form-group row">
				  <label for="title" class="col-sm-2 col-form-label">제목 </label>
				  <div class="input-group col-sm-10">
				  	<input id="title" type="text">
				  </div>
				</div>
				<div class="form-group row">
				  <label for="member" class="col-sm-2 col-form-label">일정 구분</label>
				    	<label class="form-check-label schdl_type col-sm-1"> 
				    		<input type="radio" name="schdlType" class="form-check-input" value="dep"><span>부서</span>
				    	</label> 
				    	<label class="form-check-label schdl_type col-sm-2"> 
				    		<input type="radio" name="schdlType" class="form-check-input" value="com"><span>회사</span>
						</label>
						<label for="deptSel" class="col-sm-2 col-form-label deptSel">부서 선택</label>
						<select id="deptSel" class="col-sm-3">
							<c:if test="${not empty departmentList }">
								<c:forEach items="${departmentList }" var="dept">
					              	<option value="${dept.deptId }">${dept.deptNm }</option>
				             	</c:forEach>
							</c:if>
						</select>
				</div>
				<div class="form-group row memberList">
				  <label for="member" class="col-sm-2 col-form-label">수행인원 </label>
				  <div class="input-group col-sm-10">
				  	<input name='users-list-tags' id="member" type="text">
				  	<div>
				    	<button class="btn btn-outline-secondary" type="button" data-toggle="modal" data-target="#tree-modal" id="addressbookBtn">주소록</button>
				    </div>
				  </div>
				</div>
				<div class="form-group row">
				  <label for="content" class="col-sm-2 col-form-label">내용 </label>
				  <div class="input-group col-sm-10">
				  	<textarea id="content" rows="10" cols=""></textarea>
				  </div>
				</div>
				<div class="form-group row">
				  <label class="col-sm-2 col-form-label">색깔</label>
				  <div class="btn-group col-sm-10" style="width: 100%; margin-bottom: 10px;">
						<ul class="fc-color-picker" id="color-chooser">
							<li><a class="text-primary" data-color="#007bff" href="#"><i
									class="fas fa-square"></i></a></li>
							<li><a class="text-warning" data-color="#ffc107" href="#"><i
									class="fas fa-square"></i></a></li>
							<li><a class="text-success" data-color="#28a745" href="#"><i
									class="fas fa-square"></i></a></li>
							<li><a class="text-danger" data-color="#dc3545" href="#"><i
									class="fas fa-square"></i></a></li>
							<li><a class="text-muted" data-color="#6c757d" href="#"><i
									class="fas fa-square"></i></a></li>
						</ul>
					</div>
				</div>
				<div class="form-group row">
				  <label for="content" class="col-sm-2 col-form-label">일정기간 </label>
				  <div class="input-group col-sm-10 date_group">
				  	<input type="datetime-local" id="sdate"> ~ <input type="datetime-local" id="edate">
				  </div>
				</div>
			</form>
		</div>
		<div id="calendar_modal_footer">
			<button id="cancleBtn">취소</button>
			<button id="removeBtn">삭제</button>
			<button id="updateBtn">수정</button>
			<button id="insertBtn">등록</button>
		</div>
	</div>
</div>
<%@ include file="../../everyware/contacts/contactModal.jsp" %>
<sec:authentication var="deptNm" property="principal.employee.deptNm"/>
<sec:authentication var="conm" property="principal.employee.conm"/>
<sec:authentication var="custId" property="principal.employee.custId"/>
<sec:authentication var="empName" property="principal.employee.empName"/>
<sec:authentication var="empId" property="principal.employee.empId"/>
<!-- fullCalendar 2.2.5 -->
<script src="/resources/bootstrap/plugins/moment/moment.min.js"></script>
<script src="/resources/bootstrap/plugins/fullcalendar/main.js"></script>
<!-- tippy 툴팁-->
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://unpkg.com/tippy.js@6.3.3/dist/tippy.umd.js"></script>
<!-- tagify 툴팁-->
<script src="https://cdn.jsdelivr.net/npm/@yaireo/tagify"></script>
<script src="https://cdn.jsdelivr.net/npm/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />
<script>
window.toInput = document.querySelector('#member');
  $(function () {

	var initialValue = $('#deptSel').val();
    var date = new Date()
    var d    = date.getDate(),
        m    = date.getMonth(),
        y    = date.getFullYear()

    var Calendar = FullCalendar.Calendar;
    var Draggable = FullCalendar.Draggable;
    var calendarEl = document.getElementById('calendar');

    var deptSel = document.querySelector('#deptSel');
	var insertBtn = $("#insertBtn")
	var curRadio=null;
	var curCalendar=0;
	
	$("#updateBtn").on("click",function(){
		
		var schdlId = $("#scheduleId").val()
		var schdlTtl = $("#title").val()
		var schdlType=curRadio;
		var alarm_sender=""
		var custId=null;
		var deptId=null;
		if(schdlType=="dep"){
			alarm_sender="부서일정"
			schdlType=2
			deptId=$("#deptSel").val()
		}else if(schdlType=="com"){
			alarm_sender="회사일정"
			schdlType=3
			custId="${custId}"
		}
		var memberList = tagify.value
		var schdlCn=$("#content").val()
		var schdlColor = $("#color-chooser .active").data("color")
		var sdate=$("#sdate").val()
		var edate=$("#edate").val()
		
		console.log(schdlId)
		console.log(schdlTtl)
		console.log(schdlType)
		console.log(deptId)
		console.log(memberList)
		console.log(schdlCn)
		console.log(schdlColor)
		console.log(sdate)
		console.log(edate)
		
		var allDay=""
			
			if(sdate.split('T')[1]=="00:00"&&edate.split('T')[1]=="00:00"){
				allDay=true;
			}else{
				allDay=false;
			}
		var idList = tagify.value.map(obj => obj.value);
		var obj={
			schdlId:schdlId,
			schdlTtl: schdlTtl,
			schdlType: schdlType,
			schdlCn: schdlCn,
			schdlAllday:allDay,
			schdlBgngDt:new Date(sdate),
  		    schdlEndDt:new Date(edate),
  		    schdlColor:schdlColor,
  		    deptId:deptId,
  		    memberIdList:idList,
  		    curCalendarDeptId:curCalendar
		}
		$.ajax({
			  url: '/everyware/admin/calendar/update', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: JSON.stringify(obj),
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	  contentType: 'application/json; charset=utf-8',
			  success: function(response) {
				 if(response.res=="OK"){  
					  alertSuccess("성공")
					  var socketObj={			//알람을 웹소켓으로		
  								type:"al",
  								alarm:{
  									sndrNm:alarm_sender,
  									deptId:deptId,
  									custId:custId,
  									alarmType:8,
  									urlAddr:"/everyware/calendar"
  								}
  						}
  						ws.send(JSON.stringify(socketObj));
					  if(idList.length>0){
							var obj={			//캘린더 수행인원 수정을 완료했을 때		
								type:"al",
								alarm:{
									sndrNm:schdlTtl,
									empIdList:idList,
									alarmType:9,
									urlAddr:"/everyware/calendar"
									}
							}
							ws.send(JSON.stringify(obj));
						}
					  closeModal()
					  calendar.removeAllEvents();
					  var list=[]
					  response.eventList.forEach(function(data){
					    	var allDay=""
					    	if(data.schdlAllday=="true"){
					    		 allDay=true
					    	}else{
					    		allDay=false
					    	}
					    	var event = {
					    		 title: data.schdlTtl,
					    		 start: new Date(data.schdlBgngDt),
					    		 end: new Date(data.schdlEndDt),
					    		 allDay:allDay,
					    		 backgroundColor: data.schdlColor,
					    		 borderColor: data.schdlColor,
						    	 schdlId:data.schdlId,
								 schdlType: data.schdlType,
								 schdlCn : data.schdlCn,
								 empId : data.empId,
								 memberList: data.memberList,
								 deptId:data.deptId,
								 deptNm:data.deptNm,
								 schdlColor:data.schdlColor
								 
					    	};
					    	list.push(event)
					    })
					  
					  calendar.addEventSource(list);
					  calendar.render(); 
				  }
			   
			  },
			  error: function(xhr, status, error) {
				alert("일정 등록 실패..")
			  }
		});    
	})
	
	$("#cancleBtn").on("click",function(){
		closeModal()
	})
	
	$(".calendar_dept_list a").on("click",function(e){
		e.preventDefault()
		
		$(".calendar_dept_list li").removeClass("active")
		$(this).parent("li").addClass("active")
		var deptId = this.id
		curCalendar=this.id
		$.ajax({
			  url: '/everyware/admin/calendar/deptEvent', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: JSON.stringify({deptId:deptId}),
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	  contentType: 'application/json; charset=utf-8',
			  success: function(response) {
				  calendar.removeAllEvents();
				  var list=[]
				  response.eventList.forEach(function(data){
				    	var allDay=""
				    	if(data.schdlAllday=="true"){
				    		 allDay=true
				    	}else{
				    		allDay=false
				    	}
				    	var event = {
				    		 title: data.schdlTtl,
				    		 start: new Date(data.schdlBgngDt),
				    		 end: new Date(data.schdlEndDt),
				    		 allDay:allDay,
				    		 backgroundColor: data.schdlColor,
				    		 borderColor: data.schdlColor,
					    	 schdlId:data.schdlId,
							 schdlType: data.schdlType,
							 schdlCn : data.schdlCn,
							 empId : data.empId,
							 memberList: data.memberList,
							 deptId:data.deptId,
							 deptNm:data.deptNm,
							 schdlColor:data.schdlColor
				    	};
				    	list.push(event)
				    })
				  
				  calendar.addEventSource(list);
				  calendar.render();				  
			  },
			  error: function(xhr, status, error) {
				alert("일정 등록 실패..")
			  }
		});  
		
		
	})
	
	
	insertBtn.on("click",function(){
		console.log("인서트버튼 클릭")
		console.log($("#title").val())
		console.log($('input[name="schdlType"]:checked').val())
		console.log(tagify.value)
		console.log($("#content").val())
		console.log($("#color-chooser .active").data("color"))
		console.log($("#sdate").val())
		console.log($("#edate").val())
		
		var radioVal=$('input[name="schdlType"]:checked').val()
		var schdlType =0;
		var deptId=null;
		var custId=null;
		var sndrNm=null;
		if(radioVal=="dep"){
			schdlType=2;
			deptId=$('#deptSel').val();
			sndrNm="부서일정"
		}else if(radioVal=="com"){
			schdlType=3;
			custId="${custId}"
			sndrNm="회사일정"
		}
		
		var allDay=""
			
		if($("#sdate").val().split('T')[1]=="00:00"&&$("#edate").val().split('T')[1]=="00:00"){
			allDay=true;
		}else{
			allDay=false;
		}
		
		var idList = tagify.value.map(obj => obj.value);
		var obj={
			schdlTtl: $("#title").val(),
			schdlType: schdlType,
			schdlCn:$("#content").val(),
			schdlAllday:allDay,
			schdlBgngDt:new Date($("#sdate").val()),
  		    schdlEndDt:new Date($("#edate").val()),
  		    schdlColor:$("#color-chooser .active").data("color"),
  		    deptId:deptId,
  		    memberIdList:idList,
  		    curCalendarDeptId:curCalendar
		}
		
		 
		 $.ajax({
 			  url: '/everyware/admin/calendar/register', // 요청을 보낼 URL
 			  method: 'post', // HTTP 메서드 (GET, POST 등)
 			  data: JSON.stringify(obj),
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	  contentType: 'application/json; charset=utf-8',
 			  success: function(response) {
 				 if(response.res=="OK"){
					  alertSuccess("성공")
					  
					  
					  var socketObj={			//일정을 등록했을 때 알람을 웹소켓으로		
								type:"al",
								alarm:{
									sndrNm:sndrNm,
									deptId:deptId,
									custId:custId,
									alarmType:7,
									urlAddr:"/everyware/calendar"
								}
						}
						ws.send(JSON.stringify(socketObj));
					  if(idList.length>0){
							var obj={			//캘린더 수행인원 수정을 완료했을 때		
								type:"al",
								alarm:{
									sndrNm:$("#title").val(),
									empIdList:idList,
									alarmType:9,
									urlAddr:"/everyware/calendar"
									}
							}
							ws.send(JSON.stringify(obj));
						}
					  closeModal()
					  calendar.removeAllEvents();
					  var list=[]
					  response.eventList.forEach(function(data){
					    	var allDay=""
					    	if(data.schdlAllday=="true"){
					    		 allDay=true
					    	}else{
					    		allDay=false
					    	}
					    	var event = {
					    		 title: data.schdlTtl,
					    		 start: new Date(data.schdlBgngDt),
					    		 end: new Date(data.schdlEndDt),
					    		 allDay:allDay,
					    		 backgroundColor: data.schdlColor,
					    		 borderColor: data.schdlColor,
						    	 schdlId:data.schdlId,
								 schdlType: data.schdlType,
								 schdlCn : data.schdlCn,
								 empId : data.empId,
								 memberList: data.memberList,
								 deptId:data.deptId,
								 deptNm:data.deptNm,
								 schdlColor:data.schdlColor
								 
					    	};
					    	list.push(event)
					    })
					  
					  calendar.addEventSource(list);
					  calendar.render();	
				  }
 			   
 			  },
 			  error: function(xhr, status, error) {
 				alert("일정 등록 실패..")
 			  }
 		});  
	})
    
    $("#color-chooser a").on("click",function(){
    	$("#color-chooser a").removeClass("active")
    	$(this).addClass("active")
    	
    
    	$.each($("#color-chooser a"),function(i,v){
    		if ($(v).hasClass("active")) {
		      // 회전 각도를 45도로 설정하여 아이콘을 회전시킵니다.
		      $("i",v).css('transform', 'rotate(45deg)');
		    } else {
		      // 회전을 해제하기 위해 회전 각도를 0으로 설정합니다.
		    	$("i",v).css('transform', 'rotate(0deg)');
		    }
    	})
	    
    })
    
    $('#deptSel').on("change",function(){
    	tagify.removeAllTags();
    	var selectedValue = $('#deptSel').val();
    	getDeptProfileList(selectedValue,function(response){
				var list=[]
				$.each(response,function(i,v){
					var profile ="/resources/img/basicProfile.png"
					if(v.empProfile!=null){
						profile = "/everyware/mypage/thumbnail?empId="+v.empId
					}
					var obj = {
							"value": v.empId,
							"name" : v.empName,
							"jbgdNm":v.jbgdNm,
							"deptNm":v.deptNm,
							"avatar":profile,
							"email":v.empMail
					}
					list.push(obj)
				})
				console.log(list)
				tagify.settings.whitelist=list
				
    	})
    })
    
    $('.schdl_type input').on('change', function() {
    	tagify.removeAllTags();
        // 선택된 라디오 버튼의 값을 가져옴
        var selectedValue = $(this).val()
        curRadio=selectedValue
        console.log(selectedValue)
        // 결과를 표시할 요소에 선택된 값을 적용
        if(selectedValue=="dep"){
        	$("#deptSel").css("display","block")
        	$(".deptSel").css("display","block")
        	
        	var firstOpt = $('#deptSel option:first-child').val();
        	
        	getDeptProfileList(firstOpt,function(response){

				var list=[]
				$.each(response,function(i,v){
					var profile ="/resources/img/basicProfile.png"
					if(v.empProfile!=null){
						profile = "/everyware/mypage/thumbnail?empId="+v.empId
					}
					var obj = {
							"value": v.empId,
							"name" : v.empName,
							"jbgdNm":v.jbgdNm,
							"deptNm":v.deptNm,
							"avatar":profile,
							"email":v.empMail
					}
					list.push(obj)
				})
				console.log(list)
				tagify.settings.whitelist=list
        	})
        	
        }else if(selectedValue=="com"){
        	console.log("회사잏ㄹ정")
        	$("#deptSel").css("display","none")
        	$(".deptSel").css("display","none")
        	
        	getAllProfileList(function(response){

				var list=[]
				$.each(response,function(i,v){
					var profile ="/resources/img/basicProfile.png"
					if(v.empProfile!=null){
						profile = "/everyware/mypage/thumbnail?empId="+v.empId
					}
					var obj = {
							"value": v.empId,
							"name" : v.empName,
							"jbgdNm":v.jbgdNm,
							"deptNm":v.deptNm,
							"avatar":profile,
							"email":v.empMail
					}
					list.push(obj)
				})
				console.log(list)
				tagify.settings.whitelist=list
        	})
        }
      });
    
    
    
    

    var tooltips={};
    var calendar = new Calendar(calendarEl, {
      dayMaxEvents: true,
      headerToolbar: {
        left  : 'prev,next today',
        center: 'title',
        right : 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      
      editable  : true,
      droppable : true, // this allows things to be dropped onto the calendar !!!
      eventResize: function(event, delta, revertFunc) {

        console.log("리사이즈 실행")       	
      },
      eventDrop: function(event, delta, revertFunc) {

        console.log("이벤트드랍 실행")
        //event.revert() ajax 처리 실패시 다시 일정을 원레위치로 되돌리는 함수
      },
      eventClick: function(event) {
  		//console.log(event.event._def.extendedProps.content)
  		//console.log(event.event)
  		console.log("이벤트 클릭 실행")
  		console.log(event)
		/* $("#modal_back").css("display","block")
		$("body").css("overflow","hidden") */
		
		showModalUpdate(event)
		
      },
      drop      : function(info) {
        // is the "remove after drop" checkbox checked?
     /*    console.log(info.draggedEl.innerText)
        console.dir(info.date) */
        var obj = {
        	calId:$(info.draggedEl).data("calid"),
        	startDate:info.date
        }
		 $.ajax({
  			  url: '/registerevent', // 요청을 보낼 URL
  			  method: 'post', // HTTP 메서드 (GET, POST 등)
  			  data: obj, // 요청에 첨부할 데이터 (선택 사항)
  			  success: function(response) {
  			    alert("성공")
  			  },
  			  error: function(xhr, status, error) {
  				alert("일정 등록 실패..")
  			  }
  			}); 
        if (checkbox.checked) {
          // if so, remove the element from the "Draggable Events" list
          info.draggedEl.parentNode.removeChild(info.draggedEl);
        }
      },

        eventDidMount: function(info) {
        	console.log("이벤트디드마운트")
        	console.log(info)
            var eventEl = info.el;
        	var schdlType = info.event._def.extendedProps.schdlType
        	var content=""
        	if(schdlType==2){
        		content = info.event._def.extendedProps.deptNm
        	}else if(schdlType==3){
        		content="${conm}"
        	}
            var tooltip = tippy(eventEl, {
              content: content, // content 값을 이벤트의 extendedProps에서 가져옴
              placement: 'top',
            });
            tooltips[info.event._def.extendedProps.calId]=tooltip;
          },
          
          eventChange: function(obj) {
        	  console.log("이벤트체인지 실행")
        	  console.log(obj.event._def)
        	  var newEvent=obj.event
        	  var allDay=""
      		  var sdate =new Date((obj.event._instance.range.start).getTime()-(9*60*60*1000))
      		  var edate =new Date((obj.event._instance.range.end).getTime()-(9*60*60*1000))
      		  var schdlType= obj.event._def.extendedProps.schdlType
      		var empId= obj.event._def.extendedProps.empId
      		var deptId= obj.event._def.extendedProps.deptId
      		var schdlCn= obj.event._def.extendedProps.schdlCn
      		var schdlAllday= obj.event._def.allDay
      		var schdlTtl= obj.event._def.title
      		  sdate = sdate.toISOString().slice(0, 16)
      		  edate = edate.toISOString().slice(0, 16)
        	
      		  var obj={
        		  schdlId:obj.event._def.extendedProps.schdlId,
       		      schdlBgngDt:sdate,
       		      schdlEndDt:edate,
       		      schdlType:schdlType,
       		      empId :empId,
       		      deptId:deptId,
       		      schdlCn:schdlCn,
       		      schdlAllday:schdlAllday,
       		      schdlTtl:schdlTtl
        	  }
        	  console.log(obj)
        	$.ajax({
      			  url: '/everyware/admin/calendar/dragChange', // 요청을 보낼 URL
      			  method: 'post', // HTTP 메서드 (GET, POST 등)
      			  data: JSON.stringify(obj), // 요청에 첨부할 데이터 (선택 사항)
	      		  beforeSend : function(xhr){
	  				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	  		  	  },
	  		  	  contentType: 'application/json; charset=utf-8',
      			  success: function(response) { 
      			  		if(response.res!="OK"){
	      			  		alertError("일정 등록 실패..")
	          				obj.revert()
      			  		}else{
      			  			if(schdlType==2){
      			  			var socketObj={			//일정을 변경했을 때 알람을 웹소켓으로		
    								type:"al",
    								alarm:{
    									sndrNm:"부서일정",
    									deptId:deptId,
    									alarmType:8,
    									urlAddr:"/everyware/calendar"
    								}
    						}
    						ws.send(JSON.stringify(socketObj));
      			  			}else{
      			  			var socketObj={			//일정을 변경했을 때 알람을 웹소켓으로		
    								type:"al",
    								alarm:{
    									sndrNm:"회사일정",
    									custId:"${custId}",
    									alarmType:8,
    									urlAddr:"/everyware/calendar"
    								}
    						}
    						ws.send(JSON.stringify(socketObj));	
      			  			}
      			  		}
      			  },
      			  error: function(xhr, status, error) {
      				alertError("일정 등록 실패..")
      				obj.revert()
      			  }
      			});  
          },
          
          dateClick: function(info) {
              // 날짜 클릭 시 모달 창 표시
              showModal(info.date)
            }
    });
    
    
    var eventList=JSON.parse('${eventList}')
    console.log(eventList)
     calendar.removeAllEvents();
	  var list=[]
	  eventList.forEach(function(data){
	    	var allDay=""
	    	if(data.schdlAllday=="true"){
	    		 allDay=true
	    	}else{
	    		allDay=false
	    	}
	    	var event = {
	    		 title: data.schdlTtl,
	    		 start: new Date(data.schdlBgngDt),
	    		 end: new Date(data.schdlEndDt),
	    		 allDay:allDay,
	    		 backgroundColor: data.schdlColor,
	    		 borderColor: data.schdlColor,
		    	 schdlId:data.schdlId,
				 schdlType: data.schdlType,
				 schdlCn : data.schdlCn,
				 empId : data.empId,
				 memberList: data.memberList,
				 deptId:data.deptId,
				 deptNm:data.deptNm,
				 schdlColor:data.schdlColor
	    	};
	    	list.push(event)
	    })
	  
	  calendar.addEventSource(list);
	  calendar.render();
	
    
    
    $("#calendar_modal_footer").on("click","#removeBtn",function(){
    	
    	 Swal.fire({
             title: 'Question',
             text: "'"+$("#title").val()+"'일정을 삭제하시겠습니까?",
             icon: 'question',
             showCancelButton: true,
             confirmButtonColor: '#3085d6',
             cancelButtonColor: '#d33',
             confirmButtonText: '확인',
             cancelButtonText: '취소'
           }).then((result) => {
             if (result.isConfirmed) {
               // 사용자가 확인을 눌렀을 경우에 수행할 작업
               
               var obj={
            		   schdlId:$("#scheduleId").val(),
            		   curCalendarDeptId:curCalendar
               }
               
               $.ajax({
    			  url: '/everyware/admin/calendar/delete', // 요청을 보낼 URL
    			  method: 'post', // HTTP 메서드 (GET, POST 등)
    			  data: JSON.stringify(obj), // 요청에 첨부할 데이터 (선택 사항)
    			  beforeSend : function(xhr){
    				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		  	  },
    			  contentType: 'application/json; charset=utf-8',
    			  success: function(response) {
    				  if(response.res=="OK"){
    					  alertSuccess("성공") 
    					  closeModal()
    					  calendar.removeAllEvents();
    					  var list=[]
    					  response.eventList.forEach(function(data){
    					    	var allDay=""
    					    	if(data.schdlAllday=="true"){
    					    		 allDay=true
    					    	}else{
    					    		allDay=false
    					    	}
    					    	var event = {
    					    		 title: data.schdlTtl,
    					    		 start: new Date(data.schdlBgngDt),
    					    		 end: new Date(data.schdlEndDt),
    					    		 allDay:allDay,
    					    		 backgroundColor: data.schdlColor,
    					    		 borderColor: data.schdlColor,
    						    	 schdlId:data.schdlId,
    								 schdlType: data.schdlType,
    								 schdlCn : data.schdlCn,
    								 empId : data.empId,
    								 memberList: data.memberList,
    								 deptId:data.deptId,
    								 deptNm:data.deptNm,
    								 schdlColor:data.schdlColor
    								 
    					    	};
    					    	list.push(event)
    					    })
    					  
    					  calendar.addEventSource(list);
    					  calendar.render();
    				  }
    			  },
    			  error: function(xhr, status, error) {
    				alert("일정 삭제 실패..")
    			  }
    			});
               
               
             }
           });
    	
    	
    	
    })
    
    
    
    function showModal(date){
      $("#calendar_modal_header h5").text("일정등록")
      $("#updateBtn").css("display","none")
      $("#removeBtn").css("display","none")
      $("#insertBtn").css("display","block")
      
  	  var tmp = new Date(date.getTime()+9*60*60*1000)
      var nextDate = new Date(tmp.getTime() + 24 * 60 * 60 * 1000)
      $("#modal_back").css("display","block");
  	  $("#sdate").val(new Date(tmp).toISOString().slice(0,16))
	  $("#edate").val(new Date(nextDate).toISOString().slice(0,16))
    }
    
    function showModalUpdate(event){
    	$("#calendar_modal_header h5").text("일정변경")
    	$("#updateBtn").css("display","block")
    	$("#removeBtn").css("display","block")
        $("#insertBtn").css("display","none")
        $("#modal_back").css("display","block");
    	console.log("쇼모업")
    	console.log(event)
    	var attr = event.event._def
    	
    	var schdlType = attr.extendedProps.schdlType;
    	var schdlTtl = attr.title
    	var schdlCn = attr.extendedProps.schdlCn;
    	var schdlId = attr.extendedProps.schdlId
    	var deptId = attr.extendedProps.deptId;
    	var deptNm = attr.extendedProps.deptNm;
    	var memberList = attr.extendedProps.memberList
    	var sdate = event.event._instance.range.start
    	var edate = event.event._instance.range.end
    	var schdlColor = attr.extendedProps.schdlColor
    	
    	$("#title").val(schdlTtl)
    	$("#content").val(schdlCn)
    	
    	if(schdlType==2){
    		 $('input[name="schdlType"]').filter('[value="' + "dep" + '"]').prop('checked', true);
    		 curRadio="dep"
    		 $('#deptSel').css("display","block")
    		 $('.deptSel').css("display","block")
    		 $('#deptSel').val(deptId)
    		 
    		 getDeptProfileList(deptId,function(response){
					var list=[]
					$.each(response,function(i,v){
						console.log("아니")
						var profile ="/resources/img/basicProfile.png"
						if(v.empProfile!=null){
							profile = "/everyware/mypage/thumbnail?empId="+v.empId
						}
						console.log(profile)
						var obj = {
								"value": v.empId,
								"name" : v.empName,
								"jbgdNm":v.jbgdNm,
								"deptNm":v.deptNm,
								"avatar":profile,
								"email":v.empMail
						}
						list.push(obj)
					})
					console.log(list)
					tagify.settings.whitelist=list
					
					var selectedMemberList=[]
	  				$.each(memberList,function(i,v){
	  					var profile ="/resources/img/basicProfile.png"
  						if(v.empProfile!=null){
  							profile = "/everyware/mypage/thumbnail?empId="+v.empId
  						}
	  					console.log(v.empProfile)
	  					var obj = {
	  							"value": v.empId,
	  							"name" : v.empName,
	  							"jbgdNm":v.jbgdNm,
	  							"deptNm":v.deptNm,
	  							"avatar":profile,
	  							"email":v.empMail
	  					}
	  					selectedMemberList.push(obj)
	  				})
	  				tagify.addTags(selectedMemberList)
					
	    	})
    		 
    	}else if(schdlType==3){
    		 $('input[name="schdlType"]').filter('[value="' + "com" + '"]').prop('checked', true);
    		 curRadio="com"
    		 getAllProfileList(function(response){

 				var list=[]
 				$.each(response,function(i,v){
 					var profile ="/resources/img/basicProfile.png"
					if(v.empProfile!=null){
						profile = "/everyware/mypage/thumbnail?empId="+v.empId
					}
 					var obj = {
 							"value": v.empId,
 							"name" : v.empName,
 							"jbgdNm":v.jbgdNm,
 							"deptNm":v.deptNm,
 							"avatar":profile,
 							"email":v.empMail
 					}
 					list.push(obj)
 				})
 				console.log(list)
 				tagify.settings.whitelist=list
 				
 				
 				var selectedMemberList=[]
  				$.each(memberList,function(i,v){
  					var profile ="/resources/img/basicProfile.png"
					if(v.empProfile!=null){
						profile = "/everyware/mypage/thumbnail?empId="+v.empId
					}
  					console.log(v.empProfile)
  					var obj = {
  							"value": v.empId,
  							"name" : v.empName,
  							"jbgdNm":v.jbgdNm,
  							"deptNm":v.deptNm,
  							"avatar":profile,
  							"email":v.empMail
  					}
  					selectedMemberList.push(obj)
  				})
  				tagify.addTags(selectedMemberList)
 				
         	})
    	}
    	
    	$("#color-chooser a[data-color='"+schdlColor+"']").addClass("active")
    	$.each($("#color-chooser a"),function(i,v){
      		if ($(v).hasClass("active")) {
  		      // 회전 각도를 45도로 설정하여 아이콘을 회전시킵니다.
  		      $("i",v).css('transform', 'rotate(45deg)');
  		    } else {
  		      // 회전을 해제하기 위해 회전 각도를 0으로 설정합니다.
  		    	$("i",v).css('transform', 'rotate(0deg)');
  		    }
      	})
    	
    	console.log(schdlType)
    	console.log(schdlTtl)
    	console.log(schdlCn)
    	console.log(schdlId)
    	console.log(deptId)
    	console.log(deptNm)
    	console.log(memberList)
    	console.log(sdate)
    	console.log(edate)
    	console.log(schdlColor)
    	$("#scheduleId").val(schdlId)
    	var stmp= new Date(sdate.getTime())
    	var etmp= new Date(edate.getTime())
    	
  	  $("#sdate").val(new Date(stmp).toISOString().slice(0,16))
	  $("#edate").val(new Date(etmp).toISOString().slice(0,16))
    	
    }
    
    
    
    
    
    
    
    
    function closeModal(){
  	  $("#modal_back").css("display","none");
  	  $("#title").val("")
  	  $('input[name="schdlType"]').prop('checked',false)
  	  tagify.removeAllTags();
  	  $("#content").val("")
  	  $("#color-chooser a").removeClass("active")
  	  $.each($("#color-chooser a"),function(i,v){
      		if ($(v).hasClass("active")) {
  		      // 회전 각도를 45도로 설정하여 아이콘을 회전시킵니다.
  		      $("i",v).css('transform', 'rotate(45deg)');
  		    } else {
  		      // 회전을 해제하기 위해 회전 각도를 0으로 설정합니다.
  		    	$("i",v).css('transform', 'rotate(0deg)');
  		    }
      	})
  	  $("#sdate").val("")
  	  $("#edate").val("")
  	  
  	  $('#deptSel').css("display","none")
  	  $('.deptSel').css("display","none")
  	  console.log(initialValue)
  	  if(initialValue!=null && typeof initialValue!="undefined"){
  	  	$('#deptSel').val(initialValue);
  	  	console.log("안에 실행")
  	  }
  	  
    }
    
  })
  
  
  function getAllProfileList(callback){
		$.ajax({
			  url: '/everyware/admin/calendar/allProfileList', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
			  success: function(response) {
				callback(response)
			  },
			  error: function(xhr, status, error) {
				alert("프로필 리스트 가져오기 실패")
			  }
			});
	}
  
  function getDeptProfileList(deptId,callback){
		$.ajax({
			  url: '/everyware/admin/calendar/deptProfileList', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data:{deptId:deptId},
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
			  success: function(response) {
				callback(response)
			  },
			  error: function(xhr, status, error) {
				alert("프로필 리스트 가져오기 실패")
			  }
			});
	}
  function alertSuccess(data){
		Swal.fire({
		  title: 'Success!',
		  timer: 1000,
		  text: data,
		  icon: 'success',
		  customClass: {
	    	container: 'my-swal'
	  	  },
		})
	}
  function alertError(data){
		Swal.fire({
		  title: 'Error!',
		  timer: 1000,
		  text: data,
		  icon: 'error',
		  customClass: {
	    	container: 'my-swal'
	  	  },
		})
	}
</script>
<script src="/resources/js/mail_tagify.js"></script>