<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
    let headerName = "${_csrf.headerName}"
    let token = "${_csrf.token}"
</script>

<style>
#workAdminListTable {
    font-size: large;
}

#today {
    font-size: 50px;
}

#btnLeft, #btnRight {
    border: none;
    background-color: transparent;
    font-size: 40px;
    color: gray;
}

#searchState, #searchStartDate, #searchEndDate{
    border: 1px solid #ced4da;
}

.info-box {
    height: 100px;
}

.info-box .info-box-number {
    font-size: large;
}

.tagify{    
  width: 87.3%;
  max-width: 700px;
  background: rgba(white, .8);
  max-height:100px!important;
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
#member{
	min-height: 150px;
	overflow-y: auto; 
}
</style>

<section class="content-header">
	<div class="container-fluid">

		<!-- line1 -->
		<div class="row">
			<div class="col">

				<div class="card card-primary card-outline">
					<div class="card-header">

						<div class="row">
							<!-- 검색폼-->
							<div class="col">
								<div class="text-center" id="today">
									<input id="btnLeft" type="button" value="<">
									<span id="todayStr" name="todayStr" value="todayStr">2023-08-01</span>
									<input id="btnRight" type="button" value=">">
								</div>
							</div>
						</div>

						<div class="row">
							<!-- <div class="d-flex justify-content-end"> -->
							<div>
								<form class="input-group input-group-sm" id="searchForm">
									<span>기간&nbsp;</span>
									<input type="date" pattern="yyyy-MM-dd" name="searchStartDate" id="searchStartDate" value="">
									<span>&nbsp; ~ &nbsp;</span>
									<input type="date" pattern="yyyy-MM-dd" name="searchEndDate" id="searchEndDate" value="">
						
									<span>&nbsp; &nbsp;검색항목 &nbsp;</span>
									<select class="" id="searchState" name="searchState">
										<option value="전체" selected="selected">전체</option>
										<option value="정상" <c:if test="${searchState == '정상' }">
											<c:out value="selected" />
											</c:if>>정상
										</option>
										<option value="연장" <c:if test="${searchState == '연장' }">
											<c:out value="selected" />
											</c:if>>연장
										</option>
										<option value="지각" <c:if test="${searchState == '지각' }">
											<c:out value="selected" />
											</c:if>>지각
										</option>
										<option value="조퇴" <c:if test="${searchState == '조퇴' }">
											<c:out value="selected" />
											</c:if>>조퇴
										</option>
										<option value="휴가" <c:if test="${searchState == '휴가' }">
											<c:out value="selected" />
											</c:if>>휴가
										</option>
									</select>
						
									<div class="input-group-append">
										<!-- <input type="text" id="member" name="users-list-tags" placeholder="주소록을 클릭하세요.">
											<div class="input-group-append" style="flex-direction: column;">
												<button class="btn btn-outline-secondary" type="button" data-toggle="modal" data-target="#tree-modal" id="address_book_btn">주소록</button>
											</div> -->
										<button type="submit" class="btn btn-default" id="searchBtn">
											<i class="fas fa-search"></i>검색
										</button>
									</div>
						
									<sec:csrfInput />
						
								</form>
							</div>
						</div>
						</div>

					<div class="card-body" style="display: block;">
						<div class="row">
							<div class="col-md-2 col-sm-6 col-12">
								<div class="info-box bg-primary">
									<span class="info-box-icon"><i class="far fa-bookmark"></i></span>
									<div class="info-box-content">
										<span class="info-box-text">전체</span>
										<div class="row">
											<div class="info-box-number" id="totalRecode">0건</div>
										</div>
									</div>
								</div>
							</div>

							<div class="col-md-2 col-sm-6 col-12">
								<div class="info-box bg-success">
									<span class="info-box-icon"><i class="far fa-thumbs-up"></i></span>
									<div class="info-box-content">
										<span class="info-box-text">정상</span>
										<span class="info-box-number" id="totalNormal">0건</span>
									</div>
								</div>
							</div>

							<div class="col-md-2 col-sm-6 col-12">
								<div class="info-box bg-warning">
									<span class="info-box-icon"><i class="far fa-calendar-alt"></i></span>
									<div class="info-box-content">
										<span class="info-box-text">연장</span>
										<span class="info-box-number" id="totalExtension">0건</span>
									</div>
								</div>
							</div>

							<div class="col-md-2 col-sm-6 col-12">
								<div class="info-box bg-danger">
									<span class="info-box-icon"><ion-icon
											name="alert-circle-outline"></ion-icon></span>
									<div class="info-box-content">
										<span class="info-box-text">지각</span>
										<span class="info-box-number" id="totalLateness">0건</span>
									</div>
								</div>
							</div>

							<div class="col-md-2 col-sm-6 col-12">
								<div class="info-box bg-info">
									<span class="info-box-icon"><ion-icon name="walk-outline"></ion-icon></span>
									<div class="info-box-content">
										<span class="info-box-text">조퇴</span>
										<span class="info-box-number" id="totalLeaveEarly">0건</span>
									</div>
								</div>
							</div>

							<div class="col-md-2 col-sm-6 col-12">
								<div class="info-box bg-indigo color-palette">
									<span class="info-box-icon"><i class="far fa-star"></i></span>
									<div class="info-box-content">
										<span class="info-box-text">휴가</span>
										<span class="info-box-number" id="totalVacation">0건</span>
									</div>
								</div>
							</div>

						</div>
					</div>

				</div>
			</div>

		</div>



		<!-- line2 -->
		<div class="row">
			<div class="col">

				<div class="card">
					<div class="card-header">
						<h3 class="card-title m-1">근태관리</h3>
					</div>

					<div class="card-body " style="overflow-Y: scroll; height: 650px;display: block; padding: 0%">
						<table class="table table-striped projects" id="workAdminListTable">
							<thead>
								<tr>
									<th class="text-center">일자</th>
									<th class="text-center">요일</th>
									<th class="text-center"><!-- 사진 이름-->프로필</th>
									<th class="text-center">직급</th>
									<th class="text-center">부서</th>
									<th class="text-center">출근시간</th>
									<th class="text-center">퇴근시간</th>
									<th class="text-center">근무시간</th>
									<th class="text-center">상태</th>
								</tr>
							</thead>

							<tbody id="workAdminList">
								<!-- workAdminList -->
							</tbody>
						</table>

						<div class="row">
							<!-- 페이지 번호 -->
							<div class="col-sm-12" id="pagingArea" > 
									<ul class="pagination pagination-primary mt-0">
											<!-- ${suvyPaging.pagingHTML} -->
									</ul>
							</div>
					</div>
					</div>
				</div>

			</div>
		</div>




	</div>
