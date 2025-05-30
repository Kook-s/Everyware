<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>
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
    margin:5px 0;
    margin-right: 5px;
    transition: .12s ease-out;
}

.tagify__tag img{
    width: 100%;
    vertical-align: top;
    pointer-events: none;
}
.tag_container{
	padding: 2px 10px!important;
}
.form-check-label {
	padding-left: 20px;
}
.eventRemoveBtn{
	float: right;
	display: inline-block;
	width: 23px;
	height: 23px;
	
}
#new-event-content{
	margin: 20px 0;
	resize: none;
}
 .fc-event {
    text-align: center;
  }
#add-new-event{
float: right;
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
	padding: 30px;
	border-top: rgba(0,0,0,0.15) 1.5px solid;
	min-height: 100px;
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
	color: white;
    display: inline-block;
    margin-top: 10px;
    margin-bottom: 10px;
    padding: 5px 15px;
    background: cadetblue;
    border-radius: 4px;
}
#calendar_modal_content input, #calendar_modal_content textarea, #calendar_modal_content label{
	margin: 10px 0;
}
#calendar_modal_content input{
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
#updateBtn{
	background: rgb(51, 102, 204)
}
#deleteBtn{
	background: rgb(51, 102, 204)
}
#cancleBtn{
	background: rgb(153, 153, 153)
}
#member{
	display: inline-block;
    width: 390px;
    border-bottom: 1px solid rgba(0,0,0,0.1);
    min-height: 25px;
    margin: 10px 0;
}
#addressbookBtn{
	vertical-align: top;
    margin: 5px 0;
        width: 73px;
    font-size: 15px;
}
  .modal {
    align-items: center;
    justify-content: center;
  }
.modal-dialog{
    width: 100%;
    margin-top: 230px;
}
#water{
	font-size: 28px;
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
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">Draggable Events</h4>
						</div>
						<div class="card-body">
							<!-- the events -->
							<div id="external-events">
								<c:if test="${not empty undoEventList }">
									<c:forEach items="${undoEventList }" var="event">
										<div class="external-event ui-draggable ui-draggable-handle" 
										data-schdltype="${event.schdlType }" data-schdlid="${event.schdlId }" data-empid="${event.empId}"
										style="background-color: ${event.schdlColor }; border-color: ${event.schdlColor }; color: rgb(255, 255, 255); position: relative;"><span>${event.schdlTtl }</span><img src="/resources/img/xbtn.png" class="eventRemoveBtn"></div>
									</c:forEach>
								</c:if>
								<div class="checkbox">
								</div>
							</div>
						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->
					<div class="card">
						<div class="card-header">
							<h3 class="card-title">Create Event</h3>
						</div>
						<div class="card-body">
							<div class="btn-group" style="width: 100%; margin-bottom: 10px;">
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
							<!-- /btn-group -->

							<input id="new-event" type="text" class="form-control"
								placeholder="Event Title"> 
							<textarea id="new-event-content" class="form-control col-sm-12" rows="10" placeholder="Event Content"></textarea>
							<label class="form-check-label"> <input type="radio"
											name="schdlType" class="form-check-input" value="emp">개인
										</label> <label class="form-check-label"> <input type="radio"
											name="schdlType" class="form-check-input" value="dep">부서
										</label>
							<button id="add-new-event" type="button" class="btn btn-primary">Add</button>
							<!-- /btn-group -->
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
			<h5>일정 수정</h5>
		</div>
		<div id="calendar_modal_content">
			<form>
				<input type="hidden" id="scheduleId">
				<div class="form-group row">
				  <label for="title" class="col-sm-2 col-form-label">제목 </label>
				  <div class="input-group col-sm-10">
				  	<input id="title">
				  </div>
				</div>
				<div class="form-group row">
				  <label for="member" class="col-sm-2 col-form-label">수행인원 </label>
				  <div class="input-group col-sm-10">
				  	<input name='users-list-tags' id="member">
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
				  <label class="col-sm-2 col-form-label">대상범위</label>
				  <div class="input-group col-sm-10">
				  	<div id="type">변정민</div>
				  </div>
				</div>
				<div class="form-group row">
				  <label for="content" class="col-sm-2 col-form-label">일정기간 </label>
				  <div class="input-group col-sm-10">
				  	<input type="datetime-local" id="sdate"><span id="water"> ~ </span><input type="datetime-local" id="edate">
				  </div>
				</div>
			</form>
		</div>
		<div id="calendar_modal_footer">
			<button id="cancleBtn">취소</button>
			<button id="deleteBtn">삭제</button>
			<button id="updateBtn">수정</button>
		</div>
	</div>
