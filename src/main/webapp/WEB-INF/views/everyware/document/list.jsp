<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta id="_csrf" name="_csrf" content="${_csrf.token}" />
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
    <title>Insert title here</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.bootstrap4.min.css">
    <link rel="stylesheet" href="../../../../resources/bootstrap/dist/css/adminlte.min.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
    <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />


    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script> -->
    <style>
        .form-horizontal label {
            width: 75px;
            top: 5px;
            position: relative;
            text-align: right;
            margin-right: 20px;
        }

        .form-horizontal>* {
            margin: 10px 20px;
        }

        .search-btn {
            width: 250px;
        }

        .form-daterange {
            position: relative;
        }

        .form-daterange-info {
            position: absolute;
            bottom: 36px;
            font-size: 0.8em;
            color: gray;
        }

        #document-table_length {
            float: right;
            height: 24px;
        }

        .border-bottom {
            /* margin-bottom: 20px; */
        }

        .write-btn {
            height: 50px;
            line-height: 36px;
        }

        .submenu-body {
            margin-bottom: 1px;
        }

        .custom-select-sm{
            float: right;
            width: 75px !important;
            height: 28px;
            top: 10px;
            position: relative;
            padding: 0px 10px;
            font-size: 15px;
        }
        th, td { 
            white-space: nowrap; 
            padding: 8px !important;
        }
        tr { height: 35px; }

        #document-table tr td:nth-child(2)
        ,#recently-table tr td:nth-child(2)
        {
            cursor: pointer;
        }
        #document-table tr td:nth-child(2):hover
        ,#recently-table tr td:nth-child(2):hover
        {
            color: #007bff;
        }

        .doc-list {
            display: none;
        }

        /* 문서 본문 영역 */
        .doc-card-header{
            padding-bottom: 5px;
        }

        .doc-header {
            background-color: rgb(240, 240, 240);
            text-align: center;
        }

        .doc-subtitle{
            font-size: 14px;
            color: gray;
        }
        .approval-line-table {
            width: auto;
            text-align: center;
            table-layout: fixed;
        }

        .approval-sign-td {
            position: relative;
            border: 1px solid #dee2e6;
        }

        .approval-line-table td {
            padding: 3px !important;
            width: 130px !important;
            min-width: 130px !important;
            max-width: 130px !important;
            border: 1px solid #dee2e6;
        }

        .approval-line-jbgd-tr {
            background-color: rgb(240, 240, 240);
            border: 1px solid #dee2e6;
        }

        .approval-line-sign-tr {
            height: 120px;
            border: 1px solid #dee2e6;
        }

        .approval-type {
            border: 1px solid rgb(141, 141, 141);
            position: absolute;
            background-color: white;
            left: 3px;
            width: 45px;
            font-size: 13px;
        }

        .approval-line-wrap {
            padding-left: 0px;
        }

        .document-content-wrap {
            padding: 0px !important;
        }

        .doc-content {
            display: none;
        }

        .doc-tmpltNm{
            text-align: center;
        }

        .card-tools-left{
            margin-left: -0.625rem;
        }
        .doc-content .card-tools .btn{
            font-size: 23px;
            padding: 1px 8px !important;
        }

        .doc-approval-btn
        ,.doc-agree-btn{
            position: relative;
            top: 40px;
        }

        /* 결재home 영역 */
        .approval-home {
            display: block;
        }
        .number-circle{
            object-fit: cover;
            object-position: center;
            width:68px;
            height:68px;
            background-color: white;
            display: inline-block;
            font-size: 45px;
            text-align: center;
            line-height: 62px;
            color: #007bff;
            cursor: pointer;
        }
        .number-circle:hover{
            border: 1px solid #007bff !important;  
        }
        .number-circle-wrap{
            top: 50px !important;
            margin-left: -35px !important;
        }
        .current-state-title{
            height: 84px !important;
        }
        .current-state-title h5{
            font-weight: 600 !important;
        }
        .current-state-footer{
            padding-top: 40px !important;
            color: #646464;
        }
        .home-subtitle{
            color: gray;
        }
        .template-btn{
            cursor: pointer;
        }
    </style>
</head>

