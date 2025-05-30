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
<!-- <script src="<%= request.getContextPath() %>/resources/js/work.js" type="text/javascript"></script> -->

<style>
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

<div class="content-header">
  	<div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">일일근태</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item active">일일근태</li>
                </ol>
            </div>
        </div>
    </div>
</div>

<section class="content">
    <div class="container-fluid">
        <!-- 근태 시간 -->
        <div class="row">
            <div class="col-md-4">
                <div class="card">

                    <div class="card-header">
                        <h3 class="card-title">
                            <ion-icon name="alarm-outline"></ion-icon>
                            오늘의 출퇴근
                        </h3>

                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
        
                    <div class="card-body" style="display: block;">
                        <div>
                            <!-- 시계 -->
                            <div id="date" class="date"></div>
                            <div id="time" class="time"></div>

                            <div class="today">
                                <c:set value="${workList }"  var="work"/>
                                <c:choose>
                                    <c:when test="${empty work }">
                                        <table>
                                            <tr>   
                                                <td>
                                                    <button type="button" class="btn btn-block bg-gradient-primary" id="btnWorkBgngDt">출근</button>
                                                </td>
                                                <td>00:00:00</td>
                                                <td>
                                                    <button type="button" class="btn btn-block bg-gradient-secondary" id="btnWorkEndDt">퇴근</button>
                                                </td>
                                                <td>00:00:00</td>
                                            </tr>
                                        </table>
                                    </c:when>
                                        
                                    <c:otherwise>
                                        <c:forEach items="${work }" var="work">
                                            <c:set var="workDt" value="${work.workDt}" />
                                            <c:set var="workBgngDt" value="${work.workBgngDt}"/>
                                            <c:set var="workEndDt" value="${work.workEndDt}"/>
                                            <table>
                                                <tr>   
                                                    <td>
                                                        <button type="button" class="btn btn-block bg-gradient-primary" id="btnWorkBgngDt">출근</button>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${workBgngDt}" pattern="HH:mm:ss" type="date"/>
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-block bg-gradient-secondary" id="btnWorkEndDt">퇴근</button>
                                                    </td>
                                                    <td>
                                                        <c:if test="${workEndDt eq null}"> 
                                                            00:00:00
                                                        </c:if>
                                                        <c:if test="${workEndDt ne null}"> 
                                                            <fmt:formatDate value="${workEndDt}" pattern="HH:mm:ss" type="date"/>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </table>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
        
        <!-- 날짜 선택-->
        <!-- 근태현황 Type2-->
        <div class="row">
            <div class="col">
                <div class="card">

                    <div class="card-header">
                        <h3 class="card-title">출퇴근 Summary</h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>

                    <div class="card-body" style="display: block;">
                        <div class="text-center">
                            <input id="btnLeft" type="button" value="<">
                            <span id="yearMonth"></span>
                            <input id="btnRight" type="button" value=">">
                        </div>
                        
                        <!-- 오른쪽 정렬 -->
                        <div class="text-right">
                            <form class="input-group input-group-sm" method="post" id="searchForm" style="width: 520px;">
                            	<input type="hidden" name="page" id="page" />
                                기간 &nbsp;
                                <input type="date" pattern="yyyy-MM-dd" name="searchStartDate" id="searchStartDate" value="${searchStartDate}">
                                &nbsp; ~ &nbsp;
                                <input type="date" pattern="yyyy-MM-dd" name="searchEndDate" id="searchEndDate" value="${searchEndDate}">
                                &nbsp; &nbsp;
                                검색항목 &nbsp;
                                
                                <select class="form-control" name="searchState">
                                    <option value="전체" selected="selected">전체</option>
                                    <option value="정상" <c:if test="${searchState == '정상' }"><c:out value="selected"/></c:if>>정상</option>
                                    <option value="연장" <c:if test="${searchState == '연장' }"><c:out value="selected"/></c:if>>연장</option>
                                    <option value="지각" <c:if test="${searchState == '지각' }"><c:out value="selected"/></c:if>>지각</option>
                                    <option value="조퇴" <c:if test="${searchState == '조퇴' }"><c:out value="selected"/></c:if>>조퇴</option>
                                    <option value="휴가" <c:if test="${searchState == '휴가' }"><c:out value="selected"/></c:if>>휴가</option>
                                </select>
                                
                                <div class="input-group-append">
                                    <button type="submit" class="btn btn-default" id="searchBtn">
                                        <i class="fas fa-search"></i>검색
                                    </button>
                                </div>
                                <sec:csrfInput/>
                                
                            </form>
                        </div>
                        <br>

                        <div class="row">
                            <div class="col-md-2 col-sm-6 col-12">
                                <div class="info-box bg-info">
                                    <span class="info-box-icon"><i class="far fa-bookmark"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">전체</span>
                                        <span class="info-box-number">${pagingVO.totalRecord }건</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2 col-sm-6 col-12">
                                <div class="info-box bg-success">
                                    <span class="info-box-icon"><i class="far fa-thumbs-up"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">정상</span>
                                        <span class="info-box-number">${pagingVO.totalNormal }건</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2 col-sm-6 col-12">
                                <div class="info-box bg-warning">
                                    <span class="info-box-icon"><i class="far fa-calendar-alt"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">연장</span>
                                        <span class="info-box-number">${pagingVO.totalExtension }건</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2 col-sm-6 col-12">
                                <div class="info-box bg-danger">
                                    <span class="info-box-icon"><i class="fas fa-comments"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">지각</span>
                                        <span class="info-box-number">${pagingVO.totalLateness }건</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2 col-sm-6 col-12">
                                <div class="info-box bg-info">
                                    <span class="info-box-icon"><i class="far fa-bookmark"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">조퇴</span>
                                        <span class="info-box-number">${pagingVO.totalLeaveEarly }건</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2 col-sm-6 col-12">
                                <div class="info-box bg-success">
                                    <span class="info-box-icon"><i class="far fa-thumbs-up"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">휴가</span>
                                        <span class="info-box-number">${pagingVO.totalVacation }건</span>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>


                </div>
                
            </div>
        </div>       
        
        <!-- 출퇴근기록 Type1-->
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">출퇴근기록</h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>

                    <div class="card-body">
                        <table class="table table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">상태</th>
                                    <th style="text-align: left;">일자</th>
                                    <th style="text-align: left;">요일</th>
                                    <th style="text-align: left;">출근시간</th>
                                    <th style="text-align: left;">퇴근시간</th>
                                    <th style="text-align: left;">근무시간</th>
                                    <th style="width: 10px"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set value="${pagingVO.dataList }"  var="workList"/>
                                <c:choose>
                                    <c:when test="${empty workList }">
                                        <tr>
                                            <td colspan="7">조회하신 기록이 존재하지 않습니다.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${workList }" var="work">
                                            <c:set var="workDt" value="${work.workDt}" />
                                            <c:set var="workBgngDt" value="${work.workBgngDt}"/>
                                            <c:set var="workEndDt" value="${work.workEndDt}"/>
                                            <c:set var="workNo" value="${work.workNo}"/>
                                            <input type="hidden" id="workNo" name="workNo" value="${work.workNo}">
                                            <tr>
                                                <td style="text-align: left;">${work.workState}</td>
												<td style="text-align: left;">
													<fmt:formatDate value="${workDt}" pattern="yy-MM-dd" type="date"/>
												</td>
												<td style="text-align: left;"> 
													<fmt:formatDate value="${workDt}" pattern="E" type="date"/>
												</td>
                                                <td style="text-align: left;">
													<fmt:formatDate value="${workBgngDt}" pattern="HH:mm:ss" type="date"/>
                                                </td>
                                                <td style="text-align: left;">
                                               		<c:if test="${workEndDt eq null}"> 
                                                    	00:00:00
                                                    </c:if>
                                               		<c:if test="${workEndDt ne null}"> 
														<fmt:formatDate value="${workEndDt}" pattern="HH:mm:ss" type="date"/>
                                                    </c:if>
                                                </td>
                                                <td style="text-align: left;">
                                                    근무시간
                                                </td>
                                                <td style="text-align: left;">
                                                    <button type="button" id="btnWorkAdjAdd" class="btnWorkAdjAdd" value="${work.workNo}">
                                                        <i class="fas fa-search"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- 페이지번호 -->
                     <div class="card-footer clearfix" id="pagingArea">
                         <ul class="pagination pagination-sm m-0 float-right">
                             ${pagingVO.pagingHTML }                         </ul>
                     </div>

                </div>
            </div>
        </div>

    </div>
