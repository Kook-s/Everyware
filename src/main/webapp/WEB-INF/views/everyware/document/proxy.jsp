<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link href="https://cdn.jsdelivr.net/npm/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js" defer></script>
<script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js" defer></script>
<script src="https://cdn.datatables.net/1.13.5/js/dataTables.bootstrap4.min.js" defer></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js" defer></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap4.min.js" defer></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js" defer></script>
<style>
    .form-horizontal label{
        width: 75px;
        top: 5px;
        position: relative;
        text-align: right;
        margin-right: 20px;
    }
    .form-horizontal>*{
        margin: 20px;
    }
    .search-btn{
        width: 250px;
    }
    .form-daterange{
        position: relative;
    }
    .form-daterange-info{
        position: absolute;
        bottom: 36px;
        font-size: 0.8em;
        color: gray;
    }
    #document-table_length{
        float: right;
    }
    .border-bottom{
        margin-bottom: 20px;
    }
    .write-btn{
        height: 50px;
        line-height: 36px;
    }
    #handInput{
        display: none;
    }
    .agt-btn{
        padding: 0.375rem 0.5rem !important;
    }
    .selected-agt-div{
        overflow-x: auto;
        display: block;
        width: 100%;
        height: calc(2.25rem + 2px);
        padding: 0.375rem 0.75rem;
        font-size: 1rem;
        font-weight: 400;
        line-height: 1.5;
        color: #495057;
        background-color: #fff;
        background-clip: padding-box;
        border: 1px solid #ced4da;
        border-radius: 0.25rem;
        box-shadow: inset 0 0 0 transparent;
        transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
    }
    .selected-agt-ul{
        list-style: none;
    }
    .selected-agt{
        display: inline;
        float: left;
        cursor: pointer;
        border: 1px solid #ced4da;
        padding: 0px 7px;
        border-radius: 12px;
        margin-right: 5px;
        margin-bottom: 5px;
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
    #proxy-table_length{
        float: right;
        height: 24px;
    }
    #proxy-table td{
        overflow: hidden;
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
                            <li class="breadcrumb-item active">대결자 관리</li>
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
                        <a href="#" class="btn btn-primary btn-block mb-2 write-btn">새 문서 작성</a>
                        <a href="#" class="btn btn-secondary btn-block mb-2 home-btn">결재 HOME</a>
                        <div class="card">
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
                                    <li class="nav-item active">
                                        <a href="#" class="nav-link">
                                            결재 대기
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#" class="nav-link">
                                            결재 예정
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#" class="nav-link">
                                            결재 완료
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="card">
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
                                    <li class="nav-item active">
                                        <a href="#" class="nav-link">
                                            부서 수신
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#" class="nav-link">
                                            참조/열람
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="card">
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
                                    <li class="nav-item active">
                                        <a href="#" class="nav-link">
                                            내 기안
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#" class="nav-link">
                                            임시저장
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#" class="nav-link">
                                            스크랩
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="card">
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
                                    <li class="nav-item active">
                                        <a href="#" class="nav-link">
                                            서명관리
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#" class="nav-link">
                                            대결관리
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- /.subMenu -->

                    <div class="col-md-9">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">대결관리</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div class="border-bottom">
                                    <form class="form-horizontal">
                                        <div class="row">
                                            <div class="col">
                                                <div class="form-group row">
                                                    <label>대결기간</label>
                                                    <div class="col">
                                                        <div class="input-group form-daterange">
                                                            <div class="input-group-prepend">
                                                                <span class="input-group-text">
                                                                    <i class="far fa-calendar-alt"></i>
                                                                </span>
                                                            </div>
                                                            <input type="text" class="form-control float-right" id="reservation">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="form-group row">
                                                    <label>대결자</label>
                                                    <div class="col">
                                                        <div class="selected-agt-div">
                                                            <ul class="selected-agt-ul">

                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-2">
                                                        <button type="button" class="btn btn-default agt-btn" data-toggle="modal" data-target="#tree-modal">
                                                            찾기
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col">
                                                <div class="form-group row"> 
                                                    <label>사유</label>
                                                    <div class="col">
                                                        <select name="reason" class="form-control select2 reason-select" style="width: 100%;">
                                                            <option class="reason-option" value="휴가로 인한 부재">휴가로 인한 부재</option>
                                                            <option class="reason-option" value="출장으로 인한 부재">출장으로 인한 부재</option>
                                                            <option id="handInputSelect" value="input">직접 입력</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <input type="text" class="form-control" id="handInput">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col text-center">
                                                <button class="btn btn-primary agt-save-btn" type="button">저장</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="row">
                                    <div class="col-xl-12">
                                        <!-- Date range -->
                                        <table id="proxy-table" style="width:100%"
                                            class="table table-bordered table-hover dataTable dtr-inline">
                                            <thead>
                                                <tr>
                                                    <th>proxyId</th>
                                                    <th></th>
                                                    <th>시작일자</th>
                                                    <th>종료일자</th>
                                                    <th>대결자</th>
                                                    <th>사유</th>
                                                    <th>설정일자</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                
                                            </tbody>
                                        </table>
                                    </div>
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
        <!-- /.content -->
    </div>
    <%@ include file="../contacts/contactModal.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/@yaireo/tagify"></script>
    <script src="https://cdn.jsdelivr.net/npm/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
