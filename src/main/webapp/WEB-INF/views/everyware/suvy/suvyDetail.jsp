<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-Knob/1.2.13/jquery.knob.min.js"></script>
<script>
    var headerName = "${_csrf.headerName}"
    var token = "${_csrf.token}"
</script>

<style>
.form-control:disabled {
    background-color: white;
}

.si {
    /* border: none; */
    background-color: transparent;
}

/* .suvyItem {
    border: 1px solid #e9ecef;
} */

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
#result_modal{
position: fixed;
  top: 50%;
  left: 50%;
      width: 50%;
  background: white;
  z-index: 1038;
  transform: translate(-50%, -50%);
}
#result_modal_content{
	display: flex;
	    margin: 0 25px;
    margin-top: 25px;
}
#result_modal_content2{
	margin: 25px;
}
#result_chart{
	flex: 2;
}
#statistic{
	flex: 2;
	display: flex;
	justify-content: space-evenly;
}
.statistic_content{
	display: flex;
    flex-direction: column;
    align-items: center;
}
#donut{
	width: 400px;
	height: 200px;
}
.statistic_content label{
	flex: 1;
}
.statistic_content div{
	flex: 4;
}
#result_modal_content{
	font-size: 13px;
}
#rank{
	height: 350px;
  overflow-y:auto;
}
#result_modal_header{
	border-bottom: rgba(0,0,0,0.15) 1.5px solid;
	padding: 20px;
}
#result_modal_header h5{
	font-weight: bold;
}
#result_modal_footer{
	padding: 30px;
	border-top: rgba(0,0,0,0.15) 1.5px solid;
	min-height: 100px;
}
</style>


<section class="content py-3">
    <div class="container-fluid">

        <div class="row" style="padding: 10px;">

            <div class="col">

                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">SURVEY DETAIL</h3>
                        <input type="hidden" name="suvyNo" id="suvyNo" value="">
                        <input type="hidden" name="empId" id="empId" value="">
                    </div>

                    <div class="card-body">
                        <!-- line1 -->
                        <div class="form-group row">
                            <label for="suvyTtl" class="col-sm-2 col-form-label">제목</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="suvyTtl" name="suvyTtl" value="" disabled>
                            </div>
                        </div>
                        
                        <!-- line2 -->
                        <div class="form-group row">
                            <label for="writer" class="col-sm-2 col-form-label">작성자</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="writer" name="writer" value="" disabled>
                            </div>

                            <label for="" class="col-sm-2 col-form-label">등록일자</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="suvyDt" name="suvyDt" value="" disabled>
                            </div>
                        </div>

                        <!-- line3 -->
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">설문기간</label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="far fa-calendar-alt"></i>
                                        </span>
                                    </div>
                                    <input type="text" class="form-control float-right" id="suvyPeriod" name="" value="" disabled>
                                </div>
                            </div>
                                
                            <label class="col-sm-2 col-form-label">설문설정</label>
                            <div class="col-sm-4">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text ">
                                                    <input type="checkbox" id="suvySigned" name="suvySigned" disabled>
                                                </span>
                                            </div>
                                            <input type="text" class="form-control" value="공개여부" disabled>
                                        </div>
                                    </div>
                                    
                                    <div class="col-sm-6">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">
                                                    <input type="checkbox" id="suvyDuplicate" name="suvyDuplicate" disabled>
                                                </span>
                                            </div>
                                            <input type="text" class="form-control" value="중복투표" disabled>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                            
                        <!-- line4 -->
                        <div class="form-group row">
                            <label for="" class="col-sm-2 col-form-label">내용</label>
                            <div class="col-sm-10">
                                <div class="input-group mb-3">
                                    <textarea class="form-control" id="suvyCn" name="suvyCn" rows="10" disabled></textarea>
                                </div>
                            </div>
                        </div>

                        <!-- line5 -->
                        <div class="form-group row">
                            <label for="" class="col-sm-2 col-form-label">항목</label>
                            <div class="col-sm-10">
                                <div class="suvyItemList" id="suvyItem">
                                    <!-- <div class="input-group mb-3 suvyItem">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text si">
                                                <input type="checkbox" id="" name="">
                                            </span>
                                        </div>
                                        <input type="text" class="form-control suvyInput" value="항목1" disabled>
                                    </div>
                                     -->
                                </div>
                                
                            </div>
                        </div>
                        
                    </div>
                    
                    <div class="card-footer suvy_btns">
                    	<c:if test="${(not empty voteYn) and  voteYn eq 'Y'}">
                    		<button type="button" class="btn btn-primary" id="voteBtn">투표하기</button>
                    	</c:if>
                        <c:if test="${(not empty revoteYn) and  revoteYn eq 'Y'}">
                    		<button type="button" class="btn btn-danger" id="revoteBtn">다시투표하기</button>
                    	</c:if>
                        <c:if test="${(not empty resYn) and  resYn eq 'Y'}">
                        	<button type="button" class="btn btn-primary" id="resultBtn">결과보기</button>
                        </c:if>
                        
                        <button type="button" class="btn btn-default float-right" id="btnBack">목록</button>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
