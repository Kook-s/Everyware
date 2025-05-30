<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<style>
table {
	border-spacing: 23px;
	border-collapse: separate;
}

td, th {
	font-size: 25px;
}

td {
	padding-left: 5px;
	text-align: center;
	border-right: 1px solid;
}

th {
	padding-left: 80px;
}

#btnUpd, #btnIp, #btnBck {
	color: #fff;
	background-color: #007bff;
	border-color: #007bff;
	box-shadow: none;
	border: none;
	border-radius: 5px;
	padding: 8px;
}
</style>
<html>
<body class="hold-transition sidebar-mini">
	<form:form method="post" action="/everyware/mypageupdate" id="emp">
		<input type="hidden" name="empId" value="${emp.empId }">
		<div  style="margin-left: 1px;">
			<div class="container-fluid">
				<div class="row" style="padding-top: 50px;">
					<div class="col-md-3" style="max-width: 15%;">

						<div class="card card-primary card-outline">
							<div class="card-body box-profile">
								<div class="text-center">
									<img src="${emp.empProfile }" alt="User Image"
										style="width: 50px;">
								</div>

								<h3 class="profile-username text-center">${emp.empName }</h3>


								<ul class="list-group list-group-unbordered mb-3">
									<li
										style="display: flex; flex-direction: column; align-items: center;"
										class="list-group-item"><b>입사일</b> <b class="float-right">
											<fmt:formatDate value="${emp.empDate }" pattern="yyyy-MM-dd"
												type="date" />
									</b></li>

								</ul>

								<a href="#" class="btn btn-primary btn-block"><b>프로필 사진
										변경</b></a>
							</div>
						</div>
					</div>
					<div class="col-md-9">
						<div class="card">
							<input type="hidden" id="empPw" name="empPw" value="${empPw }">
							<table>
								<tr>
									<td>이름</td>
									<th>${emp.empName }${emp.jbgdNm }</th>
								</tr>
								<tr>
									<td>사번</td>
									<th>${emp.empId }</th>
								</tr>
								<tr>
									<td>부서</td>
									<th>${emp.deptNm }</th>
								</tr>
								<tr>
									<td>생년월일</td>
									<th><fmt:formatDate value="${emp.empBirth }"
											pattern="yyyy-MM-dd" type="date" /></th>
								</tr>
								<tr>
									<td>이메일</td>
									<th><input type="text" id="empMail" name="empMail"
										style="width: 70%;" value="${emp.empMail }" /></th>
								</tr>
								<tr>
									<td>전화번호</td>
									<th><input type="text" id="empTel" name="empTel"
										style="width: 70%;" value="${emp.empTel }" /></th>
								</tr>
								<tr>
									<td>주소</td>
									<th><input type="text" id="empAddr1" name="empAddr1"
										style="width: 70%;" value="${emp.empAddr1 }" /></th>
								</tr>
								<tr>
									<td>상세주소</td>
									<th><input type="text" id="empAddr2" name="empAddr2"
										style="width: 70%;" value="${emp.empAddr2 }" /></th>
								</tr>

							</table>

						</div>
					</div>
				</div>
			</div>

			<div style="padding-left: 80%;">
				<button type="button" id="btnUpd">수정 완료</button>
				<button type="button" id="btnBck">뒤로가기</button>

			</div>
		</div>
		<sec:csrfInput />
	</form:form>
</body>
<script src="../../plugins/jquery/jquery.min.js"></script>
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../../dist/js/adminlte.min.js"></script>
<script src="../../dist/js/demo.js"></script>
<script type="text/javascript">
	$(function() {
		var btnUpd = $("#btnUpd");
		var btnBck = $("#btnBck");

		btnBck.on("click", function() {
			location.href = "/everyware/mypagemain"
		})

		btnUpd.on("click", function() {

			var email = $("#empMail").val();
			var Tel = $("#empTel").val();
			var addr1 = $("#empAddr1").val();
			var addr2 = $("#empAddr2").val();
			var emp = $("#emp");

			if (email == null || email === "") {
				alert("이메일을 입력해주세요");
				return false;
			}

			if (Tel == null || Tel === "") {
				alert("전화번호를 입력해주세요");
				return false;
			}

			if (addr1 == null || addr1 === "") {
				alert("주소를 입력해주세요");
				return false;
			}

			if (addr2 == null || addr2 === "") {
				alert("상세주소를 입력해주세요");
				return false;
			}

			else {
				alert("수정이 완료되었습니다");
			}
			emp.submit();
		})

	})
</script>
</html>