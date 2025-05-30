<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
    let headerName = "${_csrf.headerName}"
    let token = "${_csrf.token}"
</script>

<style>
.space-evenly{
	justify-content: space-evenly;
}
.suvyList {
}

.suvyItem {
    border: 1px solid #e9ecef;
    position: relative;
}

.si {
    border: none;
    background-color: transparent;
}

.form-control:disabled, .form-control[readonly] {
    background-color: transparent;
}

.btnVote {
    margin-top: 1em;
}

#pagingArea{
    margin-bottom: 1em;
}

.cover1{
	height: 100%;
    width: 100%;
    position: absolute;
    z-index: 999;
    background: rgba(0,0,0,0.2);
    text-align: center;
    justify-content: center;
    align-items: center;
}
.no_part{
	filter: blur(2px);
    opacity: 0.7;
}
.details{
	position: relative;
}
.searchPage label{
	width: 60px;
}
</style>
<section class="content-header">
   <div class="container-fluid">
       <div class="row mb-2">
           <div class="col-sm-6">
               <h1>설문</h1>
           </div>
           <div class="col-sm-6">
               <ol class="breadcrumb float-sm-right">
                   <li class="breadcrumb-item"><a href="#">Home</a></li>
                   <li class="breadcrumb-item active">설문</li>
               </ol>
           </div>
       </div>
   </div><!-- /.container-fluid -->
</section>
<section class="content">
    <div class="container-fluid">
        <div class="card searchPage col-12">
					<div class="card-body search_div">
						<div class="row space-evenly">
							<div class="form-group col-sm-4">
								<div class="row">
									<label for="suvyTtl" class="col-form-label">설문제목</label>
									<div class="col">
										<input type="text" class="form-control" id="suvyTtl"
										placeholder="title"	>
									</div>
								</div>
							</div>
							<div class="form-group col-sm-4">
								<div class="row">
									<label for="empName" class="col-form-label">등록자</label>
									<div class="col">
										<input type="text" class="form-control" id="empName"
											>
									</div>
								</div>
							</div>
						</div>
						<div class="row space-evenly">
							<div class="form-group col-sm-4">
								<div class="row">
									<label for="name" class="col-form-label">날짜</label>
									<div class="input-group col">
									<div class="input-group-prepend">
									<span class="input-group-text">
									<i class="far fa-calendar-alt"></i>
									</span>
									</div>
									<input type="text" class="form-control float-right" id="reservation">
									</div>
								</div>
							</div>
							<div class="form-group col-sm-4">
								<div class="row">
									<label for="subject">대상자</label>
									<div class="col">
										<select id="subject" class="form-control" name="searchSubject">
		                                    <option value="전체" selected="selected">전체</option>
		                                    <option value="받은설문">받은설문</option>
		                                </select>
									</div>
								</div>
							</div>
						</div>
						<div class="row space-evenly">
							<div class="form-group col-sm-4">
								<div class="row">
									<label for="searchState">진행상태</label>
									<div class="col">
		                                <select id="searchState" class="form-control" name="searchState">
		                                    <option value="0" selected="selected">전체</option>
		                                    <option value="4">진행예정</option>
		                                    <option value="1">진행중</option>
		                                    <option value="2">마감</option>
		                                </select>
		                             </div>
		                         </div>
							</div>
							<div class="col-sm-4">
								<div class="row">
									<label for="search_btn" class="col-form-label"></label>
									<div class="col">
										<button type="button" class="btn btn-default" id="search_btn">검색</button>
										<button type="button" class="btn btn-default" id="reset_btn">리셋</button>
										<button type="button" class="btn btn-primary" id="btnSuvyAdd">등록</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
        
        <!-- 설문 목록 -->
        <div class="row" id="suvyList"></div>

        <div class="row">
            <!-- 페이지 번호 -->
            <!-- <div class="col-sm-10 ms-auto text-end" id="pagingArea"> -->
            <div class="col-sm-12" id="pagingArea" > 
                <ul class="pagination pagination-primary mt-0">
                    <!-- ${suvyPaging.pagingHTML} -->
                </ul>
            </div>
        </div>
    </div>
