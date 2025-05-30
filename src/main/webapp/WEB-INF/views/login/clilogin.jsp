<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>clilogin</h1>
<form action="/everysolution/login" method="post">
	<input type="text" name="username"><br>
	<input type="text" name="password"><br>
	<security:csrfInput/>
	<input type="submit" value="로그인">
</form>
</body>
</html>