</section>


<%@ include file="/WEB-INF/views/everyware/contacts/contactModal.jsp" %>


<script src="/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@yaireo/tagify"></script>
<script src="https://cdn.jsdelivr.net/npm/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />


<script>
$(function(){
	
	$("#todayStr").text(getCurrentDate());
	$("#searchStartDate").val(getCurrentDate());
	$("#searchEndDate").val(getCurrentDate());
	


	const todayStr = $("#todayStr");
	const btnLeft = $("#btnLeft");
	const btnRight = $("#btnRight");
	const pagingArea = $("#pagingArea");
	

	const addressBookBtn=$("#address_book_btn")
	var tags = $(".tagify__tag")
  	const draftBtn = $("#draft_btn")

	var searchStartDate = $("#searchStartDate").val();
	var searchEndDate = $("#searchEndDate").val();

	var obj = {
		page:1,
		searchStartDate: searchStartDate,
		searchEndDate: searchEndDate
	}


	workAdminList(obj,addList);


	$('.tree-return-btn').on("click",function(){
		modalReturn(function(data){
			console.log(data)
			var fList=[]
			
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
					fList.push(obj)
			})
			console.log(fList)
			tagify.addTags(fList)
            
		});
	})














	// <
	btnLeft.on("click", function () {
		updateDate(-1);
	});

	// >
	btnRight.on("click", function () {
		updateDate(1);
	});

	// 검색
	$("#searchBtn").on("click", function (e) {
		e.preventDefault();

		obj.searchStartDate = $("#searchStartDate").val();
		obj.searchEndDate = $("#searchEndDate").val();
		obj.searchState = $("#searchState").val();

		workAdminList(obj,addList);
	});

	// 페이지 번호 클릭시
	pagingArea.on("click", "a", function (e) {
		event.preventDefault();
		var pageNo = $(this).data("page"); // 페이지 번호가 넘어옴
		obj.page = pageNo
		workAdminList(obj, addList)
	});


});




// 근태기록 관리자
function workAdminList(data,callback){
	$.ajax({
		url: `/everyware/admin/work/getWorkAdminList`,
		type: "post",
		contentType: 'application/json; charset=utf-8',
		dataType: "json",
		data:JSON.stringify(data),
		beforeSend : function(xhr){
			// xhr.setRequestHeader("${_headerName}","${token}");
			xhr.setRequestHeader(headerName,token);
		},
		success: function(res){
			if (typeof callback != "undefined") {
				callback(res)
			}
		},
		error: function(xhr) {
			alert("Error: " + xhr.status);
		}

	});
};

