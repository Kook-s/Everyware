<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<style>
.fc .fc-toolbar.fc-header-toolbar{
	padding: 0;
}
.fc-toolbar-title{
	font-size: 1.25rem!important;
}
    /* 헤더 버튼의 글꼴 크기 조절 */
    .fc-header-toolbar .fc-button {
      font-size: 10px;
    }

    /* 헤더 버튼의 너비와 높이 조절 */
    .fc-header-toolbar .fc-button {
      width: 30px;
      height: 30px;
    }

    /* prev와 next 버튼의 아이콘 가운데 정렬 */
    .fc-header-toolbar .fc-prev-button span, .fc-header-toolbar .fc-next-button span {
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100%;
    }
	#main_profile_img{
		width: 100%;
		height: 100%;
	}
	/* 클라우드 프로그래스바 */
	.titleNum{
	  width        :  100%;     /* 너비는 변경될수 있습니다. */
	  text-overflow: ellipsis;  /* 위에 설정한 100px 보다 길면 말줄임표처럼 표시합니다. */
	  white-space  : nowrap;    /* 줄바꿈을 하지 않습니다. */
	  overflow     : hidden;    /* 내용이 길면 감춤니다 */
	  display      : block; 
	}
	
	.progressbar{
	  width: 100%;
	  height: 30px;
	  border-radius: 5px;
	  overflow:hidden;
	  background: #ccc;
	  position:relative;
	}
	.progressbar::after{
	  content:'';
	  position:absolute;
	  top:0;
	  left:0;
	  height: 30px;
	  width:var(--width, 50%);
	  background:#007bff;
	  animation: progress 2s ease forwards;
	}
	@keyframes progress{
	  0%{width: 0px}
	}
	.progress{
	  display: flex;
	  background: none;
	  position: absolute;
	  padding: 5px 0;
	  top:30%;
	  right: 44%;
	  font-size: 16px;
	  z-index:99;
	  color: #FFF;
	}
	.progress::after{
	  content: '%';
	  
	}
	.fc .fc-daygrid-day-number {
	color: black;
}
.fc .fc-col-header-cell-cushion {
	color: black;
}

