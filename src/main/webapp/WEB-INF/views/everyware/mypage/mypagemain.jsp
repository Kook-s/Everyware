<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
.infos{
	padding-left: 1rem;
}
#modal_back{
	position: fixed;
	background: rgba(0,0,0,0.5);
    top: 0;
    width: 100%;
    height: 100%;
    left: 0;
    z-index: 1038;
    display: none;
}
#mypage_modal{
position: fixed;
  top: 50%;
  left: 50%;
     min-width: 75%;
    padding: 4rem;
  min-height: 80%;
  background: white;
  z-index: 1038;
  transform: translate(-50%, -50%);
}
#mypage_modal_content{
	padding: 1rem;
}
.modal-body{
	padding: 50px;
	padding-top: 30px;
}
#modal_back label{
	width: 100px;
}




#modal_back_ip{
	position: fixed;
	background: rgba(0,0,0,0.5);
    top: 0;
    width: 100%;
    height: 100%;
    left: 0;
    z-index: 1038;
    display: none;
}
#mypage_modal_ip{
position: fixed;
  top: 50%;
  left: 50%;
     min-width: 75%;
    padding: 4rem;
  min-height: 80%;
  background: white;
  z-index: 1038;
  transform: translate(-50%, -50%);
}
#mypage_modal_content_ip{
	padding: 1rem;
}
.modal-body_ip{
	padding: 50px;
	padding-top: 30px;
}
#modal_back_ip label{
	width: 100px;
}
.update_form_profile{
	width: 150px;
	height: 150px;
}
.profile_update_btn{
	display: inline-block;
    position: absolute;
    border: 1px solid rgba(0,0,0,0.4);
    padding: 0 10px;
    border-radius: 5px;
    bottom: 10px;
    right: 35px;
}
.profile_update_btn:hover{
	border: 1px solid rgba(0,0,0,1);
}
.profile_update_btn i{
	font-size: 19px;
}
#file{
	display: none;
}
#mypage_modal_content_ip tbody{
	font-size: 12px;
}
#mypage_main_profile{
	height: 150px!important;
	width: 150px!important;
}
</style>


