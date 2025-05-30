<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
    let headerName = "${_csrf.headerName}"
    let token = "${_csrf.token}"
</script>

<style>
#workListTable {
    font-size: large;
}

#yearMonth2 {
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

.date{
    font-size: 20px;
    text-align: center;
}

.time{
    font-size: 50px;
    text-align: center;
}

#btnWorkAdjAdd {
    border-radius: 0;
    border: none;
    background-color: white;
}
</style>

<section class="content py-3">
	<div class="container-fluid">
		

		<!-- 출퇴근 Summary -->
		<div class="row">
			<div class="col">

				<div class="card card-primary card-outline">
					<div class="card-header">
						<div class="row">

							<!-- 검색폼-->
							<div class="col">
								<div class="text-center" id="yearMonth2">
									<input id="btnLeft" type="button" value="<">
									<span id="yearMonth" name="yearMonth" value="yearMonth">2023-07</span>
									<input id="btnRight" type="button" value=">">
								</div>
							</div>
						</div>

						<!-- <h3 class="card-title">출퇴근 Summary</h3> -->
						<div class="d-flex justify-content-end" >
							<form class="input-group input-group-sm" id="searchForm">
								<span>기간&nbsp;</span>
								<input type="date" pattern="yyyy-MM-dd" name="searchStartDate" id="searchStartDate" value="${searchStartDate}">
								<span>&nbsp; ~ &nbsp;</span>
								<input type="date" pattern="yyyy-MM-dd" name="searchEndDate" id="searchEndDate" value="${searchEndDate}">
			
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
									<button type="submit" class="btn btn-default" id="searchBtn">
										<i class="fas fa-search"></i>검색
									</button>
								</div>
								<sec:csrfInput />
			
							</form>
						</div>
						
					</div>

					<div class="card-body" style="display: block;">
						<div class="row">
							<div class="col-md-2 col-sm-6 col-12">
								<div class="info-box bg-primary">
									<span class="info-box-icon"><i class="far fa-bookmark"></i></span>
									<div class="info-box-content">
										<span class="info-box-text">전체</span>
										<span class="info-box-number" id="totalRecode">0건</span>
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
									<span class="info-box-icon"><ion-icon name="alert-circle-outline"></ion-icon></span>
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

		<!-- 출퇴근기록 -->
		<div class="row">
			<div class="col">

				<div class="card">
					<div class="card-header">
						<h3 class="card-title">출퇴근기록</h3>
					</div>

					<div class="card-body" style="overflow-Y: scroll; height: 650px;display: block; padding: 0%">
						<table class="table table-striped projects" id="workListTable">
							<thead>
								<tr>
									<th style="text-align: center;">일자</th>
									<th style="text-align: center;">요일</th>
									<th style="text-align: center;">출근시간</th>
									<th style="text-align: center;">퇴근시간</th>
									<th style="text-align: center;">근무시간</th>
									<th style="text-align: center;">상태</th>
									<th style="text-align: center;">근태조정신청</th>
								</tr>
							</thead>

							<tbody id="workList">
								<!-- workList -->
							</tbody>
						</table>
					</div>

				</div>

			</div>
		</div>

	</div>
</section>

<!-- modal-workAdjForm-->
<div class="modal fade" id="modal-workAdjForm">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="modalTtl">근태조정신청서</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <form class="form-horizontal" method="post" id="toDoForm">
                    <input type="hidden" id="" name="">

                    <div class="card-body">
                        <div class="form-group row">
                            <label for="" class="col-sm-2 col-form-label">근무일</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="mWorkDt" name="mWorkDt" disabled>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label for="" class="col-sm-2 col-form-label">출퇴근시간</label>

                            <label for="" class="col-sm-2 col-form-label">출근시간</label>
                            <div class="col-sm-2">
                                <input type="time" name="mWorkBgngDt" id="mWorkBgngDt" value="" disabled>
                            </div>
                            &nbsp;
                            <label for="" class="col-sm-2 col-form-label">퇴근시간</label>
                            <div class="col-sm-2">
                                <input type="time" name="mWorkEndDt" id="mWorkEndDt" value="" disabled>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="" class="col-sm-2 col-form-label">조정시간</label>

                            <label for="" class="col-sm-2 col-form-label">출근시간</label>
                            <div class="col-sm-2">
                                <input type="time" name="" id="" value="09:00:00">
                            </div>
                            &nbsp;
                            <label for="" class="col-sm-2 col-form-label">퇴근시간</label>
                            <div class="col-sm-2">
                                <input type="time" name="" id="" value="18:00:00">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="" class="col-sm-2 col-form-label">총 근무시간</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="mTimeDiff" name="mTimeDiff" disabled>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="" class="col-sm-2 col-form-label">조정사유</label>
                            <div class="col-sm-10">
                                <div class="input-group mb-3">
                                    <textarea class="form-control" id="" name="" rows="10" placeholder="조정사유를 입력하세요."></textarea>
                                </div>
                            </div>
                        </div>


                    </div>
                </form>
            </div>

            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <div class="float-right"> 
                    <button type="button" class="btn btn-primary" id="btnToDoAdd">Save</button>
                    <!-- <button type="button" class="btn btn-danger btnDel" data-tdNo="">Delete</button> -->
                </div>
            </div>

        </div>
    </div>
