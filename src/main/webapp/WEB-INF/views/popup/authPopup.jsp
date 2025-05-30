<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>EveryWare 권한관리</title>
  
  <!-- 메신저 css -->
  <link rel="stylesheet" href="/resources/css/chat.css">

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="/resources/bootstrap/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- JQVMap -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/jqvmap/jqvmap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/resources/bootstrap/dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/daterangepicker/daterangepicker.css">
  <!-- summernote -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/summernote/summernote-bs4.min.css">
  <!-- fullCalendar -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/fullcalendar/main.css">
  <!-- Theme style -->
  <!-- tippy 툴팁 -->
<link rel="stylesheet"
	href="https://unpkg.com/tippy.js@6.3.3/dist/tippy.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<body class="hold-transition sidebar-mini layout-fixed sidebar-closed sidebar-collapse"  style="overflow: hidden;">
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<div class="wrapper">
<div class="row p-1">
      <div class="col-md-3">
        <b href="mailbox.html" class="btn btn-primary btn-block mb-3">관한관리</b>
        <div class="card">
          <div class="card-header">
            <h3 class="card-title">권한</h3>
            <div class="card-tools">
                 <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
              </button>
            </div>
          </div>
          <div class="card-body p-0 w-100">
            <ul class="nav nav-pills flex-column" id="authTotal" style="overflow-y: scroll; height: 310px;">
              <c:if test="${authList ne 'null'}">
                <c:forEach items="${authList}" var="auth">
                  <li class="nav-item authList" value="${auth.authrtId}">
                    <a href="#" class="nav-link">
                      <i class="fas fa-inbox"></i> 
                      <b>${auth.authrtNm }</b>
                    </a>
                  </li>
                </c:forEach>
              </c:if>

              <li class="nav-item active deptList" value="total">
              </li>
            </ul>
            <a href="#" class="nav-link" style="border-top: 1px solid gainsboro;">
              <div class="input-group">
                <input id="authAddNm" type="text" class="form-control" placeholder="권한생성">
                <div class="input-group-append">
                  <button type="button" class="btn btn-primary" id="authAdd">생성</button>
                </div>
              </div>
            </a>
          </div>
          <!-- /.card-body -->
        </div>
      
      <!-- /.col -->
    </div>
              <div class="col-md-9">
          <div class="card">
            <div class="card-header p-2">
              <ul class="nav nav-pills">
                <li class="nav-item"><a class="nav-link active" href="#activity" data-toggle="tab" id="authTitle">정보</a></li>
              </ul>
            </div><!-- /.card-header -->
            <div class="card-body">
              <div class="tab-content">
                <div class="active tab-pane" id="activity">
                	<b id="guide">왼쪽 리스트에서 조회하실 권한을 선택해주세요.</b>
					<input type="hidden" id="authId" value="">
                  <table class="table table-striped projects" id="authTable">
                    <tr>
                      <th style="width: 5%;" class="text-center pt-3">
                        	회사관리
                      </th>
                      <th style="width: 5%" class="text-left pt-2">
                        <div class="input-group">
                          <select name="" id="EM_AD" class="menuSelect">
                            <option value="N">미사용</option>
                            <option value="Y">사용</option>
                          </select>
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                      <th style="width: 5%;" class="text-center pt-3">
                        결제관리
                      </th>
                      <th style="width: 5%" class="text-left pt-2">
                        <div class="input-group">
                          <select name="" id="APPROVAL_AD" class="menuSelect">
                            <option value="N">미사용</option>
                            <option value="Y">사용</option>
                          </select>
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                    </tr>
                     <tr>
                      <th style="width: 5%;" class="text-center pt-3">
                        이메일
                      </th>
                      <th style="width: 5%" class="text-left pt-2">
                        <div class="input-group">
                          <select name="" id="MAIL_AD" class="menuSelect">
                            <option value="N">미사용</option>
                            <option value="Y">사용</option>
                          </select>
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                      <th style="width: 5%;" class="text-center pt-3">
                        채팅
                      </th>
                      <th style="width: 5%" class="text-left pt-2">
                        <div class="input-group">
                          <select name="" id="CHAT_AD" class="menuSelect">
                            <option value="N">미사용</option>
                            <option value="Y">사용</option>
                          </select>
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                    </tr> <tr>
                      <th style="width: 5%;" class="text-center pt-3">
                        주소록
                      </th>
                      <th style="width: 5%" class="text-left pt-2">
                        <div class="input-group">
                          <select name="" id="ADDRESSBOOK_AD" class="menuSelect">
                            <option value="N">미사용</option>
                            <option value="Y">사용</option>
                          </select>
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                      <th style="width: 5%;" class="text-center pt-3">
                        캘린더
                      </th>
                      <th style="width: 5%" class="text-left pt-2">
                        <div class="input-group">
                          <select name="" id="CALENDAR_AD" class="menuSelect">
                            <option value="N">미사용</option>
                            <option value="Y">사용</option>
                          </select>
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                    </tr> <tr>
                      <th style="width: 5%;" class="text-center pt-3">
                       근태
                      </th>
                      <th style="width: 5%" class="text-left pt-2">
                        <div class="input-group">
                          <select name="" id="HR_AD" class="menuSelect">
                            <option value="N">미사용</option>
                            <option value="Y">사용</option>
                          </select>
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                      <th style="width: 5%;" class="text-center pt-3">
                        예약
                      </th>
                      <th style="width: 5%" class="text-left pt-2">
                        <div class="input-group">
                          <select name="" id="RESERVATION_AD" class="menuSelect">
                            <option value="N">미사용</option>
                            <option value="Y">사용</option>
                          </select>
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                    </tr>
                     <tr>
                      <th style="width: 5%;" class="text-center pt-3">
                        설문
                      </th>
                      <th style="width: 5%" class="text-left pt-2">
                        <div class="input-group">
                          <select name="" id="SUVY_AD" class="menuSelect">
                            <option value="N">미사용</option>
                            <option value="Y">사용</option>
                          </select>
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                      <th style="width: 5%;" class="text-center pt-3">
                        게시판
                      </th>
                      <th style="width: 5%" class="text-left pt-2">
                        <div class="input-group">
                          <select name="" id="BOARD_AD" class="menuSelect">
                            <option value="N">미사용</option>
                            <option value="Y">사용</option>
                          </select>
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                    </tr>
                  
                  </table>
                </div>
              </div>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div><!-- /.card-body -->
        </div>
  </div>
