<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>로그인 성공</h1>

<h2>Security/test.jsp에서 확인</h2>
	
	<hr>

		역할명 : default, 이 회원은 모든 그룹웨어 일반사원 기능을 접근할 수 있으며 모든 사원이 기본으로 갖고있는 권한 
		모든 그룹웨어 컨트롤러에 preauthority로 붙어있어야함.
		<p>principal : <sec:authentication property="principal"/></p>
		<p>employee : <sec:authentication property="principal.employee"/></p>
		<p>사용자 이름 : <sec:authentication property="principal.employee.empName"/></p>
		<p>사용자 아이디 : <sec:authentication property="principal.employee.empId"/></p>
		<p>사용자 비밀번호 : <sec:authentication property="principal.employee.empPw"/></p>
		<p>부서명 : <sec:authentication property="principal.employee.deptNm"/></p>
		<p>직급코드: <sec:authentication property="principal.employee.jbgdNm"/></p>
		<p>회사명 : <sec:authentication property="principal.employee.conm"/></p>
		<p>사용자 권한 리스트 : <sec:authentication property="principal.employee.empAuthority"/></p>


</body>
</html>