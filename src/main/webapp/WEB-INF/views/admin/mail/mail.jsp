<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
.search_form {
	justify-content: space-evenly;
	margin: 0;
	margin-top: 20px;
}
.search_form button{
	margin: 0 8px;
}
.search_form label {
	width: 50px;
}

.form_container {
	overflow-x: hidden !important;
}
.search_form .form-check{
	display: inline-block;
}
.check_box_group label{
	width: 70px;
}
#total{
font-size: 12px;
    color: gray;
    margin-left: 10px;
}
.sender_profile{
	    width: 30px;
    height: 30px;
    border-radius: 100%;
}
.receiver_profile{
	    width: 30px;
    height: 30px;
    border-radius: 100%;
}
.span_date{
	font-size: 12px;
}
.sender_profile_container{
	display: flex;
}
.receiver_profile_container{
	display: flex;
}
ion-icon[name=attach-outline]{
	font-size: 24px;
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
#mail_modal{
position: fixed;
  top: 50%;
  left: 50%;
  min-width: 75%;
  min-height: 80%;
  background: white;
  z-index: 1038;
  transform: translate(-50%, -50%);
}
#mail_modal_header{
	border-bottom: rgba(0,0,0,0.15) 1.5px solid;
	padding: 20px;
}
#mail_modal_header h5{
	font-weight: bold;
}
#mail_modal_content{
	padding: 30px;
	padding-bottom: 10px;
}
#mail_modal_footer{
	padding: 30px;
	border-top: rgba(0,0,0,0.15) 1.5px solid;
	min-height: 100px;
}
#mail_modal_footer button{
	float: right;
	margin-left: 10px;
	border: none;
	color: white;
	border-radius: 10px;
	padding: 6px 25px;
	background: cadetblue;
}
#mail_modal_content label{
	width: 70px;
	vertical-align: top;
	font-weight: normal;
}
#mail_modal_content input[type=datetime-local]{
	width: 185px;
    height: 25px;
}
#content{
	min-height: 180px;
    max-height: 300px;
    width: 100%;
    resize: none;
}
.receiver_wrapper{
	display: inline-block;
}
.receiver_td{
	width: 50%;
    
}
.receiver{
	margin-right: 50px;
	max-height: 110px;
	overflow: auto;
}
.sender_td{
}
.file_thumb{
	width: 28px;
    height: 28px;
    border-radius: 5px;
    display: inline-block;
}
.thumb_div{
	width: 28px;
	height: 28px;
	display: inline-block;
	text-align: center;
	border-radius: 5px;
	background: gainsboro;
}
.thumb_container{
	margin: 3px 0;
}
.content_div{
	height: 300px;
	overflow: auto;
}
.result_table tbody tr:hover{
	background: rgba(0,0,0,0.1)
}
</style>
<section class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1>메일 관리</h1>
			</div>
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">메일 관리</li>
				</ol>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->
