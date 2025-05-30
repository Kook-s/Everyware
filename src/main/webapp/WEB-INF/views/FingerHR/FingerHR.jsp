<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | Simple Tables</title>

  	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
	
<!-- Font Awesome -->
<link rel="stylesheet"
	href="/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="/resources/bootstrap/dist/css/adminlte.min.css">
<style>
* {
	margin: 0;
	padding: 0;
	font-family: 'Noto Sans KR', sans-serif;
}

body {
	overflow: hidden;
	background: #007bff;
}

#rImg{
	position: absolute;
	right: 10%;
	bottom: 10%;
	z-index: 500; 
    right: 0%;
    bottom: 8%;
}
#profileBack{
	background-image: url("/resources/img/fingerProfileBack.jpg");
    background-size: 100%;
}
</style>
</head>
<body>
	<div style="position: fixed; top: 1%; left: 3%; z-index: 999;">
		<img class="" src="/resources/img/LOGO.png" alt="User Avatar"
			height="40px">
	</div>
	<div class="wrapper" style="padding-left: 3%; padding-top: 3%;">

		<!-- <aside class="main-sidebar sidebar-dark-primary " style="left: 0%; width: 3%; background: #007bff;">
   <div style="position: absolute ;bottom: 5%;">로그인</div>
  </aside> -->
		<!-- Content Wrapper. Contains page content -->
		<div class="pt-4 px-4"
			style="border-radius: 15px 0px 0px 0px; background: #fff; height: 100vh;">
			<!-- Content Header (Page header) -->


			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-8">
							<div class="card card-primary card-outline">
								<div class="card-header text-center">
									<h2 class="" id="titelDate"></h2>
								</div>
								<!-- /.card-header -->
								<div class="card-body p-0" style="height: 80vh;">
									<table class="table table-sm "  >
										<thead>
											<tr>
												<th style="width: 4%">#</th>
												<th class="text-center" style="width: 10%">프로필</th>
												<th class="text-center" style="width: 10%">직급</th>
												<th class="text-center" style="width: 10%">부서</th>
												<th class="text-center" style="width: 10%">날짜</th>
												<th class="text-center" style="width: 10%">출근시간</th>
												<th class="text-center" style="width: 10%">퇴근시간</th>
												<th class="text-center" style="width: 20%">상태</th>
											</tr>
										</thead>
										<tbody id="hrList">
											


										</tbody>
									</table>
								</div>
								<!-- /.card-body -->
							</div>
						</div>
						<div class="col-md-4">

							<div class="card card-widget widget-user shadow">

								<div class="widget-user-header bg-primary" id="profileBack"></div>
								<div class="widget-user-image">
									<img id="empProfile" class="img-circle elevation-2" src="/resources/img/basicProfile.png" alt="User Avatar">
								</div>
								<div class="card-footer" style="padding: 7%">
									<div class="row">
										<div class="col-sm-4 border-right">
											<div class="description-block">
												<h5 class="description-header">이름</h5>
												<span id='empNm' class="description-text"></span>
											</div>

										</div>

										<div class="col-sm-4 border-right">
											<div class="description-block">
												<h5 class="description-header">직급</h5>
												<span id='empJbgd' class="description-text"></span>
											</div>

										</div>

										<div class="col-sm-4">
											<div class="description-block">
												<h5 class="description-header">부서</h5>
												<span id='empDept' class="description-text"></span>
											</div>

										</div>

									</div>

								</div>
							</div>

						</div>
						<div id="rImg">
							<img alt="" src="/resources/img/fingerBimg.png" height="450">
						</div>
					</div>
				</div>
				<!-- /.row -->
		</div>
		<!-- /.container-fluid -->
		</section>
		<!-- /.content -->
	</div>

	</div>

	<!-- jQuery -->
	<script src="/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<script
		src="/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE App -->
	<script src="/resources/bootstrap/dist/js/adminlte.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/resources/bootstrap/dist/js/demo.js"></script>
</body>
<script type="text/javascript">
$(function(){
	
	
	 const currentDate = new Date();

      // 날짜를 "yyyy-MM-dd" 형식으로 변환하는 함수
      function formatDate(date) {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return `\${year}년 \${month}월 \${day}일 `;
      }

      // 현재 날짜를 "yyyy-MM-dd" 형식으로 변환하여 출력
      const formattedDate = formatDate(currentDate);
      $("#titelDate").text(formattedDate);
	
	//alert(123)
	setInterval(() => {
		$.ajax({
	        url: '/everyware/admin/fingerEmpList',
	        beforeSend : function(xhr){
	          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        dataType: "json",
	        success: function(res){
	        	var empList="";
	          console.log(res)
	           $.each(res, function(index, emp) {
	        	   if(index == 0){
	        		  $("#empProfile").attr('src' ,"/everyware/admin/thumbnail?empId="+emp.empId);
	     	          $("#empNm").html(emp.empName);
	     	          $("#empJbgd").html(emp.position.jbgdNm);
	     	          $("#empDept").html(emp.department.deptNm);
	        	   }
	        	   if(index<20){
			          empList +=`
			        	  <tr style="font-size: 18px">
							<td style="width: 4%">\${index+1}.</td>
							<td class="text-center">\${emp.empName}</td>
							<td class="text-center">\${emp.position.jbgdNm}</td>
							<td class="text-center">\${emp.department.deptNm}</td>
							<td class="text-center">
								\${emp.work.workDt}
							</td>
							<td class="text-center">`
							if(emp.work.workBgngDt!=null){
								empList +=	emp.work.workBgngDt.split(" ")[1];
							}else{
								empList +="";
							}
					empList +=`</td>
								<td class="text-center">`
								
							if(emp.work.workEndDt!= null){
								empList += emp.work.workEndDt.split(" ")[1];
							}else{
								empList +="";
							}
							
					 empList +=`</td>
					 			<td class="text-center">`
								if(emp.work.workBgngDt != null){
									 if(emp.work.workState == '출근'){
										 empList +="<span class='badge bg-primary col-5'>출근</span>";
									 }else if(emp.work.workState == '지각'){
										 empList +="<span class='badge bg-danger col-5'>지각</span>";
									 }else if(emp.work.workState == '조퇴'){
										 empList +="<span class='badge bg-info col-5'>조퇴</span>";
									 }else if(emp.work.workState == '퇴근'){
										 empList +="<span class='badge bg-success col-5'>정상</span>";
									 }else if(emp.work.workState == '연장'){
										 empList +="<span class='badge bg-warning col-5'>연장</span>";
									 }
								}
							 empList +=`</td>
						</tr>
			          `
	        	   }
	           })
	          
	          $("#hrList").html(empList);
	          
	          
	          
	        },
	        error: function(xhr){
	          console.log("실패",xhr.status);
	        }
	      })	
	}, 1000);
	
	
 	 
}) 
</script>
</html>











