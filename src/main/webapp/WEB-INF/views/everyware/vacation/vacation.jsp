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
.vacationText {
    margin-top: 20px;
    margin-bottom: 10px;
}

.info-box {
    height: 100px;
}

</style>

<section class="content">
    <div class="container-fluid">
        
        <!-- 검색폼-->
        <div class="row">
            <!-- <div class="col" style="text-align: center;">
                <form class="input-group input-group-sm" id="searchForm">
                    
                    <div class="year-picker">
                        <select id="year">
                            <option value=""></option>
                        </select>
                        <div>년도</div>
                    </div>
                    
                    <sec:csrfInput/>
                </form>
            </div> -->
        </div>
        
        <div class="row vacationText">
            <div class="col">
                <h3>휴가관리</h3>
                <div style="color: gray;">연도별 휴가사용내역을 확인합니다.</div>
            </div>

            <div class="col">
                <form class="input-group input-group-sm" id="searchForm">
        
                    <div class="input-group year-picker">
                        <select id="year">
                            <option value=""></option>
                        </select>
                        <div>년도</div>
                    </div>
        
                    <sec:csrfInput />
                </form>
            </div>
            
        </div>

        <!-- 휴가현황 Type1-->
        <div class="row">
            <div class="col">
                <div class="card">

                    <div class="card-header">
                        <h3 class="card-title">휴가 Summary</h3>
                    </div>
                    
                    <!-- Vacation Summary -->
                    <div class="card-body" style="display: block;">
                        <div class="row">
                            <div class="col-md-4 col-sm-6 col-12">
                                <div class="info-box bg-primary">
                                    <span class="info-box-icon"><i class="far fa-bookmark"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">총 휴가일 수</span>
                                        <span class="info-box-number" id="totalRecode">0건</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4 col-sm-6 col-12">
                                <div class="info-box bg-success">
                                    <span class="info-box-icon"><i class="far fa-calendar-alt"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">휴가 사용일 수</span>
                                        <span class="info-box-number">0건</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-4 col-sm-6 col-12">
                                <div class="info-box bg-warning">
                                    <span class="info-box-icon"><i class="far fa-star"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">휴가 잔여일 수</span>
                                        <span class="info-box-number">0건</span>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>

                </div>
            </div>
        </div>       

        <!-- 근태조정신청내역 Type1-->
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">휴가신청내역</h3>
                    </div>
                    <div class="card-body">
                        <table class="table table">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">승인여부</th>
                                    <th style="text-align: left;">신청일자</th>
                                    <th style="text-align: left;">휴가구분</th>
                                    <th style="text-align: left;">시작일자-종료일자</th>
                                    <th style="text-align: left;">소요시간</th>
                                    <th style="text-align: left;">차감일수</th>
                                    <!-- 상세보기 -->
                                    <th style="width: 10px"></th>
                                </tr>
                            </thead>
                            <tbody id="vacationList">
                                <!-- vacationList -->
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- 페이지번호 -->
                    <div class="card-footer clearfix" id="pagingArea">
                        <ul class="pagination pagination-sm m-0 float-right">
                            <!-- ${pagingVO.pagingHTML } -->
                        </ul>
                    </div>

                </div>
            </div>
        </div>

    </div>
</section>

<script>
$(function () {
    var yearSelect = $("#year");
    var currentYear = new Date().getFullYear();


    // 
    for (var i = currentYear; i >= 2000; i--) {
        var option = $("<option></option>");
        option.val(i);
        option.text(i);

        if (i === currentYear) {
            option.prop("selected", true);
        }

        yearSelect.append(option);
    }
    
});


</script>