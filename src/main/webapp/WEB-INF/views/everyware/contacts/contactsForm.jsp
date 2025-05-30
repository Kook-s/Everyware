<%@page import="kr.or.everyware.everyware.contact.vo.Folder"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta id="_csrf" name="_csrf" content="${_csrf.token}" />
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
    <title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js" defer></script>
    <script src="../../../../resources/bootstrap/plugins/moment/moment.min.js"></script>
    <script src="../../../../resources/bootstrap/plugins/inputmask/jquery.inputmask.min.js"></script>
</head>
<style>
    .select2-selection.select2-selection--single{
        height: 38px;
    }
    .contact-out-form{
        width: 100%;
    }
    .table td{
        padding: 0.25rem;
    }
    .form-group{
        width: 300px;
    }
    .invalid-tr{
        background-color: #f3a6ae !important;
    }
    .invalid-tr td{
        border: none !important;
    }
    .invalid-select{
        background-color: #f3a6ae!important;
    }
    .submenu-body {
        margin-bottom: 1px;
    }
</style>
<body>
    <sec:authentication var="empId" property="principal.employee.empId"/>

    <!-- <button type="button" onclick="addRow()">추가</button> -->
    <div class="content-container">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>DataTables</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">주소록 등록</li>
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
                        <a href="/everyware/contacts/new" class="btn btn-primary btn-block mb-2 write-btn">주소록 추가</a>
                        <div class="card">
                            <div class="card card-light submenu-body">
                                <div class="card-header">
                                    <h3 class="card-title">주소록</h3>
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
                                                사내주소록
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">
                                                사외주소록
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="card card-light submenu-body">
                                <div class="card-header">
                                    <h3 class="card-title">설정(임시)</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body p-0" style="display: block;">
                                    <ul class="nav nav-pills flex-column">
                                        <li class="nav-item active">
                                            <a href="/everyware/folderTest" class="nav-link">
                                                폴더설정
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.subMenu -->
                    <div class="col-10">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">주소록 등록</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div id="example2_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                    <div class="row">
                                        <div class="form-group">
                                            <label>폴더</label>
                                            <select class="form-control select2" style="width: 100%;">
                                            </select>
                                        </div>
                                        <!-- <div class="col-sm-12 col-md-4">
                                            <div class="dt-buttons btn-group flex-wrap"> <button
                                                    class="btn btn-secondary buttons-copy buttons-html5"
                                                    tabindex="0" aria-controls="example1"
                                                    type="button"><span>Copy</span></button> <button
                                                    class="btn btn-secondary buttons-csv buttons-html5" tabindex="0"
                                                    aria-controls="example1" type="button"><span>CSV</span></button>
                                                <button class="btn btn-secondary buttons-excel buttons-html5"
                                                    tabindex="0" aria-controls="example1"
                                                    type="button"><span>Excel</span></button> <button
                                                    class="btn btn-secondary buttons-pdf buttons-html5" tabindex="0"
                                                    aria-controls="example1" type="button"><span>PDF</span></button>
                                                <button class="btn btn-secondary buttons-print" tabindex="0"
                                                    aria-controls="example1"
                                                    type="button"><span>Print</span></button>
                                                <div class="btn-group"><button
                                                        class="btn btn-secondary buttons-collection dropdown-toggle buttons-colvis"
                                                        tabindex="0" aria-controls="example1" type="button"
                                                        aria-haspopup="true"><span>Column visibility</span><span
                                                            class="dt-down-arrow"></span></button></div>
                                            </div>
                                        </div> -->
                                    </div>
                                    <form class="row g-3 needs-validation" novalidate>
                                        <div class="row contact-out-form">
                                            <div class="col-sm-12">
                                                <table id="example2" class="table table-bordered table-hover dataTable dtr-inline" aria-describedby="example2_info">
                                                    <thead>
                                                        <tr>
                                                            <th class="sorting sorting_asc" tabindex="0"
                                                                aria-controls="example2" rowspan="1" colspan="1"
                                                                aria-sort="ascending"
                                                                aria-label="Rendering engine: activate to sort column descending">
                                                                소속</th>
                                                            <th class="sorting" tabindex="0" aria-controls="example2"
                                                                rowspan="1" colspan="1"
                                                                aria-label="Browser: activate to sort column ascending">
                                                                이름*</th>
                                                            <th class="sorting" tabindex="0" aria-controls="example2"
                                                                rowspan="1" colspan="1"
                                                                aria-label="Browser: activate to sort column ascending">
                                                                연락처1*</th>
                                                            <th class="sorting" tabindex="0" aria-controls="example2"
                                                                rowspan="1" colspan="1"
                                                                aria-label="Platform(s): activate to sort column ascending">
                                                                연락처2</th>
                                                            <th class="sorting" tabindex="0" aria-controls="example2"
                                                                rowspan="1" colspan="1"
                                                                aria-label="CSS grade: activate to sort column ascending">
                                                                이메일</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                            	<input type="hidden" class="form-control" name="empId" value="${empId }"/>
                                                                <input type="text" class="form-control" name="ogdpInstNm" onkeypress="toNext(this)" autofocus>
                                                            </td>
                                                            <td>
                                                                <input type="text" class="form-control" name="name" onkeypress="toNext(this)" required>
                                                            </td>
                                                            <td>
                                                                <input type="text" class="form-control" name="telno1" onkeypress="toNext(this)" required>
                                                            </td>
                                                            <td>
                                                                <input type="text" class="form-control" name="telno2" onkeypress="toNext(this)">
                                                            </td>
                                                            <td>
                                                                <input type="email" class="form-control" name="emlAddr" onkeypress="addRow(this)">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </form>
                                    <div class="row">
                                        <div class="d-grid gap-2 col-2 mx-auto">
                                            <button type="button" class="btn btn-block btn-primary contact-insert-btn">저장</button>
                                        </div>
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
<script>
$(function(){
    var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
    var csrfToken = $('meta[name="_csrf"]').attr('content');

    var select2 = $('.select2')

    $.ajax({
        url: '/everyware/contacts/new/folders',
        method: 'GET',
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        success: function(rslt){
            $(select2).html(rslt);
            $(select2).select2();
        }
    })
    
    var contactOutForm = $('.contact-out-form');
    var emptyRowHtml = contactOutForm.find('tbody').html();
    var insertBtn = $('.contact-insert-btn');

    addRow = function(fthis){
        if(event.key == 'Enter' || event.key == 'Tab'){
            $(fthis).parents('tbody').append(emptyRowHtml);

            var nextTr =  $(fthis).parents('tr').next();
            var firstInput = $(nextTr).find('input:eq(1)');
            firstInput.focus();
        }
    }

    toNext = function(fthis){
        if(event.key == 'Enter' || event.key == 'Tab'){
            var nextTd =  $(fthis).parents('td').next();
            var firstInput = $(nextTd).find('input:eq(0)');
            firstInput.focus();
        }
    }

    // 나중에 시간 남으면..
    // toDown = function(fthis){
    //     if(event.key == 'Down'){
    //         $(fthis).parents('tbody').append(emptyRowHtml);

    //         var nextTr =  $(fthis).parents('tr').next();

    //         var firstInput = $(nextTr).find('input:eq(1)');
    //         firstInput.focus();
    //     }
    // }

    var insertValidFlag = true;

    isEmpty = function(value){
        if( value == "" 
        || value == null 
        || value == undefined 
        || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){
            return true;
        }else{
            return false;
        }
    }  

    generateDatas = function(){
        var folSn = $(select2).val();
        if(isEmpty(folSn)){
            $('.select2-selection.select2-selection--single').addClass('invalid-select');
            return false;
        }
        
        var trs = $('.contact-out-form tbody tr').get();
        var datas = [];
        $.each(trs, function(i){
            var tr = trs[i];

            var empId = $(tr).find('input[name="empId"]').val();
            var ogdpInstNm = $(tr).find('input[name="ogdpInstNm"]').val();
            var name = $(tr).find('input[name="name"]').val();
            var telno1 = $(tr).find('input[name="telno1"]').val();
            var telno2 = $(tr).find('input[name="telno2"]').val();
            var emlAddr = $(tr).find('input[name="emlAddr"]').val();

            if(isEmpty(name) || isEmpty(telno1)){
                $(tr).addClass('invalid-tr');
                insertValidFlag = false;
            }

            var data = {
                folSn
                ,empId
                ,ogdpInstNm
                ,name
                ,telno1
                ,telno2
                ,emlAddr
            }

            datas.push(data);
        })
        return datas;
    }

    insertBtn.on('click', function(event){
        event.preventDefault();

        $('.select2-selection.select2-selection--single').removeClass('invalid-select');
        $('tr').removeClass('invalid-tr');

        var datas = generateDatas();

        if(isEmpty(datas)){
            return false;
        }

        if(insertValidFlag){
            $.ajax({
                url: '/everyware/contacts/out',
                method: 'post',
                data: JSON.stringify(datas),
                contentType : "application/json; charset=utf-8",
                beforeSend : function(xhr){
                  xhr.setRequestHeader(csrfHeader,csrfToken);
                },
                success: function(rslt){
                    console.log(rslt);
                }
            });

            $('.select2-selection.select2-selection--single').removeClass('invalid-select');
            $('tr').removeClass('invalid-tr');

            // 이동? 제자리?
        }
    })
})

</script>
</body>
</html>