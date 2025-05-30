<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="date" class="date"></div>
<div id="time" class="time"></div>
<div id="today">

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
                    <div id="date" class="date"></div>
                    <div id="time" class="time"></div>
                    <div id="today"></div>

                    <div class="today">
                        <c:set value="${workList }" var="work" />
                        <c:choose>
                            <c:when test="${empty work }">
                                <table>
                                    <tr>
                                        <td>
                                            <button type="button" class="btn btn-block bg-gradient-primary"
                                                id="btnWorkBgngDt">출근</button>
                                        </td>
                                        <td>00:00:00</td>
                                        <td>
                                            <button type="button" class="btn btn-block bg-gradient-secondary"
                                                id="btnWorkEndDt">퇴근</button>
                                        </td>
                                        <td>00:00:00</td>
                                    </tr>
                                </table>
                            </c:when>

                            <c:otherwise>
                                <c:forEach items="${work }" var="work">
                                    <c:set var="workDt" value="${work.workDt}" />
                                    <c:set var="workBgngDt" value="${work.workBgngDt}" />
                                    <c:set var="workEndDt" value="${work.workEndDt}" />
                                    <table>
                                        <tr>
                                            <td>
                                                <button type="button" class="btn btn-block bg-gradient-primary"
                                                    id="btnWorkBgngDt">출근</button>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${workBgngDt}" pattern="HH:mm:ss" type="date" />
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-block bg-gradient-secondary"
                                                    id="btnWorkEndDt">퇴근</button>
                                            </td>
                                            <td>
                                                <c:if test="${workEndDt eq null}">
                                                    00:00:00
                                                </c:if>
                                                <c:if test="${workEndDt ne null}">
                                                    <fmt:formatDate value="${workEndDt}" pattern="HH:mm:ss"
                                                        type="date" />
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


<script>
//DomContentLoaded  이벤트
$(function () {
    setClock();
    setInterval(setClock, 1000); //1초마다 setClock 함수 실행
    setYearMonth();

    var btnWorkBgngDt = $("#btnWorkBgngDt");    // 출근
    var btnWorkEndDt = $("#btnWorkEndDt");     // 퇴근

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
            }
        });
	});
    
});

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