<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>사원추가(엑셀)</title>

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
<body class="hold-transition sidebar-mini">
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
  <section class="content-header">
  </section>

  <div class="container-fluid">
    <div class="row">

      <!-- /.col -->
      <div class="col-md-12">
        <div class="card">
          <div class="card-header p-2">

            <div class="input-group">
              <input class="form-control m-sm-1" placeholder="사원정보가 담겨있는 파일을 추가해주세요." id="fileName">
              <div class="input-group-append">
                <label for="filePoi" type="button" class="btn btn-primary addBtn m-sm-1">
                  <form id="uploadFrm" enctype="multipart/form-data">
                    <input type="file" id="filePoi" accept=".xlsx, .xls">
                  </form>
                  <i class="fas fa-pencil-alt"> 업로드</i>
                </label>
                <label type="button" class="btn btn-primary m-sm-1" id="saveBtn">
                  <i class="fas fa-pencil-alt"> 저장</i>
                </label>
              </div>
            </div>
          </div><!-- /.card-header -->
        
          <div class="card-body " style="overflow-Y: scroll; height: 450px;display: block; padding: 0%">
            <table class="table table-striped projects m-0">
            	<thead> 
	            	<tr>
			              <th style="width: 15%;" class="text-center">
	               				 이름
			              </th>
			              <th style="width: 15%" class="text-center">
								 직급
			              </th>
			              <th style="width: 15%;" class="text-center">
			             		   부서
			              </th>
			              <th style="width: 15%" class="text-center">
			              		  사번
			              </th>
			              <th style="width: 15%" class="text-center">
			               		 이메일
			              </th>
	            	</tr>
            	</thead>
            	<tbody id="empTable">
            	
            	</tbody>
            </table>
          </div>
        </div>
        <!-- /.card -->
      </div>
      <!-- /.col -->
    </div>
  </div>
</div>
<!-- ./wrapper -->

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
	  
	  
      $("#filePoi").hide()
     var empTotalList = [];
      
    $('.addBtn').on('change', function(event){
      $("#fileName").val($("#filePoi").val());
      
       var files = event.target.files;
       var file = files[0];
       var formData = new FormData();
       formData.append("file", file);

      $.ajax({
        type:'post',
        url: "/everyware/popup/excelEmp",
        data: formData,
        dataType: "json",
        processData: false,
        contentType: false,
        beforeSend : function(xhr){
          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success: function(data){
        	var empList ="";
         	console.log("받은거 확인",data)
        	 empTotalList = data;
         	
         	
         	 $.each(data, function(index, employee) {
         	
                 empList+=
                	 	 `<tr>
		                     <th style="width: 15%" class="text-center">
		                     	\${employee.empName}
		                     </th>
		                     <th style="width: 15%;" class="text-center">
		                    	 \${employee.department.deptNm}
		                     </th>
		                     <th style="width: 15%" class="text-center">
		                     	\${employee.position.jbgdNm}
		                     </th>
		                     <th style="width: 15%;" class="text-center">
		                     	\${employee.empId}
		                     </th>
		                     <th style="width: 15%" class="text-center">
		                    	 \${employee.empMail}
		                     </th>
         		 		</tr>`
                		 
             });
         	console.log(empTotalList)
         	$("#empTable").html(empList);
        },
        error: function(xhr){
          alert("실패",xhr.status);
        }
      })
    })
    
    $("#saveBtn").on('click', function(){
    	// 저장 누르면 저장
    	  for (var i = 0; i < empTotalList.length; i++) {
    	    console.log(empTotalList[i].empId);
    	  }
    	
    	  $.ajax({
    	        url:'/everyware/popup/addNewEmp',
    	        method: 'post',
    	        data: JSON.stringify(empTotalList),
    	        dataType: "json",
    	        contentType : "application/json",
    	        beforeSend : function(xhr){
    	            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    	          },
    	        success: function(res){
    	          if(res == 'OK') {
    	            Toast.fire({
    	              icon: 'success',
    	              title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
    	            })
    	            $("#empTable").html("");
    	          }else{
    	            alert("실패1")
    	          }
    	        },
    	        error: function(xhr){
    	          console.log("실패: ",xhr.status);
    	          Toast.fire({
    	            icon: 'error',
    	            title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
    	          })
    	        }
    	      })
    	
    	
    	});
      
  })

</script>
</html>

