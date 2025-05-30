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
  <title>EveryWare</title>
  
   <style>
   *{
   	font-family: 'Noto Sans KR', sans-serif;
   }

 body::-webkit-scrollbar {
    width: 15px;
  }
  body::-webkit-scrollbar-thumb {
    background-color: #217af4;;
    border-radius: 5px;
    background-clip: padding-box;
    border: 2px solid transparent;
  }
  body::-webkit-scrollbar-track {
    background: rgba(33, 122, 244, 0.3);
    border-radius: 10px;
    box-shadow: inset 0px 0px 5px white;
  }
   
   .loadingPage{
    background: #FFF;
    display: flex;
    justify-content: center;
    align-items: center;
    position: fixed;
    width: 100%;
    height: 100%;
	z-index: 9999;
   }
  .loader {
  font-size: 100px;
  display: inline-block;
  font-family: Arial, Helvetica, sans-serif;
  font-weight: bold;
  color: #007bff;
  letter-spacing: 2px;
  position: relative;
  box-sizing: border-box;
}
.loader::after {
  content: 'EveryWare';
  position: absolute;
  left: 0;
  top: 0;
  color: #fff;
  text-shadow: 0 0 2px #fff, 0 0 1px #fff, 0 0 1px #fff;
  width: 100%;
  height: 100%;
  overflow: hidden;
  box-sizing: border-box;
  animation: animloader 0.5s linear infinite;
}

@keyframes animloader {
  0% {
    height: 100%;
  }
  100% {
    height: 0%;
  }
}
    </style>
  <link rel="shortcut icon" type="image/x-icon" href="/resources/img/EveryWarePageIcon.png">
  <!-- 메신저 css -->
  <link rel="stylesheet" href="/resources/css/chat.css">

  <!-- Google Font: Source Sans Pro -->
  <!-- <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback"> -->
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
  
  <link rel="stylesheet" href="/resources/css/sideButton.css">
  <!-- Theme style -->
  <!-- tippy 툴팁 -->
<link rel="stylesheet"
	href="https://unpkg.com/tippy.js@6.3.3/dist/tippy.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	  <!-- Toastr -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/toastr/toastr.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/resources/bootstrap/dist/css/adminlte.min.css">
  <!-- sweetAlert2 -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
  <script src="https://use.fontawesome.com/releases/v6.4.0/js/all.js"></script>
</head>
<body class="sidebar-mini control-sidebar-slide-open layout-fixed layout-navbar-fixed">
<!-- <body class="hold-transition sidebar-mini layout-fixed"> -->

<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

<sec:authentication var="empId" property="principal.employee.empId"/>
<sec:authentication var="conm" property="principal.employee.conm"/>

 <sec:authentication var="menuList" property='principal.employee.authMenuList' />

	<div class="loadingPage">
	    <span class="loader">EveryWare</span>
	</div>
	
	<div class="sideHomeBtn">
        <ion-icon name="rocket-outline"></ion-icon>
    </div>
    <div class="sideMsg msgBtn"><ion-icon name="chatbubbles-outline"></ion-icon></div>
    <div class="sideZoom"><ion-icon name="desktop-outline"></ion-icon></div>
    
    <sec:authorize access="hasAuthority('HOME_AD')">  
			  <c:forEach items="${menuList }"  var="authmenu">
		      	<c:if test="${authmenu.menu.menuId eq 'HOME_AD'}">
    				<div class="sideAdmin"><a href="${authmenu.menu.menuUrl }" style="text-decoration: none; color: #FFF"><ion-icon name="business-outline"></ion-icon></a></div>
		        </c:if>
		      </c:forEach>
     </sec:authorize>
    
    

<div class="wrapper">
	<tiles:insertAttribute name="header"></tiles:insertAttribute>
	<tiles:insertAttribute name="aside"></tiles:insertAttribute>
	<div class="content-wrapper" style="min-height: 724px;margin-top: 0%;">
    <tiles:insertAttribute name="content"></tiles:insertAttribute>
  	</div>
	<tiles:insertAttribute name="footer"></tiles:insertAttribute>
	
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- 버튼 완성되면 갈아끼울게요(이 아래코드부터 무시하세요) -->
<!-- 	<style>
		.msgBtn{
			position: fixed;
			right: 25px;
			bottom: 25px;
		}
	</style>
	<button class="msgBtn">메신저</button>
