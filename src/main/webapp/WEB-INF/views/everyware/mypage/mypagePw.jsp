<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<style>
table.type02 {
	border-collapse: separate;
	border-spacing: 0;
	text-align: left;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	border-left: 1px solid #ccc;
	margin: 20px 10px;
}

table.type02 th {
	width: 30%;
	padding: 10px;
	font-weight: bold;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	border-top: 1px solid #fff;
	border-left: 1px solid #fff;
	background: #eee;
}

table.type02 td {
	width: 350px;
	padding: 10px;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

#btnUpd, #btnPw, #btnBck {
	color: #fff;
	background-color: #007bff;
	border-color: #007bff;
	box-shadow: none;
	border: none;
	border-radius: 5px;
	padding: 8px;
}
</style>
<h3>비밀번호 변경</h3>
	<div style="padding-top: 5%;">
	<div style="padding-left: 20%;"> 
		<h2>${emp.empName }${emp.jbgdNm }님!비밀번호를 다음과 같이 설정하시면 유출될 위험이
			높습니다.</h2>
	</div>
	<div style="    padding-top: 3%; font-size: 20px; padding-left: 25%;">
		<li>아이디와 동일한 비밀번호​</li>

		<li>주민번호/ 사업자번호/생일/전화번호 등 회원정보와 관련된 숫자로된 비밀번호​</li>

		<li>연속된 숫자, 반복된 숫자 등 다른 사람이 쉽게 알아 낼 수 있는 비밀번호</li>
	</div>
	<div style="padding-left: 25%;">
		<form:form method="post" action="/everyware/mypagePw" id="emp">
			<table class="type02" style="width: 60%; margin-top: 5%;">
				<tr>
					<th scope="row">현재 사용중인 비밀번호 입력</th>
					<td><input type="password" id="empPwTest" name="empPwTest"
						onchange="inputValueChange()" class="form-control">
				</tr>
				<tr>
					<th scope="row">새 비밀번호 입력</th>
					<td><input type="password" id="empPwNew" name="empPwNew"
						class="form-control"></td>

				</tr>
				<tr>
					<th scope="row">새 비밀번호 재입력</th>
					<td><input type="password" id="empPwNewTest" name="empPwNewTest"
						class="form-control"></td>
				</tr>
			</table>
			<div style="padding-left: 51%;">
				<button type="button" id="btnPw" name="btnPw">등록</button>
				<button type="button" id="btnBck">뒤로가기</button>
			</div>
			<sec:csrfInput />
		</form:form>
	</div>
	</div>
<script src="../../plugins/jquery/jquery.min.js"></script>

<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

<script>
	function inputValueChange() {
		var empPwTest = document.getElementById('empPwTest').value;
		console.log(empPwTest);
	}
	function inputValueChange() {
		var empPwTest = document.getElementById('empPwNew').value;
		console.log(empPwTest);
	}

	function inputValueChange() {
		var empPwTest = document.getElementById('empPwNewTest').value;
		console.log(empPwTest);
	}


	$(function() {
		var btnPw = $("#btnPw");
		var btnBck = $("#btnBck");

		btnBck.on("click", function() {
			location.href = "/everyware/mypagemain"
		})

		btnPw.on("click", function() {
			// Replace "your_password_here" with the actual password value
			if (document.getElementById('empPwTest').value === "${emp.empPw}") {
				alert("비밀번호가 일치합니다!");
				if(document.getElementById('empPwNew') == document.getElementById('empPwNewTest')){
					alert("비밀번호가 변경되었습니다")
				}else{
					alert("비밀번호가 틀립니다")
					alert(empPwNew)
					alert(empPwNewTest)
					return false;
				}
			} else {
				alert("비밀번호가 틀렸습니다");
				return false;
			}
		});
	});
</script>