</section>
<div class="row d-flex justify-content-center">
	<div class="col-11">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">Fixed Header Table</h3>
				<div class="card-tools">
					<div class="input-group input-group-sm" style="width: 150px;">
					</div>
				</div>
			</div>

			<div class="card-body table-responsive p-0 form_container"
				style="height: 150px;">
				<div class="form-group row search_form">
					<label for="deptSel" class="col-form-label">부서</label>
					<div class="col-sm-2">
						<select class="form-control" id="deptSel">
							<option value="0">default</option>
							<c:if test="${not empty deptList }">
								<c:forEach items="${deptList }" var="dept">
									<option value="${dept.deptId }">${dept.deptNm }</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
					<label for="posSel" class="col-form-label">직급</label>
					<div class="col-sm-2">
						<select class="form-control" id="posSel">
							<option value="0">default</option>
							<c:if test="${not empty posList }">
								<c:forEach items="${posList }" var="pos">
									<option value="${pos.jbgdId }">${pos.jbgdNm }</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
					<label for="name" class="col-form-label">이름</label>
					<div class="col-sm-2">
						<input type="text" class="form-control" id="name"
							placeholder="Name">
					</div>
					<label for="title" class="col-form-label">제목</label>
					<div class="col-sm-2">
						<input type="text" class="form-control" id="title"
							placeholder="Title">
					</div>
				</div>
				<div class="form-group row search_form">
					<label for="sdate" class="col-form-label">날짜</label>
					<div class="col-sm-2">
						<input type="date" id="sdate" class="form-control">
					</div>
					<label for="edate" class="col-form-label" style="padding: 0; font-size: 25px;">&nbsp;&nbsp;~</label>
					<div class="col-sm-2">
						<input type="date" class="form-control" id="edate">
					</div>
					<label for="isRemove" class="col-form-label"></label>
					<div class="col-sm-2">
					</div>
					<label for="inputEmail3" class="col-form-label"></label>
					<div class="col-sm-2">
						<div class="row">
							<button type="button" class="btn btn-default" id="search_btn">검색</button>
							<button type="button" class="btn btn-default" id="reset_btn">리셋</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="row d-flex justify-content-center page_a">
	<div class="col-11">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">검색 결과 <span id="total">전체 3건</span></h3>
				<div class="card-tools">
					<div class="input-group input-group-sm" style="width: 150px;">
						<div class="input-group-append">
							<select class="form-control" id="orderSel">
								<option>날짜 오름차순</option>
								<option>날짜 내림차순</option>
							</select>
						</div>
					</div>
				</div>
			</div>

			<div class="card-body table-responsive p-0" style="height: 400px;">
				<table class="table table-head-fixed text-nowrap result_table">
					<thead>
						<tr>
							<th>User</th>
							<th>position</th>
							<th>department</th>
							<th>title</th>
							<th>attach</th>
							<th>date</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
			<div class="card-footer">
				
			</div>
		</div>

	</div>
</div>
<div id=modal_back>
	<div id="mail_modal">
		<div id="mail_modal_header">
			<h5>메일 상세</h5>
		</div>
		<div id="mail_modal_content">
			<table class="table" border="1">
					<thead>
						<tr>
							<th><h5>제목</h5></th>
							<th id="title_div" colspan="5"><h5></h5></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>보낸이</td>
							<td colspan="2" class="sender_td"><div class="sender"></div></td>
							<td>받는이</td>
							<td colspan="2" class="receiver_td"><div class="receiver"></div></td>
						</tr>
						<tr>
							<td>첨부파일</td>
							<td colspan="5" class="attach">
								<div class="col-sm-10 detail_file_div">
								  <div class="thumb_container" data-atchfileno="128" data-atchfileseq="1" data-filenm="알람-메신저.png" data-filesz="10500" data-filetype="image/png">
				                  	<div class="thumb_div">
				                  		<img class="file_thumb" src="/everyware/mail/thumbnail/?atchFileNo=128&amp;atchFileSeq=1" alt="Attachment">
				                  	</div>
				                    <a href="/everyware/mail/filedownload/?atchFileNo=128&amp;atchFileSeq=1" class="mailbox-attachment-name">
				                    	<i class="fas fa-paperclip"></i> 알람-메신저.png
				                    </a>
				                    <span>10.25 MB</span>
				                    <a href="/everyware/mail/filedownload/?atchFileNo=128&amp;atchFileSeq=1" class="btn btn-default btn-sm float-right download_btn"><i class="fas fa-cloud-download-alt"></i></a>
				               	 </div>
					           </div>
							</td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="5"><div class="content_div"></div></td>
						</tr>
					</tbody>
				</table>
		
		
			<!-- <div class="row title_row" style="max-height:100px;">
				<div class="col-sm-2"><h5>제목: </h5></div>
				<div class="col-sm-10 title_div">
					<h5>나는야 타이틀 제목이빈다.sfsafsfsfsfsf나나나나나나자가마가나다라마바사아자차카타파하에에에헤이에ㅣ에이ㅔ</h5>
				</div>
			</div>
			<hr>
			<div class="row profile_row">
				<label for="name" class="col-form-label col-sm-2">보낸이</label>
				<div class="col-sm-4 sender">
				</div>
				<label for="name" class="col-form-label col-sm-2">받는이</label>
				<div class="col-sm-4 receiver">
				</div>
			</div>
			<hr>
			<div class="row attach_row">
				<label for="name" class="col-form-label col-sm-2">첨부파일</label>
				<div class="col-sm-10 attach">
				</div>
			</div>
			<hr>
			<div class="row content_row">
				<label for="name" class="col-form-label col-sm-2">내용</label>
				<div class="col-sm-10 content_div">
					<textarea id="content" class="form-control" rows="" cols="" readonly="readonly"></textarea>
				</div>
			</div> -->
		</div>
		<div id="mail_modal_footer">
			<button id="cancleBtn">나가기</button>
		</div>
	</div>