</section>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.0/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.39.0/js/tempusdominus-bootstrap-4.min.js" integrity="sha512-k6/Bkb8Fxf/c1Tkyl39yJwcOZ1P4cRrJu77p83zJjN2Z55prbFHxPs9vN7q3l3+tSMGPDdoH51AEU8Vgo1cgAA==" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.39.0/css/tempusdominus-bootstrap-4.min.css" integrity="sha512-3JRrEUwaCkFUBLK1N8HehwQgu8e23jTH4np5NHOmQOobuC4ROQxFwFgBLTnhcnQRMs84muMh0PnnwXlPq5MGjg==" crossorigin="anonymous" />
<sec:authentication var="empId" property="principal.employee.empId"/>
<script>
$(()=>{
    
	var obj={
			suvyTtl:null,
			empName:null,
			subject:'전체',
			suvyState:0,
			sdate:null,
			edate:null,
			page:1
	}
	
	var btnSuvyAdd = $("#btnSuvyAdd");
    var searchForm = $("#searchForm");
    var pagingArea = $("#pagingArea");
	

    suvyList(obj,addList)
    
    $("#reset_btn").on("click",function(){
    	obj={
    			suvyTtl:null,
    			empName:null,
    			subject:'전체',
    			suvyState:0,
    			sdate:null,
    			edate:null,
    			page:1
    	}
    	 $("#empName").val("")      
    	 $("#subject").val('전체')      
    	 $("#searchState").val(0)
    	 $("#suvyTtl").val("")      
    		
    		
    	suvyList(obj,addList)
    })
    
    $("#search_btn").on("click",function(){
    	var date = $("#reservation").val()
    	obj.sdate = date.substr(0,10)
		obj.edate = date.substr(13,23)
		
    	obj.empName = $("#empName").val()
    	obj.subject = $("#subject").val()
    	obj.suvyState = $("#searchState").val()
    	obj.suvyTtl = $("#suvyTtl").val()
    	
    	
    	suvyList(obj,addList)
    })
    
    //투표하기버튼 눌렀을때
    $(document).on("click",".btnVote", function(){
    	var suvyList=$(this).parents(".suvyList")
    	var details=$(this).parents(".details")
    	var items = suvyList.find(".suvyItem")
    	if(items.hasClass("ra")){
    		var checkedValues = items.find("input[type='radio']:checked").map(function() {
	    	    return $(this).attr("id");
	    	  }).get();
    		console.log(checkedValues)
    	}
    	else if(items.hasClass("cb")){
    		var checkedValues = items.find("input[type='checkbox']:checked").map(function() {
	    	    return $(this).attr("id");
	    	  }).get();
	    	console.log(checkedValues)
    	}
    	$.ajax({
            url: `/everyware/suvy/vote`,
            type: "post",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            data: JSON.stringify(checkedValues),
            beforeSend : function(xhr){
                // xhr.setRequestHeader("${_headerName}","${token}");
                xhr.setRequestHeader(headerName,token);
            },
            success: function(res){
                if(res=="OK"){
                	alertSuccess("투표가 완료되었습니다.")
                	details.find(".btnVote").remove()
                	var btn = `<button type="button" class="btn btn-outline-danger btn-sm mb-0 btnRevote">투표 다시하기</button>`
                	var stmt=`<span class="stmt" style="color:gray;">이미 참여한 설문입니다.</span>`
                	details.append(btn).append(stmt)
                }
                if(res=="EXIST"){
                	alert("이미 참여하셨습니다.")
                	location.reload();
                }
                if(res=="FAILED"){
                	alert("잘못된 접근입니다.")
                	location.reload();
                }
            },
            error: function(xhr) {
                alert("Error: " + xhr.status);
            }
        });
    })
    //다시투표하기버튼 눌렀을때
    $(document).on("click",".btnRevote", function(){
    	var suvyList=$(this).parents(".suvyList")
    	var items = suvyList.find(".suvyItem")
    	if(items.hasClass("ra")){
    		var checkedValues = items.find("input[type='radio']:checked").map(function() {
	    	    return $(this).attr("id");
	    	  }).get();
    		console.log(checkedValues)
    	}
    	else if(items.hasClass("cb")){
    		var checkedValues = items.find("input[type='checkbox']:checked").map(function() {
	    	    return $(this).attr("id");
	    	  }).get();
	    	console.log(checkedValues)
    	}
    	$.ajax({
            url: `/everyware/suvy/revote`,
            type: "post",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            data: JSON.stringify(checkedValues),
            beforeSend : function(xhr){
                // xhr.setRequestHeader("${_headerName}","${token}");
                xhr.setRequestHeader(headerName,token);
            },
            success: function(res){
                if(res.res>0){
                	alertSuccess("투표가 완료되었습니다.")
                }
            },
            error: function(xhr) {
                alert("Error: " + xhr.status);
            }
        });
    })
    
    $("#reservation").daterangepicker({
		   locale: {
			    "separator": " ~ ",                     // 시작일시와 종료일시 구분자
			    "format": 'YYYY/MM/DD',     // 일시 노출 포맷
			    "applyLabel": "확인",                    // 확인 버튼 텍스트
			    "cancelLabel": "취소",                   // 취소 버튼 텍스트
			    "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
			    "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
			    },
			    autoApply: false, 
			    startDate: moment().subtract(1, 'month'),
			    endDate: new Date(),
			    drops: "auto"
	})
    //설문등록 클릭시
    btnSuvyAdd.on("click", function(){
        location.href = "/everyware/suvy/form.do";
    });

	// 페이지 번호 클릭시
    pagingArea.on("click", "a", function(event) {
        event.preventDefault();
        var pageNo = $(this).data("page"); // 페이지 번호가 넘어옴
        obj.page=pageNo
        suvyList(obj,addList)
    });
    

});