</div>




	<button class="msgBtn">msgBtn</button> -->
	
	
	
	
	
	
	<!-- 여기부턴 메신저 요소임 -->
	<div id="messenger"
		style="right: 100px; bottom: 10px;">
		<div class="row flex-row">

			<!--  왼쪽 메뉴 -->
			<div class="col-4">
				<div
					class="card max-height-vh-70 overflow-auto overflow-x-hidden mb-5 mb-0 left_content">
					<form class="card-header searchForm">
						<div class="input-group input-group-outline">
							<input type="text" class="form-control" placeholder="Search contact" id="input_search">
						</div>
					</form>
					<div id="createRoomBtn"></div>
					<div id="chatprofile_list" class="card-body p-2 overflow-auto overflow-x-hidden"></div>
					<div id="chatroom_list" class="card-body p-2 overflow-auto overflow-x-hidden"></div>
					<div id="search_list" class="card-body p-2 overflow-auto overflow-x-hidden">
						<h4>인원 선택</h4>
						<div id="selected_div">
							
						</div>
					</div>
					<div class="chat_switch">
						<div class="on_profile_list on">프로필</div>
						<div class="on_chatroom_list">채팅방</div>
					</div>
				</div>
			</div>
			<div class="col-8">
				<div class="card max-height-vh-70 right_content">
					<div
						class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 bg-transparent">
						<div class="bg-gradient-primary shadow-primary border-radius-lg p-3 chatroom_header">
							<div class="row">
								<div class="col-md-10">
									<div class="d-flex align-items-center chatroom_header_profile">
										<div class="ms-3 chatroom_header_name">
											<h6 class="mb-0 d-block text-white"></h6>
											<span class="text-sm text-white opacity-8"></span>
										</div>
									</div>
								</div>
								<div class="col-1 my-auto"></div>
								<div class="col-1 my-auto">
									<div class="dropdown">
										<!-- <button class="btn btn-icon-only text-white mb-0" type="button" data-bs-toggle="dropdown">
                            <i class="material-icons"></i>
                          </button> -->
										<ul class="dropdown-menu dropdown-menu-end me-sm-n2 p-2"
											aria-labelledby="chatmsg">
											<li><a class="dropdown-item border-radius-md"
												> Profile </a></li>
											<li><a class="dropdown-item border-radius-md"
												> Mute conversation </a></li>
											<li><a class="dropdown-item border-radius-md"
												> Block </a></li>
											<li><a class="dropdown-item border-radius-md"
												> Clear chat </a></li>
											<li>
												<hr class="dropdown-divider">
											</li>
											<li><a
												class="dropdown-item border-radius-md text-danger"
												> Delete chat </a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="card-body overflow-auto overflow-x-hidden chat_list">
						
					</div>
					<div class="pre_img">
						<img alt="ss" src="/resources/img/Anne-Marie(앤마리)-2002.jpg">
					</div>
					<div class="card-footer d-block">
						<form class="align-items-center">
							<div class="input-group input-group-outline d-flex send_btn_group"><input
									type="text" class="form-control form-control-lg" placeholder="Type your message" id="send_text">
								<div id="image_send_btn"></div>
								<input type="file" name="file" id="fileSelector">
								<button class="btn bg-gradient-primary mb-0" id="send_btn" type="button">
									<i class="material-icons">send</i>
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
<!-- jQuery -->
<!-- <script src="/resources/bootstrap/plugins/jquery/jquery.min.js"></script> -->
<!-- jQuery UI 1.11.4 -->
<script src="/resources/bootstrap/plugins/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript">
window.messengerCsrf = "${_csrf.headerName}";
window.messengerCsrfToken = "${_csrf.token}";
window.messengerEmpId = "${empId}";
window.messengerConm = "${conm}";
console.log("asdasd")
console.log("empId : " + window.messengerEmpId);
console.log("csrf : " + window.messengerCsrf);
console.log("token : " + window.messengerCsrfToken);
</script>
<script>
   $.widget.bridge('uibutton', $.ui.button)
   
      // 로딩코드
   // 로딩시간 짧다싶으면 none으로 바꿀 시간 settimeout으로 넉넉하게 잡아도 될듯?
  /*  window.addEventListener('load', function() {
            $(".loadingPage").css("display","none")
            $(".header_nav").css("position","fixed")
        }); */
   setTimeout(() => {
	   $(".loadingPage").css("display","none")
       $(".header_nav").css("position","fixed")
}, 500);
   
   
   $(function(){
    $(".sideHomeBtn").on('click', function(){
        if($(".sideHomeBtn").attr("class")=="sideHomeBtn sideActive"){
            $(".sideHomeBtn").removeClass("sideActive");

            $(".sideMsg").removeClass("sideActive");
            $(".sideZoom").removeClass("sideActive");
            $(".sideAdmin").removeClass("sideActive");
        }else{
            $(".sideHomeBtn").addClass("sideActive");

            $(".sideMsg").addClass("sideActive");
            $(".sideZoom").addClass("sideActive");
            $(".sideAdmin").addClass("sideActive");
        }
    })
})
  
</script>
<script src="/resources/js/chat.js"></script>
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
<!-- 알람toastr -->
<script src="/resources/bootstrap/plugins/toastr/toastr.min.js"></script>
<!-- sweetAlert2 -->
<script src="/resources/bootstrap/plugins/sweetalert2/sweetalert2.min.js"></script>
</body>
</html>
