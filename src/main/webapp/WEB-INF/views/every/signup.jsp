<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div class="page-header align-items-start min-height-300 m-0" style="background-image: url('https://images.unsplash.com/photo-1491466424936-e304919aada7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1949&q=80');" loading="lazy">
    <span class="mask bg-gradient-dark opacity-6"></span>
</div>
<div class="container mb-4">
    <div class="row mt-lg-n12 mt-md-n12 mt-n12 justify-content-center">
        <div class="col-xl-8 col-lg-7 col-md-7 mx-auto">
            <div class="card mt-8">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                    <div class="bg-gradient-info shadow-info border-radius-lg py-3 pe-1 text-center py-4">
                        <h4 class="font-weight-bolder text-white mt-0">회원가입</h4>
                        <!-- <p class="mb-1 text-sm text-white">Enter your email and password to Sign In</p> -->
                    </div>
                </div>
                <div class="card-body">
                    <form role="form" class="text-start" method="post" action="/everysolution/signup" id="signupForm">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="input-group input-group-static mb-4">
                                    <label>아이디</label>
                                    <input class="form-control" placeholder="이름을 입력해주세요." aria-label="First Name.." type="text" name="custId">
                                </div>
                            </div>
                            <div class="col-md-6 ps-2">
                                <div class="input-group input-group-static">
                                    <label>회사(단체)코드</label>
                                    <input type="text" class="form-control" placeholder="회사(단체)코드를 입력해주세요." aria-label="Last Name..." name="conm">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="input-group input-group-static mb-4">
                                    <label>비밀번호</label>
                                    <input class="form-control" placeholder="비밀번호를 입력해주세요." aria-label="First Name..." type="text" name="custPw">
                                </div>
                            </div>
                            <div class="col-md-6 ps-2">
                                <div class="input-group input-group-static">
                                    <label>비밀번호(재확인)</label>
                                    <input type="text" class="form-control" placeholder="비밀번호(재확인) 입력해주세요." aria-label="Last Name..." name="reCustPw">
                                </div>
                            </div>
                        </div>
                        <div class="mb-4">
                            <div class="input-group input-group-static">
                                <label>사업자명</label>
                                <input type="text" class="form-control" placeholder="사업자명을 입력해주세요." name="bplcNm">
                            </div>
                        </div>
                        <div class="mb-4">
                            <div class="input-group input-group-static">
                                <label>사업자 번호</label>
                                <input type="text" class="form-control" placeholder="사업자번호를 입력해주세요." name="brno">
                            </div>
                        </div>
                        <div class="mb-4">
                            <div class="input-group input-group-static">
                                <label>주소</label>
                                <input type="text" class="form-control" placeholder="주소를 입력해주세요." name="bplcAddr">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="input-group input-group-static mb-4">
                                    <label>우편번호</label>
                                    <input class="form-control" placeholder="우편번호를 입력해주세요." aria-label="First Name..." type="text" name="bplcZip">
                                </div>
                            </div>
                            <div class="col-md-6 ps-2">
                                <div class="input-group input-group-static">
                                    <label>상세주소</label>
                                    <input type="text" class="form-control" placeholder="상세주소를 입력해주세요." aria-label="Last Name..." name="bplcDaddr">
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <div class="input-group input-group-static">
                                <label>전화번호</label>
                                <input type="text" class="form-control" placeholder="주소를 입력해주세요." name="bplcTelno">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="input-group input-group-static mb-4">
                                    <label>담당자명</label>
                                    <input class="form-control" placeholder="우편번호를 입력해주세요." aria-label="First Name..." type="text" name="picNm">
                                </div>
                            </div>
                            <div class="col-md-6 ps-2">
                                <div class="input-group input-group-static">
                                    <label>담당자 연락처</label>
                                    <input type="text" class="form-control" placeholder="상세주소를 입력해주세요." aria-label="Last Name..." name="picTelno">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-check form-switch d-flex align-items-center mb-4">
                                    <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault" >
                                    <label class="form-check-label mb-0 ms-3" for="flexSwitchCheckDefault">I agree to the </label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <button type="button" id="signup" class="btn bg-gradient-info float-end">완료</button>
                            </div>
                        </div>
                        <sec:csrfInput/>
                    </form>
                </div>
                <div class="card-footer text-center pt-0 px-lg-2 px-1">
                    <p class="mb-4 text-sm mx-auto">
                        Don't have an account?
                        <a href="#" class="text-info text-gradient font-weight-bold">Login</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
 
<script type="text/javascript">
$(function(){
	const signupBtn = $("#signup");
	const signupForm = $("#signupForm");
	
	signupBtn.on("click",function(){
		
		
		if($("input[name=custId]").val()==""){
			// $("#errId").text("*이미 사용중인 아이디 입니다.");
			$("input[name=custId]").focus();
		}
		else if($("input[name=custPw]").val() ==""){
            $("input[name=custPw]").focus();
            
		}else if($("input[name=custPw]").val() != $("input[name=reCustPw]").val() || $("input[name=custPw]").val() ==""){
			$("#errRePw").text("*비밀번호가 일치하지 않습니다."); 
			$("input[name=custPw]").focus();
		}
		else if(!$("input[name=custPw]").val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)){
			$("#errPw").text("*비밀번호가 올바르지 않습니다.");
			$("input[name=custPw]").focus();
		}
		else if($("input[name=conm]").val()==""){
			$("input[name=conm]").focus();
			
		}else if($("input[name=bplcNm]").val()==""){
			$("input[name=bplcNm]").focus();
			
		}else if($("input[name=brno]").val()==""){
			$("input[name=brno]").focus();
			
		}else if($("input[name=brno]").val().length <10){
			$("#errBrno").text("*10자리를 입력해 주세요.");
			
		}else if($("input[name=bplcAddr]").val()==""){
			$("input[name=bplcAddr]").focus();
			
		}else if($("input[name=bplcZip]").val()==""){
			$("input[name=bplcZip]").focus();
			
		}else if($("input[name=bplcDaddr]").val()==""){
			$("input[name=bplcDaddr]").focus();
			
		}else if($("input[name=bplcTelno]").val()==""){
			$("input[name=bplcTelno]").focus();
			
		}else if($("input[name=picNm]").val()==""){
			$("input[name=picNm]").focus();
			
		}else if($("input[name=picTelno]").val()==""){
			$("input[name=picTelno]").focus();
			
		}else{
			signupForm.submit();
		}
	})
	
	$("input[name=bplcAddr], input[name=bplcZip]").click(function() {
		  DaumPostcode();
	});
	
})

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
             console.log(data)
             $("input[name=bplcAddr]").val(addr);
             $("input[name=bplcZip]").val(data.zonecode);
             $("input[name=bplcDaddr]").focus();
         }
     }).open();
}

</script> 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    