</section>
<div id=modal_back>
	<div id="result_modal">
		<div id="result_modal_header">
			<h5>설문 결과</h5>
		</div>
		<div id="result_modal_content">
			<div id="result_chart">
				<label for="donut" id="donutLabel">여긴 라베르</label>
				<canvas id="donut"></canvas>
			</div>
			<div id="statistic">
				<div class="statistic_content">
					<label for="partStatic">여긴 라베르</label>
					<input id="partStatic" type="text" class="partStatic">
				</div>
				<div class="statistic_content">
					<label for="voteStatic">여긴 라베르</label>
					<input id="voteStatic" type="text" class="voteStatic">
				</div>
			</div>
		</div>
		<div id="result_modal_content2">
			<div id="rank">
				<table class="table table-bordered">
				<thead>
				<tr>
				<th style="width: 10px">#</th>
				<th>항목</th>
				<th>득표수</th>
				<th style="width: 70px">득표율</th>
				</tr>
				</thead>
				<tbody>
				</tbody>
				</table>
			</div>
		</div>
		<div id="result_modal_footer">
			<button id="closeBtn" class="btn btn-primary" style="float: right;">닫기</button>
		</div>
	</div>
</div>
<script>
$(()=>{
    const queryString = window.location.search;
    const paramName = 'suvyNo=';
    const suvyNo = queryString.substring(queryString.indexOf(paramName) + paramName.length);
    const staticColors = ['#f56954', '#00a65a', '#f39c12', '#00c0ef', '#3c8dbc', '#d2d6de']
    
    console.log(empId);
    suvyDetail(suvyNo);

    
    $("#resultBtn").on("click",function(){
    	//-------------
        //- DONUT CHART -
        //-------------
        // Get context with jQuery - using jQuery's .get() method.
       
        
         $.ajax({ 
            url: `/everyware/suvy/result`,
            type: "post",
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            data: JSON.stringify(suvyNo),
            beforeSend : function(xhr){
                // xhr.setRequestHeader("${_headerName}","${token}");
                xhr.setRequestHeader(headerName,token);
            },
            success: function(res){
            	//예네는 ajax로 값 가져온 후에 콜백으로 실행
            	
            	res.itemList.sort((a,b)=>b.count-a.count)
            	
            	var labels=[]
            	var counts=[]
            	var total=0
            	for(var i=0; i<res.itemList.length; i++){
            		counts.push(res.itemList[i].count)
            		labels.push(res.itemList[i].siCn)
            		total+=res.itemList[i].count
            	}
            	console.log("라벨이다")
            	console.log(labels)
            	
            	console.log("카운트다")
            	console.log(counts)
            	var colors=staticColors.slice(0,counts.length)
            	
                var donutChartCanvas = $('#donut').get(0).getContext('2d')
                var donutData        = {
                  labels: labels,
                  datasets: [
                    {
                      data: counts,
                      backgroundColor : colors,
                    }
                  ]
                }
                //Create pie or douhnut chart
                // You can switch between pie and douhnut using the method below.
                new Chart(donutChartCanvas, {
                  type: 'doughnut',
                  data: donutData
                })  
            	$("#rank tbody").empty()
            	for(var i=0; i<res.itemList.length; i++){
            		var ratio = res.itemList[i].count/total*100
            		var format= Number(ratio.toFixed(2))
            		if(total==0){
            			format=0
            		}
            		var tr = `<tr>
			       				<td>\${i+1}</td>
			       				<td>\${res.itemList[i].siCn}</td>
			       				<td>총 \${total}표중 \${res.itemList[i].count}득표</td>
			       				<td><span class="badge bg-warning">\${format}%</span></td>
		       				  </tr>`
		       				  
		       		$("#rank tbody").append(tr)
            	}
            	
            	$("#statistic label").eq(0).text(`대상 \${res.subCount}명중 \${res.partCount}명 참여`)
            	$(".partStatic").val(res.partCount)
            	$(".partStatic").knob({
            	    'min':0,
            	    'max':res.subCount,
            	    "readOnly":true,
            	    "width":"50px",
            	    "height":"50px",
            	    "inputColor":"#ffc107",
            	    "fgColor":"#ffc107"
            	});
            	
            	$("#statistic label").eq(1).text(`개표수 총 \${total}표`)
            	$(".voteStatic").val(total)
            	$(".voteStatic").knob({
            	    'min':0,
            	    'max':(res.subCount*res.itemList.length),
            	    "readOnly":true,
            	    "width":"50px",
            	    "height":"50px",
            	    "inputColor":"#17a2b8",
            	    "fgColor":"#17a2b8"
            	});
            	
            },
            error: function(xhr) {
                alert("Error: " + xhr.status);
            }
        }); 
        
        
    	
    	
    	
    	
    	
    	
    	$("#modal_back").css("display","block")
    })
    $("#closeBtn").on("click",function(){
    	$("#modal_back").css("display","none")
    })
    
    $(".suvy_btns").on("click","#voteBtn",function(){
    	console.log("보트비티엔")
    	if($(".suvyItemList").hasClass("ra")){
    		var checkedValues = $(".suvyItemList input[type='radio']:checked").map(function() {
	    	    return $(this).attr("id");
	    	  }).get();
    		console.log(checkedValues)
    	}
    	else if($(".suvyItemList").hasClass("cb")){
    		var checkedValues = $(".suvyItemList input[type='checkbox']:checked").map(function() {
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
                	$("#voteBtn").removeClass("btn-primary")
                	$("#voteBtn").addClass("btn-danger")
                	$("#voteBtn").text("다시투표하기")
                	$("#voteBtn").attr("id","revoteBtn")
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
    $(document).on("click","#revoteBtn",function(){
    	if($(".suvyItemList").hasClass("ra")){
    		var checkedValues = $(".suvyItemList input[type='radio']:checked").map(function() {
	    	    return $(this).attr("id");
	    	  }).get();
    		console.log(checkedValues)
    	}
    	else if($(".suvyItemList").hasClass("cb")){
    		var checkedValues = $(".suvyItemList input[type='checkbox']:checked").map(function() {
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
    
    // Cancel버튼 클릭시
    $(document).on("click", "#btnBack", function () {
        location.href = "/everyware/suvy";
    });

    $(document).on('click', '#btnDelete', function () {
        console.log('btnDelete');

        var suvyNo = $("#suvyNo").val();
        console.log("suvyNo", suvyNo);

        if(!confirm('삭제하시면 복구할수 없습니다. \n정말로 삭제하시겠습니까??')){
            return false;
        }

        $.ajax({
            type: "delete",
            url: `/everyware/suvy/delSuvy/\${suvyNo}`,
            contentType: 'application/json; charset=utf-8',
            dataType: "text",
            beforeSend : function(xhr){
                xhr.setRequestHeader(headerName,token);
            },
            success: function(res){
                console.log("res", res);
                if (res == "success") {
                    alert("삭제되었습니다.");
                    
                    location.href = "/everyware/suvy";
                } else {
                    alert("삭제가 되지않았습니다. 다시 시도해주세요.");
                }

            },
            error: function (xhr) {
                alert("Error: " + xhr.status);
            }
        });
    });

});

function suvyDetail(suvyNo){
    console.log("suvyDetail");
    
    $.ajax({
        type: "get",
        url: `/everyware/suvy/getOneSuvy/\${suvyNo}`,
        contentType: 'application/json; charset=utf-8',
        dataType: "json",
        beforeSend : function(xhr){
            xhr.setRequestHeader(headerName,token);
        },
        success: function(res){
            console.log("res", res);
            var suvyNo = res.suvyNo;
            var suvyTtl = res.suvyTtl;
            var suvyCn = res.suvyCn;
            var suvyDt = res.suvyDt;
            var writer = res.empId;
            var suvySigned = res.suvySigned;
            var suvyDuplicate = res.suvyDuplicate;
            var suvyItemList = res.suvyItemList;
            var suvyListStr = "";
            var suvyBgngDt = res.suvyBgngDt.substring(0, 10);
            var suvyEndDt = res.suvyEndDt.substring(0, 10);
            var suvyPeriod = `\${suvyBgngDt} ~ \${suvyEndDt}`;
            
            if(suvySigned == 'Y'){
                $("#suvySigned").prop("checked", true);
            }
			var answers=null;
            if(res.answers!=null){
            	answers = res.answers.map(obj => obj.siNo);
        	}
            
            if(suvyDuplicate == 'Y'){
                $("#suvyDuplicate").prop("checked", true);

                for(let i = 0; i < suvyItemList.length; i++){
                	var checked=""
                   	if(answers!=null){
                   		if(answers.includes(suvyItemList[i].siNo)){
                   			checked="checked"
                   		}
                   	}
                    suvyListStr += 
                    `<div class="input-group mb-3 suvyItem">
                        <div class="input-group-prepend">
                            <span class="input-group-text si">
                                <input type="checkbox" id="\${suvyItemList[i].siNo}" name="" \${checked}>
                            </span>
                        </div>
                        <input type="text" class="form-control si" value="\${suvyItemList[i].siCn}" disabled="">
                    </div>`;
                }
                $(".suvyItemList").addClass("cb")
            } else {
                for(let j = 0; j < suvyItemList.length; j++){
                	var checked=""
                	if(answers!=null){
                		if(answers.includes(suvyItemList[j].siNo)){
                			checked="checked"
                		}
                	}
                    suvyListStr += 
                    `<div class="input-group mb-3 suvyItem">
                        <div class="input-group-prepend">
                            <span class="input-group-text si">
                                <input type="radio" id="\${suvyItemList[j].siNo}" name="radio" \${checked}>
                            </span>
                        </div>
                        <input type="text" class="form-control si" value="\${suvyItemList[j].siCn}" disabled="">
                    </div>`;
                }
                $(".suvyItemList").addClass("ra")
            }

            // console.log("suvyNo", suvyNo);
            // console.log("suvyTtl", suvyTtl);
            // console.log("suvyCn", suvyCn);
            // console.log("suvyDt", suvyDt);
            // console.log("writer", writer);
            // console.log("suvySigned", suvySigned);
            // console.log("suvyDuplicate", suvyDuplicate);
            // console.log("suvyItemList", suvyItemList);
            // console.log("suvyListStr", suvyListStr);
            // console.log("suvyBgngDt", suvyBgngDt);
            // console.log("suvyEndDt", suvyEndDt);
            // console.log("suvyPeriod", suvyPeriod);
            
            $('#suvyNo').val(suvyNo);
            $(`#suvyTtl`).val(suvyTtl);
            $(`#suvyCn`).val(suvyCn);
            $(`#suvyDt`).val(suvyDt);
            $(`#writer`).val(writer);
            $(`#suvyPeriod`).val(suvyPeriod);
            $(`.suvyItemList`).html(suvyListStr);
			$("#donutLabel").text(suvyTtl)
            if(writer == window.messengerEmpId) {
                const deleteButton  = 
                `<button type="button" class="btn btn-danger float-right" id="btnDelete" style="margin-right: 4px">삭제</button>`;
                $('.card-footer').append(deleteButton);
            }

        }, 
        error: function(xhr) {
            alert("Error: " + xhr.status);
        }
    });
}

</script>