</div>












<script>
//DomContentLoaded  이벤트
$(function () {
	setYearMonth();
	workList();

	const yearMonth = $("#yearMonth");   // jQuery는 항상 바구니에 담아서 가져옴
	// const yearMonth = document.querySelectorAll("#yearMonth"); //  DOM  서치는 해당하는 놈 바로 들고옴
	const btnLeft = $("#btnLeft");
	const btnRight = $("#btnRight");

	// 근태조정신청폼 // 상세보기
	$(document).on("click", ".btnWorkAdjForm", function () {
		var workNo = $(this).closest(".workListTable").find("input[name='workNo']").val();
		console.log("workNo", workNo);

		$.ajax({
			type: "get",
			url: `/everyware/work/getOneWork/\${workNo}`,
			contentType: 'application/json; charset=utf-8',
			dataType: "json",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(headerName, token);
			},
			success: function (res) {
				console.log("res", res);
				var workNo = res.workNo;
				var workDt = res.workDt;
				var workBgngDt = res.workBgngDt;
				var workEndDt = res.workEndDt;
				var workState = res.workState;
				var timeDiff = calculateTimeDifference(workBgngDt, workEndDt);


				$('#mWorkDt').val(workDt);
				$('#mWorkBgngDt').val(workBgngDt);
				$('#mWorkEndDt').val(workEndDt);
				$('#mWorkState').val(workState);
				$('#mTimeDiff').val(timeDiff);

				$('#modal-workAdjForm').modal("show");
			},
      error: function (xhr) {
        alert("Error: " + xhr.status);
      }

			});


	});


	// 검색
	// 왼쪽 < 버튼 클릭시
	btnLeft.on("click", function () {
		updateYearMonth(-1);
	});

	// 오른쪽 > 버튼 클릭시
	btnRight.on("click", function () {
		updateYearMonth(1);
	});

	// 검색
	$("#searchBtn").on("click", function (e) {
		e.preventDefault();
		workList();
	});

	// $(function () {});
});