/* TODO 롤링 배너 */
.rollingbanner{
    position: relative;
    width: 380px;
    height: 32px;
    font-size: .875rem;
    letter-spacing: -1px;
    padding: 7px 15px;
    box-sizing: border-box;
    /* background-color: #f0f0f0; */
    border-radius: 16px;
}
/* 타이틀 */
.rollingbanner > .title{
    font-weight: bold;
    float: left;
    padding-right: 10px;
}
/* 롤링 배너 */
.rollingbanner > .wrap{
    position: relative;
    width: auto;
    height: 100%;
    box-sizing: border-box;
    overflow: hidden;
}        
.rolling ul{
    list-style: none;
}
.rollingbanner li{
    position: absolute;
    top: -36px;
    left: 0;
}
/* 이전, 현재, 다음 롤링 배너 표시 */
.rollingbanner li.prev{
    top: 36px;
    transition: top 0.5s ease;
}
.rollingbanner li.current{
    top: 0;
    transition: top 0.5s ease;
}
.rollingbanner li.next{
    top: -36px;
}
.rollingbanner a{
    display: block;
    display: -webkit-box;
    text-decoration: none;
    -webkit-line-clamp: 1;
    -webkit-box-orient:vertical;
    overflow: hidden;
    color: #000;
}
.notice_table{
	line-height: 1.2;
}
.notice_table td{
	font-size: 0.9rem;
}
#time{
	line-height: 1;
    font-size: 34px;
    font-weight: 100;
}
#date{
	line-height: 1;
    font-size: 15px;
    color: gray;
}
</style>
<sec:authentication var="employee" property="principal.employee"/>
<section class="content">
      <div class="container-fluid">
        <!-- Small boxes (Stat box) -->
       
        <!-- /.row -->
        <!-- Main row -->
        <div class="row">
          <!-- Left col -->
          <section class="col-lg-2 connectedSortable py-3">
            <!-- Custom tabs (Charts with tabs)-->
            <div class="card card-primary card-outline">
              <div class="card-body box-profile">
                <div class="text-center">
                <c:if test="${not empty employee.empProfile}">
                	<img  src="/everyware/mypage/thumbnail" alt="User profile picture" id="main_profile_img">
                </c:if>
                <c:if test="${empty employee.empProfile}">
                	<img  src="/resources/img/basicProfile.png" alt="User profile picture" id="main_profile_img">
                </c:if>
                  
                </div>

                <h3 class="profile-username text-center">${employee.empName }</h3>


                <ul class="list-group list-group-unbordered mb-0">
                  <li class="list-group-item">
                    <b>부서</b> <a class="float-right">${employee.deptNm }</a>
                  </li>
                  <li class="list-group-item">
                    <b>직급</b> <a class="float-right">${employee.jbgdNm }</a>
                  </li>
                  <li class="list-group-item">
                    <b>사번</b> <a class="float-right">${employee.empId}</a>
                  </li>
                </ul>

                <!-- <a href="#" class="btn btn-primary btn-block"><b>마이페이지</b></a> -->
              </div>
              <!-- /.card-body -->
            </div>

           <div class="card card-primary card-outline">
           <div class="card-header">
           <i class="fa-solid fa-cloud"></i> 
           	<b>클라우드</b>  
           </div> 
              <div class="card-body box-profile">
					<div class="progressbar">
					   <span class="progress" >0</span>
					  </div>
                    <b>전체용량</b><b class="float-right" > GB</b> <a class="float-right" id="cldId">0</a> 

              </div>
              <!-- /.card-body -->
            </div>
           <div class="card card-primary card-outline">
            <div class="card-header">
           <i class="fa-solid fa-folder-open"></i>
           	<b>첨부파일</b>  
           </div>
              <div class="card-body box-profile ">
              	<div class="d-flex" style="height: 30px ;justify-content: space-evenly; align-items: center;">
              		<div style="display: inline-block; width: 20%; height: 10px;background: rgba(0, 181, 148, 0.6);"></div>
              		<span style="font-size: 11px;">사용중</span>
              		<div style="display: inline-block; width: 20%; height: 10px;background: rgba(0, 0, 0, 0.2);"></div>
              		<span style="font-size: 11px;">미사용</span>
              	</div>
              	<div>
				<canvas id="fileDonut" width="40px" height="40px"></canvas>
				<div class= "d-flex justify-content-center">
				<b> ${useFileSz } GB</b>/<b>${maxFileSz } GB</b>
				</div>
              </div>
              <!-- /.card-body -->
            </div>

         
         
          </section>

            <section class="col-lg-5 connectedSortable py-3">
            <!-- Custom tabs (Charts with tabs)-->
              <div class="card card-primary card-outline">
              <div class="card-header">
              	<i class="fa-solid fa-list"></i>
                <b>공지사항</b>
              </div>
                <div class="card-body p-0">
                 	<table class="table text-center notice_table">
                 		<thead>
                 			<tr>
                 				<th>순서</th>
                 				<th>제목</th>
                 				<th>작성자</th>
                 				<th>조회수</th>
                 				<th>날짜</th>
                 			</tr>
                 		</thead>
                 		<tbody>
                 			<c:if test="${not empty notices }">
                 				<c:forEach items="${notices }" var="notice" varStatus="stat">
                 					<tr>
		                 				<td>${stat.index+1}</td>
		                 				<td>${notice.pstTtl }</td>
		                 				<td>${notice.empId }</td>
		                 				<td>${notice.pstCnt }</td>
		                 				<td>${notice.pstgBgngDt }</td>
		                 			</tr>
                 				</c:forEach>
                 			</c:if>
                 			<c:if test="${empty notices }">
	                 			<tr>
	                 				<td colspan="4">공지사항이 없습니다.</td>
	                 			</tr>
                 			</c:if>
                 		</tbody>
                 	</table>
                </div>
              </div>
	<div class="d-flex">
			<div class="card card-primary card-outline mr-3" style="width: 30%">
				<div class="card-body" >
              		날씨 API
              	</div>
              </div>
               <div class="card card-primary card-outline" style="width: 70%">
                   <div class="card-header">
		                <h3 class="card-title">
		                    <i class="fa-solid fa-clock"></i>
		                    	오늘의 출퇴근
		                </h3>
		            </div>
	            <div class="card-body">
	                <div class = "d-flex justify-content-between align-content-center align-items-center p-2">
	                	<div class="" style="font-size: 24px">
		                    <div class="d-flex justify-content-center" id="date" class="date"></div>
		                    <div class="d-flex justify-content-center" id="time" class="time"></div>
		                    <!-- <div id="today"></div> -->
						</div>
	                  <div class="today d-flex justify-content-center">
	                         <table style="font-size: 20px">
	                             <tr class="m-2">
	                                 <td>
	                                     <button type="button" class="btn btn-block bg-gradient-primary inputWorkBtn">출근</button>
	                                 </td>
	                                 <td class="text-center" id="bgngDate" style="width: 120px">
						
	                                 </td>
	                             </tr>
	                             <tr class="m-2">
	                                 <td>
	                                     <button type="button" class="btn btn-block bg-gradient-secondary inputWorkBtn">퇴근</button>
	                                 </td>
	                                 <td class="text-center"  id="endDate" style="width: 120px">
	                                     
	                                 </td>
	                             </tr>
	                         </table>
	                    </div>
	
	                </div>
	            </div>
              </div>
              
              </div>

               <div class="card card-primary card-outline">
               <div class="card-header">
		                <h3 class="card-title">
		                    <i class="fa-solid fa-chart-simple"></i>
		                    	 <b>주간 업무 통계</b>
		                </h3>
		            </div>
                <div class="card-body">
		                <div class="chart">
		                  <canvas id="barChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
		                </div>
                </div>
              </div>
            </section>
        

          <section class="col-lg-5 connectedSortable py-3">

            <div >
              <div class="row">
         
          <div class="col-lg-4 col-6">
            <div class="small-box bg-success">
              <a href="#" class="small-box-footer">금주일정</a>
              <div class="inner">
                <h3 class="event_num">${weekEventCount}<sup style="font-size: 20px">+</sup></h3>
              </div>
              <div class="icon">
                <i class="ion ion-android-calendar"></i>
              </div>
            </div>
          </div>
          
          <div class="col-lg-4 col-6">
            <div class="small-box bg-warning">
              <a href="#" class="small-box-footer">오늘 일정</a>
              <div class="inner">
                <h3 class="event_num">${todayEventCount }<sup style="font-size: 20px">+</sup></h3>
              </div>
              <div class="icon">
                <i class="ion ion-ios-clock-outline"></i>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-6">
            <div class="small-box bg-danger">
              <a href="#" class="small-box-footer">내일일정</a>
              <div class="inner">
                <h3 class="event_num">${tomorrowEventCount }<sup style="font-size: 20px">+</sup></h3>
              </div>
              <div class="icon">
                <i class="ion ion-arrow-graph-up-right"></i>
              </div>
            </div>
          </div>
              </div> 
            </div>

               <div class="card card-primary card-outline">
               <div class="card-header">
		                <h3 class="card-title">
		                   <i class="fa-regular fa-calendar"></i>
		                    	 <b>일정</b>
		                </h3>
		            </div>
                <div class="card-body">
                 <div id="calendar"></div>
                </div>
              </div>

              <div class="card card-primary card-outline">
                
                <div class="card-body d-flex col-12">
	                 <div class="rollingbanner">
					    <div class="title col-3">TODO </div>
					    <div class="wrap d-flex">
					        <ul id="todoRolling">
					            
					        </ul>
					    </div>
					</div>
                </div>
              </div>
         
          </section>
          <!-- right col -->
        </div>
        <!-- /.row (main row) -->
      </div><!-- /.container-fluid -->
    </section>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.bundle.js"></script>
