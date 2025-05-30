<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">


    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/Login.css">

</head>
<body>
  <div class="haeder">
    <!-- <nav><img src="img/Logo(color).png" alt="" height="40px"></nav> -->
    <nav class="open_menu"><ion-icon name="menu-outline"></ion-icon> </nav>
  </div>

    <!-- <div class="backimg"></div>-->
    <div class="mainLeft"></div>
    <div class="mainRight"></div>
    <div class="mainTop"></div>
    <div class="mainBottom"></div> 

<video autoplay loop muted >
    <source src="${pageContext.request.contextPath }/resources/video/loginback2.mov">
</video>

<div class="centerLogo">
<!-- <h1>EveryWare</h1> -->
  <img src="${pageContext.request.contextPath }/resources/img/EveryWare.png" alt="" height="10%">
</div>

<div class="leftLogo">
    <!-- YOUR  CREATION <br>
    STARTS HERE -->
    <nav><img src="${pageContext.request.contextPath }/resources/img/EveryWare.png" alt="" height="100%"></nav>
    <!-- <p style="font-size: 20px;">We look forward to your support.</p> -->
</div>

<div class="wrapper">
    <div class="form-box login">
      <h2>Login</h2>
      <!-- 로그인 버튼 눌렀을 때 -->
      <form id="form" method="post" action="/everyware/login">
        <div class="input-box">
          <span class="icon"><ion-icon name="person-outline"></ion-icon></span>
          <input type="text" id="empId" name="username" required />
          <label for="">아이디</label>
        </div>

        <div class="input-box">
          <span class="icon"><ion-icon name="lock-closed-outline"></ion-icon></span>
          <input type="password" required id="empPass" name="password" />
          <label for="">비밀번호</label>
        </div>
        <div class="remember-forgot">
          <label id="idSave"><input type="checkbox" name="chkid" value="check" style="display: inline;">아이디 저장 </label>
          <label><a href="#" id="passSearch" style="float: right" class="find-link"> 비밀번호 찾기</a></label>
        </div>
        <br />
        <button type="submit" class="btn">Login</button>
        <sec:csrfInput/>
      </form>
    </div>
    
    <div class="form-box password">
      <h2>비밀번호 찾기</h2>
      <!-- 로그인 버튼 눌렀을 때 -->
      <form id="findPass" class="findPass" method="post">
        <div class="input-box">
          <span class="icon"><ion-icon name="person-outline"></ion-icon></span>
          <input type="text" id="empId3" name="empId3" required />
          <label for="empId3">아이디</label>
        </div>

        <div class="input-box">
          <span class="icon"><ion-icon name="lock-closed-outline"></ion-icon></span>
          <input type="text" required id="empName3" name="empName3" />
          <label for="empName3">이 름</label>
        </div>
       
        <br />
        <button type="submit" class="btn3" id="check">찾 기</button>
        <div class="login-register">
          <p><a href="#" class="sreach-link">로그인</a></p>
        </div>
      </form>     
    </div>
    
  </div>

  <script src="${pageContext.request.contextPath }/resources/js/Loginscript.js"></script>
</body>
</html>