<sec:authentication var="employee" property="principal.employee"/>
 <section class="content">
      <div class="container-fluid">
        <!-- Small boxes (Stat box) -->
       
        <!-- /.row -->
        <!-- Main row -->
        <div class="row col-12 d-flex justify-content-center">
          <!-- Left col -->
          <section class="col-lg-3 connectedSortable py-3 justify-content-end">
            <!-- Custom tabs (Charts with tabs)-->
            <div class="card card-primary card-outline">
              <div class="card-body box-profile">
                <div class="text-center profile_img_container">
                	<c:if test="${not empty employee.empProfile}">
                		<img class="profile-user-img img-fluid img-circle" id="mypage_main_profile" src="/everyware/mypage/thumbnail" alt="User profile picture">
                	</c:if>
                	<c:if test="${empty employee.empProfile}">
                		<img class="profile-user-img img-fluid img-circle" id="mypage_main_profile" src="/resources/img/basicProfile.png" alt="User profile picture">
                	</c:if>
                </div>
                <h3 class="profile-username text-center">${employee.empName }</h3>
                <ul class="list-group list-group-unbordered mb-3">
                  <li class="list-group-item">
                    <b>부서</b> <a class="float-right">${employee.deptNm }</a>
                  </li>
                  <li class="list-group-item">
                    <b>직급</b> <a class="float-right">${employee.jbgdNm }</a>
                  </li>
                  <li class="list-group-item">
                    <b>사번</b> <a class="float-right">${employee.empId }</a>
                  </li>
                </ul>

              </div>
              <!-- /.card-body -->
            </div>

           <div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title"></h3>
              </div>
              <div class="card-body p-0 w-100">
                <ul class="nav nav-pills flex-column" id="deptTotal" >
                  <li class="nav-item active deptList p-2" value="total" >
                    <a href="#" class="nav-link btn btn-primary" style="color: #fff;" id="info_update_btn">
             			  개인정보 수정
                    </a>
                  </li>
                  <li class="nav-item active deptList p-2" value="total">
                    <a href="#" class="nav-link btn btn-primary" style="color: #fff;" id="ip_list_btn">
                     IP 기록
                    </a>
                  </li>
                </ul>
              </div>
            </div>

         
         
          </section>

			<section class="col-lg-9 connectedSortable py-3">
              <div class="card card-primary card-outline">
                <div class="card-body">
                  <div class="row">
                    <div class="col-lg-3 col-6">
                      <div class="small-box bg-success">
                        <a href="#" class="small-box-footer ">출근</a>
                        <div class="inner d-flex justify-content-center">
                          <h3>53<sup style="font-size: 20px">건</sup></h3>
          
                        </div>
                        <div class="icon">
                          <i class="ion ion-stats-bars"></i>
                        </div>
                      </div>
                    </div>
                    
                    <div class="col-lg-3 col-6">
                      <div class="small-box bg-primary">
                        <a href="#" class="small-box-footer">연차</a>
                        <div class="inner d-flex justify-content-center">
                          <h3>53<sup style="font-size: 20px">건</sup></h3>
                        </div>
                        <div class="icon">
                          <i class="ion ion-person-add"></i>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-3 col-6">
                      <div class="small-box bg-indigo">
                        <a href="#" class="small-box-footer">휴가</a>
                        <div class="inner d-flex justify-content-center">
                          <h3>53<sup style="font-size: 20px">건</sup></h3>
                        </div>
                        <div class="icon">
                          <i class="ion ion-pie-graph"></i>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-3 col-6">
                      <div class="small-box bg-cyan">
                        <a href="#" class="small-box-footer">기타</a>
                        <div class="inner d-flex justify-content-center">
                          <h3>53<sup style="font-size: 20px">건</sup></h3>
                        </div>
                        <div class="icon">
                          <i class="ion ion-pie-graph"></i>
                        </div>
                      </div>
                    </div>
                  </div> 
                  <div class="d-flex justify-content-between">
	                   		 <div class="card card-contact card-raised col-12">
					            <div class="card-body myInfoContent">
					            <div class="col-12 info_head">
								<h4>
								<i class="fas fa-globe"></i><span class="conm">${employee.conm }</span>
								<small class="float-right"></small>
								</h4>
								</div>
								<hr style="background: black;">
					              <div class="row infos">
					                <div class="col-md-6 pe-2">
					                  <div class="py-3 align-items-center row">
									     <div class="col-sm-4">
									       <small class="text-uppercase font-weight-bold">사번</small>
									     </div>
									     <div class="col-sm-9 info_el">
									       <h6 class="mb-0 empId">${employee.empId }</h6>
									     </div>
									   </div>
					                </div>
					                <div class="col-md-6 pe-2">
					                  <div class="py-3 align-items-center row">
									     <div class="col-sm-4">
									       <small class="text-uppercase font-weight-bold">회사명</small>
									     </div>
									     <div class="col-sm-9 info_el">
									       <h6 class="mb-0 conm">${employee.conm }</h6>
									     </div>
									   </div>
					                </div>
					              </div>
					              <div class="row infos">
					                <div class="col-md-6 pe-2">
					                  <div class="py-3 align-items-center row">
									     <div class="col-sm-4">
									       <small class="text-uppercase font-weight-bold">이름</small>
									     </div>
									     <div class="col-sm-9 info_el">
									       <h6 class="mb-0 empName">${employee.empName }</h6>
									     </div>
									   </div>
					                </div>
					                <div class="col-md-6 pe-2">
					                  <div class="py-3 align-items-center row">
									     <div class="col-sm-4">
									       <small class="text-uppercase font-weight-bold">생년월일</small>
									     </div>
									     <div class="col-sm-9 info_el">
									     <c:set var="dateTimeString" value="${employee.empBirth }" />

										 <fmt:parseDate value="${dateTimeString}" pattern="yyyy-MM-dd HH:mm:ss" var="date" />
										 <fmt:formatDate value="${date}" pattern="yyyy-MM-dd" var="formatBirth"/>
									       <h6 class="mb-0 empBirth">${formatBirth }</h6>
									     </div>
									   </div>
					                </div>
					              </div>
					              <div class="row infos">
					                <div class="col-md-6 pe-2">
					                  <div class="py-3 align-items-center row">
									     <div class="col-sm-4">
									       <small class="text-uppercase font-weight-bold">이메일</small>
									     </div>
									     <div class="col-sm-9 info_el">
									       <h6 class="mb-0 empMail">${employee.empMail }</h6>
									     </div>
									   </div>
					                </div>
					                <div class="col-md-6 pe-2">
					                  <div class="py-3 align-items-center row">
									     <div class="col-sm-4">
									       <small class="text-uppercase font-weight-bold">우편번호</small>
									     </div>
									     <div class="col-sm-9 info_el">
									       <h6 class="mb-0 empPost">${employee.empPost }</h6>
									     </div>
									   </div>
					                </div>
					              </div>
					              <div class="row infos">
					                <div class="col-md-6 pe-2">
					                  <div class="py-3 align-items-center row">
									     <div class="col-sm-4">
									       <small class="text-uppercase font-weight-bold">주소</small>
									     </div>
									     <div class="col-sm-9 info_el">
									       <h6 class="mb-0 empAddr1">${employee.empAddr1 }</h6>
									     </div>
									   </div>
					                </div>
					                <div class="col-md-6 pe-2">
					                  <div class="py-3 align-items-center row">
									     <div class="col-sm-4">
									       <small class="text-uppercase font-weight-bold">상세주소</small>
									     </div>
									     <div class="col-sm-9 info_el">
									       <h6 class="mb-0 empAddr2">${employee.empAddr2 }</h6>
									     </div>
									   </div>
					                </div>
					              </div>
					              <div class="row infos">
					                <div class="col-md-6 pe-2">
					                	<div class="py-3 align-items-center row">
									     <div class="col-sm-4">
									       <small class="text-uppercase font-weight-bold">휴대폰 번호</small>
									     </div>
									     <div class="col-sm-9 info_el">
									       <h6 class="mb-0 empTel">${employee.empTel }</h6>
									     </div>
									   </div>
					                </div>
					                <div class="col-md-6 pe-2">
					                  <div class="py-3 align-items-center row">
									     <div class="col-sm-4">
									       <small class="text-uppercase font-weight-bold">입사년월</small>
									     </div>
									     <div class="col-sm-9 info_el">
									     
									        <c:set var="dateTimeString" value="${employee.empDate }" />

											<fmt:parseDate value="${dateTimeString}" pattern="yyyy-MM-dd HH:mm:ss" var="date" />
											<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" var="formatDate"/>
									       <h6 class="mb-0 empDate">${formatDate }</h6>
									     </div>
									   </div>
					                </div>
					              </div>
					            </div>
					        </div>
                  </div>
                </div>
              </div>

              
            </section>        

          <!-- right col -->
        </div>
        <!-- /.row (main row) -->
      </div><!-- /.container-fluid -->
    </section>
    
    
    