</section>

<script type="text/javascript">
    

//DomContentLoaded  이벤트
$(function () {
    setClock();
    setInterval(setClock, 1000); //1초마다 setClock 함수 실행
    setYearMonth();

    var btnWorkBgngDt = $("#btnWorkBgngDt");   
    var btnWorkEndDt = $("#btnWorkEndDt");   
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
    var btnWorkAdjAdd = $(".btnWorkAdjAdd");

    // 근태조정
    btnWorkAdjAdd.on("click", function(){
        
    })

    // 출근버튼 클릭시
    btnWorkBgngDt.on("click", function () {
        $.ajax({
            type: 'POST',
            url: '/everyware/work/addWorkBgngDt.do',
            beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
            success: function (res) {
                // alert("성공");
                location.reload();
            },
            error: function(xhr) {
                alert("Error: " + xhr.status);
            }
        });
	});
    
    // 퇴근버튼 클릭시
    btnWorkEndDt.on("click", function () {
        $.ajax({
            type: 'POST',
            url: '/everyware/work/editWorkEndDt.do',
            beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
            success: function (res) {
                // alert("성공");
                location.reload();
            },
            error: function(xhr) {
                alert("Error: " + xhr.status);
            }
        });
	});
    
    // 검색 < 2023-07 >
    const yearMonth = $("#yearMonth");   // jQuery는 항상 바구니에 담아서 가져옴
    //    const yearMonth = document.querySelectorAll("#yearMonth"); //  DOM  서치는 해당하는 놈 바로 들고옴
    const btnLeft = $("#btnLeft");
    const btnRight = $("#btnRight");
    
    // 검색 년월 왼쪽 < 
    btnLeft.on("click", function () {
        let spanStr = yearMonth.html().split("-");  // - 으로 쪼개깅, split은 배열을 리턴
        let year = spanStr[0];

        let month = parseInt(spanStr[1]);
        month = month -1;
        if(month < 1){ //   0월은 없으니깡, 1월 아래는 12월
            month = 12;
            year = year -1;
        }
        if(month < 10){
            month = `0\${month}`;
        }
        updateDates(-1);
        yearMonth.html(`\${year}-\${month}`);
        // searchForm.submit();
    });
    
    // 검색 년월 오른쪽 >
    btnRight.on("click", function () {
        let spanStr = yearMonth.html().split("-");
        let year = parseInt(spanStr[0]);
        let month = parseInt(spanStr[1]);
        month = month +1;
        if(month > 12){
            month = 1;
            year = year +1;
        }
        if(month < 10){
            month = `0\${month}`;
        }
        updateDates(1);
        yearMonth.html(`\${year}-\${month}`);
        // searchForm.submit();
    });
    
 	// 페이지 번호 클릭시
	pagingArea.on("click", "a", function(event) {
		event.preventDefault();
		var pageNo = $(this).data("page");	// 페이지 번호가 넘어옴
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
});

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
function setYearMonth(){
    var dateInfo = new Date();
    var year = dateInfo.getFullYear();
    var month = dateInfo.getMonth() + 1; //monthIndex를 반환해주기 때문에 1을 더해준다.

    if(month < 10){
        month = `0\${month}`;
    }
    document.getElementById("yearMonth").innerHTML = `\${year}-\${month}`;
    updateDates(0);
}

// 시계
function setClock() {
	var dateInfo = new Date();
	var hour = modifyNumber(dateInfo.getHours());
	var min = modifyNumber(dateInfo.getMinutes());
	var sec = modifyNumber(dateInfo.getSeconds());
	var year = dateInfo.getFullYear();
	var month = dateInfo.getMonth() + 1; //monthIndex를 반환해주기 때문에 1을 더해준다.
	var date = dateInfo.getDate();
	document.getElementById("time").innerHTML = hour + ":" + min + ":" + sec;
	document.getElementById("date").innerHTML = year + "년 " + month + "월 " + date + "일";
}

// 시계 
function modifyNumber(time) {
	if (parseInt(time) < 10) {
		return "0" + time;
	} else
		return time;
}



</script>