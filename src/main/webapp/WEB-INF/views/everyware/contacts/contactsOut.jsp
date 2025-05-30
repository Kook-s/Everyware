<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<link rel="stylesheet" href="https://cdn.datatables.net/select/1.7.0/css/select.dataTables.min.css">


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js" defer></script>
<script src="https://cdn.datatables.net/1.13.5/js/dataTables.bootstrap4.min.js" defer></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js" defer></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap4.min.js" defer></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js" defer></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.colVis.min.js" defer></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js" defer></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js" defer></script>

<script src="https://cdn.datatables.net/select/1.7.0/js/dataTables.select.min.js" defer></script>
<style>
    table.dataTable>tbody>tr>td.select-checkbox:before,
    table.dataTable>tbody>tr>th.select-checkbox:before {
        margin-top: -9px !important;
        margin-left: -9px !important;
        border: 1px solid #c1c1c1 !important;
    }
    table.dataTable>tbody>tr>td.select-checkbox:before,
    table.dataTable>tbody>tr>td.select-checkbox:after,
    table.dataTable>tbody>tr>th.select-checkbox:before,
    table.dataTable>tbody>tr>th.select-checkbox:after{
        width: 20px !important;
        height: 20px !important;
    }
    table.dataTable>tbody>tr.selected>td.select-checkbox:after,
    table.dataTable>tbody>tr.selected>th.select-checkbox:after{
        margin-top: -13px !important;
        margin-left: -9px !important;
    }
    #contact-table{
        width: 100% !important;
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
                        <h1>사외주소록</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">사외주소록</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">DataTable with minimal features &amp; hover style</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                    <div class="row">
                                        <button type="button" class="contact-edit-btn">수정</button>
                                        <button type="button" class="contact-delete-btn">삭제</button>
                                        <div class="col-sm-12 col-md-6">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <table id="contact-table"
                                                class="table table-bordered table-hover dataTable dtr-inline">
                                                <thead>
                                                    <tr>
                                                        <th></th>
                                                        <th>소속</th>
                                                        <th>이름</th>
                                                        <th>연락처1</th>
                                                        <th>연락처2</th>
                                                        <th>이메일</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                   <c:forEach items="${list }" var="contact">
                                                    <tr class="odd" contactSn="${contact.contactSn}">
                                                        <td tabindex="-1">
                                                            <!-- <div class="icheck-primary d-inline">
                                                                <input type="checkbox" id="${contact.contactSn}">
                                                                <label for="${contact.contactSn}"></label>
                                                            </div> -->
                                                        </td>
                                                        <td>${contact.ogdpInstNm}</td>
                                                        <td>${contact.name}</td>
                                                        <td>${contact.telno1 }</td>
                                                        <td>${contact.telno2 }</td>
                                                        <td>${contact.emlAddr }</td>
                                                    </tr>
                                                   </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <!-- <div class="row">
                                        <div class="col-sm-12 col-md-1"></div>
                                        <div class="col-sm-12 col-md-7">
                                        </div>
                                    </div> -->
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
<script src="../../../../resources/bootstrap/plugins/jszip/jszip.min.js"></script>
<script src="../../../../resources/bootstrap/plugins/pdfmake/pdfmake.min.js"></script>
<script src="../../../../resources/bootstrap/plugins/pdfmake/vfs_fonts.js"></script>
<script>
    var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
    var csrfToken = $('meta[name="_csrf"]').attr('content');

    $(function () {
        var editBtn = $('.contact-edit-btn');
        var delBtn = $('.contact-delete-btn');
        
        var isEditing = false;
        
        var table = $('#contact-table').DataTable({
            responsive: true,
            lengthChange: true,
            autoWidth: true,
            order: [[1, 'asc']],
            columnDefs: [
                {
                    orderable: false,
                    sortable: false,
                    selectable: false,
                    className: 'select-checkbox',
                    targets: 0
                }
            ],
            select: {
                style: 'multi',
                selector: 'td:first-child',
                info: false
            },
            language: {
                info: 'total: _TOTAL_',
                search: '검색:',
                lengthMenu: '_MENU_ 개씩 보기'
            },
            dom: 'Bfrtip',
            buttons: ["excel", "pdf", "print"]
        })
        table.buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
        // $('#example1').DataTable({
            //     "paging": true,
            //     "lengthChange": false,
            //     "searching": false,
            //     "ordering": true,
            //     "info": true,
            //     "autoWidth": false,
            //     "responsive": true,
            // });

        var checkBoxes = $('.select-checkbox').get();
        removeTabIndex = function(checkBoxes){
            $.each(checkBoxes, function(i){
                $(checkBoxes[i]).attr('tabindex', -1);
            })
        }
        removeTabIndex(checkBoxes);
            
        editBtn.on('click', function(){
            var rows = $('#contact-table .selected').get();
            
            if(!isEditing){
                editBtn.text('취소');
                editBtn.addClass('editing');
                delBtn.text('완료');
                delBtn.addClass('editing');

                // 추가선택 방지
                table.settings()[0]._select.className = '';
                
                $.each(rows, function(i){
                    var cells = rows[i].cells;
                    changeToInput(cells);
                })
                
                $('#contact-table input:text')[0].focus();
                
                isEditing = true;
                return false;
            }
            
            if(isEditing){
                editBtn.text('수정');
                editBtn.removeClass('editing');
                delBtn.text('삭제');
                delBtn.removeClass('editing');
                
                table.settings()[0]._select.className = 'selected';

                $.each(rows, function(i){
                    var cells = rows[i].cells;
                    changeToTd(cells);
                })
                
                isEditing = false;
                return false;
            }
        })

        delBtn.on('click', function(){
            var rows = $('#contact-table .selected').get();

            if(!isEditing){
                if(confirm('주소록을 삭제하시겠습니까?')){
                    var contactNums = [];
                    var els = [];
                    $.each(rows, function(i){
                        contactNums.push($(rows[i]).attr('contactSn'));
                        els.push(rows[i]);
                    })
                    console.log(contactNums);
                    deleteRows(contactNums, els);
                    return true;
                } 
                return false;
            }
            
            if(isEditing){
                if(confirm('주소록을 수정하시겠습니까?')){
                    var contacts = [];

                    $.each(rows, function(i, row){
                        console.log(row);
                        var contact = {
                            contactSn: $(row).attr('contactSn'),
                            ogdpInstNm: $(row).children('td:eq(1)').children('input').val(),
                            name: $(row).children('td:eq(2)').children('input').val(),
                            telno1: $(row).children('td:eq(3)').children('input').val(),
                            telno2: $(row).children('td:eq(4)').children('input').val(),
                            emlAddr: $(row).children('td:eq(5)').children('input').val()
                        }
                        console.log(contact);
                        contacts.push(contact);
                    })
                    updateRows(contacts)

                    editBtn.text('취소');
                    editBtn.addClass('editing');
                    delBtn.text('완료');
                    delBtn.addClass('editing');

                    $.each(rows, function(i){
                        inputToObject($(rows[i]).find('td').get());
                    })

                    table.settings()[0]._select.className = 'selected';
                    table.rows().deselect();
                    return true;
                }
            }
        });

        // $.ajax({
        //     url: "/everyware/contacts/out",
        //     type: "GET",
        //     dataType: 'json',
        //     success: function (rslt) {
        //         console.log(rslt);
        //         grid.resetData(rslt);
        //     }
        // })

    });

    inputToObject = function(cells){
        for(var i=1; i<cells.length; i++){
            var value = $(cells[i]).find('input').val();
            $(cells[i]).attr('text', value);
            $(cells[i]).html(value);
            
        }
    }

    changeToInput = function(cells){
        for(var i=1; i<cells.length; i++){
            var value = cells[i].innerText;
            $(cells[i]).attr('text', value);

            var input = $('<input>');

            input.attr('type', 'text');
            input.val(value);
            input.attr('onfocus', 'selextText(this)');

            $(cells[i]).html(input);
        }
    }
    changeToTd = function(cells){
        for(var i=1; i<cells.length; i++){
            var value = $(cells[i]).attr('text');
            $(cells[i]).html(value);
        }
    }
    selextText = function(fthis){
        $(fthis).select();
    }

    updateRows = function(contacts){
        $.ajax({
            url: '/everyware/contacts/out',
            method: 'PUT',
            data: JSON.stringify(contacts),
            contentType : "application/json; charset=utf-8",
            beforeSend : function(xhr){
                xhr.setRequestHeader(csrfHeader,csrfToken);
            },
            success: function(rslt){
                alert(rslt);
            }
        })
    }

    deleteRows = function(contactNums, els){
        $.ajax({
            url: '/everyware/contacts/out',
            method: 'DELETE',
            data: JSON.stringify(contactNums),
            contentType : "application/json; charset=utf-8",
            beforeSend : function(xhr){
                xhr.setRequestHeader(csrfHeader,csrfToken);
            },
            success: function(rslt){
                alert(rslt);

                if(rslt.toLowerCase() == 'ok'){
                    $.each(els, function(i){
                        els[i].remove();
                    })
                }
            }
        })
    }
</script>
</body>

</html>