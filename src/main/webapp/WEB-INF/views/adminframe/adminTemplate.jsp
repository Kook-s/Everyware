<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>EveryWre Admin</title>
   <link rel="shortcut icon" type="image/x-icon" href="/resources/img/EveryWarePageIcon.png">
  <!-- 메신저 css -->

  <!-- Google Font: Source Sans Pro -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
	
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
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
   <!-- sweetAlert2 -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
  <!-- tippy 툴팁 -->
<link rel="stylesheet"
	href="https://unpkg.com/tippy.js@6.3.3/dist/tippy.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script src="https://use.fontawesome.com/releases/v6.4.0/js/all.js"></script>
	
	<style type="text/css">
	 *{
   	font-family: 'Noto Sans KR', sans-serif;
   }
	
		body::-webkit-scrollbar {
	    width: 15px;
	  }
	  body::-webkit-scrollbar-thumb {
	    background-color: #2f3542;
	    border-radius: 5px;
	    background-clip: padding-box;
	    border: 2px solid transparent;
	  }
	  body::-webkit-scrollbar-track {
	    background-color: grey;
	    border-radius: 10px;
	    box-shadow: inset 0px 0px 5px white;
	  }
	</style>
</head>
<body class="hold-transition sidebar-mini layout-fixed sidebar-closed sidebar-collapse">
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

<%--<sec:authentication var="empId" property="principal.employee.empId"/>--%>


<div class="wrapper">
	<tiles:insertAttribute name="header"></tiles:insertAttribute>
	<tiles:insertAttribute name="aside"></tiles:insertAttribute>
	<div class="content-wrapper" style="min-height: 724px;">
    <tiles:insertAttribute name="content"></tiles:insertAttribute>
  	</div>
	<%-- <tiles:insertAttribute name="footer"></tiles:insertAttribute> --%>
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
<script src="/resources/js/admin_socket.js"></script>
<script>
   $.widget.bridge('uibutton', $.ui.button)
  
</script>
<!-- Bootstrap 4 -->
<script src="/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="/resources/bootstrap/plugins/chart.js/Chart.min.js"></script>
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
<!-- sweetAlert2 -->
<script src="/resources/bootstrap/plugins/sweetalert2/sweetalert2.min.js"></script>
</body>
</html>