</div>
<%@ include file="../contacts/contactModal.jsp" %>
<sec:authentication var="deptNm" property="principal.employee.deptNm"/>
<sec:authentication var="deptId" property="principal.employee.deptId"/>
<sec:authentication var="conm" property="principal.employee.conm"/>
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
	const cancleBtn = $("#cancleBtn");
	const deleteBtn = $("#deleteBtn");
	const updateBtn = $("#updateBtn");
	
	const addressbookBtn = $("#addressbookBtn")

	
	const scheduleId = $("#scheduleId")
	const title = $("#title")
	const member = $("#member")
	const content = $("#content")
	const type = $("#type")
	const sdate = $("#sdate")
	const edate = $("#edate")
	
	var curType=0
	
	cancleBtn.on("click",function(){
		$("#modal_back").css("display","none")
		$("body").css("overflow","auto") 
		title.val("")
		member.html("")
		content.val("")
		type.text("")
		sdate.val("")
		edate.val("")
		buttonHiddenAndReadOnly(false)
	})
	updateBtn.on("click",function(){

		//시간 allday인지 아닌지 판단
		var allDay=""
		
		if(sdate.val().split('T')[1]=="00:00"&&edate.val().split('T')[1]=="00:00"){
			allDay=true;
		}else{
			allDay=false;
		}
		
		console.log("아니왜그래")
		console.log(curType)
		
		
		var idList = tagify.value.map(obj => obj.value);
		var obj={
        		  schdlId:scheduleId.val(),
        		  schdlType:curType,
        		  schdlAllday:allDay,
        		  schdlTtl:title.val(),
        		  schdlBgngDt:new Date(sdate.val()),
        		  schdlEndDt:new Date(edate.val()),
        		  schdlCn:content.val(),
        		  memberIdList:idList
        } 
		
		calendarModify(obj,function(response){
			if(response.res=="OK"){
				if(curType==2){
					var socketObj={			//일정을 등록했을 때 알람을 웹소켓으로		
							type:"al",
							alarm:{
								sndrNm:"부서일정",
								deptId:"${deptId}",
								alarmType:8,
								urlAddr:"/everyware/calendar"
							}
					}
					ws.send(JSON.stringify(socketObj));
				}
				alertSuccess("성공")
				if(idList.length>0&&curType!=1){
					var obj={			//캘린더 수행인원 수정을 완료했을 때		
						type:"al",
						alarm:{
							sndrNm:title.val(),
							empIdList:idList,
							alarmType:9,
							urlAddr:"/everyware/calendar"
							}
					}
					ws.send(JSON.stringify(obj));
				}
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
							 memberList: data.memberList
				    	};
				    	list.push(event)
				    })
				  
				  calendar.addEventSource(list);
				  calendar.render();
			  }else{
				alert("다시 시도해주세요.")
				location.reload();
			  }
			
			$("#modal_back").css("display","none")
			$("body").css("overflow","auto") 
			title.val("")
			member.html("")
			content.val("")
			type.text("")
			sdate.val("")
			edate.val("")
			buttonHiddenAndReadOnly(false)
		})
		
	})
	deleteBtn.on("click",function(){
		Swal.fire({
		      title: 'Are you sure?',
		      text: 'This action cannot be undone!',
		      icon: 'warning',
		      showCancelButton: true,
		      confirmButtonText: 'Yes, proceed',
		      cancelButtonText: 'No, cancel',
		      reverseButtons: true,
		    }).then((result) => {
		      // Check if the user clicked "Yes"
		      if (result.isConfirmed) {
		        // "Yes" was clicked
		        deleteCalendar(scheduleId.val(),function(response){
					if(response.res=="OK"){
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
									 memberList: data.memberList
						    	};
						    	list.push(event)
						    })
						  
						  calendar.addEventSource(list);
						  calendar.render();
						  $("#modal_back").css("display","none")
							$("body").css("overflow","auto") 
							title.val("")
							member.html("")
							content.val("")
							type.text("")
							sdate.val("")
							edate.val("")
							buttonHiddenAndReadOnly(false)
					}
					
				})
		        
		        Swal.fire({
		          icon: 'success',
		          title: 'Action confirmed!',
		          text: 'You clicked "Yes".',
		        });
		      }
		    });
		
		
	})
	
	$('.tree-return-btn').on('click', function(){
		// modalReturn 파라미터에
		// 사원 객체 배열을 전달받아 처리할 function을 넣어주세요!
		// 예) modalReturn(myLogic(emps));
		// 객체 내용은 console에 출력되고 있습니다
		modalReturn(addressInfo);
	});

	

    /* initialize the external events
     -----------------------------------------------------------------*/
    function ini_events(ele) {
      ele.each(function () {

        // create an Event Object (https://fullcalendar.io/docs/event-object)
        // it doesn't need to have a start or end
        var eventObject = {
          title: $.trim($(this).text()) // use the element's text as the event title
        }

        // store the Event Object in the DOM element so we can get to it later
        $(this).data('eventObject', eventObject)

        // make the event draggable using jQuery UI
        $(this).draggable({
          zIndex        : 1070,
          revert        : true, // will cause the event to go back to its
          revertDuration: 0  //  original position after the drag
        })
      })
    }

    ini_events($('#external-events div.external-event'))

    /* initialize the calendar
     -----------------------------------------------------------------*/
    //Date for the calendar events (dummy data)
    var date = new Date()
    var d    = date.getDate(),
        m    = date.getMonth(),
        y    = date.getFullYear()

    var Calendar = FullCalendar.Calendar;
    var Draggable = FullCalendar.Draggable;

    var containerEl = document.getElementById('external-events');
    var calendarEl = document.getElementById('calendar');

    // initialize the external events
    // -----------------------------------------------------------------

    new Draggable(containerEl, {
      itemSelector: '.external-event',
      eventData: function(eventEl) {
        return {
          title: eventEl.innerText,
          schdlType: $(eventEl).data("schdltype"),
          schdlId:$(eventEl).data("schdlid"),
          schdlCn:$(eventEl).data("schdlcn"),
          memberList:$(eventEl).data("memberlist"),
          empId:$(eventEl).data("empid"),
          backgroundColor: window.getComputedStyle( eventEl ,null).getPropertyValue('background-color'),
          borderColor: window.getComputedStyle( eventEl ,null).getPropertyValue('background-color'),
          textColor: window.getComputedStyle( eventEl ,null).getPropertyValue('color'),
        };
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

      },
      eventDrop: function(event, delta, revertFunc) {

        //event.revert() ajax 처리 실패시 다시 일정을 원레위치로 되돌리는 함수
      },
      eventClick: function(event) {
    	  console.log(event)
    	  console.log("클릭")
    	  tagify.removeAllTags();
    	  var schdlType = event.event._def.extendedProps.schdlType
    	  var props = event.event._def
	  	  var dates= event.event._instance.range
	      var memberList = props.extendedProps.memberList
	  	  var eventType = props.extendedProps.schdlType
	  	  var restMem = 0
    	  
	  	  curType = schdlType
	  	  
    	  if(schdlType==1||schdlType==3){
    		  getAllProfileList(function(profileList){
  				console.log(profileList)
  				console.log("얘는 전")
  				var list=[]
  				$.each(profileList,function(i,v){
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
  				
  				console.log(memberList)
				console.log("멤버리스트")
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
    	  }else if(schdlType==2){
    		 getDeptProfileList(function(profileList){
  				console.log(profileList)
  				console.log("얘는 전")
  				var list=[]
  				$.each(profileList,function(i,v){
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
  				
  				
  				console.log(memberList)
				console.log("멤버리스트")
  				var selectedMemberList=[]
  				$.each(memberList,function(i,v){
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
  					selectedMemberList.push(obj)
  				})
  				tagify.addTags(selectedMemberList)
  			})
    	  }

		$("#modal_back").css("display","block")
		$("body").css("overflow","hidden")
		
		
		
		
		
		
		var resType=""
		switch(eventType){
		case 1:
			getEmpNameById(props.extendedProps.empId,function(response){
				type.text(response)
				type.attr('data-type', '1');
			})
			break;
		case 2:
			type.text("${deptNm}")
			type.attr('data-type', '2');
			break;
		case 3:
			type.text("${conm}")
			type.attr('data-type', '3');
		}
		scheduleId.val(props.extendedProps.schdlId)
		title.val(props.title)
		content.val(props.extendedProps.schdlCn)
		sdate.val(new Date(dates.start).toISOString().slice(0,16))
		edate.val(new Date(dates.end).toISOString().slice(0,16))

		
		if(eventType==3){
			
			buttonHiddenAndReadOnly(true)
		}

      },
      drop      : function(info) {
        // is the "remove after drop" checkbox checked?
     /*    console.log(info.draggedEl.innerText)
        console.dir(info.date) */
        console.log("drop 실행")
        var empId = $(info.draggedEl).data("empid")
        var obj = {
        	schdlId:$(info.draggedEl).data("schdlid"),
        	schdlBgngDt:info.date,
        	schdlAllday:info.allDay,
        	schdlType : $(info.draggedEl).data("schdltype")
        }
        calendarModify(obj,function(response){
        	  if(response.res=="OK"){
				  info.draggedEl.parentNode.removeChild(info.draggedEl);
				  var type= obj.schdlType;
				  if(type==2){
					  console.log("메시지 보냄")
					  var socketObj={			//일정을 등록했을 때 알람을 웹소켓으로		
								type:"al",
								alarm:{
									sndrNm:"부서일정",
									deptId:"${deptId}",
									alarmType:7,
									urlAddr:"/everyware/calendar"
								}
						}
						ws.send(JSON.stringify(socketObj));
				  }
			  }else{
				alert("일정 등록 실패..")
				location.reload();
			  }
        })
      },

        eventDidMount: function(info) {
        	console.log("디드마")
            var eventEl = info.el;
        	var type = info.event._def.extendedProps.schdlType;
        	var empId = info.event._def.extendedProps.empId;
        	var content = "";
        	if(type=="1"){
        		//content="${empName}"
        		content="개인일정"
        	}else if(type=="2"){
        		//content="${deptNm}"
        		content="부서일정"
        	}else if(type=="3"){
        		content="${conm}"
        	}
        	
       		var tooltip = tippy(eventEl, {
             		content: content, 
	             	placement: 'top'
	         });
    	 
          },
          
          eventChange: function(obj) {
        	  console.log("eventChange 실행")
        	  var newEvent=obj.event
        	  var empId=newEvent._def.extendedProps.empId
        	  var schdlType = newEvent._def.extendedProps.schdlType
        	  
        	  
        	  if(schdlType==3){
        		  setTimeout(() => {
 					 alert("회사일정을 수정할 권한이 없습니다.")
 				}, 10);
         		  setTimeout(() => {
 					obj.revert()
 				}, 50);
         		  
        		  return;
        	  }
        	  console.log(newEvent)
        	  console.log("여기")
        	  var sdKorea=new Date(newEvent._instance.range.start)
        	  var temp = sdKorea.getHours()-9
        	  sdKorea.setHours(temp)
        	  var edKorea=new Date(newEvent._instance.range.end)
        	  var temp2 = edKorea.getHours()-9
        	  edKorea.setHours(temp2)
        	  console.log(sdKorea)
        	  console.log(edKorea)
        	  var idList = []
        	  $.each(newEvent._def.extendedProps.memberList,function(i,v){
        		  idList.push(v.empId)
        	  })
        	  
        	  var ajaxObj={
        		  schdlId:newEvent._def.extendedProps.schdlId,
        		  schdlType:newEvent._def.extendedProps.schdlType,
        		  schdlAllday:newEvent._def.allDay,
        		  schdlBgngDt:sdKorea,
        		  schdlEndDt:edKorea,
        		  memberIdList:idList
        	  }
        	  calendarModify(ajaxObj,function(response){
        		  if(response.res=="OK"){
        			  if(newEvent._def.extendedProps.schdlType==2){
        				  var socketObj={			//일정을 등록했을 때 알람을 웹소켓으로		
								type:"al",
								alarm:{
									sndrNm:"부서일정",
									deptId:"${deptId}",
									alarmType:8,
									urlAddr:"/everyware/calendar"
								}
						}
						ws.send(JSON.stringify(socketObj));
        			  }
        			  
        		  }
        	  })
          }
    });
    
    var eventList=JSON.parse('${eventList}')
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
			 memberList: data.memberList
    	};    		
    	calendar.addEvent(event);
    })
	
    calendar.render();
    // $('#calendar').fullCalendar()
    /* ADDING EVENTS */
    var currColor = '#3c8dbc' //Red by default
    // Color chooser button
    $('#color-chooser > li > a').click(function (e) {
      e.preventDefault()
      // Save color
      currColor = $(this).data('color')
      // Add color effect to button
      $('#add-new-event').css({
        'background-color': currColor,
        'border-color'    : currColor
      })
    })
    $('#add-new-event').click(function (e) {
      e.preventDefault()
      // Get value and make sure it is not null
      var val = $('#new-event').val()
      var content = $("#new-event-content").val().replace(/\n/g, '<br>')
      var schdlType = $("input[name=schdlType]:checked").val()
	  
      if(schdlType=="emp"){
    	  schdlType=1
      }else if(schdlType=="dep"){
    	  schdlType=2
      }
      
      if (val.length == 0) {
        return
      }
      if(typeof schdlType=='undefined' || schdlType==null){
    	  return;
      }
      var obj = {
          	schdlTtl:val,
          	schdlType:schdlType,
          	schdlColor:currColor,
          	schdlCn:content
          }
  		$.ajax({
  			  url: '/everyware/calendar/register', // 요청을 보낼 URL
  			  method: 'post', // HTTP 메서드 (GET, POST 등)
  			  data: obj, // 요청에 첨부할 데이터 (선택 사항)
	  		  beforeSend : function(xhr){
			  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	  		  },
  			  success: function(response) {
  			    
  			    var schdlId=response;
	  		      // Create events
	  		      var event = $('<div />')
	  		      event.css({
	  		        'background-color': currColor,
	  		        'border-color'    : currColor,
	  		        'color'           : '#fff'
	  		      }).addClass('external-event')
	  		      event.append($("<span>"+val+"</span>"))
	  		      event.attr("data-schdlType",schdlType)
	  		      event.attr("data-schdlId",schdlId)
	  		      event.attr("data-schdlCn",content);
	  		      event.attr("data-memberList","[]");
	  		      event.attr("data-empId","${employee.empId}");
	  		      event.append($("<img src='/resources/img/xbtn.png' class='eventRemoveBtn'>").clone())
	  		      $('#external-events').prepend(event)
	
	  		      // Add draggable funtionality
	  		      ini_events(event)
  			  },
  			  error: function(xhr, status, error) {
  				alert("일정 등록 실패..")
  			  }
  			});



      // Remove event from text input
      $('#new-event').val('')
      $("#new-event-content").val("")
    })
    
    $(document).on("click",".eventRemoveBtn",function(){
    	var schdlId=$(this).parent().data("schdlid")
    	var title=$(this).parent().text()
    	if(confirm(title+" 일정을 삭제하시겠습니까?")){
    		$.ajax({
    			  url: '/everyware/calendar/delete', // 요청을 보낼 URL
    			  method: 'post', // HTTP 메서드 (GET, POST 등)
    			  data: {schdlId:schdlId}, // 요청에 첨부할 데이터 (선택 사항)
    			  beforeSend : function(xhr){
    				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		  	  },
    			  success: function(response) {
    				  if(response.res=="OK"){
	    				  alert("삭제되었습니다.")
	    				  $(".external-event[data-schdlId="+schdlId+"]").remove();
    				  }else{
    					  alert("일정 삭제 실패..")
    				  }
    			  },
    			  error: function(xhr, status, error) {
    				alert("일정 삭제 실패..")
    			  }
    			});
    	}
    })
  })
  
  
function getEmpNameById(empId,callback){
	$.ajax({
		  url: '/everyware/calendar/empName', // 요청을 보낼 URL
		  method: 'post', // HTTP 메서드 (GET, POST 등)
		  data: {empId:empId}, // 요청에 첨부할 데이터 (선택 사항)
		  beforeSend : function(xhr){
		  	xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  success: function(response) { 
			  callback(response)
		  },
		  error: function(xhr, status, error) {
			alert("툴팁 가져오기 실패..")
		  }
		});
}
function buttonHiddenAndReadOnly(flag){
	if(flag){
		title.readOnly = true;
		content.readOnly = true;
		sdate.readOnly = true
		edate.readOnly = true
		deleteBtn.style.display = 'none';
		updateBtn.style.display = 'none';
		addressbookBtn.disabled=true;
		tagify.settings.readonly = true;
	}else{
		title.readOnly = false;
		content.readOnly = false;
		sdate.readOnly = false
		edate.readOnly = false
		deleteBtn.style.display = 'block';
		updateBtn.style.display = 'block';
		addressbookBtn.disabled=false;
		tagify.settings.readonly = false;
	}
}

function deleteCalendar(scheduleId,callback){
	$.ajax({
		  url: '/everyware/calendar/delete', // 요청을 보낼 URL
		  method: 'post', // HTTP 메서드 (GET, POST 등)
		  data: {schdlId:scheduleId},
		  beforeSend : function(xhr){
		  	xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  success: function(response) { 
		    
			  callback(response)
		  },
		  error: function(xhr, status, error) {
			alert("일정 등록 실패..")
		  }
		});
}

function calendarModify(data,callback){
	console.log(data)
	$.ajax({
		  url: '/everyware/calendar/modify', // 요청을 보낼 URL
		  method: 'post', // HTTP 메서드 (GET, POST 등)
		  data: data, // 요청에 첨부할 데이터 (선택 사항)
		  beforeSend : function(xhr){
		  	xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  success: function(response) { 
		    callback(response)
		  },
		  error: function(xhr, status, error) {
			alert("일정 등록 실패..")
			obj.revert()
		  }
		});
}
function getDeptProfileList(callback){
	$.ajax({
		  url: '/everyware/calendar/deptProfileList', // 요청을 보낼 URL
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
function getAllProfileList(callback){
	$.ajax({
		  url: '/everyware/calendar/allProfileList', // 요청을 보낼 URL
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

function addressInfo(data){

		var list=[]
		$.each(data,function(i,v){
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
		tagify.addTags(list)
		
}
</script>
<script src="/resources/js/mail_tagify.js"></script>