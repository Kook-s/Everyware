<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<script src="https://use.fontawesome.com/releases/v6.4.0/js/all.js"></script>
<style>
.titleNum{
  width        :  100%;     /* 너비는 변경될수 있습니다. */
  text-overflow: ellipsis;  /* 위에 설정한 100px 보다 길면 말줄임표처럼 표시합니다. */
  white-space  : nowrap;    /* 줄바꿈을 하지 않습니다. */
  overflow     : hidden;    /* 내용이 길면 감춤니다 */
  display      : block; 
}

.progressbar{
  width: 100%;
  height: 30px;
  border-radius: 5px;
  overflow:hidden;
  background: #ccc;
  position:relative;
}
.progressbar::after{
  content:'';
  position:absolute;
  top:0;
  left:0;
  height: 30px;
  width:var(--width, 50%);
  background:#007bff;
  animation: progress 2s ease forwards;
}
@keyframes progress{
  0%{width: 0px}
}
.progress{
  display: flex;
  background: none;
  position: absolute;
  padding: 5px 0;
  top:30%;
  right: 44%;
  font-size: 16px;
  z-index:99;
  color: #FFF;
}
.progress::after{
  content: '%';
  
}
</style>

<section class="content-header">
  <div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1>클라우드</h1>
			</div>
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">Cloud</li>
				</ol>
			</div>
		</div>
	</div>
	
  <div class="d-flex px-4">
  
    <!-- Content Header (Page header) -->
          <div class="col-md-2">
            <b href="mailbox.html" class="btn btn-primary btn-block mb-3">Cloud</b>
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">부서 클라우드</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <div class="card-body p-0 w-100">
                <ul class="nav nav-pills flex-column" id="deptTotal">
                  <li class="nav-item active deptList" value="total">
                    <a href="/everyware/cloud/depCloud?path" class="nav-link">
                      <img alt="basic" src="/resources/img/folder.png" height="20" width="20">
                      	${employee.jbgdNm }
                    </a>
                  </li>
                </ul>
              </div>
            </div>

            <div class="card ">
              <div class="card-header ">
                <h3 class="card-title">My클라우드</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <div class="card-body p-0 w-100">
                <ul class="nav nav-pills flex-column" id="deptTotal">
                  <li class="nav-item active deptList" value="total">
                    <a href="/everyware/cloud/cloud?path" class="nav-link">
                      <img alt="basic" src="/resources/img/folder.png" height="20" width="20">
                      	${employee.empId }
                    </a>
                  </li>
                </ul>
              </div>
            </div>
             <div class="card ">
              <b href="mailbox.html" class="btn btn-primary btn-block mb-3">상세정보</b>
              <div class="p-1 mb-4 d-flex justify-content-center align-content-center mx-3 py-1" style="background: #f5f5f5; border-radius: 10px;">
                <img src="/resources/img/EveryWarePageIcon.png" alt="" id="dataImg" height="100" width="100">
              </div>
            <!--   <b class="text-bold ml-3">종류: <h7 id="dataType"></h7></b>
              <b class="text-bold ml-3">이름: <h7 id="dataName"></h7></b>
              <b class="text-bold ml-3">크기: <h7 id="dataSize"></h7></b>
              <b class="text-bold ml-3">위치: <h7 id="dataPath"></h7></b> -->
					<div class="ml-3 mb-3">  
						<div class='d-flex'>            
							<b style="width: 50px">형식</b>
							<span class="badge bg-success" id="dataType">선택한 파일의 형식</span>
						</div>
						<div class='d-flex my-2'>  
							<b style="width: 50px">이름</b></td>
							<span class="badge bg-warning" id="dataName">선택한 파일의 이름</span>
						</div>
						<div class='d-flex'>  
							<b style="width: 50px">크기</b></td>
							<span class="badge bg-primary" id="dataSize">선택한 파일 사이즈</span>
						</div>
					</div>
            </div>
        </div>

    <!-- Main content -->

      <!-- Default box -->
      
      <div class="col-10 h-50">
        <div class="d-flex">

          <div class="row col-12 d-flex justify-content-center">
	          <div class="row card card-primary card-outline col-12 p-1 m-y2 ">
	            <div>
	            	<div class="d-flex justify-content-between ">
	            		<div><b id="cldTotalSize">${cldTotalSize } </b>/ ${sCldTotalSize }GB</div>
	            		<div class="d-flex"><b>여유</b> <div id="cldRemain"></div><b>GB</b></div>
	            	</div>
	           		<div class="progressbar">
					   <span class="progress" >0</span>
					  </div>
	           	</div>
	          </div>
	          
            <input type="hidden" id="thisPath" value="${thisPath }">
            <%-- ${thisPath } --%>
            <div class="col-12 card-primary card-outline" id='dragUpload' style="background: #FFF; border-radius: 10px; padding-bottom: 20px " >
            		<div class="mt-3 d-flex justify-content-between ">
            			<c:if test="${menu eq 'dep' }">
            				<h4 style="color: #007bff; font-weight: bold;">${employee.jbgdNm } 클라우드</h4> 
            			</c:if>
            			<c:if test="${menu eq 'emp' }">
            				<h4 style="color: #007bff; font-weight: bold;">My 클라우드</h4>
            			</c:if>
   						<button class ="btn btn-sm btn-primary" id="fCreate"><i class="fa-solid fa-folder-plus fa-xl" style="color: #ffffff;"></i></button>
            		</div>
            		<hr>

            <c:if test="${myHomePath ne backFolder}">
	            <div class="col-2 float-left my-2" style="height: 240px;">
		              <div class="card bg-light" style="margin: 0%">
		                <div class="card-header text-center" >뒤로가기</div>
		                <div class="card-body d-flex justify-content-center">
		                  	<img alt="basic" src="/resources/img/folder.png">
		                </div>
		                <div class="card-footer " style="padding: 2px">
		                  <div class="text-right">
		                  	<c:if test="${menu eq 'emp' }">
		                    	<a href="/everyware/cloud/cloud?path=${backFolder }" class="btn btn-sm btn-primary"><i class="fa-solid fa-folder" style="color: #ffffff;"></i></a>
                    		</c:if>
                    		<c:if test="${menu eq 'dep' }">
		                    	<a href="/everyware/cloud/depCloud?path=${backFolder }" class="btn btn-sm btn-primary"><i class="fa-solid fa-folder" style="color: #ffffff;"></i></a>
                    		</c:if>
		                  </div>
		                </div>
		              </div>
		            </div>
	            </c:if>
              <c:forEach items="${cldList }" var="cld">
               	<c:if test="${cld.cldNm ne employee.empId }">
		            <div class="col-2 float-left my-2 fileData">
		            	<input type="hidden" class="dType" value="${cld.cldType }">
		            	<input type="hidden" class="dName" value="${cld.cldNm }">
		            	<input type="hidden" class="dSize" value="${cld.cldSize }">
		            	<input type="hidden" class="dPath" value="${cld.cldTotalPath }">
		              <div class="card bg-light" style="margin: 0%">
		                <div class="card-header text-center titleNum" >${cld.cldNm }</div>
			                <div class="card-body d-flex justify-content-center fileDataBody">
			                  	<c:choose>
			                  		<c:when test="${cld.cldType eq 'png' || cld.cldType eq 'jpg' || cld.cldType eq 'jpeg' }">
			                  			<img alt="png" src="/resources/img/img.png">
			                  		</c:when>
			                  		<c:when test="${cld.cldType eq 'mp3' }">
			                  			<img alt="mp3" src="/resources/img/mp3.png">
			                  		</c:when>
			                  		<c:when test="${cld.cldType eq 'doc' }">
			                  			<img alt="doc" src="/resources/img/doc.png">
			                  		</c:when>
			                  		<c:when test="${cld.cldType eq 'mp4' }">
			                  			<img alt="video" src="/resources/img/video.png">
			                  		</c:when>
			                  		<c:when test="${cld.cldType eq 'ppt' }">
			                  			<img alt="ppt" src="/resources/img/ppt.png">
			                  		</c:when>
			                  		<c:when test="${cld.cldType eq 'pdf' }">
			                  			<img alt="pdf" src="/resources/img/pdf.png">
			                  		</c:when>
			                  		<c:when test="${cld.cldType eq 'xls' || cld.cldType eq 'xlsx' }">
			                  			<img alt="xls" src="/resources/img/xls.png">
			                  		</c:when>
			                  		<c:when test="${cld.cldType eq 'doc' }">
			                  			<img alt="doc" src="/resources/img/doc.png">
			                  		</c:when>
			                  		<c:when test="${cld.cldType eq 'css' }">
			                  			<img alt="css" src="/resources/img/css.png">
			                  		</c:when>
			                  		<c:when test="${cld.cldType eq 'html' }">
			                  			<img alt="html" src="/resources/img/html.png">
			                  		</c:when>
			                  		<c:when test="${cld.cldType eq 'txt' }">
			                  			<img alt="txt" src="/resources/img/txt.png">
			                  		</c:when>
			                  		<c:when test="${cld.cldType eq 'zip' }">
			                  			<img alt="zip" src="/resources/img/zip.png">
			                  		</c:when>
			                  		<c:otherwise>
			                  			<c:choose>
			                  				<c:when test="${cld.cldSize eq '0'}">
			                  					<img alt="basic" src="/resources/img/folder.png">
			                  				</c:when>
			                  				<c:otherwise>
			                  					<img alt="basic" src="/resources/img/basic.png">
			                  				</c:otherwise>
			                  			</c:choose>
			                  		</c:otherwise>
			                  	</c:choose>
			                </div>
				                <div class="card-footer" style="padding: 2px">
				                  <div class="text-right">
				                  <c:if test="${cld.cldSize ne '0' }">
				                    <a href="/everyware/cloud/downloadCloud?cldTotalNm=${cld.cldTotalNm }&cldTotalPath=${cld.cldTotalPath }" class="btn btn-sm bg-teal cldDownload">
				                     	<i class="fa-solid fa-download" style="color: #ffffff;"></i>
				                    </a>
				                    <a href="#" class="btn btn-sm btn-primary cldDelete">
				                    	<input type="hidden" value="${cld.cldTotalNm }" class="cldTotalNm">
				                    	<input type="hidden" value="${cld.cldTotalPath }" class="cldTotalPath">
				                    	<i class="fa-solid fa-xmark" style="color: #ffffff;"></i>
				                    </a>
				                    </c:if>
				                    <c:if test="${cld.cldSize eq '0' }">
				                    	<c:if test="${menu eq 'emp' }">
					                    	<a href="/everyware/cloud/cloud?path=${cld.cldTotalPath }" class="btn btn-sm btn-primary"><i class="fa-regular fa-folder-open" style="color: #ffffff;"></i></a>
			                    		</c:if>
			                    		<c:if test="${menu eq 'dep' }">
					                    	<a href="/everyware/cloud/depCloud?path=${cld.cldTotalPath }" class="btn btn-sm btn-primary"><i class="fa-regular fa-folder-open" style="color: #ffffff;"></i></a>
			                    		</c:if>
				                    </c:if>
				                  </div>
				                </div>
			             	 </div>
			            </div>
		            </c:if>
	            </c:forEach>
          
           
          </div>
          <!-- @@@@@@ -->
          </div>

        </div>
      </div>
  </div>
 </section>
 <script type="text/javascript">
 var fileList = []; //파일 정보를 담아 둘 배열