</div>
<script type="text/javascript">
$(()=>{
	var obj={
			deptId:0,
			jbgdId:0,
			name:null,
			title:null,
			sdate:null,
			edate:null,
			isLately:"날짜 오름차순",
			page:1 
	}
	
	$("#cancleBtn").on("click",function(){
		$("#modal_back").fadeOut()
	})
	
	$(".result_table").on("click","tr",function(){
		$(".detail_file_div").empty();
		$(".sender").empty();
		$(".receiver").empty();
		var emlId = this.id
		getMailDetail(emlId,function(response){
			$(".content_div").html(response.emlCn)
			$("#title_div h5").html(response.emlTtl)
			var profileimg ="/resources/img/basicProfile.png"
			if(response.sender.empProfile!=null){
				profileimg = "/everyware/mypage/thumbnail?empId="+response.sender.empId
			}
			var profile = `<div class="sender_profile_container">
								<img src="\${profileimg}" class="sender_profile">
								<div class="sender_profile_container">
									<div class="sender_name">\${response.sender.empName}</div>
								</div>
							</div>`
			$(".sender").html(profile)
			
			$.each(response.receiver,function(i,v){
				var profileimg ="/resources/img/basicProfile.png"
				if(v.empProfile!=null){
					profileimg = "/everyware/mypage/thumbnail?empId="+v.empId
				}
				var profile=`
							<div class="receiver_wrapper">
								<div class="receiver_profile_container">
									<img src="\${profileimg}" class="receiver_profile">
									<div class="receiver_profile_container">
										<div class="sender_name">\${v.empName}</div>
									</div>
								</div>
							</div>`
				$(".receiver").append(profile)
			})
			
			
			if(response.fileList!=null && response.fileList.length>0){
				$.each(response.fileList,function(i,v){
					var fileContent = `<div class="thumb_container" data-atchfileno="\${v.atchFileNo}" data-atchfileseq="\${v.atchFileSeq}" data-filenm="\${v.fileNm}" data-filesz="\${v.fileSz}" data-filetype="\${v.fileType}">
					                  	<div class="thumb_div">
					              		<img class="file_thumb" src="/everyware/mail/thumbnail/?atchFileNo=\${v.atchFileNo}&atchFileSeq=\${v.atchFileSeq}" alt="Attachment">
					              	</div>
					                <a href="/everyware/mail/filedownload/?atchFileNo=\${v.atchFileNo}&atchFileSeq=\${v.atchFileSeq}" class="mailbox-attachment-name">
					                	<i class="fas fa-paperclip"></i> \${v.fileNm}
					                </a>
					                <span>\${convertFileSize(v.fileSz)}</span>
					                <a href="/everyware/mail/filedownload/?atchFileNo=\${v.atchFileNo}&atchFileSeq=\${v.atchFileSeq}" class="btn btn-default btn-sm float-right download_btn"><i class="fas fa-cloud-download-alt"></i></a>
					           	 </div>`
					 $(".detail_file_div").append(fileContent)
				})
				
			}
		})
		$("#modal_back").fadeIn()
	})
	
	$(".card-footer").on("click",".pagination a",function(e){
		e.preventDefault()
		var page=$(this).data("page")

		obj.page=page
		getMailList(obj,fillTable)
		
	})
	
	$("#search_btn").on("click",function(){
		var deptId = $("#deptSel").val()
		var jbgdId = $("#posSel").val()
		var name = $("#name").val()
		var title = $("#title").val()
		var sdate = $("#sdate").val()
		var edate = $("#edate").val()
		if(sdate!=""){
			sdate=new Date(sdate).toISOString().slice(0,10)
		}
		if(edate!=""){
			edate=new Date(edate).toISOString().slice(0,10)
		}
		console.log(sdate)
		console.log(edate)
		obj.deptId=deptId;
		obj.jbgdId=jbgdId;
		obj.name=name;
		obj.title=title;
		obj.sdate=sdate;
		obj.edate=edate;
		obj.page=1;
		
		console.log(obj)
		getMailList(obj,fillTable)
	})
	
	$("#reset_btn").on("click",function(){
		$("#deptSel").val(0)
		$("#posSel").val(0)
		$("#name").val("")
		$("#title").val("")
		$("#sdate").val("")
		$("#edate").val("")
		obj.deptId=0;
		obj.jbgdId=0;
		obj.name=null;
		obj.title=null;
		obj.sdate=null;
		obj.edate=null;
		obj.page=1;

		
		getMailList(obj,fillTable)
	})
	
	$("#orderSel").on("change",function(){
		console.log($(this).val())
		obj.isLately=$(this).val()
		getMailList(obj,fillTable)
	})
	
	
	getMailList(obj,fillTable)
	
	
	
	
	function getMailList(obj,callback){
		$.ajax({
			  url: '/everyware/admin/mail/mailList', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: JSON.stringify(obj),
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	  contentType: 'application/json; charset=utf-8',
			  success: function(response) {
				  if(typeof callback !="undefined"){
					  callback(response)
				  }
				 
			  },
			  error: function(xhr, status, error) {
				alert("메일전송 실패")
			  }
			});
	}
	
	function fillTable(response){
		var total = "전체 "+ response.totalRecord+"건"
		 $("#total").text(total)
		 $(".result_table tbody").empty()
		 
		 $.each(response.dataList,function(i,v){
			 var date = dateFormat2(v.emlSndngDt)
			 var attach = ""
			 if(v.atchFileNo>0){
				 attach=`<ion-icon name="attach-outline"></ion-icon>`
			 }
			 var profileimg ="/resources/img/basicProfile.png"
			 if(v.senderProfile!=null){
				profileimg = "/everyware/mypage/thumbnail?empId="+v.senderId
			 }
			 var tr=`<tr id=\${v.emlId}>
					<td>
						<div class="sender_profile_container">
							<img src="\${profileimg}" class="sender_profile">
							<div class="sender_profile_container">
								<div class="sender_name">\${v.senderName}</div>
							</div>
						</div>
					</td>
					<td>\${v.senderJbgdNm}</td>
					<td>\${v.senderDeptNm}</td>
					<td>\${v.emlTtl}</td>
					<td>\${attach}</td>
					<td><span class="span_date">\${date}</span></td>
				</tr>`
				 $(".result_table tbody").append(tr)
		 })
		  $(".card-footer").html(response.pagingHTML)
		
	}
	
	function getMailDetail(emlId,callback){
		$.ajax({
			  url: '/everyware/admin/mail/detail', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: JSON.stringify({emlId:emlId}),
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	  contentType: 'application/json; charset=utf-8',
			  success: function(response) {
				  if(typeof callback !="undefined"){
					  callback(response)
				  }
				 
			  },
			  error: function(xhr, status, error) {
				alert("메일전송 실패")
			  }
		});
	}
	
})



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
function convertFileSize(sizeInKB) {
	  if (sizeInKB < 1024) {
	    return sizeInKB + ' KB';
	  } else if (sizeInKB < 1024 * 1024) {
	    const sizeInMB = (sizeInKB / 1024).toFixed(2);
	    return sizeInMB + ' MB';
	  } else {
	    const sizeInGB = (sizeInKB / (1024 * 1024)).toFixed(2);
	    return sizeInGB + ' GB';
	  }
	}
</script>