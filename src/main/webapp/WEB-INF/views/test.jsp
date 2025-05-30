<%--
  Created by IntelliJ IDEA.
  User: kooks
  Date: 2023/07/03
  Time: 5:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>POI TEST</title>
</head>
<body>
<h2>num : ${num}</h2>

<c:forEach items="${num }" var="info">
	<h3>${info }</h3>
</c:forEach>

<form action="/test/poi" method="post" enctype="multipart/form-data">
    <h1>엑셀업로드</h1>
    <input type="file" name="excelFile" accept=".xls,.xlsx">
    <input type="submit">
</form>

</body>
</html>