<body>
    <div class="content-container">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>전자결재</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">전자결재</li>
                            <li class="breadcrumb-item active">문서함</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <!-- subMenu -->
                    <div class="col-md-2">
                        <a href="#" data-href="/everyware/writeTest"
                            class="btn btn-primary btn-block mb-2 write-btn" data-toggle="modal"
                            data-target="#template-modal">새 문서 작성</a>
                        <a href="#" class="btn btn-warning btn-block mb-2 home-btn">결재 HOME</a>
                        <div class="card">
                            <div class="card card-light submenu-body">
                                <div class="card-header">
                                    <h3 class="card-title">결재문서함</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body p-0" style="display: block;">
                                    <ul class="nav nav-pills flex-column">
                                        <li class="nav-item" onclick="selectSubmenu(this, pending, 'pending')">
                                            <a href="#" class="nav-link">
                                                결재 대기
                                            </a>
                                        </li>
                                        <li class="nav-item scheduled"
                                            onclick="selectSubmenu(this, scheduled, 'scheduled')">
                                            <a href="#" class="nav-link">
                                                결재 예정
                                            </a>
                                        </li>
                                        <li class="nav-item completed"
                                            onclick="selectSubmenu(this, completed, 'completed')">
                                            <a href="#" class="nav-link">
                                                결재 완료
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="card card-light submenu-body">
                                <div class="card-header">
                                    <h3 class="card-title">수신문서함</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body p-0" style="display: block;">
                                    <ul class="nav nav-pills flex-column">
                                        <li class="nav-item department"
                                            onclick="selectSubmenu(this, department, 'department')">
                                            <a href="#" class="nav-link">
                                                부서 수신
                                            </a>
                                        </li>
                                        <li class="nav-item reference"
                                            onclick="selectSubmenu(this, reference, 'reference')">
                                            <a href="#" class="nav-link">
                                                참조/열람
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="card card-light submenu-body">
                                <div class="card-header">
                                    <h3 class="card-title">개인문서함</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body p-0" style="display: block;">
                                    <ul class="nav nav-pills flex-column">
                                        <li class="nav-item drafts" onclick="selectSubmenu(this, drafts, 'drafts')">
                                            <a href="#" class="nav-link">
                                                내 기안
                                            </a>
                                        </li>
                                        <li class="nav-item temp" onclick="selectSubmenu(this, temp, 'temp')">
                                            <a href="#" class="nav-link">
                                                임시저장
                                            </a>
                                        </li>
                                        <li class="nav-item scraps" onclick="selectSubmenu(this, scraps, 'scraps')">
                                            <a href="#" class="nav-link">
                                                스크랩
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="card card-light submenu-body">
                                <div class="card-header">
                                    <h3 class="card-title">설정</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body p-0" style="display: block;">
                                    <ul class="nav nav-pills flex-column">
                                        <li class="nav-item sign" onclick="selectSubmenu(this, sign, 'sign')">
                                            <a href="#" class="nav-link">
                                                서명관리
                                            </a>
                                        </li>
                                        <li class="nav-item proxy" onclick="selectSubmenu(this, proxy, 'proxy')">
                                            <a href="/everyware/proxyTest" class="nav-link">
                                                대결관리
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- /.subMenu -->

                    <!-- approval Home -->
                    <div class="col-md-10 approval-home">
                        <div class="card">
                            <div class="card-header border-0 pt-4 pb-0">
                                <h3>결재HOME</h3>
                            </div>

                            <div class="card-body ">
                                <div>
                                    <div class="home-subtitle">최근 사용한 양식</div>
                                    <div class="row">
                                    	<c:forEach items="${tmpltList }" var="item">
                                        <div class="col-md-2 col-sm-6 col-12">
                                            <div class="info-box template-btn" tmpltCd="${item.tmpltCd}">
                                                <span class="info-box-icon bg-${item.backgroundColor }">
                                                ${item.icon }
                                                </span>
                                                <div class="info-box-content">
                                                	<span class="${item.tmpltCd }">${item.tmpltNm }</span>
                                                </div>
                                            </div>
                                        </div>
                                    	</c:forEach>
                                    </div>
                                </div>
                                <!-- ./양식 -->
                
                                <div>
                                <div class="home-subtitle">결재현황</div>
                                    <div class="row">
                                        
                                        <div class="col-md-4">
                                        <div class="card card-widget  widget-user">
                                            <div class="widget-user-header current-state-title">
                                            <!-- <h3 class="widget-user-username">Alexander Pierce</h3> -->
                                            <h5 class="widget-user-desc">진행 중인 문서</h5>
                                            </div>
                                            <div class="widget-user-image number-circle-wrap">
                                            <span class="rounded-circle number-circle border">${fn:length(inProcessList)}</span>
                                            </div>
                                            <div class="card-footer current-state-footer ">
                                            <div class="row">
                                                <div class="col-sm-6 border-right">
                                                <div class="description-block">
                                                    <h5 class="description-header">승인완료</h5>
                                                    <span class="description-text">${confirmedCnt}</span>
                                                </div>
                                                </div>
                    
                                                <div class="col-sm-6">
                                                <div class="description-block">
                                                    <h5 class="description-header">반려완료</h5>
                                                    <span class="description-text">${rejectedCnt}</span>
                                                </div>
                                                </div>
                    
                                            </div>
                                            </div>
                                        </div>
                                        </div>
                                        <!-- ./카드 -->
                                        
                                        <div class="col-md-4">
                                        <div class="card card-widget  widget-user">
                                            <div class="widget-user-header current-state-title">
                                            <!-- <h3 class="widget-user-username">Alexander Pierce</h3> -->
                                            <h5 class="widget-user-desc">결재 대기 문서</h5>
                                            </div>
                                            <div class="widget-user-image number-circle-wrap">
                                            <span class="rounded-circle number-circle border">${fn:length(pendingList)}</span>
                                            </div>
                                            <div class="card-footer current-state-footer ">
                                            <div class="row">
                                                <div class="col-sm-6 border-right">
                                                <div class="description-block">
                                                    <h5 class="description-header">예정</h5>
                                                    <span class="description-text">${scheduledCnt}</span>
                                                </div>
                                                </div>
                    
                                                <div class="col-sm-6">
                                                <div class="description-block">
                                                    <h5 class="description-header">완료</h5>
                                                    <span class="description-text">${completedCnt}</span>
                                                </div>
                                                </div>
                                            </div>
                                            </div>
                                        </div>
                                        </div>
                                        <!-- ./카드 -->
                                        
                                        <div class="col-md-4">
                                        <div class="card card-widget  widget-user">
                                            <div class="widget-user-header current-state-title">
                                            <!-- <h3 class="widget-user-username">Alexander Pierce</h3> -->
                                            <h5 class="widget-user-desc">읽지 않은 문서</h5>
                                            </div>
                                            <div class="widget-user-image number-circle-wrap">
                                            <span class="rounded-circle number-circle border">${fn:length(notReadList)}</span>
                                            </div>
                                            <div class="card-footer current-state-footer ">
                                            <div class="row">
                                                <div class="col-sm-6 border-right">
                                                <div class="description-block">
                                                    <h5 class="description-header">열람</h5>
                                                    <span class="description-text">${notReadAsViewerCnt}</span>
                                                </div>
                                                </div>
                    
                                                <div class="col-sm-6">
                                                <div class="description-block">
                                                    <h5 class="description-header">참조</h5>
                                                    <span class="description-text">${notReadAsReferencerCnt}</span>
                                                </div>
                                                </div>
                    
                                            </div>
                                            </div>
                                        </div>
                                        </div>
                                        <!-- ./카드 -->
                                    
                    
                                    </div>
                                </div>
                                <!-- ./결재현황 -->
                
                                <div>
                                <div class="home-subtitle">최근 부서수신 문서(5건)</div>
                                <!-- 테이블 영역...... -->
                                    <table id="recently-table" style="width:100%"
                                    class="table table-bordered table-hover dataTable dtr-inline">
                                        <thead>
                                            <tr>
                                                <th>aprvSn</th>
                                                <th>문서번호</th>
                                                <th>제목</th>
                                                <th>작성자</th>
                                                <th>기안일자</th>
                                                <th>완료일자</th>
                                                <!-- <th>결재선</th> -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${recentList }" var="item">
                                            <tr>
                                            	<td>${item.aprvSn }</td>
                                            	<td>${item.aprvNo }</td>
                                            	<td>${item.aprvTtl }</td>
                                            	<td>${item.empName }</td>
                                            	<td>${item.atrzDmndDt }</td>
                                            	<td>${item.atrzCmptnDt }</td>
                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- ./approval Home -->

                    <!-- document List -->
                    <div class="col-md-10 doc-list">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title doc-list-title"></h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div class="border-bottom">
                                    <form class="form-horizontal">
                                        <div class="row">
                                            <div class="col">
                                                <div class="form-group row">
                                                    <label>기안일자</label>
                                                    <div class="col">
                                                        <div class="input-group form-daterange">
                                                            <div class="input-group-prepend">
                                                                <span class="input-group-text">
                                                                    <i class="far fa-calendar-alt"></i>
                                                                </span>
                                                            </div>
                                                            <input type="text" class="form-control float-right"
                                                                id="searchDate">
                                                        </div>
                                                        <span class="form-daterange-info">기본설정은 최근 1년입니다.</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /.input group -->
                                            <div class="col">
                                                <div class="form-group row">
                                                    <label>종류</label>
                                                    <div class="col">
                                                        <select class="form-control select2"
                                                            style="width: 100%;">
                                                            <option selected="selected" value="">전체</option>
                                                            <option value="">휴가</option>
                                                            <option value="">근태</option>
                                                            <option value="">등등..</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col">
                                                <div class="form-group row">
                                                    <label>결재상태</label>
                                                    <div class="col">
                                                        <select class="form-control select2"
                                                            style="width: 100%;">
                                                            <option selected="selected" value="">전체</option>
                                                            <option value="">진행중</option>
                                                            <option value="">결재</option>
                                                            <option value="">반려</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="form-group row">
                                                    <label>검색</label>
                                                    <div class="col-md-3">
                                                        <select class="form-control select2"
                                                            style="width: 100%;">
                                                            <option selected="selected" value="">제목</option>
                                                            <option value="">작성자</option>
                                                        </select>
                                                    </div>
                                                    <div class="col">
                                                        <input type="text" class="form-control" id="searchWord">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col text-center">
                                                <input class="btn btn-primary search-btn" type="submit"
                                                    value="검색">
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="row">
                                    <div class="col-xl-12">
                                        <!-- <div id="document-table">
                                        <div id="pagination" class="tui-pagination"></div> -->
                                        <table id="document-table" style="width:100%"
                                    class="table table-bordered table-hover dataTable dtr-inline">
                                            <thead>
                                                <tr>
                                                    <th>aprvSn</th>
                                                    <th>문서번호</th>
                                                    <th>제목</th>
                                                    <th>작성자</th>
                                                    <th>기안일자</th>
                                                    <th>완료일자</th>
                                                    <!-- <th>결재선</th> -->
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- ./document List -->


                        <!-- document -->
                        <div class="col-md-10 doc-content">
                            <div class="card">
                                <div class="card-header doc-card-header">
                                    <!-- <h1 class="doc-tmpltNm"></h1> -->
                                    <div class="card-title">
                                        <div class="btn-group card-tools-left" role="group" aria-label="approval-btns"></div>
                                        <!-- <button type="button" class="btn btn-light doc-approval-btn">결재</button>
                                        <button type="button" class="btn btn-light doc-agree-btn">합의</button>
                                        <button type="button" class="btn btn-light doc-modify-btn">수정</button>
                                        <button type="button" class="btn btn-light doc-ret-btn">회수</button>
                                        <button type="button" class="btn btn-light doc-red-btn">재기안</button> -->
                                    </div>
                                    <div class="card-tools card-tools-right">
                                        <!-- <button type="button" class="btn btn-light doc-scrap-btn"><ion-icon name="share-social-outline"></ion-icon></button> -->
                                        <button type="button" class="btn btn-light doc-scrap-btn"><ion-icon name="star-outline"></ion-icon></button>
                                        <button type="button" class="btn btn-light doc-print-btn"><ion-icon name="print-outline"></ion-icon></button>
                                        <button type="button" class="btn btn-light doc-list-btn"><ion-icon name="list-outline"></ion-icon></button>
                                    </div>
                                </div>
                                <div class="card-body p-0">
                                    <div class="mailbox-controls">
                                        <span class="doc-subtitle">기본정보</span>
                                        <table class="table table-bordered mb-0">
                                            <colgroup>
                                                <col style="width: 20%">
                                                <col style="width: 30%">
                                                <col style="width: 20%">
                                                <col style="width: 30%">
                                            </colgroup>
                                            <tr>
                                                <td class="doc-header">문서종류</td>
                                                <td class="left-cell doc-tmpltCd"></td>
                                                <td class="doc-header">문서번호</td>
                                                <td class="left-cell doc-aprvNo"></td>
                                            </tr>
                                            <tr>
                                                <td class="doc-header">기안부서</td>
                                                <td class="left-cell doc-deptNm"></td>
                                                <td class="doc-header">기안자</td>
                                                <td class="left-cell doc-empName"></td>
                                            </tr>
                                            <tr>
                                                <td class="doc-header">기안일자</td>
                                                <td class="left-cell doc-atrzDmndDt">
                                                    
                                                </td>
                                                <td class="doc-header">완료일자</td>
                                                <td class="left-cell doc-atrzCmptnDt">
                                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="doc-header">수신처</td>
                                                <td colspan="3" class="left-cell doc-destination">
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="mailbox-controls">
                                        <span class="doc-subtitle">결재선(결재의견 버튼)</span>
                                        <div class="col-sm-4 approval-line-wrap">
                                            <table class="table approval-line-table mb-0">
                                                <tbody>
                                                    <tr class="approval-line-jbgd-tr"></tr>
                                                    <tr class="approval-line-sign-tr"></tr>
                                                    <tr class="approval-line-name-tr"></tr>
                                                    <tr class="approval-line-date-tr"></tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="mailbox-read-message p-1">
                                        <span class="doc-subtitle">내용</span>
                                        <table class="table table-bordered mb-0">
                                            <colgroup>
                                                <col style="width:20%">
                                                <col style="width:80%">
                                            </colgroup>
                                            <tr>
                                                <td class="doc-header">제목</td>
                                                <td class="left-cell doc-aprvTtl"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="content">
                                                    <div class="doc-aprvCn"></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="doc-header">첨부파일</td>
                                                <td class="left-cell">
                                                    <a href="#"></a>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- ./document -->
                    </div>
                </div>
            </div>
        </section>
    </div>
    <%@ include file="../template/templateModal.jsp" %>
    <%@ include file="./approvalProcessModal.jsp" %>
    <%@ include file="./agreeProcessModal.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js" defer></script>
    <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js" defer></script>
    <script src="https://cdn.datatables.net/1.13.5/js/dataTables.bootstrap4.min.js" defer></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js" defer></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap4.min.js" defer></script>
    <script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js" defer></script>
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
    <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

    <script>
        var currentEmpId;
        // var  document = '${document}';
        // console.log(document);

        const pending = '';
        const scheduled = '';
        const completed = '';
        const department = '';
        const reference = '';
        const drafts = '';
        const temp = '';
        const scraps = '';

        var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
        var csrfToken = $('meta[name="_csrf"]').attr('content');

        var aprvSn;
        var approvers = [];
        var viewers = [];

        const docTmpltNm = $('.doc-tmpltNm');
        const docTmpltCd = $('.doc-tmpltCd');
        const docAprvNo = $('.doc-aprvNo');
        const docDeptNm = $('.doc-deptNm');
        const docEmpName = $('.doc-empName');
        const docAtrzDmndDt = $('.doc-atrzDmndDt');
        const docAtrzCmptnDt = $('.doc-aprzCmptnDt');
        const docDestination = $('.doc-destination');
        const approvalLineJbgdTr = $('.approval-line-jbgd-tr');
        const approvalLineSignTr = $('.approval-line-sign-tr');
        const approvalLineNameTr = $('.approval-line-name-tr');
        const approvalLineDateTr = $('.approval-line-date-tr');
        const docAprvTtl = $('.doc-aprvTtl');
        const docAprvCn = $('.doc-aprvCn');
        // 첨부파일 추가

        $(function () {
            var approvalHome = $('.approval-home');
            var docList = $('.doc-list');
            var docContent = $('.doc-content');
            var leftTools = $('.card-tools-left');
            var rightTools = $('.card-tools-right');
            var docListTitle = $('.doc-list-title');

            var select2 = $('.select2')

            
            homeActive = function(){
                $(approvalHome).css('display', 'block');
                $(docList).css('display', 'none');
                $(docContent).css('display', 'none');
            }
            
            listActive = function(submenu){
                $(approvalHome).css('display', 'none');
                $(docList).css('display', 'block');
                $(docContent).css('display', 'none');

                if(submenu){
                    var submenuName = $(submenu).find('a').text();
                    $(docListTitle).html(submenuName);
                }
            }
            
            docActive = function(){
                $(approvalHome).css('display', 'none');
                $(docList).css('display', 'none');
                $(docContent).css('display', 'block');
            }



            $.datepicker.setDefaults($.datepicker.regional['ko']);
            $('#searchDate').daterangepicker({
                startDate: moment().subtract(365, 'days'),
                endDate: moment(),
                locale: {
                    format: "YYYY-MM-DD",
                    separator: "  ~  ",
                    applyLabel: "확인",
                    cancelLabel: "취소",
                    fromLabel: "From",
                    toLabel: "To",
                    customRangeLabel: "직접 선택",
                    yearSuffix: "년",
                    daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
                    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                    firstDay: 0
                },
                opens: "left",
                alwaysShowCalendars: true,
                ranges: {
                    '오늘': [moment(), moment()],
                    '어제': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    '이번달': [moment().startOf('month'), moment().endOf('month')],
                    '올해': [moment().startOf('year'), moment().endOf('year')]
                }
            })

            // $('input[name="datefilter"]').on('apply.daterangepicker', function(ev, picker) {
            //     $(this).val(picker.startDate.format('MM/DD/YYYY') + ' - ' + picker.endDate.format('MM/DD/YYYY'));
            // });

            // $('input[name="datefilter"]').on('cancel.daterangepicker', function(ev, picker) {
            //     $(this).val('');
            // });


            /* Data Tables */
            var tableOptions = {
                destroy: true,
                responsive: true,
                lengthChange: true,
                autoWidth: true,
                searching: false,
                columnDefs: [
                    {
                        searchable: false,
                        orderable: false,
                        visible: false,
                        targets: 0
                    }
                    , {
                        targets: 1,
                        className: 'dt-head-body-center'
                    }
                    , {
                        targets: 3,
                        className: 'dt-head-body-center'
                    }
                    , {
                        targets: 4,
                        className: 'dt-head-body-center'
                    }
                    , {
                        targets: 5,
                        className: 'dt-head-body-center'
                    }
                ],
                order: [[0, 'desc']],
                rowHeight: 20,
                language: {
                    info: 'total: _TOTAL_',
                    // search: '검색:',
                    lengthMenu: '_MENU_',
                    emptyTable: "목록이 존재하지 않습니다.",
                    infoEmpty: ""
                },
                dom: "<'row'<'col col-info'i><'col col-length-menu'l>>" + 'rtp',
                pagingType: "numbers"
            };

            var recentlyTableOptions = {
                destroy: true,
                // responsive: true,
                // lengthChange: false,
                autoWidth: true,
                searching: false,
                paging: false,
                columnDefs: [
                        {
                            searchable: false,
                            orderable: false,
                            visible: false,
                            targets: 0
                    }
                ],
                order: [[0, 'desc']],
                rowHeight: 20,
                language: {
                    info: 'total: _TOTAL_',
                    // search: '검색:',
                    // lengthMenu: '_MENU_',
                    emptyTable: "목록이 존재하지 않습니다.",
                    infoEmpty: ""
                },
                // dom: "<'row'<'col col-info'i><'col col-length-menu'l>>" + 'rtp',
                // pagingType: "numbers"
            };

            var table = $('#document-table').DataTable(tableOptions);
            var recentlyTable = $('#recently-table').DataTable(recentlyTableOptions);

            $('.template-tree-return-btn').on('click', function () {
                templateModalReturn(selectTemplate);
            })

            selectTemplate = function (data) {
                if (data.type == 'template') {
                    location.href = '/everyware/approval/new/' + data.id;
                    return true;
                }
                return false;
            }

            // 문서 리스트 영역
            var data = []
            selectSubmenu = function (fthis, submenu, submenuStr) {
                
                var dmndStartDate = $('#searchDate').data('daterangepicker').startDate.format('YYYY-MM-DD');
                var dmndEndDate = $('#searchDate').data('daterangepicker').endDate.format('YYYY-MM-DD');
                
                var doc = {
                    dmndStartDate,
                    dmndEndDate
                }
                
                $.ajax({
                    url: '/everyware/documents/' + submenuStr,
                    method: 'POST',
                    contentType : "application/json; charset=utf-8",
                    dataType : 'text',
                    data: JSON.stringify(doc),
                    beforeSend : function(xhr){
                        xhr.setRequestHeader(csrfHeader,csrfToken);
                    },
                    success: function(rslt){
                        data = rslt;
                        $('#document-table').DataTable().destroy();
                        $('#document-table tbody').html(rslt);
                        table = $('#document-table').DataTable(tableOptions);
                    }
                })
                    
                listActive(fthis);
            }

            $(document).on('click', '#document-table tbody tr td:nth-child(2)', function () {
                var row = $(this).closest('tr');
                var aprvSn = table.row( row ).data()[0];
                getDocument(aprvSn);
            });

            $(document).on('click', '#recently-table tbody tr td:nth-child(2)', function () {
                var row = $(this).closest('tr');
                var aprvSn = table.row( row ).data()[0];
                getDocument(aprvSn);
            });




            $('.search-btn').on('click', function () {
                alert($('#searchDate').val());
            })


            // home 영역
            $('.home-btn').on('click', function(){
                location.reload();
            })

            $('.template-btn').on('click', function(){
                var tmpltCd = $(this).attr('tmpltCd');
                location.href = '/everyware/approval/new/' + tmpltCd;
            })




            // 문서 영역
            documentRender = function (docData) {
                leftTools.empty();
                $(rightTools).find('.doc-share-btn').remove();
                console.log(docData);
                aprvSn = docData.aprvSn;
                approvers = docData.approvalLine;
                viewers = docData.viewers;
                currentEmpId = docData.currentEmpId;

                var config = docData.config;
                var permission = docData.myPermission;
                console.log(permission);

                // 확인하고 수정하기
                // 현재 수정 가능자일 때 
                if(docData.empId == docData.currentEmpId && 
                ((config.modifyTime == 'beforeFirst' && docData.prgrsSttsCd == 3) || 
                (config.modifyTime == 'beforeFinal' && (docData.prgrsSttsCd  == 3 || docData.prgrsSttsCd  == 4)))){
                    var btn = document.createElement('button');
                    $(btn).attr('type', 'button');
                    $(btn).addClass('btn btn-light doc-modify-btn');
                    $(btn).text('수정');
                    $(leftTools).append(btn);
                } else{
                    for(var i in permission){
                        if((permission[i].prgrsSttsCd == 2 && permission[i].aprvSeCd == 1 && config.modifyer == 'writerAndApprover' && 
                        (docData.prgrsSttsCd == '3' || docData.prgrsSttsCd == '4'))){
                            var btn = document.createElement('button');
                            $(btn).attr('type', 'button');
                            $(btn).addClass('btn btn-light doc-modify-btn');
                            $(btn).text('수정');
                            $(leftTools).append(btn);
                            break;
                        }
                    }
                }
                
                // 현재 회수 가능자일 때
                if(docData.empId == docData.currentEmpId && 
                    ((config.retTime = 'beforFirst' && docData.prgrsSttsCd == 3)||
                    (config.retTime = 'beforeFinal' && (docData.prgrsSttsCd == 3 || docData.prgrsSttsCd == 4)))){
                    var btn = document.createElement('button');
                    $(btn).attr('type', 'button');
                    $(btn).addClass('btn btn-light doc-ret-btn');
                    $(btn).text('회수');
                    $(leftTools).append(btn);
                }
                
                // 재기안 가능 상태일 때
                if(docData.empId == docData.currentEmpId && (docData.prgrsSttsCd == 1 || docData.prgrsSttsCd == 2)){
                    var btn = document.createElement('button');
                    $(btn).attr('type', 'button');
                    $(btn).addClass('btn btn-light doc-red-btn');
                    $(btn).text('재기안');
                    $(leftTools).append(btn);
                }
                
                // 공유 가능 상태일 때
                if((docData.prgrsSttsCd == 5 || docData.prgrsSttsCd == 6) && config.shareUseYn == 'Y'){
                    var btn = document.createElement('button');
                    $(btn).attr('type', 'button');
                    $(btn).addClass('btn btn-light doc-share-btn');
                    $(btn).html('<ion-icon name="share-social-outline"></ion-icon>');
                    $(rightTools).preppend(btn);
                }

                $(docTmpltNm).html(docData.tmpltNm);
                $(docTmpltCd).html(docData.clsfNm + ' > ' + docData.tmpltNm);
                $(docAprvNo).html(docData.aprvNo);
                $(docDeptNm).html(docData.deptNm);
                $(docEmpName).html(docData.empName);
                $(docAtrzDmndDt).html(docData.atrzDmndDt);
                $(docAtrzCmptnDt).html(docData.atrzCmptnDt);

                var destinations = docData.destinations;
                var destData = '';
                $.each(destinations, function (i, dest) {
                    if (i != 0) {
                        destData += ', ';
                    }
                    destData += dest.deptNm;
                })
                $(docDestination).html(destData);

                var approvalLine = docData.approvalLine;
                var apprLineJbgdData = '';
                var apprLineSignData = '';
                var apprLineNameData = '';
                var apprLineDateData = '';
                $.each(approvalLine, function (i, apprLine) {
                    apprLineJbgdData += '<td>' + apprLine.jbgdNm;
                    // if(apprLine.aprvSeCd == 3){
                    //     apprLineJbgdData += ' (합의)'
                    // }
                    apprLineJbgdData += '</td>'
                    apprLineSignData += '<td class="approval-sign-td">';


                    /* 도장칸 */
                    if((docData.prgrsSttsCd == 3 || docData.prgrsSttsCd == 4) && (apprLine.prgrsSttsCd == 1 || apprLine.prgrsSttsCd == 2)){
                        $.each(permission, function(j, per){
                            if(apprLine.empId == per.empId){
                                if(apprLine.aprvSeCd == 1){
                                    if(per.prgrsSttsCd == 2){
                                        // 결재버튼
                                        apprLineSignData += '<button type="button" aprvLineSn="' + apprLine.aprvLineSn + '"'
                                                            + ' dcrbYn="' + apprLine.dcrbYn + '"'
                                                            + ' aprvOrder = "' + apprLine.aprvOrder + '"'
                                                            + ' class="btn btn-primary btn-sm doc-approval-btn"'
                                                            + ' data-toggle="modal" data-target="#approval-process-modal">결재</button>';
                                    }
                                    // 전결은 결재 모달에서 체크로 대체
                                    // if(config.dcrbUseYn == 'Y' &&  per.prgrsSttsCd == 2 && per.dcrbYn == 'Y'){
                                    //     // 전결버튼
                                    //     apprLineSignData += '<button type="button" aprvLineSn="' + apprLine.aprvLineSn
                                    //                         + '" class="btn btn-success btn-sm doc-approval-btn">전결</button>';
                                    // }
                                    if(config.subUseYn == 'Y' && per.prgrsSttsCd == 2 && per.empId != docData.currentEmpId){
                                        // 대결버튼
                                        apprLineSignData += '<button type="button" aprvLineSn="' + apprLine.aprvLineSn
                                                            + 'subYn="Y"'
                                                            + ' dcrbYn="' + apprLine.dcrbYn + '"'
                                                            + ' aprvOrder = "' + apprLine.aprvOrder + '"'
                                                            + '" class="btn btn-warning btn-sm doc-approval-btn">대결</button>';
                                    }
                                }
                                if(apprLine.aprvSeCd == 3  && ((config.agreeOrder == "line" && per.prgrsSttsCd == 2)|| (config.agreeOrder == "row"))){
                                    apprLineSignData += '<button type="button" aprvLineSn="' + apprLine.aprvLineSn + '"'
                                                            + ' dcrbYn="' + apprLine.dcrbYn + '"'
                                                            + ' class="btn btn-warning btn-sm doc-agree-btn"'
                                                            + ' data-toggle="modal" data-target="#agree-process-modal">합의</button>';
                                }
                            }
                        })
                    }else{
                        if (apprLine.aprvSeCd != 1) {
                            // 상단타입표시 수정
                            apprLineSignData += '<span class="approval-type">' + apprLine.cocoNm + '</span>';
                        }
                        apprLineSignData += '도장이미지~';
                    }
                    /* ./도장칸 */

                    apprLineSignData += '</td>'
                    apprLineNameData += '<td>' + apprLine.empName + '</td>';
                    apprLineDateData += '<td class="approve-date">';
                    if (apprLine.atrzDt != null) {
                        apprLineDateData += apprLine.atrzDt;
                    } else {
                        apprLineDateData += '-';
                    }
                    apprLineDateData += '</td>';
                })
                $(approvalLineJbgdTr).html(apprLineJbgdData);
                $(approvalLineSignTr).html(apprLineSignData);
                $(approvalLineNameTr).html(apprLineNameData);
                $(approvalLineDateTr).html(apprLineDateData);

                var viewers = docData.viewers;
                // 추가

                $(docAprvTtl).html(docData.aprvTtl);
                $(docAprvCn).html(docData.aprvCn);

                docActive();
                return true;
            }

            // if(document){
            //     documentRender(document);
            // }
            

            // 문서 버튼 영역

            // 기본버튼
            var docListBtn = $('.doc-list-btn');
            var docPrintBtn = $('.doc-print-btn');
            var docScrapBtn = $('.doc-scrap-btn');

            // 목록 버튼
            docListBtn.on('click', function(){
                listActive();
            })

            // 인쇄 버튼
            docPrintBtn.on('click', function(){
                console.log('docPrintBtn');
            })

            // 스크랩 버튼
            docScrapBtn.on('click', function(){
                console.log('docScrapBtn');
                $.ajax({
                    url: '/everyware/documents/scrap',
                    method: 'POST',
                    data: JSON.stringify(aprvSn),
                    contentType: 'application/json; charset=utf-8',
                    beforeSend : function(xhr){
                        xhr.setRequestHeader(csrfHeader,csrfToken);
                    },
                    sunccess: function(rslt){

                    }
                })
            })
            
            // 권한/상태별 버튼
            // 회수 버튼
            $(document).on('click', '.doc-ret-btn', function(){
                console.log('retBtn');
                $.ajax({
                    url: '/everyware/documents/collect',
                    method: 'POST',
                    data: JSON.stringify(aprvSn),
                    contentType: 'application/json; charset=utf-8',
                    beforeSend : function(xhr){
                        xhr.setRequestHeader(csrfHeader,csrfToken);
                    },
                    sunccess: function(rslt){
    
                    }
                })
            })

            // 수정 버튼
            $(document).on('click', '.doc-modify-btn', function(){
                console.log('modifyBtn');
                $.ajax({
                    url: '/everyware/documents/modify',
                    method: 'GET',
                    data: JSON.stringify(aprvSn),
                    contentType: 'application/json; charset=utf-8',
                    beforeSend : function(xhr){
                        xhr.setRequestHeader(csrfHeader,csrfToken);
                    },
                    sunccess: function(rslt){
    
                    }
                })
            })

            // 재기안 버튼
            $(document).on('click', '.doc-red-btn', function(){
                console.log('redBtn');
                $.ajax({
                    url: '/everyware/documents/re',
                    method: 'POST',
                    data: JSON.stringify(aprvSn),
                    contentType: 'application/json; charset=utf-8',
                    beforeSend : function(xhr){
                        xhr.setRequestHeader(csrfHeader,csrfToken);
                    },
                    sunccess: function(rslt){
    
                    }
                })
                
            })

            // 공유 버튼
            $(document).on('click', '.doc-share-btn', function(){
                console.log('shareBtn');
                $.ajax({
                    url: '/everyware/documents/share',
                    method: 'POST',
                    data: JSON.stringify(aprvSn),
                    contentType: 'application/json; charset=utf-8',
                    beforeSend : function(xhr){
                        xhr.setRequestHeader(csrfHeader,csrfToken);
                    },
                    sunccess: function(rslt){
    
                    }
                })
            })

            



            
            
            
            getDocument = function (aprvCn) {
                $.ajax({
                    url: '/everyware/documents/' + aprvCn,
                    dataType: 'json',
                    success: function (rslt) {
                        documentRender(rslt);
                    }
                })
            }
            //./문서영역
            
            
            // 결재영역
            
            // 모달에 aprvLineSn 전달
            $('#approval-process-modal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget);

                var dcrbYn = button.attr('dcrbYn');
                if(dcrbYn != 'Y'){
                    $('.dcrb-box').css('display', 'none');
                }
                
                var aprvLineSn = button.attr('aprvLineSn');
                var modal = $(this)
                modal.find('#approval-aprvLineSn').val(aprvLineSn)
                            
                var subYn = button.attr('subYn');
                modal.find('#approval-subYn').val(aprvLineSn)
            })

            // 모달에 aprvLineSn 전달
            $('#agree-process-modal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget);
                var aprvLineSn = button.attr('aprvLineSn');
                var modal = $(this)
                modal.find('#agree-aprvLineSn').val(aprvLineSn)
            })

            $('.approval-process-btn').on('click', function(){
                // 대결 구분
                var aprvLineSn = $('#approval-aprvLineSn').val();
                var prgrsSttsCd = $('input[name="approval-type"]:checked').val();
                console.log(prgrsSttsCd);
                var atrzOpnn = $('#approval-oppn').val();
                var dcrbYn = $('#dcrbYn').prop('checked')? 'Y':'N';
                var subYn = $('#approval-subYn').val();
                
                var aprvLine = {
                    aprvLineSn
                    ,aprvSeCd : 1
                    ,prgrsSttsCd
                    ,atrzOpnn
                    ,dcrbYn
                    ,subYn
                }
                
                if(subYn == 'Y'){
                    aprvLine.empId = currentEmpId;
                }
                console.log(aprvLine);
                
                docApproval(aprvLine);
            })
            
            $('.agree-process-btn').on('click', function(){
                var aprvLineSn = $('#agree-aprvLineSn').val();
                var prgrsSttsCd = $('input[name="agree-type"]:checked').val();
                var atrzOpnn = $('#agree-oppn').val();
                
                var aprvLine = {
                    aprvLineSn
                    ,aprvSeCd : 3
                    ,prgrsSttsCd
                    ,atrzOpnn
                }
                console.log(aprvLine);
                
                docApproval(aprvLine);
            })

            docApproval = function(aprv){
                $.ajax({
                    url: '/everyware/approval/approval-process',
                    method: 'POST',
                    data: JSON.stringify(aprv),
                    contentType : "application/json; charset=utf-8",
                    beforeSend : function(xhr){
                        xhr.setRequestHeader(csrfHeader,csrfToken);
                    },
                    success: function(aprvSn){
                        getDocument(aprvSn);
                    }
                })
            }
            
        })
        
        
        openDocumentBox = function (type) {
            $.ajax({
                url: '',
                method: 'GET',
                dataType: 'json',
                success: function (rslt) {

                }
            })
        }

    </script>
</body>

</html>