// 설문목록
function suvyList(data,callback){
    $.ajax({
        url: `/everyware/suvy/suvyList`,
        type: "post",
        contentType: 'application/json; charset=utf-8',
        dataType: "json",
        data:JSON.stringify(data),
        beforeSend : function(xhr){
            // xhr.setRequestHeader("${_headerName}","${token}");
            xhr.setRequestHeader(headerName,token);
        },
        success: function(res){
        	if(typeof callback != "undefined"){
        		callback(res)
        	}
        },
        error: function(xhr) {
            alert("Error: " + xhr.status);
        }
    });
}

function addList(res){

    // alert("check");
    console.log("res",res);
    $("#suvyList").html("");
    $("#pagingArea").html("");
    
    var dataList = res.dataList;
    var suvyListStr = "";
    var pagingAreaStr = res.suvyPaging.pagingHTML;
    if(dataList.length == 0){
        suvyListStr += `<div>조회하신 기록이 존재하지 않습니다.</div>`;
    } else {
        
        
        for(let i=0; i<dataList.length; i++){
            var sdate = dateFormat2(dataList[i].suvyBgngDt);
            var edate = dateFormat2(dataList[i].suvyEndDt)
            var suvyDuplicate = dataList[i].suvyDuplicate;
            var suvyItemList = dataList[i].suvyItemList;
            
            var cantDo=""
            var opt=""
            var stmt=""
            var disabled=""
             if(dataList[i].partYn==null){
					cantDo=`<div class="cover1 d-flex">
								<h4>설문 대상자가 아닙니다.</h4>
							</div>`
					opt=" no_part"
						disabled=" disabled"
				}else if(dataList[i].suvyState==4||dataList[i].suvyState==2||dataList[i].suvyState==3){
					cantDo=`<div class="cover1 d-flex">
						<h4>설문 기간이 아닙니다.</h4>
					</div>`
				opt=" no_part"
				disabled=" disabled"
				}
				var precom=""
				var revote=`<button type="button" class="btn btn-outline-primary btn-sm mb-0 btnVote\${disabled}" >투표하기</button>`
				var revoteClass=""
				if(dataList[i].partYn=="Y"){
					precom=`<span class="stmt" style="color:gray;">이미 참여한 설문입니다.</span>`
					revote=`<button type="button" class="btn btn-outline-danger btn-sm mb-0 btnRevote\${disabled}" >투표 다시하기</button>`
				}
            
				var status=""
				if(dataList[i].suvyState==1){
					status="<span class='btn btn-success'>진행중</span>"
				}else if(dataList[i].suvyState==2||dataList[i].suvyState==3){
					status="<span class='btn btn-secondary'>마감</span>"
				}else if(dataList[i].suvyState==4){
					status="<span class='btn btn-info'>예정</span>"
				}
				
				
            suvyListStr += 
            `<div class="col-md-12 col-sm-12">
                    <div class="card mb-4">
                        <div class="card-body pt-3 suvyList">
                            <p class="text-dark mb-2 text-sm">설문 등록자: \${dataList[i].empName}</p>
                            <p class="text-gray mb-2 text-sm">진행 기간: \${sdate} ~ \${edate} \${status}</p>
                            <a href="/everyware/suvy/suvyDetail?suvyNo=\${dataList[i].suvyNo}">
                                <h5>\${dataList[i].suvyTtl}</h5>
                            </a>
                            <div class="details">
                            \${cantDo}
                            <p class="\${opt}">\${dataList[i].suvyCn}</p>`;
                           
				
				
            if (suvyDuplicate == 'Y'){
            	suvyListStr += ` <div class="suvyItem cb">`
                for(let j=0; j<suvyItemList.length; j++){
                	var checkOpt=""
                	if(dataList[i].siNoList!=null){
                		if(dataList[i].siNoList.includes(dataList[i].suvyItemList[j].siNo)){
                			checkOpt=" checked"
                		}
                	}
                    suvyListStr += 
                    `<div class="input-group\${opt}">
                        <div class="input-group-prepend">
                            <span class="input-group-text si">
                                <input type="checkbox" id="\${dataList[i].suvyItemList[j].siNo}" name=""\${checkOpt}>
                            </span>
                        </div>
						<div class="item_cn">
							\${dataList[i].suvyItemList[j].siCn}
						</div>
                     </div>`
                }
            } else {
            	suvyListStr += `<div class="suvyItem ra">`
                for(let j=0; j<suvyItemList.length; j++){
                	var checkOpt=""
                    	if(dataList[i].siNoList!=null){
                    		if(dataList[i].siNoList.includes(dataList[i].suvyItemList[j].siNo)){
                    			checkOpt=" checked"
                    		}
                    	}
                    suvyListStr += 
                    `<div class="input-group\${opt}">
                        <div class="input-group-prepend">
                            <span class="input-group-text si">
                                <input type="radio" id="\${dataList[i].suvyItemList[j].siNo}" name="\${dataList[i].suvyNo}"\${checkOpt}>
                            </span>
                        </div>
                        <div class="item_cn">
							\${dataList[i].suvyItemList[j].siCn}
						</div>
                    </div>`
                }
            }

            suvyListStr += 
            `</div>
            \${revote}\${precom}
                    </div>
                </div>
            </div>
            </div>
            `;

        }
    }

    $("#suvyList").html(suvyListStr);
    $("#pagingArea").html(pagingAreaStr);
	
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
		var formattedDateString = `\${year}년 \${formattedMonth}월 \${formattedDay}일 (\${getDayOfWeekString(date)})`;
		
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
</script>