// 
function addList(res){
	console.log("res",res);
	$("#workAdminList").html("");
  	$("#pagingArea").html("");

	var dataList = res.dataList;
	var workAdminListStr = "";
	var pagingAreaStr = res.workAdmin.pagingHtml;

	// 근태현황
	var totalWork = res.totalWork;
	var totalNormal = res.totalNormal;
	var totalExtension = res.totalExtension;
	var totalLateness = res.totalLateness;
	var totalLeaveEarly = res.totalLeaveEarly;
	var totalVacation = res.totalVacation;


	if(dataList.length == 0){
		workAdminListStr += `<tr><td colspan='9'>조회하신 기록이 존재하지 않습니다.</td></tr>`;
	} else {

		for(let i=0; i<dataList.length; i++){
			workAdminListStr += 
			`<tr class="workAdminListTable">
				<input type="hidden" id="\${dataList[i].workNo}" name="workNo" value="\${dataList[i].workNo}">
				<th style="text-align: center;">\${dataList[i].workDt}</th>
				<th style="text-align: center;">\${dataList[i].workDw}</th>
				<th style="text-align: center;">\${dataList[i].empId}</th>
				<th style="text-align: center;">직급</th>
				<th style="text-align: center;">부서</th>
				<th style="text-align: center;">\${dataList[i].workBgngDt}</th>
				<th style="text-align: center;">\${dataList[i].workEndDt}</th>
				<th style="text-align: center;">`
				
 			var timeDiff = calculateTimeDifference(dataList[i].workBgngDt, dataList[i].workEndDt);
			workAdminListStr += timeDiff;
			workAdminListStr += `</th>`;

			if (`\${dataList[i].workState}` == '정상') {
				workAdminListStr +=
					`<th style="text-align: center;">
								<span class="badge bg-success">
									\${dataList[i].workState}
								</span>
							</th>`
			}

			if (`\${dataList[i].workState}` == '연장') {
					workAdminListStr +=
						`<th style="text-align: center;">
								<span class="badge bg-warning">
									\${dataList[i].workState}
								</span>
							</th>`
				}

				if (`\${dataList[i].workState}` == '지각') {
					workAdminListStr +=
						`<th style="text-align: center;">
								<span class="badge bg-danger">
									\${dataList[i].workState}
								</span>
							</th>`
				}

				if (`\${dataList[i].workState}` == '조퇴') {
					workAdminListStr +=
						`<th style="text-align: center;">
								<span class="badge bg-info">
									\${dataList[i].workState}
								</span>
							</th>`
				}

				if (`\${dataList[i].workState}` == '휴가') {
					workAdminListStr +=
					`<th style="text-align: center;">
						<span class="badge bg-indigo color-palette">
							\${dataList[i].workState}
						</span>
					</th>`
				}

				workAdminListStr += `</tr>`;
		}

		// 근태목록
		$("#workAdminList").html(workAdminListStr);

		// 근태현황
		$("#totalRecode").text(totalWork + '건');
		$("#totalNormal").text(totalNormal + '건');
		$("#totalExtension").text(totalExtension + '건');
		$("#totalLateness").text(totalLateness + '건');
		$("#totalLeaveEarly").text(totalLeaveEarly + '건');
		$("#totalVacation").text(totalVacation + '건');

	}
};

function parseTime(timeString) {
	console.log(timeString)
	const [hours, minutes, seconds] = timeString.split(":");
	return {
		hours: parseInt(hours),
		minutes: parseInt(minutes),
		seconds: parseInt(seconds),
	};
}

function formatTime(time) {
	return time.toString().padStart(2, "0");
}

function calculateTimeDifference(startTime, endTime) {
	const start = parseTime(startTime);
	const end = parseTime(endTime);
	console.log(start)
	console.log(end)

	let hoursDiff = end.hours - start.hours;
	let minutesDiff = end.minutes - start.minutes;
	let secondsDiff = end.seconds - start.seconds;

	if (secondsDiff < 0) {
		secondsDiff += 60;
		minutesDiff--;
	}

	if (minutesDiff < 0) {
		minutesDiff += 60;
		hoursDiff--;
	}
	return formatTime(hoursDiff) + ":" + formatTime(minutesDiff) + ":" + formatTime(secondsDiff);
}


// 오늘 날짜 설정
function getCurrentDate() {
    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const day = String(now.getDate()).padStart(2, '0');
    return `\${year}-\${month}-\${day}`;
}

// <> 날짜 update
function updateDate(days) {
    const todayStr = $("#todayStr").text();
    const currentDate = new Date(todayStr);
    currentDate.setDate(currentDate.getDate() + days);

    const year = currentDate.getFullYear();
    const month = String(currentDate.getMonth() + 1).padStart(2, '0');
    const day = String(currentDate.getDate()).padStart(2, '0');
    const newDateStr = `\${year}-\${month}-\${day}`;

    $("#todayStr").text(newDateStr);
    $("#searchStartDate").val(newDateStr);
    $("#searchEndDate").val(newDateStr);

	searchBtn.click();
}
</script>


<script src="/resources/js/mail_tagify.js"></script> 