<div id=modal_back>
	<div id="mypage_modal">
		<div id="mypage_modal_header">
			<h5>계정 정보 수정</h5>
		</div>
		<hr>
		<div id="mypage_modal_content">
			<form>
			<div class="row my-4">
				<div class="col-6">
					<div class="text-center">
	                  <img class="profile-user-img img-fluid img-circle update_form_profile" src="" alt="User profile picture">
	                  <div class="profile_update_btn">
		                  <i class="ion ion-gear-a"></i>
		                  <span>프로필 수정</span>
	                  </div>
	                  <input type="file" id="file">
	                </div>
				</div>
				<div class="col-6">
				  <div class="row" style="padding: 0 7.5px;">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">회사명</label>
	                  <input class="form-control" id="conm" type="text" value="" readonly="readonly">
	                </div>
	              </div>
				  <div class="row" style="padding: 0 7.5px;">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">사번</label>
	                  <input class="form-control" id="empId" type="text" value="" readonly="readonly">
	                </div>
	              </div>
	              <div class="row" style="padding: 0 7.5px;">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">이름</label>
	                  <input class="form-control" id="empName" type="text" value="" readonly="readonly">
	                </div>
	              </div>
				</div>
	          </div>
              <div class="row">
				<div class="col-md-6">
	                <div class="input-group date" id="datetimepickerBirth" data-target-input="nearest">
	                	<label class="form-label">생년월일</label>
		                <input type="text" class="form-control datetimepicker-input" data-target="#datetimepickerBirth"/>
		                <div class="input-group-append" data-target="#datetimepickerBirth" data-toggle="datetimepicker">
		                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
		                </div>
		            </div>
	              </div>
	              <div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  	<label class="form-label">이메일</label>
						<input type="text" id="emp_mail_form" class="form-control" value="${fn:split(employee.empMail,'@')[0] }">
						<div class="input-group-append">
						<span class="input-group-text">@everyware.com</span>
						</div>
	                </div>
	              </div>
	          </div>
              <div class="row">
				<div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">주소</label>
	                  <input class="form-control" id="emp_addr1_form" type="text" value="${employee.empAddr1 }">
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">우편번호</label>
	                  <input class="form-control" id="emp_post_form" type="text" value="${employee.empPost }" >
	                  <button type="button" class="btn btn-default" id="address_search" onclick="DaumPostcode()">검색</button>
	                </div>
	              </div>
	          </div>
               <div class="row">
				<div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">상세주소</label>
	                  <input class="form-control" id="emp_addr2_form" type="text" value="${employee.empAddr2 }">
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">휴대폰 번호</label>
	                  <input class="form-control" id="emp_tel_form" type="text" value="${employee.empTel }" >
	                </div>
	              </div>
	          </div>
	          <div class="row">
			    <div class="col-4">
			      <div class="form-group">
					  <div class="custom-control custom-switch">
					    <input type="checkbox" class="custom-control-input" id="passwordFlag">
					    <label class="custom-control-label" for="passwordFlag">비밀번호 변경</label>
					  </div>
				  </div>
			    </div>
			  </div>
	          <div class="row py-3">
				<div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">비밀번호</label>
	                  <input class="form-control" id="password" type="password" value="" disabled="disabled">
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">비밀번호 재확인</label>
	                  <input class="form-control" id="password2" type="password" value="" disabled="disabled">
	                </div>
	              </div>
	          </div>
			</form>
		</div>
		<hr>
		<div id="mypage_modal_footer">
			<button class="btn btn-info" id="cancleBtn"">취소</button>
			<button class="btn btn-info" id="updateBtn">완료</button>
		</div>
	</div>
