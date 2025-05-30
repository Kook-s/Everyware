<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
        .submenu-body {
            margin-bottom: 1px;
        }
        #options {
            display: flex;
            gap: 8px;
        }
        .option {
            padding: 8px;
            background-color: #f0f0f0;
            /* border: 1px solid #ccc; */
            cursor: pointer;
            border-radius: 15px;
            font-size: 15px;
            height: 30px;
            padding: 3px 15px;
        }
        #document-number-format {
            margin-top: 20px;
            padding: 12px;
            border: 1px solid #007bffa3;
            height: 50px;
        }
        #document-number-format>.option{
            margin-right: 5px;
        }
        .config-subject{
            background-color: #f5f5f5;
            text-align: right;
            width: 200px;
        }
        .config-table td{
            font-size: 14px;
            color: #252525;
        }
    </style>
</head>
<body>
    <div class="content-container">
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
                            <li class="breadcrumb-item active">전자결재설정</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
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

                    <div class="col-md-9">
                        <div class="card card-outline card-primary">
                            <div class="card-header">
                                <h3 class="card-title">전자결재설정</h3>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-block btn-primary submit-btn">저장</button>
                                </div>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div class="mailbox-controls">
                                    <form id="configForm" action="/everyware/admin/approval/config" method="post">
                                        <table class="table config-table">
                                            <tr>
                                                <th class="config-subject">결재 유형<ion-icon name="information-circle-outline"></ion-icon></th>
                                                <td>
                                                    <input type="checkbox" id="config-approve" name="approve" value="approve" checked disabled/>결재
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input type="checkbox" id="config-agree" name="agree" value="Y" <c:if test="${config.agreeUseYn == 'Y' }">checked</c:if>/>합의
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <!-- <input type="checkbox" id="config-pre" name="pre" value="Y" <c:if test="${config.preUseYn == 'Y' }">checked</c:if>/>선결
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
                                                    <input type="checkbox" id="config-dcrb" name="dcrb" value="Y" <c:if test="${config.dcrbUseYn == 'Y' }">checked</c:if>/>전결
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input type="checkbox" id="config-sub" name="sub" value="Y" <c:if test="${config.subUseYn == 'Y' }">checked</c:if>/>대결
                                                    <input type="hidden" id="agreeUseYn" name="agreeUseYn"/>
                                                    <input type="hidden" id="preUseYn" name="preUseYn"/>
                                                    <input type="hidden" id="dcrbUseYn" name="dcrbUseYn"/>
                                                    <input type="hidden" id="subUseYn" name="subUseYn"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="config-subject">열람 유형<ion-icon name="information-circle-outline"></ion-icon></th>
                                                <td>
                                                    <input type="checkbox" id="config-view" name="view" value="Y" <c:if test="${config.viewUseYn == 'Y' }">checked</c:if>/>열람
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input type="checkbox" id="config-ref" name="ref" value="Y" <c:if test="${config.refUseYn == 'Y' }">checked</c:if>/>참조
                                                    <input type="hidden" id="viewUseYn" name="viewUseYn"/>
                                                    <input type="hidden" id="refUseYn" name="refUseYn"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="config-subject">합의 순서<ion-icon name="information-circle-outline"></ion-icon></th>
                                                <td>
                                                    <input type="radio" name="agreeOrder" value="line" <c:if test="${config.agreeOrder == 'line' }">checked</c:if>/>순차합의
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input type="radio" name="agreeOrder" value="row" <c:if test="${config.agreeOrder == 'row' }">checked</c:if>/>병렬합의
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="config-subject">문서 수정</td>
                                                <td>
                                                    <input type="radio" name="modifyer" value="writer" <c:if test="${config.modifyer == 'writer' }">checked</c:if>/>문서 작성자만 수정
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input type="radio" name="modifyer" value="writerAndApprover" <c:if test="${config.modifyer == 'writerAndApprover' }">checked</c:if>/>문서 작성자 및 결재자 수정
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="config-subject">수정 가능 시점</td>
                                                <td>
                                                    <input type="radio" name="modifyTime" value="beforeFirst" <c:if test="${config.modifyTime == 'beforeFirst' }">checked</c:if>/>1차 결재 전까지
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input type="radio" name="modifyTime" value="beforeFinal" <c:if test="${config.modifyTime == 'beforeFinal' }">checked</c:if>/>최종 결재 전까지
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="config-subject">회수 가능 시점</td>
                                                <td>
                                                    <input type="radio" name="retTime" value="beforeFirst" <c:if test="${config.retTime == 'beforeFirst' }">checked</c:if>/>1차 결재 전까지
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input type="radio" name="retTime" value="beforeFinal" <c:if test="${config.retTime == 'beforeFinal' }">checked</c:if>/>최종 결재 전까지
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="config-subject">공유기능 사용<ion-icon name="information-circle-outline"></ion-icon></th>
                                                <td>
                                                    <input type="radio" name="shareUseYn" value="Y" <c:if test="${config.shareUseYn == 'Y' }">checked</c:if>/>사용
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input type="radio" name="shareUseYn" value="N" <c:if test="${config.shareUseYn == 'N' }">checked</c:if>/>미사용
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="config-subject">결재 인증<ion-icon name="information-circle-outline"></ion-icon></th>
                                                <td>
                                                    <input type="radio" name="verifUseYn" value="password" <c:if test="${config.verifUseYn == 'password' }">checked</c:if>/>비밀번호 인증
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input type="radio" name="verifUseYn" value="N" <c:if test="${config.verifUseYn == 'N' }">checked</c:if>/>인증 미사용
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="config-subject">문서번호 채번 시점</th>
                                                <td>
                                                    <input type="radio" name="numberingTime" value="finished" <c:if test="${config.numberingTime == 'finished' }">checked</c:if>/>결재완료 시점
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input type="radio" name="numberingTime" value="wrote" <c:if test="${config.numberingTime == 'wrote' }">checked</c:if>/>문서 기안 시점
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="config-subject">문서번호 채번</th>
                                                <td>
                                                    <div id="options">
                                                        <span class="option" data-val="{company}">회사명</span>
                                                        <span class="option" data-val="{dept}">부서명</span>
                                                        <span class="option" data-val="{tmplt}">양식명</span>
                                                        <span class="option" data-val="{year}">연도</span>
                                                        <span class="option" data-val="{month}">월</span>
                                                        <span class="option" data-val="{day}">일</span>
                                                        <span class="option" data-val="{seq}">순번</span>
                                                        <span class="option" data-val="-">-</span>
                                                    </div>
                                                    <div id="document-number-format"></div>
                                                    <input id="numberingReg" type="hidden" name="numberingReg"/>
                                                </td>
                                            </tr>
                                        </table>
                                        <sec:csrfInput />
                                    </form>
                                </div>
                            </div>
                            <!-- ./card -->
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <script>
    $(function(){
        var numberFormat = $('#document-number-format');
        var submitBtn = $('.submit-btn');
        var numberingReg = '${config.numberingReg}';

        renderNumberingOptions = function(reg){
            var company = '<span class="option ui-draggable ui-draggable-handle" data-val="{company}" style="width: 75px; height: 30px;">회사명</span>';
            var dept = '<span class="option ui-draggable ui-draggable-handle" data-val="{dept}" style="width: 75px; height: 30px;">부서명</span>';
            var tmplt = '<span class="option ui-draggable ui-draggable-handle" data-val="{tmplt}" style="width: 75px; height: 30px;">양식명</span>';
            var year = '<span class="option ui-draggable ui-draggable-handle" data-val="{year}" style="width: 60px; height: 30px;">연도</span>';
            var month = '<span class="option ui-draggable ui-draggable-handle" data-val="{month}" style="width: 45px; height: 30px;">월</span>';
            var day = '<span class="option ui-draggable ui-draggable-handle" data-val="{day}" style="width: 45px; height: 30px;">일</span>';
            var seq = '<span class="option ui-draggable ui-draggable-handle" data-val="{seq}" style="width: 60px; height: 30px;">순번</span>';
            var hyphen = '<span class="option ui-draggable ui-draggable-handle" data-val="-" style="width: 34.6719px; height: 30px;">-</span>';

            optionHtml = reg.replace(/-/g, hyphen).replace(/{company}/g, company).replace(/{dept}/g, dept).replace(/{tmplt}/g, tmplt)
            	.replace(/{year}/g, year).replace(/{month}/g, month).replace(/{day}/g, day).replace(/{seq}/g, seq);

            $('#document-number-format').html(optionHtml);
            return true;
        }

        renderNumberingOptions(numberingReg);
            
        $(numberFormat).sortable({
            revert: true
        });
        $( ".option" ).draggable({
            connectToSortable: "#document-number-format",
            helper: "clone",
            revert: "invalid"
        });
        $( "#options, .option" ).disableSelection();
    
        $(document).on('dblclick', '#document-number-format>.option', function(){
            $(this).remove();
        });


        $(submitBtn).on('click', function(){
            confirmCheck();

            var options = $('#document-number-format').find('.option').get();
            numbering(options);

            $('#configForm').submit();
        })

        confirmCheck = function(){
            var agree = $("#config-agree").prop("checked")? "Y" :"N";
            $("#agreeUseYn").val(agree);
            // var pre = $("#config-pre").prop("checked")? "Y" :"N";
            // $("#preUseYn").val(pre);
            var dcrb = $("#config-dcrb").prop("checked")? "Y" :"N";
            $("#dcrbUseYn").val(dcrb);
            var sub = $("#config-sub").prop("checked")? "Y" :"N";
            $("#subUseYn").val(sub);
            var view = $("#config-view").prop("checked")? "Y" :"N";
            $("#viewUseYn").val(view);
            var ref = $("#config-ref").prop("checked")? "Y" :"N";
            $("#refUseYn").val(ref);
        }
        
        numbering = function(options){
            var reg = "";
            
            $.each(options, function(i, op){
                reg += $(op).attr('data-val');
            })
    
            $('#numberingReg').val(reg);
        }
    })
    </script>
</body>

</html>