$(function(){
	var Toast = Swal.mixin({
	      toast: true,
	      position: 'top-end',
	      showConfirmButton: false,
	      timer: 3000
	    });
	
	var orCldSize = "${sCldTotalSize }"
	
	var progressbar = parseFloat($("#cldTotalSize").text())/orCldSize*100;
	
	$("#cldRemain").text(orCldSize - parseFloat($("#cldTotalSize").text()))
	
	$('.progressbar').css('--width', progressbar+'%');
    $({ val : 0 }).animate({ val : progressbar }, {
    	   duration: 2000,
    	  step: function() {
    	    $(".progress").text(Math.floor(this.val));
    	  },
    	  complete: function() {
    	    $(".progress").text(Math.floor(this.val));
    	    $(".progress").css("color","#fff");
    	  }
    	});
	
	$(".cldDownload").on('click', function(){
		  var cldTotalNmValue = $(this).find('.cldTotalNm').val();
	        var cldTotalPathValue = $(this).find('.cldTotalPath').val();
	        
	        console.log(cldTotalNmValue)
	        console.log(cldTotalPathValue)
	        
	       Toast.fire({
             icon: 'success',
             title: cldTotalNmValue+'다운로드 완료되었습니다.'
           })
	}) 
	
	
	$(".cldDelete").on('click', function(){
		  var cldTotalNmValue = $(this).find('.cldTotalNm').val();
	        var cldTotalPathValue = $(this).find('.cldTotalPath').val();
	        
	        console.log(cldTotalNmValue)
	        console.log(cldTotalPathValue)
	        $(this).closest(".fileData").hide()
	         $.ajax({
			        url: '/everyware/cloud/deleteCloud',
			        method: 'post',
			        data:{	cldTotalNm:  $(this).find('.cldTotalNm').val(),
			        	cldTotalPath: $(this).find('.cldTotalPath').val()
			        },
			        beforeSend : function(xhr){
			          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			        },
			        success: function(res){
			            
			        	console.log(res)
			            Toast.fire({
			              icon: 'success',
			              title: cldTotalNmValue+'삭제 완료되었습니다.'
			            })
			        },
			        error: function(xhr){
			          console.log("실패",xhr.status);
			          Toast.fire({
			              icon: 'error',
			              title: '삭제 실패되었습니다.'
			            })
			        }
			      })
	})
	
	 $("#dragUpload").on("dragenter", function(e){
	        e.preventDefault();
	        e.stopPropagation();
	    }).on("dragover", function(e){
	        e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#FFD8D8");
	    }).on("dragleave", function(e){
	        e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#FFF");
	    }).on("drop", function(e){
	        e.preventDefault();
	        var files = e.originalEvent.dataTransfer.files;
	      console.log(files)
	        if(files != null && files != undefined){
	            var tag = "";
	            for(i=0; i<files.length; i++){
	                var f = files[i];
	                fileList.push(f);
	            }
	        }
	      
	      var formData = new FormData($("#fileForm")[0]);
	        if(fileList.length > 0){
	            fileList.forEach(function(f){
	                formData.append("fileList", f);
	            });
	        }         
	        $.ajax({
	            url : "/everyware/cloud/uploadCloud?thisPath="+$("#thisPath").val(),
	            data : formData,
	            type:'POST',
	            enctype:'multipart/form-data',
	            processData:false,
	            contentType:false,
	            dataType:'json',
	            beforeSend : function(xhr){
	                xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	              },
	            success:function(res){
	            	Toast.fire({
			              icon: 'success',
			              title:'업로드 완료되었습니다.'
			            })
	            },error:function(res){
	            	Toast.fire({
			              icon: 'error',
			              title:'업로드 실패되었습니다.'
			            })
	            }
	        });
	      

	        $(this).css("background-color", "#FFF");
	        console.log(fileList)
	        
	        setTimeout(() => {
		        location.reload();
			}, 1000);
	    });
	
	$(".fileData").on("click",function(){
		
	var imgNum ="";		
	
  	if($(this).find(".dType").val() == 'png'||$(this).find(".dType").val() == 'jpg'||$(this).find(".dType").val() == 'jpeg'){
  		imgNum ="/resources/img/img.png";
  	}else if($(this).find(".dType").val() == 'doc'){
  		imgNum ="/resources/img/doc.png";
  	
  	}else if($(this).find(".dType").val() == 'mp4'){
  		imgNum ="/resources/img/video.png";
  	
  	}else if($(this).find(".dType").val() == 'ppt'){
  		imgNum ="/resources/img/ppt.png";
  	
  	}else if($(this).find(".dType").val() == 'pdf'){
  		imgNum ="/resources/img/pdf.png";
  	
  	}else if($(this).find(".dType").val() == 'xls' || $(this).find(".dType").val() == 'xlsx'){
  		imgNum ="/resources/img/xls.png";
  	
  	}else if($(this).find(".dType").val() == 'css'){
  		imgNum ="/resources/img/css.png";
  	
  	}else if($(this).find(".dType").val() == 'html'){
  		imgNum ="/resources/img/html.png";
  	
  	}else if($(this).find(".dType").val() == 'txt'){
  		imgNum ="/resources/img/txt.png";
  	
  	}else if($(this).find(".dType").val() == 'zip'){
  		imgNum ="/resources/img/zip.png";
  	}else{
  		if($(this).find(".dSize").val() == 0){
  			imgNum ="/resources/img/folder.png";
  		}else{
  			imgNum ="/resources/img/basic.png";
  		}
  	}
  	
  		$(".fileDataBody").css("background-color", "#fff");
  		$(this).find($(".fileDataBody")).css("background-color", "#c6e2ff");
  	
		$("#dataImg").attr("src", imgNum);
		
		$("#dataType").html($(this).find(".dType").val())
		$("#dataName").html($(this).find(".dName").val())
		$("#dataSize").html($(this).find(".dSize").val())
		$("#dataPath").html($(this).find(".dPath").val())
	
	})
	
	$("#fCreate").on('click', function(){
		var folder = "";
			
		folder = 
					`
					<form action="/everyware/cloud/createFoler" method="post">
						<input type="hidden" value=${thisPath } name="thisPath">
						<input type="hidden" value=${menu } name="menu">
						<div class="col-2 float-left my-2" style="height: 240px;">
			            <div class="card bg-light" style="margin: 0%">
			              <div class="card-header text-center  d-flex">
			              	<input type="text" style="width: 100%;" name="folderNm"/>
			              </div>
			              <div class="card-body d-flex justify-content-center">
			                	<img alt="basic" src="/resources/img/folder.png">
			              </div>
			              <div class="card-footer" style="padding: 2px">
			                <div class="text-right">
			                  	<input type="submit" class="btn btn-sm btn-primary" value="생성">
			                </div>
			              </div>
			            </div>
			          </div>
			          <sec:csrfInput/>
		          </form>
				`
		
		$("#dragUpload").append(folder)
	})
})
 
</script>














