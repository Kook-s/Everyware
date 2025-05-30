<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath }/resources/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath }/resources/assets/img/favicon.png">

    <title>EveryWare</title>
    <link rel="shortcut icon" type="image/x-icon" href="/resources/img/EveryWarePageIcon.png">

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script src="/resources/ckeditor/ckeditor.js"></script>
  <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
  <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
    <!-- Nucleo Icons -->
    <link href="${pageContext.request.contextPath }/resources/assets/css/nucleo-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath }/resources/assets/css/nucleo-svg.css" rel="stylesheet" />
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    <!-- CSS Files -->
    <link id="pagestyle" href="${pageContext.request.contextPath }/resources/assets/css/material-kit-pro.css?v=3.0.3" rel="stylesheet" />

  <script>history.scrollRestoration = "manual"</script>

  
  <style type="text/css">
   body{-ms-overflow-style:none; }
body::-webkit-scrollbar { display:none; } 
  </style>
</head>
<body class="pricing bg-gray-200">
	<!-- header 영역 -->
	<tiles:insertAttribute name="header"/>

	<!-- content 영역 -->
	<tiles:insertAttribute name="content"/>
    <%--footer 영역--%>
    <tiles:insertAttribute name="footer"/>

    <script src="${pageContext.request.contextPath }/resources/assets/js/core/bootstrap.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugins/perfect-scrollbar.min.js"></script>
    <!--  Plugin for TypedJS, full documentation here: https://github.com/mattboldt/typed.js/ -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugins/typedjs.js"></script>
    <!--  Plugin for Parallax, full documentation here: https://github.com/wagerfield/parallax  -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugins/parallax.min.js"></script>
    <!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugins/nouislider.min.js" type="text/javascript"></script>
    <!--  Plugin for the blob animation -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugins/anime.min.js" type="text/javascript"></script>
    <!-- Control Center for Material UI Kit: parallax effects, scripts for the example pages etc -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugins/countup.min.js"></script>
    <script src="?v=3.0.4" type="text/javascript"></script>
    <!--  Google Maps Plugin    -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDTTfWur0PDbZWPr7Pmq8K3jiDp0_xUziI"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/material-kit-pro.min.js?v=3.0.3" type="text/javascript"></script>
</body>
<script type="text/javascript">
    if (document.getElementById("state1")) {
        const countUp = new CountUp("state1", document.getElementById("state1").getAttribute("countTo"));
        if (!countUp.error) {
            countUp.start();
        } else {
            console.error(countUp.error);
        }
    }
    if (document.getElementById("state2")) {
        const countUp1 = new CountUp("state2", document.getElementById("state2").getAttribute("countTo"));
        if (!countUp1.error) {
            countUp1.start();
        } else {
            console.error(countUp1.error);
        }
    }
    if (document.getElementById("state3")) {
        const countUp2 = new CountUp("state3", document.getElementById("state3").getAttribute("countTo"));
        if (!countUp2.error) {
            countUp2.start();
        } else {
            console.error(countUp2.error);
        };
    }
</script>
</html>
