<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        #document-table tr td:nth-child(2){
            cursor: pointer;
        }
        #document-table tr td:nth-child(2):hover{
            color: #007bff;
        }

        .doc-list {
            /* display: none; */
        }

        /* 문서 본문 영역 */
        .doc-header {
            background-color: rgb(240, 240, 240);
            text-align: center;
        }

        .approval-line-table {
            text-align: center;
        }

        .approval-sign-td {
            position: relative;
        }

        .approval-line-table td {
            padding: 3px !important;
            width: 130px !important;
            min-width: 130px !important;
        }

        .approval-line-jbgd-tr {
            background-color: rgb(240, 240, 240);
        }

        .approval-line-sign-tr {
            height: 120px;
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

        /* 결재home 영역 */
        .approval-home {
            display: none;
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
                            <li class="breadcrumb-item active">전체문서조회</li>
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
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card card-light submenu-body">
                                <div class="card-header">
                                    <h3 class="card-title">전자결재</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body p-0" style="display: block;">
                                    <ul class="nav nav-pills flex-column">
                                        <li class="nav-item" onclick="selectSubmenu(pending, 'pending')">
                                            <a href="#" class="nav-link">
                                                전자결재설정
                                            </a>
                                        </li>
                                        <li class="nav-item scheduled"
                                            onclick="selectSubmenu(scheduled, 'scheduled')">
                                            <a href="#" class="nav-link">
                                                전체문서조회
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.subMenu -->

                    <!-- document List -->
                    <div class="col-md-9 doc-list">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">전체문서조회</h3>
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
                                                                id="reservation">
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
                                            <c:forEach items="${docList }" var="doc">
                                                <tr>
                                                    <td><a href="#" onclick="openDocument(${doc.aprvSn})">${doc.aprvNo }</a></td>
                                                    <td>${doc.aprvTtl }</td>
                                                    <td>${doc.empName }</td>
                                                    <td>${doc.atrzDmndDt }</td>
                                                    <td>${doc.atrzCmptnDt }</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- ./document List -->
                        
                        <!-- document -->
                        <div class="col-md-9 doc-content">
                            <div class="card">
                                <div class="card-header">
                                    문서조회..... 버튼 영역
                                </div>
                                <div class="card-body p-0">
                                    <div class="mailbox-controls">
                                        <h6>기본정보</h6>
                                        <table class="table table-bordered">
                                            <colgroup>
                                                <col style="width: 20%">
                                                <col style="width: 30%">
                                                <col style="width: 20%">
                                                <col style="width: 30%">
                                            </colgroup>
                                            <tr>
                                                <td class="doc-header">문서종류</td>
                                                <td class="left-cell doc-tmpltCd">${document.clsfNm} >
                                                    ${document.tmpltNm}</td>
                                                <td class="doc-header">문서번호</td>
                                                <td class="left-cell doc-aprvNo">${document.aprvNo}</td>
                                            </tr>
                                            <tr>
                                                <td class="doc-header">기안부서</td>
                                                <td class="left-cell doc-deptNm">${document.deptNm}</td>
                                                <td class="doc-header">기안자</td>
                                                <td class="left-cell doc-empName">${document.empName}</td>
                                            </tr>
                                            <tr>
                                                <td class="doc-header">기안일자</td>
                                                <td class="left-cell doc-atrzDmndDt">
                                                    <fmt:formatDate pattern="yyyy-MM-dd"
                                                        value="${document.atrzDmndDt}" />
                                                </td>
                                                <td class="doc-header">완료일자</td>
                                                <td class="left-cell doc-atrzCmptnDt">
                                                    <fmt:formatDate pattern="yyyy-MM-dd"
                                                        value="${document.atrzCmptnDt}" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="doc-header">수신처</td>
                                                <td colspan="3" class="left-cell doc-destination">
                                                    <c:forEach items="${document.destinations }" var="destination"
                                                        varStatus="status">
                                                        <c:if test="${status.index != 0 }">
                                                            ,
                                                        </c:if>
                                                        ${destination.deptNm }
                                                    </c:forEach>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="mailbox-controls">
                                        <h6>결재선(결재의견 버튼)</h6>
                                        <div class="col-sm-4 approval-line-wrap">
                                            <table class="table table-bordered approval-line-table">
                                                <tr class="approval-line-jbgd-tr">
                                                    <c:forEach items="${document.approvalLine }" var="apprLine">
                                                        <td>${apprLine.jbgdNm }</td>
                                                    </c:forEach>
                                                </tr>
                                                <tr class="approval-line-sign-tr">
                                                    <c:forEach items="${document.approvalLine }" var="apprLine">
                                                        <td class="approval-sign-td">
                                                            <c:if test="${apprLine.aprvSeCd != 1}">
                                                                <span class="approval-type">${apprLine.cocoNm }</span>
                                                            </c:if>
                                                            도장이미지~
                                                        </td>
                                                    </c:forEach>
                                                </tr>
                                                <tr class="approval-line-name-tr">
                                                    <c:forEach items="${document.approvalLine }" var="apprLine">
                                                        <td>${apprLine.empName }</td>
                                                    </c:forEach>
                                                </tr>
                                                <tr class="approval-line-date-tr">
                                                    <c:forEach items="${document.approvalLine }" var="apprLine">
                                                        <td class="approve-date">
                                                            <c:choose>
                                                                <c:when test="${apprLine.atrzDt != null }">
                                                                    <fmt:formatDate pattern="yyyy-MM-dd"
                                                                        value="${apprLine.atrzDt }" />
                                                                </c:when>
                                                                <c:otherwise>
                                                                    -
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </c:forEach>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="mailbox-read-message p-1">
                                        <table class="table table-bordered">
                                            <colgroup>
                                                <col style="width:20%">
                                                <col style="width:80%">
                                            </colgroup>
                                            <tr>
                                                <td class="doc-header">제목</td>
                                                <td class="left-cell doc-aprvTtl">${document.aprvTtl}</td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="content">
                                                    <div class="doc-aprvCn">${document.aprvCn}</div>
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
            </section>
        </div>
    </div>
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js" defer></script>
        <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js" defer></script>
        <script src="https://cdn.datatables.net/1.13.5/js/dataTables.bootstrap4.min.js" defer></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js" defer></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap4.min.js" defer></script>
        <script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js" defer></script>
        <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
        <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

        <script>
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

                var select2 = $('.select2')

                $.datepicker.setDefaults($.datepicker.regional['ko']);
                $('#reservation').daterangepicker({
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
                    ],
                    order: [[1, 'asc']],
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

                var table = $('#document-table').DataTable(tableOptions);

                $('.template-tree-return-btn').on('click', function () {
                    templateModalReturn(selectTemplate);
                })

                selectTemplate = function (data) {
                    if (data.type == 'template') {
                        location.href = '/everyware/documents/new/' + data.id;
                        return true;
                    }
                    return false;
                }

                // 문서 리스트 영역
                var data = []
                selectSubmenu = function () {
                    
                    var dmndStartDate = $('#reservation').data('daterangepicker').startDate.format('YYYY-MM-DD');
                    var dmndEndDate = $('#reservation').data('daterangepicker').endDate.format('YYYY-MM-DD');
                    
                    var doc = {
                        dmndStartDate,
                        dmndEndDate
                    }
                    
                    $.ajax({
                        url: '/everyware/admin//approval/documents',
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
                        
                        $(approvalHome).css('display', 'none');
                        $(docContent).css('display', 'none');
                        $(docList).css('display', 'block');
                }
                selectSubmenu();

                $(document).on('click', '#document-table tbody tr td:nth-child(2)', function () {
                    var row = $(this).closest('tr');
                    var aprvSn = table.row( row ).data()[0];
                    getDocument(aprvSn);
                });




                $('.search-btn').on('click', function () {
                    alert($('#reservation').val());
                })













                // 문서 영역
                documentRender = function (docData) {
                    aprvSn = docData.aprvSn;
                    approvers = docData.approvalLine;
                    viewers = docData.viewers;

                    $(docTmpltCd).html(docData.clsfNm + ' > ' + docData.tmpltNm);
                    $(docAprvNo).html(docData.aprvNo);
                    $(docDeptNm).html(docData.deptNm);
                    $(docEmpName).html(docData.empName);
                    $(docAtrzDmndDt).html(docData.atrzDmndDt);
                    $(docAtrzCmptnDt).html(docData.atrzCmptnDt);

                    var destinations = docData.destinations;
                    var destData = '';
                    $.each(destinations, function (i, dest) {
                        console.log(dest);
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
                        apprLineJbgdData += '<td>' + apprLine.jbgdNm + '</td>';
                        apprLineSignData += '<td class="approval-sign-td">';
                        if (apprLine.aprvSeCd != 1) {
                            apprLineSignData += '<span class="approval-type">' + apprLine.cocoNm + '</span>';
                        }
                        apprLineSignData += '도장이미지~' + '</td>';
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

                    $(approvalHome).css('display', 'none');
                    $(docList).css('display', 'none');
                    $(docContent).css('display', 'block');
                    return true;
                }

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

            })
        </script>
</body>

</html>