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
#searchState, #searchStartDate, #searchEndDate{
    border: 1px solid #ced4da;
}

.info-box {
    height: 100px;
}

.info-box .info-box-number {
    font-size: large;
}
</style>

<section class="content py-3">
    <div class="container-fluid">

        
        <!-- 근태조정현황-->
        <div class="row">
            <div class="col">
                
                <div class="card card-primary card-outline">
                    <div class="card-header">
                        <!-- <div class="row"> -->
                            <div class="row">
                                <div class="col">
                                    <!-- <span>근태조정 Summary</span> -->
                                    <h3 class="card-title">근태조정 Summary</h3>
                                </div>
                            </div>

                        <!-- </div> -->
                        

                        <!-- <div class="row"> -->
                            <div class="d-flex justify-content-end" >
                                <form class="input-group input-group-sm" id="searchForm">
                                    <span>기간&nbsp;</span>
                                    <input type="date" pattern="yyyy-MM-dd" name="searchStartDate" id="searchStartDate" value="${searchStartDate}">
                                    <span>&nbsp; ~ &nbsp;</span>
                                    <input type="date" pattern="yyyy-MM-dd" name="searchEndDate" id="searchEndDate" value="${searchEndDate}">
                
                                    <span>&nbsp; &nbsp;검색항목 &nbsp;</span>
                                    <select class="" id="searchState" name="searchState">
                                        <option value="전체" selected="selected">전체</option>
                                        <option value="승인" <c:if test="${searchState == '승인' }">
                                            <c:out value="selected" />
                                            </c:if>>승인
                                        </option>
                                        <option value="승인대기" <c:if test="${searchState == '승인대기' }">
                                            <c:out value="selected" />
                                            </c:if>>승인대기
                                        </option>
                                        <option value="반려" <c:if test="${searchState == '반려' }">
                                            <c:out value="selected" />
                                            </c:if>>반려
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
                            <div class="col-md-3 col-sm-6 col-12">
                                <div class="info-box bg-primary">
                                    <span class="info-box-icon"><i class="far fa-bookmark"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">전체</span>
                                        <span class="info-box-number" id="totalRecode">0건</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3 col-sm-6 col-12">
                                <div class="info-box bg-success">
                                    <span class="info-box-icon"><i class="far fa-thumbs-up"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">승인</span>
                                        <span class="info-box-number">0건</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3 col-sm-6 col-12">
                                <div class="info-box bg-warning">
                                    <span class="info-box-icon"><ion-icon name="ellipsis-horizontal-circle-outline"></ion-icon></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">승인대기</span>
                                        <span class="info-box-number">0건</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3 col-sm-6 col-12">
                                <div class="info-box bg-danger">
                                    <span class="info-box-icon"><ion-icon name="ban-outline"></ion-icon></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">반려</span>
                                        <span class="info-box-number">0건</span>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>

            </div>
        </div>       

        <!-- 근태조정신청내역 -->
        <div class="row">
            <div class="col">

                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">근태조정신청내역</h3>
                    </div>
                    <div class="card-body"  style="overflow-Y: scroll; height: 650px;display: block; padding: 0%">
                        <table class="table table-striped projects">
                            <thead>
                                <tr>
                                    <th style="text-align: center;">신청일자</th>
                                    <th style="text-align: center;">조정일자</th>
                                    <th style="text-align: center;">출근시간</th>
                                    <th style="text-align: center;">퇴근시간</th>
                                    <th style="text-align: center;">근무시간</th>
                                    <th style="text-align: center;">승인여부</th>
                                    <th style="text-align: center;">상세보기</th>
                                </tr>
                            </thead>
                            <tbody id="workAdjList">
                                <!-- workAdjList -->
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- 페이지번호 -->
                    <div class="row">
                        <div class="card-footer clearfix" id="pagingArea">
                            <ul class="pagination pagination-sm m-0 float-right">
                                <!-- ${pagingVO.pagingHTML } -->
                            </ul>
                        </div>
                    </div>

                </div>

            </div>
        </div>

    </div>
</section>


<script src="/resources/bootstrap/plugins/jquery/jquery.min.js"></script>

<script>

$(function(){

    var searchStartDate = $("#searchStartDate").val();
    var searchEndDate = $("#searchEndDate").val();

    console.log("searchStartDate", searchStartDate);
    console.log("searchEndDate", searchEndDate);    

    var searchForm = $("#searchForm");
    var pagingArea = $("#pagingArea");
    
    var obj = {
        page: 1,
        searchStartDate: searchStartDate,
        searchEndDate: searchEndDate,
        searchState: '전체'
    }
    
    workAdjList(obj, addList);

    // 페이지 번호 클릭시
    pagingArea.on("click", "a", function(event) {
        event.preventDefault();
        var pageNo = $(this).data("page"); // 페이지 번호가 넘어옴
        obj.page=pageNo
        workAdjList(obj,addList)
    });

});


// 근태조정내역
function workAdjList(data, callback){
    $.ajax({
       url: `/everyware/workAdj/getWorkAdjList`,
       type: "post",
       contentType: 'application/json; charset=utf-8',
        dataType: "json",
        data: JSON.stringify(data),
        beforeSend: function (xhr) {
            // xhr.setRequestHeader("${_headerName}","${token}");
            xhr.setRequestHeader(headerName, token);
        },
        success: function (res) {
            if (typeof callback != "undefined") {
                callback(res)
            }
        },
        error: function (xhr) {
            alert("Error: " + xhr.status);
        }
    });
}


function addList(res) {
    console.log("res", res);
    $("#workAdjList").html("");
	$("#pagingArea").html("");

    var dataList = res.dataList;
	var workAdjListStr = "";
	var pagingAreaStr = res.workAdj.pagingHTML;
    console.log("pagingAreaStr", pagingAreaStr);

    if(dataList.length == 0){
        workAdjListStr += `<tr><td colspan='7'>조회하신 기록이 존재하지 않습니다.</td></tr>`;
    } else {
        workAdjListStr +=
        '신청일자,조정일자,출근시간,퇴근시간,근무시간,승인여부'
        `<tr>
            <th style="text-align: center;">신청일자</th>
            <th style="text-align: center;">조정일자</th>
            <th style="text-align: center;">\${dataList[i].waBgngDt}</th>
            <th style="text-align: center;">\${dataList[i].waEndDt}</th>
            <th style="text-align: center;">근무시간</th>
            <th style="text-align: center;">승인여부</th>
            <th style="text-align: center;">승인여부</th>
            <th style="text-align: center;">
                <button type="button" class="btn btn-tool bg-info btnWorkAdjForm">
                    <i class="fas fa-pencil-alt"></i>Edit
                </button>
            </th>
        </tr>`;
    }
        



    // 목록 
	$("#workAdjList").html(workAdjListStr);
	$("#pagingArea").html(pagingAreaStr);


}

</script>