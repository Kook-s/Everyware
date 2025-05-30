<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.bundle.js"></script>
<style>
.myinfo, .mycontract{
	display: none;
}
.header_img{
	position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    z-index: -1;
}
#cover{
	width: 100%;
	height: 55vh;
	background-color: rgba(0,0,0, 0.5);
	position: absolute;
	top:0;
	left:0;
	
	
}
.container{
z-index: 100;
    position: relative;
}
.mypage_content{
	margin-top: 130px!important;
	background: rgba(0,0,0,0.2);
	border: none;
}
.submenu-wrap{
    height: 120px;
}
#relContainer{
	width: 100%;
	padding-top: 80px;
    padding-left: 200px;
    padding-right: 200px;
}
h3{
	color: black;
}
.bar{
	height: 30px;
}
.barFill{
	height: 27px;
}
.endDate{
	color: black;
}
.startDate{
	color: black;
}
.buttons button{
	color: white;
	border: 1px solid white!important;
}
.crown{
	height: 140px;
    margin-left: 100px;
    display: inline-block;
}
.myInfoContent{
	padding: 4.5rem!important;
    padding-left: 6.5rem!important;
}
.info_el{
	border-bottom: 1px solid rgba(0,0,0,0.2);
}
.info_head{
	margin-bottom: 40px;
}
.infos{
	margin-bottom: 20px;
}
.modal-content {
	background: rgba(255,255,255,1);
	border:1px solid black;
}
.modal-close-btn span{
	color: black;
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
.paymentList th{
	border-bottom-color: #495057;
    color: black;
    font-size: 1.0rem;
    text-align: center;
    background: rgba(0, 0, 0, 0.06);
}
.card-title{
	margin: 0;
}
</style>
<header class="header_img">
    <div class="page-header min-vh-55 position-relative" style="background-image: url('https://images.unsplash.com/photo-1460794418188-1bb7dba2720d?ixlib=rb-1.2.1&amp;ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&amp;auto=format&amp;fit=crop&amp;w=1950&amp;q=80');" loading="lazy">
      <span class="mask bg-gradient-dark opacity-6"></span>
    </div>
  </header>
<div id="cover">
</div>
<div id="relContainer">
	<div class="root fadeIn3 fadeInBottom text-white opacity-8">
		HOME
		<img src="${pageContext.request.contextPath }/resources/img/root_arw.png" />
		My Page
	</div>
	<h1 class="menu text-white fadeIn2 fadeInBottom" >MY PAGE</h1>
	<div class="submenu-wrap text-white fadeIn1 fadeInBottom">
        <ul>
            <li><span class="current-menu submenu" onclick="ftab(0)">마이페이지</span></li>
            <li><span class="other-menu submenu" onclick="ftab(1)">내 정보</span></li>
            <li><span class="other-menu submenu" onclick="ftab(2)">주문내역</span></li>
        </ul>
    </div>
    <div class="row mt-6 tabs">
      <div class="col-lg-5">
	      <c:if test="${order.pdtId eq 1 }">
	      	<div class="card bg-gradient-info">
	      </c:if>
	      <c:if test="${order.pdtId eq 2 }">
	      	<div class="card bg-gradient-primary">
	      </c:if>
          <div class="card-body" style="height: 536px;">
            <div class="author align-items-center">
            
           	  <c:if test="${order.pdtId eq 1 }">
		      	<div class="name">
	                <span class="text-white" style="font-size: 25px;">BASIC <img class="crown" alt="" src="/resources/img/왕관.png"> </span>
	                <div class="stats">
	                  <small class="text-white">BASIC 등급을 사용중입니다.</small>
	                </div>
	              </div>
		      </c:if>
		      <c:if test="${order.pdtId eq 2 }">
		      	<div class="name">
	                <span class="text-white" style="font-size: 25px;">PREMIUM <img class="crown" alt="" src="/resources/img/왕관.png"> </span>
	                <div class="stats">
	                  <small class="text-white">PREMIUM 등급을 사용중입니다.</small>
	                </div>
	              </div>
		      </c:if>
            </div>
            <div class="d-flex text-white justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">최대 100명중 ${employeeCount }명의 사원이 등록되어 있습니다.</span>
                  </div>
             <div class="d-flex text-white justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">최대 ${order.ordrPerson * product.addFileSz}GB의 파일용량을 사용할 수 있습니다.</span>
                  </div>
             <div class="d-flex text-white justify-content-lg-start justify-content-center p-2">
                   <i class="material-icons my-auto">done</i>
                   <span class="ps-3">최대  ${order.ordrPerson * product.addCldSz}GB의 클라우드 서비스를 사용할 수 있습니다.</span>
                 </div>
             <div class="d-flex text-white justify-content-lg-start justify-content-center p-2">
               <i class="material-icons my-auto">done</i>
               <c:if test="${order.pdtId eq 1 }">
		      	 <span class="ps-3">최대 100명까지 인원 추가 가능</span>
		       </c:if>
		       <c:if test="${order.pdtId eq 2 }">
		      	 <span class="ps-3">최대 1000명까지 인원 추가 가능</span>
		       </c:if>
             </div>
             <div class="buttons">
              <button type="button" class="btn mt-4 btn-default">인원 추가</button>
              <button type="button" class="btn mt-4 ms-2 btn-default">업그레이드</button>
            </div>
          </div>
        </div>
      </div>
      
      <div class="col-lg-7">
        <div class="card" style="height: 536px;">
          <div class="card-body">
            <div class="row">
            	 <div class="cont-cont" style="display: block;">
	               <h5>잔여 멤버쉽 기간</h5>
	               <div class="bar-chart-container">
	                   <div class="chartDate">
	                   	   <fmt:parseDate value="${order.ordrBgngDt}" var="parsedDate4" pattern="yyyy-MM-dd HH:mm:ss" />
						   <fmt:parseDate value="${order.ordrEndDt}" var="parsedDate5" pattern="yyyy-MM-dd HH:mm:ss" />
	                       <span class="startDate"><fmt:formatDate value="${parsedDate4}" pattern="yyyy/MM/dd" /></span>
	                       <span class="endDate"><fmt:formatDate value="${parsedDate5}" pattern="yyyy/MM/dd" /></span>
	                   </div>
	                   <div class="bar">
	                       <div class="barFill">
	                       </div>
	                   </div>
	                   <span class="tooltiptext"></span>
	               </div>
	           </div>
	           <div id="barchart_container" class="px-3" style="height: 300px; width: 600px;">
		           <h5>이번주 근태</h5>
		           <canvas id="barChart" width="581px" height="280px" class="mx-5"></canvas>
	           </div>
            </div>
          </div>
        </div>
      </div>
      
      <div class="col-lg-12 py-3">
            <div class="card">
            	 <div class="card-body" style="display: block;">
	               <div class="doughnut-chart-container">
	                   <div class="cloud-chart-container">
	                    	<h4>클라우드 사용량</h4>
	                   		<div class="d-flex" style="height: 30px ;justify-content: space-evenly; align-items: center;">
			              		<div style="display: inline-block; width: 20%; height: 10px;background: rgba(121, 120, 210, 0.6);"></div>
			              		<span style="font-size: 11px;">사용중</span>
			              		<div style="display: inline-block; width: 20%; height: 10px;background: rgb(255,255,255); border:1px solid rgba(121, 120, 210, 0.6)"></div>
			              		<span style="font-size: 11px;">미사용</span>
			              	</div>
	                       <canvas id="cloudChart" width="300px" height="300px"></canvas>
	                       <b id='maxCldSz'> </b> 중 <b id="useCldSz"> </b>만큼 사용하였습니다.
	                   </div>
	                   <div class="mail-chart-container">
	                       <h4>이번달 파일 사용량</h4>
	                       <div class="d-flex" style="height: 30px ;justify-content: space-evenly; align-items: center;">
			              		<div style="display: inline-block; width: 20%; height: 10px;background: rgba(0, 181, 148, 0.6);"></div>
			              		<span style="font-size: 11px;">사용중</span>
			              		<div style="display: inline-block; width: 20%; height: 10px;background: rgb(255,255,255); border:1px solid rgba(0, 181, 148, 0.6);"></div>
			              		<span style="font-size: 11px;">미사용</span>
			              	</div>
	                       <canvas id="fileChart" width="300px" height="300px"></canvas>
	                       <b id='maxFileSz'> </b> 중 <b id="useFileSz"> </b>만큼 사용하였습니다.
	                   </div>
	               </div>
	           </div>
            </div>
      </div>
     </div>
     <div class="col-lg-12 tabs">
        <div class="card card-contact card-raised">
            <div class="card-body myInfoContent">
            <div class="col-12 info_head">
			<h4>
			<i class="fas fa-globe"></i><span class="conm"> ${client.conm }</span>
			<small class="float-right"></small>
			</h4>
			</div>
              <div class="row infos">
                <div class="col-md-6 pe-2">
                  <div class="py-3 align-items-center row">
				     <div class="col-sm-4">
				       <small class="text-uppercase font-weight-bold">아이디</small>
				     </div>
				     <div class="col-sm-9 info_el">
				       <h6 class="mb-0 custId">${client.custId }</h6>
				     </div>
				   </div>
                </div>
                <div class="col-md-6 pe-2">
                  <div class="py-3 align-items-center row">
				     <div class="col-sm-4">
				       <small class="text-uppercase font-weight-bold">회사명</small>
				     </div>
				     <div class="col-sm-9 info_el">
				       <h6 class="mb-0 conm">${client.conm }</h6>
				     </div>
				   </div>
                </div>
              </div>
              <div class="row infos">
                <div class="col-md-6 pe-2">
                  <div class="py-3 align-items-center row">
				     <div class="col-sm-4">
				       <small class="text-uppercase font-weight-bold">사업자명</small>
				     </div>
				     <div class="col-sm-9 info_el">
				       <h6 class="mb-0 bplcNm">${client.bplcNm }</h6>
				     </div>
				   </div>
                </div>
                <div class="col-md-6 pe-2">
                  <div class="py-3 align-items-center row">
				     <div class="col-sm-4">
				       <small class="text-uppercase font-weight-bold">사업자번호</small>
				     </div>
				     <div class="col-sm-9 info_el">
				       <h6 class="mb-0 brno">${client.brno }</h6>
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
				       <h6 class="mb-0 bplcAddr">${client.bplcAddr }</h6>
				     </div>
				   </div>
                </div>
                <div class="col-md-6 pe-2">
                  <div class="py-3 align-items-center row">
				     <div class="col-sm-4">
				       <small class="text-uppercase font-weight-bold">우편번호</small>
				     </div>
				     <div class="col-sm-9 info_el">
				       <h6 class="mb-0 bplcZip">${client.bplcZip }</h6>
				     </div>
				   </div>
                </div>
              </div>
              <div class="row infos">
                <div class="col-md-6 pe-2">
                  <div class="py-3 align-items-center row">
				     <div class="col-sm-4">
				       <small class="text-uppercase font-weight-bold">상세주소</small>
				     </div>
				     <div class="col-sm-9 info_el">
				       <h6 class="mb-0 bplcDaddr">${client.bplcDaddr }</h6>
				     </div>
				   </div>
                </div>
                <div class="col-md-6 pe-2">
                  <div class="py-3 align-items-center row">
				     <div class="col-sm-4">
				       <small class="text-uppercase font-weight-bold">전화번호</small>
				     </div>
				     <div class="col-sm-9 info_el">
				       <h6 class="mb-0 bplcTelno">${client.bplcTelno }</h6>
				     </div>
				   </div>
                </div>
              </div>
              <div class="row infos">
                <div class="col-md-6 pe-2">
                  <div class="py-3 align-items-center row">
				     <div class="col-sm-4">
				       <small class="text-uppercase font-weight-bold">담당자명</small>
				     </div>
				     <div class="col-sm-9 info_el">
				       <h6 class="mb-0 picNm">${client.picNm }</h6>
				     </div>
				   </div>
                </div>
                <div class="col-md-6 pe-2">
                  <div class="py-3 align-items-center row">
				     <div class="col-sm-4">
				       <small class="text-uppercase font-weight-bold">담당자 연락처</small>
				     </div>
				     <div class="col-sm-9 info_el">
				       <h6 class="mb-0 picTelno">${client.picTelno }</h6>
				     </div>
				   </div>
                </div>
              </div>
              <div class="row infos">
              	<div class="col-3">
              		<button class="btn btn-sm  bg-gradient-info  mb-0 reviseBtn" data-bs-toggle="modal" data-bs-target="#exampleModal">정보 수정</button>
              	</div>
              </div>
            </div>
        </div>
      </div> 
      
      <div class="row tabs">
	<div class="col-12">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">결제 내역</h3>
			</div>
			<div class="card-body table-responsive p-0">
				 <table class="table table-hover text-nowrap paymentList">
					<thead>
						<tr>
							<th>주문번호</th>
							<th>결제자</th>
							<th>상품명</th>
							<th>결제일자</th>
							<th>유효기간</th>
							<th>가격</th>
							<th>최대사원수</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty orderList }">
							<c:forEach items="${orderList }" var="ordr">
								<tr>
								<td>${ordr.ordrId }</td>
								<td>${ordr.custId }</td>
								<c:if test="${ordr.pdtId eq 1 }">
									<td>BASIC 요금제</td>
								</c:if>
								<c:if test="${ordr.pdtId eq 2 }">
									<td>PREMIUM 요금제</td>
								</c:if>
								<fmt:parseDate value="${ordr.ordrDt}" var="parsedDate1" pattern="yyyy-MM-dd HH:mm:ss" />
								<fmt:parseDate value="${ordr.ordrBgngDt}" var="parsedDate2" pattern="yyyy-MM-dd HH:mm:ss" />
								<fmt:parseDate value="${ordr.ordrEndDt}" var="parsedDate3" pattern="yyyy-MM-dd HH:mm:ss" />
								
								<td><fmt:formatDate value="${parsedDate1}" pattern="yyyy/MM/dd" /></td>
								<td><fmt:formatDate value="${parsedDate2}" pattern="yyyy/MM/dd" /> - <fmt:formatDate value="${parsedDate3}" pattern="yyyy/MM/dd" /></td>
								<td>${ordr.ordrAmt }￦</td>
								<td>${ordr.ordrPerson }명</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty orderList }">
							<tr>
								<td colspan="6">결제내역이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