</div>

<!-- jQuery -->
<script src="/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="/resources/bootstrap/plugins/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript">
window.messengerCsrf = "${_csrf.headerName}";
window.messengerCsrfToken = "${_csrf.token}";
window.messengerEmpId = "${empId}";
console.log("asdasd")
console.log("empId : " + window.messengerEmpId);
console.log("csrf : " + window.messengerCsrf);
console.log("token : " + window.messengerCsrfToken);
</script>
<script>
   $.widget.bridge('uibutton', $.ui.button)
  
</script>
<script src="/resources/js/chat.js"></script>
<!-- Bootstrap 4 -->
<script src="/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="/resources/bootstrap/plugins/chart.js/Chart.min.js"></script>
<script src="/resources/bootstrap/plugins/sweetalert2/sweetalert2.min.js"></script>
<!-- Sparkline -->
<script src="/resources/bootstrap/plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="/resources/bootstrap/plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="/resources/bootstrap/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="/resources/bootstrap/plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="/resources/bootstrap/plugins/moment/moment.min.js"></script>
<script src="/resources/bootstrap/plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="/resources/bootstrap/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="/resources/bootstrap/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="/resources/bootstrap/dist/js/adminlte.js"></script>

</body>
<script>
  $(function(){
    var Toast = Swal.mixin({
      toast: true,
      position: 'top-end',
      showConfirmButton: false,
      timer: 3000
    });
   $("#authTable").hide();
   
    
  $("#authAdd").on("click",function(){
	 
	  //alert($("#authAddNm").val())
	  
	   $.ajax({
        url: '/everyware/popup/addAuthGrop',
        method: 'post',
        data:{authrtNm:  $("#authAddNm").val()
        },
        beforeSend : function(xhr){
          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success: function(res){
          if(res == 'OK') {
            Toast.fire({
              icon: 'success',
              title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
            })
          }else{
            Toast.fire({
              icon: 'error',
              title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
            })
          }
        },
        error: function(xhr){
          Toast.fire({
              icon: 'error',
              title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
            })
        }
      })
  })
  
  $(".authList").on('click', function(){
	  $("#authTable").show();
	  $("#guide").hide();
	  $("#authTitle").text($(this).find("b").text())
	  $("#authId").val($(this).val())
	  $.ajax({
        url: '/everyware/popup/getAuthMenu',
        method: 'post',
        data:{authrtId:  $(this).attr("value")
        },
        beforeSend : function(xhr){
          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success: function(res){
         	var authNum = '';
            Toast.fire({
              icon: 'success',
              title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
            })
             $.each(res, function(index, authMenu) {
            	
            	if(authMenu.menuId == 'EM_AD'){
            		$("#"+authMenu.menuId).val('Y')
            	}
            	if(authMenu.menuId == 'APPROVAL_AD'){
            		$("#"+authMenu.menuId).val('Y')
            	}
            	if(authMenu.menuId == 'MAIL_AD'){
            		$("#"+authMenu.menuId).val('Y')
            	}
            	if(authMenu.menuId == 'CHAT_AD'){
            		$("#"+authMenu.menuId).val('Y')
            	}
            	if(authMenu.menuId == 'ADDRESSBOOK_AD'){
            		$("#"+authMenu.menuId).val('Y')
            	}
            	if(authMenu.menuId == 'CALENDAR_AD'){
            		$("#"+authMenu.menuId).val('Y')
            	}
            	if(authMenu.menuId == 'HR_AD'){
            		$("#"+authMenu.menuId).val('Y')
            	}
            	if(authMenu.menuId == 'RESERVATION_AD'){
            		$("#"+authMenu.menuId).val('Y')
            	}
            	if(authMenu.menuId == 'SUVY_AD'){
            		$("#"+authMenu.menuId).val('Y')
            	}
            	if(authMenu.menuId == 'BOARD_AD'){
            		$("#"+authMenu.menuId).val('Y')
            	}
             })
        },
        error: function(xhr){
          console.log("실패",xhr.status);
          Toast.fire({
              icon: 'error',
              title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
            })
        }
      })
  })
  
  
  $(".menuSelect").on("change", function(){
	  
	   $.ajax({
        url: '/everyware/popup/addDelAuthMenu',
        method: 'post',
        data:{	authrtId:  $("#authId").val(),
	        	addDel: $(this).val(),
	        	authMenu: $(this).attr("id")
        },
        beforeSend : function(xhr){
          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success: function(res){
         	var authNum = '';
        	console.log(res)
            Toast.fire({
              icon: 'success',
              title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
            })
        },
        error: function(xhr){
          console.log("실패",xhr.status);
          Toast.fire({
              icon: 'error',
              title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
            })
        }
      })
	  
  })
    
  })

</script>


</html>