<script>
    var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
    var csrfToken = $('meta[name="_csrf"]').attr('content');

    $(function(){
        var saveBtn = $('.agt-save-btn');
        var select2 = $('.select2')

        $.datepicker.setDefaults($.datepicker.regional['ko']);
        $('#reservation').daterangepicker({
            startDate: moment(),
            endDate: moment(),
            locale: {
                format: "YYYY-MM-DD",
                separator: "  ~  ",
                applyLabel: "확인",
                cancelLabel: "취소",
                fromLabel: "From",
                toLabel: "To",
                // customRangeLabel: "직접 선택",
                yearSuffix: "년",
                daysOfWeek:['일','월','화','수','목','금','토'],
                monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                firstDay: 0
            },
            opens: "left",
            alwaysShowCalendars: true
        })

        // $('input[name="datefilter"]').on('apply.daterangepicker', function(ev, picker) {
        //     $(this).val(picker.startDate.format('MM/DD/YYYY') + ' - ' + picker.endDate.format('MM/DD/YYYY'));
        // });

        // $('input[name="datefilter"]').on('cancel.daterangepicker', function(ev, picker) {
        //     $(this).val('');
        // });

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
                ,{
                    searchable: false,
                    orderable: false,
                    targets: 1
                }
                ,{ "width": "7%", "targets": 1 }
                ,{ "width": "15%", "targets": 2 }
                ,{ "width": "15%", "targets": 3 }
                ,{ "width": "18%", "targets": 4 }
                ,{ "width": "30%", "targets": 5 }
                ,{ "width": "105", "targets": 6 }
                // ,{
                //     "data": null,
                //     "defaultContent": "<button type='button' class='btn btn-warning btn-xs proxy-cancel-btn'>취소</button>",
                //     "targets": 1
                // }
            ],
            order: [[2, 'asc']],
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

        $('.reason-select').on('change', function(){
            var value = $(this).val();

            if(value == 'input'){
                $('#handInput').css('display', 'block');
                $('#handInput').attr('name', 'reason');
                $('.reason-select').removeAttr('name');
            } else{
                $('#handInput').css('display', 'none');
                $('#handInput').removeAttr('name');
                $('.reason-select').attr('name', 'reason');
            }
        })

        $('.tree-return-btn').on('click', function(){
            modalReturn(selectEmp);
	    });

        selectEmp = function(datas){
            var selectedList = $('.selected-agt-ul');
            $(selectedList).html('');

            $.each(datas, function(i,data){
                var li = document.createElement('li');
                // var span = document.createElement('span');
                $(li).addClass('selected-agt');
                $(li).attr('empId', data.empId);
                $(li).text(data.empName + ' ' + data.jbgdNm);

                // $(li).append(span);
                $(selectedList).append(li);
            })

        }

        function parseDateFromString(dateString) {
            var parts = dateString.split('-'); // 예시로 '-'로 구분된 문자열을 가정합니다.
            // parts 배열에서 순서대로 년, 월, 일을 가져와서 Date 객체를 생성합니다.
            return new Date(parts[0], parts[1] - 1, parts[2]);
        }
        function getToday() {
            var today = new Date();
            today.setHours(0, 0, 0, 0); // 시간 부분을 0시 0분 0초 0밀리초로 설정하여 날짜만 비교하도록 합니다.
            return today;
        }

        listToHtml = function(list){
            var html = '';
            $.each(list, function(i,v){
                html += '<tr>';
                html += '<td>' + v.proxyId + '</td>';
                if(parseDateFromString(v.endDt) > getToday()){
                    html += '<td>' + '<button type="button" class="btn btn-warning btn-xs proxy-cancel-btn">취소</button>' + '</td>';
                } else{
                    html += '<td></td>';
                }
                html += '<td>' + v.bgngDt + '</td>';
                html += '<td>' + v.endDt + '</td>';
                html += '<td>' + v.empName + '</td>';
                html += '<td>' + v.reason + '</td>';
                html += '<td>' + v.stngYmd + '</td>';
                html += '</tr>';
            })
            return html;
        }

        getProxyList = function(){
            $.ajax({
                url: '/everyware/approval/proxy',
                method: 'GET',
                contentType : "application/json; charset=utf-8",
                dataType : "json",
                success: function(rslt){
                    var html = listToHtml(rslt);
                    $('#proxy-table').DataTable().destroy();
                    $('#proxy-table tbody').empty().html(html);
                    table = $('#proxy-table').DataTable(tableOptions);
                }
            })
        }

        getProxyList();


        $(saveBtn).on('click', function(){
            var startDate = $('#reservation').data('daterangepicker').startDate.format('YYYY-MM-DD');
            var endDate = $('#reservation').data('daterangepicker').endDate.format('YYYY-MM-DD');
            var reason = $('[name="reason"]').val();
            var emps = $('.selected-agt-ul').find('li').get();

            var datas = [];
            $.each(emps, function(i, v){
                var bgngDt = startDate;
                var endDt = endDate;
                var agtId = $(v).attr('empId');
                var empName = v.innerHTML;

                var emp = {
                    bgngDt,
                    endDt,
                    agtId,
                    empName,
                    reason
                }
                datas.push(emp);
            })

            $.ajax({
                url: '/everyware/approval/proxy',
                method: 'POST',
                data: JSON.stringify(datas),
                contentType : "application/json; charset=utf-8",
                dataType : "text",
                beforeSend : function(xhr){
                  xhr.setRequestHeader(csrfHeader,csrfToken);
                },
                success: function(rslt){
                    getProxyList();
                }

            })
        })

        cancelProxy = function(btn, proxyId){
            $.ajax({
                url: '/everyware/approval/proxy',
                method: 'PATCH',
                data: JSON.stringify(proxyId),
                contentType : "application/json; charset=utf-8",
                dataType : "text",
                beforeSend : function(xhr){
                  xhr.setRequestHeader(csrfHeader,csrfToken);
                },
                success: function(rslt){
                    $(btn).remove();
                }
            })
        }

        $(document).on('click', '.proxy-cancel-btn', function () {
            var row = $(this).closest('tr');
            var proxyId = table.row( row ).data()[0];
            cancelProxy($(this), proxyId);
        });
        
    })
</script>
</body>
</html>