</div>


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
      </div>
      <div class="modal-body">
      	<div class="row">
      		<div class="col-4 mx-auto">
      			<img alt="" src="/resources/img/보안.png" style="width: 100%; height: 100%; padding: 0">
      		</div>
      	</div>
      	<div class="col-sm-6">
	       <small class="text-uppercase font-weight-boldc" style="color: black;font-size: 16px;">비밀번호를 입력해주세요</small>
	     </div>
        <div class="pass-form-box">
							<div class="pass-form-title"><span>현재 비밀번호</span></div>
							<div class="pass-form-input"><input type="password" id="confirm_pw" name="current-password"/></div>
						</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-info" data-bs-dismiss="modal" id="pw_modal_close">닫기</button>
        <button type="button" class="btn btn-info" id="nextBtn">다음</button>
      </div>
    </div>
  </div>
</div>

<div id=modal_back>
	<div id="mypage_modal">
		<div id="mypage_modal_header">
			<h5>계정 정보 수정</h5>
		</div>
		<div id="mypage_modal_content">
			<form>
			<div class="row">
				<div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">아이디</label>
	                  <input class="form-control" id="custId" type="text" value="${client.custId }" readonly="readonly">
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">회사명</label>
	                  <input class="form-control" id="conm" type="text" value="${client.conm }" >
	                </div>
	              </div>
	          </div>
              <div class="row">
				<div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">사업자명</label>
	                  <input class="form-control" id="bplcNm" type="text" value="${client.bplcNm }">
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">사업자번호</label>
	                  <input class="form-control" id="brno" type="text" value="${client.brno }" >
	                </div>
	              </div>
	          </div>
              <div class="row">
				<div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">주소</label>
	                  <input class="form-control" id="bplcAddr" type="text" value="${client.bplcAddr }">
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">우편번호</label>
	                  <input class="form-control" id="bplcZip" type="text" value="${client.bplcZip }" >
	                  <button type="button" class="btn btn-default" id="address_search" onclick="DaumPostcode()">검색</button>
	                </div>
	              </div>
	          </div>
               <div class="row">
				<div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">상세주소</label>
	                  <input class="form-control" id="bplcDaddr" type="text" value="${client.bplcDaddr }">
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">전화번호</label>
	                  <input class="form-control" id="bplcTelno" type="text" value="${client.bplcTelno }" >
	                </div>
	              </div>
	          </div>
              <div class="row">
				<div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">담당자명</label>
	                  <input class="form-control" id="picNm" type="text" value="${client.picNm }">
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="input-group input-group-dynamic mb-4">
	                  <label class="form-label">담당자 연락처</label>
	                  <input class="form-control" id="picTelno" type="text" value="${client.picTelno }" >
	                </div>
	              </div>
	          </div>
	          <div class="row">
			    <div class="col-4">
			      <div class="form-check form-switch d-flex align-items-center ps-5">
			        <input class="form-check-input" type="checkbox" id="passwordFlag">
			        <label class="form-check-label ms-3 mb-0" for="passwordFlag">비밀번호 변경</label>
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
		<div id="mypage_modal_footer">
			<button class="btn btn-info" id="cancleBtn" onclick="fmodalClose()">취소</button>
			<button class="btn btn-info" id="updateBtn">완료</button>
		</div>
	</div>