// 근태목록
function workList() {
	// 검색
	var searchData = {
		searchStartDate: $("#searchStartDate").val(),
		searchEndDate: $("#searchEndDate").val(),
		searchState: $("#searchState").val()
	}
	// console.log("searchData: ", searchData);

	$.ajax({
		url: "/everyware/work/workList",
		type: "post",
		data: JSON.stringify(searchData),
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		beforeSend: function (xhr) {
			xhr.setRequestHeader(headerName, token);
		},
		success: function (res) {
			var dataList = res.dataList;
			var workListStr = "";
			var workStateColor = "";
			// console.log("res",res);
			// console.log("dataList : ", dataList);

			// 근태현황
			var totalWork = res.totalWork;
			var totalNormal = res.totalNormal;
			var totalExtension = res.totalExtension;
			var totalLateness = res.totalLateness;
			var totalLeaveEarly = res.totalLeaveEarly;
			var totalVacation = res.totalVacation;

			//  근태목록
			if (dataList.length == 0) {
				workListStr += `<tr><td colspan='7'>조회하신 기록이 존재하지 않습니다.</td></tr>`;
			} else {
				for (let i = 0; i < res.dataList.length; i++) {

					workListStr +=
					`<tr class="workListTable">;
						<input type="hidden" id="\${dataList[i].workNo}" name="workNo" value="\${dataList[i].workNo}">
						<th style="text-align: center;">\${dataList[i].workDt}</th>
						<th style="text-align: center;">\${dataList[i].workDw}</th>
						<th style="text-align: center;">\${dataList[i].workBgngDt}</th>
						<th style="text-align: center;">\${dataList[i].workEndDt}</th>
						<th style="text-align: center;">`

					var timeDiff = calculateTimeDifference(dataList[i].workBgngDt, dataList[i].workEndDt);
					workListStr += timeDiff;

					workListStr += `</th>`;

					if (`\${dataList[i].workState}` == '정상') {
						workListStr +=
							`<th style="text-align: center;">
								<span class="badge bg-success">
									\${dataList[i].workState}
								</span>
							</th>`
					}

					if (`\${dataList[i].workState}` == '연장') {
					workListStr +=
						`<th style="text-align: center;">
								<span class="badge bg-warning">
									\${dataList[i].workState}
								</span>
							</th>`
				}

				if (`\${dataList[i].workState}` == '지각') {
					workListStr +=
						`<th style="text-align: center;">
								<span class="badge bg-danger">
									\${dataList[i].workState}
								</span>
							</th>`
				}

				if (`\${dataList[i].workState}` == '조퇴') {
					workListStr +=
						`<th style="text-align: center;">
								<span class="badge bg-info">
									\${dataList[i].workState}
								</span>
							</th>`
				}

				if (`\${dataList[i].workState}` == '휴가') {
					workListStr +=
					`<th style="text-align: center;">
						<span class="badge bg-indigo color-palette">
							\${dataList[i].workState}
						</span>
					</th>`
				}
						
					workListStr +=
					`<th style="text-align: center;">
							<button type="button" class="btn btn-tool bg-info btnWorkAdjForm">
								<i class="fas fa-pencil-alt"></i>Edit
							</button>
						</th>
					</tr>`;
				}
			}

			// 근태목록
			$("#workList").html(workListStr);

			// 근태현황
			$("#totalRecode").text(totalWork + '건');
			$("#totalNormal").text(totalNormal + '건');
			$("#totalExtension").text(totalExtension + '건');
			$("#totalLateness").text(totalLateness + '건');
			$("#totalLeaveEarly").text(totalLeaveEarly + '건');
			$("#totalVacation").text(totalVacation + '건');
		}

	});
}







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
	  return formatTime(hoursDiff) +":"+formatTime(minutesDiff) +":"+formatTime(secondsDiff);
	}
        

// 검색 년월 클릭시 -> input date 값 수정
function updateDates(monthOffset) {
    var yearMonth = document.getElementById('yearMonth');
    var searchStartDate = document.getElementById('searchStartDate');
    var searchEndDate = document.getElementById('searchEndDate');

    var currentYearMonth = yearMonth.textContent.trim();
    var year = parseInt(currentYearMonth.split('-')[0]);
    var month = parseInt(currentYearMonth.split('-')[1]);

    var currentDate = new Date(year, month - 1, 1);
    currentDate.setMonth(currentDate.getMonth() + monthOffset);

    var newYear = currentDate.getFullYear();
    var newMonth = currentDate.getMonth() + 1;

    yearMonth.textContent = newYear + '-' + ('0' + newMonth).slice(-2);

    var lastDay = new Date(newYear, newMonth, 0).getDate();

    searchStartDate.value = newYear + '-' + ('0' + newMonth).slice(-2) + '-01';
    searchEndDate.value = newYear + '-' + ('0' + newMonth).slice(-2) + '-' + lastDay;
}


// 이번달 설정
function setYearMonth() {
    var dateInfo = new Date();
    var year = dateInfo.getFullYear();
    var month = dateInfo.getMonth() + 1; //monthIndex를 반환해주기 때문에 1을 더해준다.

    if (month < 10) {
        month = `0\${month}`;
    }

    $("#yearMonth").html(`\${year}-\${month}`);
    $("#searchStartDate").val(`\${year}-\${month}-01`);

    var lastDay = new Date(year, month, 0).getDate();
    $("#searchEndDate").val(`\${year}-\${month}-\${lastDay}`);
}


// < > 버튼 클릭시 기간 input 업데이트
function updateYearMonth(monthOffset) {
	let yearMonth = $("#yearMonth");
	let spanStr = yearMonth.text().split("-");
	let year = parseInt(spanStr[0]);
	let month = parseInt(spanStr[1]);

	month = month + monthOffset;

	if (month > 12) {
		month = 1;
		year = year + 1;
	}

	if (month < 1) {
		month = 12;
		year = year - 1;
	}

	if (month < 10) {
		month = `0\${month}`;
	}

	yearMonth.html(`\${year}-\${month}`);
	$("#searchStartDate").val(`\${year}-\${month}-01`);

	var lastDay = new Date(year, month, 0).getDate();
	$("#searchEndDate").val(`\${year}-\${month}-\${lastDay}`);

	searchBtn.click();
}

</script>