<!-- tippy 툴팁, 풀캘린더 -->    
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://unpkg.com/tippy.js@6.3.3/dist/tippy.umd.js"></script>
<script src="/resources/bootstrap/plugins/moment/moment.min.js"></script>
<script src="/resources/bootstrap/plugins/fullcalendar/main.js"></script>
<script type="text/javascript">
$(function(){
	
	    /* 클라우드 전체 용량 가져오기  */
	    $.ajax({
	        url: '/everyware/cloud/getCloutSize',
	        beforeSend : function(xhr){
	          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        dataType: "json",
	        success: function(res){
	          console.log(res[0])	// 총
	          console.log(res[1]) //전체
	          
	          var orCldSize = "${sCldTotalSize }"
	      		
	      		var progressbar = parseFloat(res[0])/parseFloat(res[1])*100;
	          	$("#cldId").text(progressbar.toFixed(2))
	      		console.log(progressbar)
	      		//$("#cldRemain").text(orCldSize - parseFloat($("#cldTotalSize").text()))
	      		
	      		$('.progressbar').css('--width', progressbar+'%');
	      	    $({ val : 0 }).animate({ val : progressbar }, {
	      	    	   duration: 2000,
	      	    	  step: function() {
	      	    	    $(".progress").text(Math.floor(this.val));
	      	    	  },
	      	    	  complete: function() {
	      	    	    $(".progress").text(Math.floor(this.val));
	      	    	    $(".progress").css("color","#fff");
	      	    	  }
	      	    	}); 
	          
	        },
	        error: function(xhr){
	          console.log("실패",xhr.status);
	        }
	      })	
	/* TODO 롤릴 배너  */
		 $.ajax({
	        url: '/everyware/todo/getMainTodo',
	        beforeSend : function(xhr){
	          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        dataType: "json",
	        success: function(res){
	        	console.log(res)
	        	var todoList = "";
	        	 $.each(res, function(index, emp) {
	        		 console.log( res.length)
	        		
		        		 if(index == 0){
		        			 todoList+= `<li class="current"><a href="/everyware/todo">\${emp.tdTtl}</a></li>`
		        		 }
		        		 if(index == 1){
		        			 todoList+= `<li class="next"><a href="/everyware/todo">\${emp.tdTtl}</a></li>`
		        		 }
		        		 
		        		 if(index>1 && index < res.length-1){
		        			 todoList+= `<li><a href="/everyware/todo">\${emp.tdTtl}</a></li>`
		        		 }
		        		 
		        		 if(index ==  res.length-1){
		        			 todoList+= `<li class="prev"><a href="/everyware/todo">\${emp.tdTtl}</a></li>`
		        		 }
	        		  
	        	 })
	           $("#todoRolling").html(todoList);
	        },
	        error: function(xhr){
	          console.log("실패",xhr.status);
	        }
	      })	
	
	 
	
	 var donutChartCanvas = $('#fileDonut').get(0).getContext('2d')
     var donutData        = {
       labels: ['사용중','미사용'],
       datasets: [
         {
           data: [${useFileSz},${maxFileSz}-${useFileSz}],
           backgroundColor : [
        	   'rgba(0, 181, 148, 0.6)',
        	   'rgba(0, 0, 0, 0.2)'
               ]
         }
       ]
       
     }
     //Create pie or douhnut chart
     // You can switch between pie and douhnut using the method below.
     new Chart(donutChartCanvas, {
       type: 'doughnut',
       data: donutData,
       options: {
    	     responsive: true,
    	    legend: {
    	      display: false
    	    }
    	  }
     })  
	    
	    Chart.pluginService.register({
	    	  beforeDraw: function(chart) {
	    		  if (chart.canvas.id === "fileDonut") {
			   	    var width = chart.chart.width,
			   	        height = chart.chart.height,
			   	        ctx = chart.chart.ctx;
			   	    ctx.restore();
			   	    var fontSize = (height / 114).toFixed(2);
			   	    ctx.font = fontSize + "em sans-serif";
			   	    ctx.textBaseline = "middle";
			   	    var percent = ${useFileSz}/${maxFileSz}*100
			   	    var text = Math.round(percent)+"%",
			   	        textX = Math.round((width - ctx.measureText(text).width) / 2),
			   	        textY = height / 2;
			   	    ctx.fillText(text, textX, textY);
			   	    ctx.save();
	    		  }
	    	  }
	    	});   
	    
	
	    
	var eventList = JSON.parse('${eventList}')
	console.log(eventList)
	var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      // 캘린더 설정들
      headerToolbar: {
          right: 'prev,next', // today 버튼을 빼고 이전(prev), 다음(next) 버튼만 표시
          left: 'title',
        },
        eventDidMount: function(info) {
        	var content = info.event._def.title
       		var tooltip = tippy(info.el, {
             		content: content, 
	             	placement: 'top'
	         }); 
    	 
          },
        dayMaxEvents: true,
        height:"500px",
        eventLimit: true, // 이벤트가 한 날짜에 너무 많을 때 "+X more" 버튼 표시
        eventLimitClick: 'popover'
    });

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
			};    		
			calendar.addEvent(event);
	    })
		
	    // 풀캘린더 렌더링
	    calendar.render();
	
	var today = new Date();
	
	var pastDates = [];
	for (var i = 6; i >= 0; i--) {
	  var pastDate = new Date(today);
	  pastDate.setDate(today.getDate() - i);
	  pastDates.push(pastDate.toISOString().slice(0, 10));
	}
		console.log(pastDates)
		var areaChartData={}
			areaChartData = {
						      labels  : [],
						      datasets: [
						        {
						          label               : '업무시간',
						          backgroundColor     : 'rgba(0, 123, 255, 0.6)',
						          borderColor         : 'rgba(0, 123, 255, 1)',
						          pointRadius          : false,
						          pointColor          : '#3b8bba',
						          pointStrokeColor    : 'rgba(60,141,188,1)',
						          pointHighlightFill  : '#fff',
						          pointHighlightStroke: 'rgba(60,141,188,1)',
						          data                : []
						        },
						        
						      ]
						    }
	
		//areaChartData.datasets[0].data.push(num);
		$.ajax({
	        url: '/everyware/work/getAllWork',
	        beforeSend : function(xhr){
	          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        dataType: "json",
	        success: function(res){
	        	console.log(res)
	        	var workList = "";
	        	 $.each(res, function(index, emp) {
	        			 
	        			 var num = parseInt(emp.workEndDt) - parseInt(emp.workBgngDt)
	        			 console.log(parseInt(emp.workEndDt)+"          "+parseInt(emp.workBgngDt)+">>>>>>>>         "+num)
	        			 areaChartData.labels.push(emp.workDt);
	        			 areaChartData.datasets[0].data.push(num);
	        		
	        		 
	        	 })
	        	 
	        	 //-------------
			    //- BAR CHART -
			    //-------------
			    var barChartCanvas = $('#barChart').get(0).getContext('2d')
			    
			    var barChartData = $.extend(true, {}, areaChartData)
			    var temp0 = areaChartData.datasets[0]
			    barChartData.datasets[0] = temp0;
		
		
			    new Chart(barChartCanvas, {
			      type: 'bar',
			      data: barChartData,
			      options: {
					    	  scales: {
					              // ⑫y축에 대한 설정(Object)
					               yAxes: [{
							                ticks: {
							                    display: true,
							                    min: 0,   //y축 최솟값
							                    max: 15, //y축 최댓값
							                    stepSize: 1
							                }
							            }]
					          }
					      }
			    })
	          
	        },
	        error: function(xhr){
	          console.log("실패",xhr.status);
	        }
	      })	
		
		
		/* 근태 시간 */
	    setClock();
	    setInterval(setClock, 1000); //1초마다 setClock 함수 실행
	   // setYearMonth();
	    
	    setInterval(() => {
	    	 $.ajax({
		            url: '/everyware/work/getWorkTime',
		            dataType: 'json',
		            beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
		            success: function (res) {
//						console.log(res)
						if(res.workBgngDt == null){
							$("#bgngDate").text("00:00:00")
						}else{
							$("#bgngDate").text(res.workBgngDt.split(" ")[1])
						}
						
						if(res.workEndDt == null){
							$("#endDate").text("00:00:00")
						}else{
							$("#endDate").text(res.workEndDt.split(" ")[1])
						}
						
		            },
		            error: function(xhr){
		  	          console.log("실패",xhr.status);
		  	        }
		        }); 
		}, 1000);


 	    // 출근버튼 클릭시
	    $(".inputWorkBtn").on("click", function() {
	    		
	        $.ajax({
	            type: 'POST',
	            url: '/everyware/work/workAddDel',
	            data: { time: new Date(),
	            		hr: $(this).text()
	            },
	            dataType: 'json',
	            beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
	            success: function (res) {
					console.log(" 성공")	                
	            },
	            error: function(xhr){
	  	          console.log("실패",xhr.status);
	  	        }
	        }); 
		});
		
	
})