</div>


	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
	$(()=>{
		drawDateChart();
		finitTab()
		ftab(0)
		var maxFileSz=${order.ordrPerson}*${product.addFileSz}
		var useFileSz=(${fileSum}/1024/1024/1024)
		
		$("#maxFileSz").text(maxFileSz+ " GB")
		$("#useFileSz").text(useFileSz.toFixed(2)+" GB")
		
		
		
		
		
		Chart.pluginService.register({
	    	  beforeDraw: function(chart) {
	    		  if (chart.canvas.id === "fileChart") {
			   	    var width = chart.chart.width,
			   	        height = chart.chart.height,
			   	        ctx = chart.chart.ctx;
			   	    ctx.restore();
			   	    var fontSize = (height / 114).toFixed(2);
			   	    ctx.font = fontSize + "em sans-serif";
			   	    ctx.textBaseline = "middle";
			   	    var percent = useFileSz/maxFileSz*100
			   	    var text = Math.round(percent)+"%",
			   	        textX = Math.round((width - ctx.measureText(text).width) / 2),
			   	        textY = height / 2;
			   	    ctx.fillText(text, textX, textY);
			   	    ctx.save();
	    		  }
	    		  if (chart.canvas.id === "cloudChart") {
				   	    var width = chart.chart.width,
				   	        height = chart.chart.height,
				   	        ctx = chart.chart.ctx;
				   	    ctx.restore();
				   	    var fontSize = (height / 114).toFixed(2);
				   	    ctx.font = fontSize + "em sans-serif";
				   	    ctx.textBaseline = "middle";
				   	    var percent = 0/0*100			//여기다가 사용중인용량/최대용량*100만 넣으면 알아서 도넛 가운데 숫자들어감
				   	    var text = Math.round(percent)+"%",
				   	        textX = Math.round((width - ctx.measureText(text).width) / 2),
				   	        textY = height / 2;
				   	    ctx.fillText(text, textX, textY);
				   	    ctx.save();
		    	}
	    	  }
	    	});  
		
		
		
		var today = new Date("2023-07-25");

	var normalList = JSON.parse('${normalList}')
	var abnormalList = JSON.parse('${abnormalList}')
	console.log(normalList)
	var normalData = normalList.map(obj => obj.normalCount);
	var abnormalData = abnormalList.map(obj => obj.abnormalCount);
	var dates = normalList.map(obj => obj.workDate.split(" ")[0]);
		var areaChartData = {
      labels  : dates,
      datasets: [
        {
          label               : '정시출근',
          backgroundColor     : 'rgba(60,141,188,0.9)',
          borderColor         : 'rgba(60,141,188,0.8)',
          pointRadius          : false,
          pointColor          : '#3b8bba',
          pointStrokeColor    : 'rgba(60,141,188,1)',
          pointHighlightFill  : '#fff',
          pointHighlightStroke: 'rgba(60,141,188,1)',
          data                : normalData
        },
        {
          label               : '지각,조퇴',
          backgroundColor     : 'rgba(210, 214, 222, 1)',
          borderColor         : 'rgba(210, 214, 222, 1)',
          pointRadius         : false,
          pointColor          : 'rgba(210, 214, 222, 1)',
          pointStrokeColor    : '#c1c7d1',
          pointHighlightFill  : '#fff',
          pointHighlightStroke: 'rgba(220,220,220,1)',
          data                : abnormalData
        },
      ]
    }
		
		//-------------
	    //- BAR CHART -
	    //-------------
	    var barChartCanvas = $('#barChart').get(0).getContext('2d')
	    var barChartData = $.extend(true, {}, areaChartData)
	    var temp0 = areaChartData.datasets[0]
	    var temp1 = areaChartData.datasets[1]
	    barChartData.datasets[0] = temp1
	    barChartData.datasets[1] = temp0


	    new Chart(barChartCanvas, {
	      type: 'bar',
	      data: barChartData,
	    })
	})
	const tabs = document.querySelectorAll(".tabs");
	const submenus = document.querySelectorAll(".submenu");
	
	function finitTab(){
        for(let i = 0; i < tabs.length; i++){
        	tabs[i].style.display = 'none';
        	submenus[i].className = "other-menu submenu";
        }
    }
    function ftab(pNum){
        finitTab();
        if(pNum==0){
        	tabs[pNum].style.display = 'flex';
        }else{
        	tabs[pNum].style.display = 'block';
        }
        
        submenus[pNum].className = "current-menu submenu";
    }
	
    $("#passwordFlag").on("change",function(){
    	console.log($(this).prop("checked"))
    	if($(this).prop("checked")){
    		$("#password").prop("disabled",false)
    		$("#password2").prop("disabled",false)
    	}else{
    		$("#password").val("")
    		$("#password").prop("disabled",true)
    		$("#password2").val("")
    		$("#password2").prop("disabled",true)
    	}
    })
    
    $("#updateBtn").on("click",function(){
    	var custId=$("#custId").val()
    	var conm = $("#conm").val()
    	var bplcNm=$("#bplcNm").val();
    	var brno = $("#brno").val();
    	var bplcAddr = $("#bplcAddr").val();
    	var bplcDaddr = $("#bplcDaddr").val();
    	var bplcZip = $("#bplcZip").val();
    	var bplcTelno = $("#bplcTelno").val();
    	var picNm = $("#picNm").val();
    	var picTelno = $("#picTelno").val();
    	var password = $("#password").val();
    	var password2 = $("#password2").val();
    	var passwordFlag = $("#passwordFlag").prop("checked")
    	
    	if(password!=password2){
    		alert("비밀번호와 비밀번호 재확인이 일치하지 않습니다.")
    		return false;
    	}
		
    	if(passwordFlag&&password==""){
    		alert("비밀번호를 입력해주세요.")
    		return false;
    	}

    	
    	var obj={
    			custId:custId,
    			conm:conm,
    			bplcNm:bplcNm,
    			brno:brno,
    			bplcAddr:bplcAddr,
    			bplcDaddr:bplcDaddr,
    			bplcZip:bplcZip,
    			bplcTelno:bplcTelno,
    			picNm:picNm,
    			picTelno:picTelno,
    			custPw:password,
    			passwordFlag:passwordFlag
    	}
    	$.ajax({
			  url: '/everysolution/updateClient', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: obj, // 요청에 첨부할 데이터 (선택 사항)
	  		  beforeSend : function(xhr){
			  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	  		  },
			  success: function(response) {
			  		if(response=="OK"){
			  			alert("수정되었습니다.")
			  			$(".custId").text(custId)
						$(".conm").text(conm)
						$(".bplcNm").text(bplcNm)
						$(".brno").text(brno)
						$(".bplcAddr").text(bplcAddr)
						$(".bplcDaddr").text(bplcDaddr)
						$(".bplcZip").text(bplcZip)
						$(".bplcTelno").text(bplcTelno)
						$(".picNm").text(picNm)
						$(".picTelno").text(picTelno)
			  			fmodalClose()
			  		}else{
			  			alert("수정실패")
			  		}
			  },
			  error: function(xhr, status, error) {
				alert("서버에러")
			  }
			});
    })

    
    
	$("#nextBtn").on("click",function(){
		$.ajax({
			  url: '/everysolution/confirmPw', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: {password:$("#confirm_pw").val()}, // 요청에 첨부할 데이터 (선택 사항)
	  		  beforeSend : function(xhr){
			  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	  		  },
			  success: function(response) {
			  		if(response=="OK"){
			  			$("#pw_modal_close").click()
			  			fmodalOpen()
			  		}else{
			  			alert("비밀번호가 일치하지 않습니다!")
			  		}
			  },
			  error: function(xhr, status, error) {
				alert("서버에러")
			  }
			});
	})
	
	
	
	
	
	
	
	
    
	/* 멤버십 현황 시작 */
    // 차트를 그리는 함수
    function drawDateChart() {
        var startDate = new Date('${order.ordrBgngDt}');
        var endDate = new Date('${order.ordrEndDt}');
        var today = new Date();

        // 2023년 1월 1일부터 오늘까지의 날짜 데이터를 생성합니다.
        var passDays = Math.floor((today - startDate) / (1000 * 60 * 60 * 24));
        var totalDays = Math.floor((endDate - startDate) / (1000 * 60 * 60 * 24));
        console.log(totalDays);

        var bar = document.querySelector('.bar');
        var barFill = document.querySelector('.barFill');
        var tooltiptext = document.querySelector('.tooltiptext');

        barFill.style.width = (passDays / totalDays * 100) + '%';
        tooltiptext.innerHTML = (totalDays-passDays) + '일 남았습니다!';
    }


    function drawCloudChart(){
        const data = {
        labels: [
            '여유 용량',
            '사용 중'
        ],
        datasets: [{
            label: 'Cloud',
            data: [300, 50],
            backgroundColor: [
            'rgba(255, 255, 255, 0.1)',
            'rgba(121, 120, 210, 0.6)'
            ],
            borderColor: 'rgb(121, 120, 210)',
            hoverOffset: 4,
            borderWidth: 1
        }]
        };

        const ctx = document.getElementById('cloudChart');

        new Chart(ctx, {
            type: 'doughnut',
            data: data ,
            options: {
            	cutoutPercentage: 70,
       	     responsive: true,
       	    legend: {
       	      display: false
       	    }
       	  }
        });
    }

    function drawFileChart(){
        const data = {
        labels: [
            '여유 용량',
            '사용 중'
        ],
        datasets: [{
            label: 'File(GB)',
            data: [(${order.ordrPerson}*${product.addFileSz}-(${fileSum}/1024/1024/1024)).toFixed(2),(${fileSum}/1024/1024/1024).toFixed(2)],
            backgroundColor: [
            'rgba(255, 255, 255, 0.1)',
            'rgba(0, 181, 148, 0.6)'
            ],
            borderColor: 'rgb(0, 181, 148)',
            hoverOffset: 4,
            borderWidth: 1
        }]
        };

        const mtx = document.getElementById('fileChart');

        new Chart(mtx, {
            type: 'doughnut',
            data: data,
            options: {
            	cutoutPercentage: 70,
       	     responsive: true,
       	    legend: {
       	      display: false
       	    }
       	  }
        });
    }
    drawCloudChart();
    drawFileChart();
    
	/* 멤버십 현황 끝 */
	
	/* 내 정보 시작 */
    
    const modal = document.querySelector('#modal_back');

    function fmodalOpen() {
    	modal.style.display = 'block';
    	$("input",modal).focus()
    }

    function fmodalClose(){
    	modal.style.display = 'none';
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
                document.getElementById('bplcZip').value = data.zonecode;
                document.getElementById("bplcAddr").value = addr + ' ' + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("bplcDaddr").focus();
            }
        }).open();
    }
    
	/* 내 정보 끝 */
</script>