</div>







    
    
    
    
<div id=modal_back_ip>
	<div id="mypage_modal_ip">
		<div id="mypage_modal_header_ip">
			<h5>접속 ip 로그</h5>
		</div>
		<hr>
		<span style="margin-left: 1rem; color: cadetblue;">회원님의 2개월간 접속 로그를 출력합니다.</span>
		<div id="mypage_modal_content_ip">
			<div class="card-body table-responsive p-0" style="height: 400px;">
			<table class="table table-head-fixed text-nowrap">
				<thead>
					<tr>
						<th>사원</th>
						<th>ip</th>
						<th>브라우저</th>
						<th>지역</th>
						<th>일시</th>
					</tr>
				</thead>
				<tbody>
				
				</tbody>
			</table>
			</div>
		</div>
		<hr>
		<div id="mypage_modal_footer_ip">
			<button class="btn btn-info" id="ipCancleBtn">나가기</button>
		</div>
	</div>
</div>








<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(()=>{
	var selectedFile=null;
	 $('#datetimepickerBirth').datetimepicker({
         format:'L',
         "format": 'YYYY/MM/DD', 
     });
	 
	 
	 $("#ip_list_btn").on("click",function(){
		 $.ajax({
			  url: '/everyware/mypage/ipInfo', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	 contentType: 'application/json; charset=utf-8',
			  success: function(response) {
				  if(response.res=="OK"){
					  $.each(response.ipList,function(i,v){
						  var tr = `<tr>
										<td>\${v.lgnDeptNm}</td>
										<td>\${v.lgnIpAddr}</td>
										<td>\${v.lgnBro}</td>
										<td>\${v.lgnArea}</td>
										<td>\${dateFormat2(v.lgnDt)}</td>
									</tr>`
				  		  $("#mypage_modal_content_ip tbody").append(tr)
					  })
					  $("#modal_back_ip").css("display","block")
				  }else{
					  alertError("서버에러")
				  }
				  
			  },
			  error: function(xhr, status, error) {
				alertError("실패")
			  }
			}); 
		 
	 })
	 $("#ipCancleBtn").on("click",function(){
		 $("#modal_back_ip").css("display","none")
		 $("#mypage_modal_content_ip tbody").empty()
	 })
	 $("#updateBtn").on("click",function(){
		 var birth = $('#datetimepickerBirth').datetimepicker("date")._d
		 birth = $.datepicker.formatDate("yy/mm/dd",birth)
		 var mail =  $("#emp_mail_form").val()
		 var addr1 = $("#emp_addr1_form").val()
		 var post = $("#emp_post_form").val()
		 var addr2 = $("#emp_addr2_form").val()
		 var tel = $("#emp_tel_form").val()
		 var pw = $("#password").val()
		 var pw2 = $("#password2").val()
		 var passwordFlag =$("#passwordFlag").prop("checked")
		 console.log(mail)
		 console.log(addr1)
		 console.log(post)
		 console.log(addr2)
		 console.log(tel)
		 console.log(pw)
		 console.log(pw2)
		 console.log(passwordFlag)
		 console.log(selectedFile)
		 
		 if(pw!=pw2){
			 alert("비밀번호와 비밀번호 재확인이 일치하지 않습니다.")
			 return false;
		 }
		 var formData = new FormData();
		 if(selectedFile!=null){
			 formData.append("profileFile",selectedFile); 
		 }
		 formData.append("empMail",mail+"@everyware.com")
		 formData.append("empBirth",birth)
		 formData.append("empAddr1",addr1)
		 formData.append("empPost",post)
		 formData.append("empAddr2",addr2)
		 formData.append("empTel",tel)
		 formData.append("empPw",pw)
		 formData.append("passwordFlag",passwordFlag)
		 
		 $.ajax({
			  url: '/everyware/mypage/upEmp', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: formData,
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	  processData : false,
			  contentType : false,
			  success: function(response) {
				  $(".profile_img_container").empty()
				  var newImg = `<img class="profile-user-img img-fluid img-circle" id="mypage_main_profile" src="/everyware/mypage/thumbnail" alt="User profile picture">`
				  $(".profile_img_container").html(newImg)
			  	  
				  $(".aside_img_div .image").empty()
				  var newImg2=`<img src="/everyware/mypage/thumbnail" class="img-circle elevation-2 aside_profile" alt="User Image">`
				  $(".aside_img_div .image").html(newImg2)
				  
				              
				  $(".conm").text(response.emp.conm)
				  $(".empId").text(response.emp.empId)
				  $(".empName").text(response.emp.empName)
				  $(".empBirth").text(response.emp.empBirth.substr(0,10))
				  $(".empMail").text(response.emp.empMail)
				  $(".empPost").text(response.emp.empPost)
				  $(".empAddr1").text(response.emp.empAddr1)
				  $(".empAddr2").text(response.emp.empAddr2)
				  $(".empTel").text(response.emp.empTel)
				  $(".empDate").text(response.emp.empDate.substr(0,10))
				  
				  
				  
				  alertSuccess("수정이 완료되었습니다.")
				  $("#cancleBtn").click()
			  		
			  
			  },
			  error: function(xhr, status, error) {
				  alertError("수정 실패하였습니다.")
			  }
			});
	 })
	 $("#cancleBtn").on("click",function(){
		 $("#modal_back").css("display","none")
		 $("#emp_mail_form").val('')
		 $("#emp_addr1_form").val('')
		 $("#emp_post_form").val('')
		 $("#emp_addr2_form").val('')
		 $("#emp_tel_form").val('')
		 $("#password").val('')
		 $("#password2").val("")
		 $("#passwordFlag").prop("checked",false)
		 $("#password").prop("disabled",true)
		 $("#password2").prop("disabled",true)
		 $(".update_form_profile").attr("src","/resources/img/basicProfile.png")
		 $("#conm").val('');
		 $("#empId").val('')
		 selectedFile=null
	 })
	 $("#info_update_btn").on("click",function(e){
		 e.preventDefault()
		 console.log("눌러따")
		 if($("#modal_back").css("display")=="none"){
			 console.log("들와따")
			 $.ajax({
				  url: '/everyware/mypage/empInfo', // 요청을 보낼 URL
				  method: 'post', // HTTP 메서드 (GET, POST 등)
				  beforeSend : function(xhr){
					  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			  	  },
			  	 contentType: 'application/json; charset=utf-8',
				  success: function(response) {
					  if(response.res=="OK"){
							 $("#emp_mail_form").val(response.emp.empMail.split("@")[0])
							 $("#emp_addr1_form").val(response.emp.empAddr1)
							 $("#emp_post_form").val(response.emp.empPost)
							 $("#emp_addr2_form").val(response.emp.empAddr2)
							 $("#emp_tel_form").val(response.emp.empTel)
							 $("#passwordFlag").prop("checked",false)
							 $("#password").prop("disabled",true)
							 $("#password2").prop("disabled",true)
							 if(response.emp.empProfile!=null){
								 $(".update_form_profile").attr("src","/everyware/mypage/thumbnail")
							 }else{
								 $(".update_form_profile").attr("src","/resources/img/basicProfile.png")
							 }
							 $("#datetimepickerBirth").datetimepicker("date", response.emp.empBirth);
							 $("#empName").val(response.emp.empName)
							 $("#conm").val(response.emp.conm);
							 $("#empId").val(response.emp.empId)
							 
							 $("#modal_back").css("display","block")
					  }
				  },
				  error: function(xhr, status, error) {
					alertError("실패")
				  }
				}); 
		 }
	 })
	 
	 $("#passwordFlag").on("change",function(){
		 var flag = $(this).prop("checked")
		 if(flag){
	    		$("#password").prop("disabled",false)
	    		$("#password2").prop("disabled",false)
	    	}else{
	    		$("#password").val("")
	    		$("#password").prop("disabled",true)
	    		$("#password2").val("")
	    		$("#password2").prop("disabled",true)
	    	}
	 })
	 $(".profile_update_btn").on("click",function(){
		 $("#file").click()
	 })
	 
	 $("#modal_back").on("change","#file",function(e){
		 
		 var files = e.target.files;
		 var file = files[0];
		 
		 if(!isImageFile(file)){
			alert("이미지 파일이 아닙니다.") 
		 	return false;
		 }
		var reader = new FileReader();
		reader.onload = function(e){
			$(".update_form_profile").attr("src",e.target.result)
		}
		reader.readAsDataURL(file);
		selectedFile=file;
	 })
})


