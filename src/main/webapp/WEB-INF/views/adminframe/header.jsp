<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div class="preloader flex-column justify-content-center align-items-center" style="height: 0px;">
    <img class="animation__shake" src="/resources/bootstrap/dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60" style="display: none;">
  </div>
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
   
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
	    <li class="nav-item dropdown dropdown_menu" id="goEW">
	      <a class="nav-link" data-toggle="dropdown">
	   		<i class="fa-solid fa-backward"></i>
	      	</a>
      	</li>
	    <li class="nav-item dropdown dropdown_menu"  id="logout">
	      <form action="/everyware/logout" method="post" id="logoutForm">
		       <sec:csrfInput/>
	      </form>
	      <a class="nav-link" data-toggle="dropdown" href="#" id="alarm_btn">
	   		<i class="fa-solid fa-door-open"></i>
	      	</a>
	      </li>
    </ul>
  
  </nav>
  
  <script type="text/javascript">
$(function(){
	 $("#goEW").on("click", function(){
		  location.href = "/everyware/main";
	  })
	 $("#logout").on("click", function(){
		  $("#logoutForm").submit();
	  })
})
</script>