document.addEventListener('DOMContentLoaded', ()=>{
    var interval = window.setInterval(rollingCallback, 3000);
})
function rollingCallback(){
    //.prev 클래스 삭제
    document.querySelector('.rollingbanner .prev').classList.remove('prev');

    //.current -> .prev
    let current = document.querySelector('.rollingbanner .current');
    current.classList.remove('current');
    current.classList.add('prev');

    //.next -> .current
    let next = document.querySelector('.rollingbanner .next');
    //다음 목록 요소가 널인지 체크
    if(next.nextElementSibling == null){
        document.querySelector('.rollingbanner ul li:first-child').classList.add('next');
    }else{
    	//목록 처음 요소를 다음 요소로 선택
        next.nextElementSibling.classList.add('next');
    }
    next.classList.remove('next');
    next.classList.add('current');
}

/* 근태 시간 */
/* // 이번달 설정
function setYearMonth(){
    var dateInfo = new Date();
    var year = dateInfo.getFullYear();
    var month = dateInfo.getMonth() + 1; //monthIndex를 반환해주기 때문에 1을 더해준다.
 
    if(month < 10){
        month = `0\${month}`;
    }
    document.getElementById("yearMonth").innerHTML = `\${year}-\${month}`;
    updateDates(0);
} */

// 시계
function setClock() {
	var dateInfo = new Date();
	var hour = modifyNumber(dateInfo.getHours());
	var min = modifyNumber(dateInfo.getMinutes());
	var sec = modifyNumber(dateInfo.getSeconds());
	var year = dateInfo.getFullYear();
	var month = dateInfo.getMonth() + 1; //monthIndex를 반환해주기 때문에 1을 더해준다.
	var date = dateInfo.getDate();
	var day = getDayString(dateInfo.getDay()); // 요일을 문자열로 가져옴
	
	document.getElementById("time").innerHTML = hour + ":" + min + ":" + sec;
	document.getElementById("date").innerHTML = year + "년 " + month + "월 " + date + "일 (" + day + ")";;
}

// 시계 
function modifyNumber(time) {
	if (parseInt(time) < 10) {
		return "0" + time;
	} else
		return time;
}
function getDayString(dayIndex) {
	  // 요일 인덱스에 해당하는 문자열을 반환
	  var days = ["일", "월", "화", "수", "목", "금", "토"];
	  return days[dayIndex];
	}
</script>