function isImageFile(file){
	var ext = file.name.split(".").pop().toLowerCase();//파일명에서 확장자를 가져온다.
	return($.inArray(ext,["jpg","jpeg","gif","png"])===-1)?false:true;
	
}

function DaumPostcode() {
    	new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('emp_post_form').value = data.zonecode;
                document.getElementById("emp_addr1_form").value = addr + ' ' + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("emp_addr2_form").focus();
            }
        }).open();
    }
    
function dateFormat2(data){
	//입력된 날짜 문자열을 Date 객체로 변환합니다.
		var date = new Date(data);
		
		//연도, 월, 일, 시간, 분을 추출합니다.
		var year = date.getFullYear();
		var month = date.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
		var day = date.getDate();
		var hours = date.getHours();
		var minutes = date.getMinutes();
		
		//월과 일이 한 자리 수일 경우 앞에 0을 붙입니다.
		var formattedMonth = (month < 10 ? "0" : "") + month;
		var formattedDay = (day < 10 ? "0" : "") + day;
		
		// 2023년 7월 15일 (화) 오전 12시 25분와 같은 형태
		var formattedDateString = `\${year}년 \${formattedMonth}월 \${formattedDay}일 (\${getDayOfWeekString(date)}) \${getAMPMString(hours)} \${getFormattedHours(hours)}시 \${getFormattedMinutes(minutes)}분`;
		
		return formattedDateString
	}
	//요일을 문자열로 반환하는 함수
	function getDayOfWeekString(date) {
	const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
	return daysOfWeek[date.getDay()];
	}

	//오전/오후를 문자열로 반환하는 함수
	function getAMPMString(hours) {
	return hours < 12 ? "오전" : "오후";
	}

	//시간을 12시간 형식으로 변환하는 함수
	function getFormattedHours(hours) {
	const formattedHours = hours % 12;
	return formattedHours === 0 ? 12 : formattedHours;
	}

	//분을 두 자리 수로 변환하는 함수
	function getFormattedMinutes(minutes) {
	return minutes < 10 ? "0" + minutes : minutes;
	}

	function getFileType(fileName){
		var fileName = fileName;
		var dotIndex = fileName.lastIndexOf('.');
		var extension=""
		if (dotIndex !== -1) {
			extension = fileName.substr(dotIndex + 1);
		} else {
			extension=null
		}
		return extension;
	}
</script>