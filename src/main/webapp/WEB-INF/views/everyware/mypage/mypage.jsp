<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | Lockscreen</title>

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&amp;display=fallback">

<link rel="stylesheet"
	href="../../plugins/fontawesome-free/css/all.min.css">

<link rel="stylesheet" href="../../dist/css/adminlte.min.css?v=3.2.0">
</head>
<body class="hold-transition lockscreen">
<sec:authentication var="employee" property="principal.employee"/>
	<div class="lockscreen-wrapper"
		style="max-width: 100%; margin-top: 0px; padding-top: 10%;">
		<div class="lockscreen-logo" style="font-weight: bold;" >
			<img src="../../resources/img/열쇠.png" alt="User Image"
				style="width: 6%; margin-bottom: 2%;">
			<h2 style="margin-bottom: 2%;">비밀번호를 다시 입력해주세요!</h2>
				<h3>${emp.empName }님!</h3>
			<div style="margin-top: 30px;">
				<h5> 외부로부터 사원님의 정보를 더 안전하게 보호하기 위한 방법입니다.​</h5>
				<h5>본인확인을 위해 현재 사용하고 있는 사원님의 비밀번호를 한 번 더 입력해주세요.</h5>
			</div>
		</div>
		<div class="lockscreen-item" style="margin-top: 60px">
			<div class="lockscreen-image"
				style="width: 81px; height: 80px;">
				<c:if test="${not empty employee.empProfile}">
					<img src="/everyware/mypage/thumbnail" alt="User Image">
				</c:if>
				<c:if test="${empty employee.empProfile}">
					<img src="/resources/img/basicProfile.png" alt="User Image">
				</c:if>
			</div>
			<form id="form" action="/everyware/confirmPw" class="lockscreen-credentials" method="post">
				<div class="input-group">
					<input type="hidden" id="empId" name="empId" value="${empId }">
					<input type="password" id="empPwTest" name="empPw"
						onchange="inputValueChange()" class="form-control"
						placeholder="password">
					<div class="input-group-append">
						<button type="button" class="btn" name="btn">
							<i class="fas fa-arrow-right text-muted"></i>
						</button>
					</div>
				</div>
				<sec:csrfInput/>
			</form>
		</div>
	</div>

	<script src="../../plugins/jquery/jquery.min.js"></script>

	<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>


</body>
<script type="text/javascript">
	var flag="${flag}"
	if(flag=='false'){
		alert("비밀번호가 틀렸습니다.")
	}

	function inputValueChange() {
		var empPwTest = document.getElementById('empPwTest').value;
		console.log(empPwTest)
	}

	$(function() {
		var btn = $(".btn");
		var empPw = $("#empPw");
		btn.on("click", function() {
			$("#form").submit()

		});

	});
	
	
</script>
</html>
