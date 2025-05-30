<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.contextmenu {
  display: none;
  position: absolute;
  width: 200px;
  margin: 0;
  padding: 0;
  background: #FFFFFF;
  border-radius: 5px;
  list-style: none;
  box-shadow:
    0 15px 35px rgba(50,50,90,0.1),
    0 5px 15px rgba(0,0,0,0.07);
  overflow: hidden;
  z-index: 999999;
}

.contextmenu li {
  border-left: 3px solid transparent;
  transition: ease .2s;
}

.contextmenu li a {
  display: block;
  padding: 10px;
  color: #B0BEC5;
  text-decoration: none;
  transition: ease .2s;
}

.contextmenu li:hover {
  background: #CE93D8;
  border-left: 3px solid #9C27B0;
}

.contextmenu li:hover a {
  color: #FFFFFF;
}
.table-avatar{
	height: 40px;
	width: 40px;
}
</style>

<section class="content-header">
  <div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1>사원관리</h1>
			</div>
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">Management</li>
				</ol>
			</div>
		</div>
	</div>

    <div class="row px-4">
      <div class="col-md-2">
        <b href="mailbox.html" class="btn btn-primary btn-block mb-3">회사관리</b>
        <div class="card">
          <div class="card-header">
            <h3 class="card-title">부서</h3>
            <div class="card-tools">
                 <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
              </button>
            </div>
          </div>
          <div class="card-body p-0 w-100">
            <ul class="nav nav-pills flex-column" id="deptTotal">
              <li class="nav-item active deptList" value="total">
                <a href="#" class="nav-link">
                  <i class="fas fa-inbox"></i> 전체
                  <c:set var="count" value="0" /> <!-- 초기 카운트 값 설정 -->
                  <c:forEach items="${empList}" var="emp">
                    <c:set var="count" value="${count + 1}" /> <!-- index 값을 활용한 카운트 증가 -->
                  </c:forEach>
                  <span class="badge bg-primary float-right m-1">
                    ${count}
                  </span>
                </a>
              </li>

              <c:if test="${depList ne 'null'}">
                <c:forEach items="${depList}" var="department">
                  <li class="nav-item deptList" value="${department.deptId}">
                    <a href="#" class="nav-link">
                      <i class="fas fa-inbox"></i> ${department.deptNm}
                      <c:set var="count" value="0" /> <!-- 초기 카운트 값 설정 -->
                      <c:forEach items="${empList}" var="emp">
                        <c:if test="${department.deptNm eq emp.department.deptNm }">
                          <c:set var="count" value="${count + 1}" /> <!-- index 값을 활용한 카운트 증가 -->
                        </c:if>
                      </c:forEach>
                      <span class="badge bg-primary float-right m-1" >
                          ${count}
                      </span>
                    </a>
                  </li>
                </c:forEach>
              </c:if>

              <li class="nav-item active deptList" value="total">
                <a href="#" class="nav-link">
                  <div class="input-group">
                    <input id="addDeptNm" type="text" class="form-control" placeholder="추가 부서명">
                    <div class="input-group-append">
                      <button type="button" class="btn btn-primary" id="dAdd">추가</button>
                    </div>
                  </div>
                </a>
              </li>
            </ul>
          </div>
          <!-- /.card-body -->
        </div>
        <div class="card">
          <div class="card-header">
            <h3 class="card-title">직급</h3>

            <div class="card-tools">
              <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
              </button>
            </div>
          </div>
          <div class="card-body p-0">
            <ul class="nav nav-pills flex-column" id="posiTotal">
              <li class="nav-item active posiList" value="total">
                <a href="#" class="nav-link">
                  <i class="fas fa-inbox"></i> 전체
                  <c:set var="count" value="0" /> <!-- 초기 카운트 값 설정 -->
                  <c:forEach items="${empList}" var="emp">
                    <c:set var="count" value="${count + 1}" /> <!-- index 값을 활용한 카운트 증가 -->
                  </c:forEach>
                  <span class="badge bg-primary float-right">
                    ${count}
                  </span>
                </a>
              </li>
              <c:if test="${posiList ne 'null'}">
                <c:forEach items="${posiList}" var="position">
                  <li class="nav-item posiList d-flex" value="${position.jbgdId}">
                    <a href="#" class="nav-link w-100">
                      <i class="fas fa-inbox"></i> ${position.jbgdNm}
                      <c:set var="count" value="0" /> <!-- 초기 카운트 값 설정 -->
                      <c:forEach items="${empList}" var="emp">
                        <c:if test="${position.jbgdNm eq emp.position.jbgdNm}">
                          <c:set var="count" value="${count + 1}" /> <!-- index 값을 활용한 카운트 증가 -->
                        </c:if>
                      </c:forEach>
                      <span class="badge bg-primary float-right m-1">
                          ${count}
                      </span>
                    </a>
                  </li>
                </c:forEach>
              </c:if>

              <li class="nav-item active deptList" value="total">
                <a href="#" class="nav-link">
                  <div class="input-group">
                    <input id="addPosiNm" type="text" class="form-control" placeholder="추가 직급명">
                    <div class="input-group-append">
                      <button type="button" class="btn btn-primary" id="pAdd">추가</button>
                    </div>
                  </div>
                </a>
              </li>
            </ul>
          </div>
      </div>
      <!-- /.col -->
    </div>
      <div class="col-md-10" id="emp">
        <div class="card card-primary card-outline">
          <div class="card-header">
            <h3 class="card-title m-1">사원관리</h3>
            <div class="card-tools">
              <a class="btn btn-info btn-sm" href="#" id="nums" onclick="addPopup('${custId}')">
                <i class="fas fa-pencil-alt">
                </i>
             		   사원추가
              </a>
              <a class="btn btn-primary btn-sm" href="#" onclick="addAuthPopup('${custId}')">
                <i class="fas fa-folder">
                </i>
               		권한관리
              </a>

            </div>
          </div>
          <div class="card-body " style="overflow-Y: scroll; height: 650px;display: block; padding: 0%">
            <table class="table table-striped projects">
            <thead>
            <tr>
              <th style="width: 20%;" class="text-center">
                프로필
              </th>
              <th style="width: 15%" class="text-center">
                직급
              </th>
              <th style="width: 15%;" class="text-center">
                부서
              </th>
              <th style="width: 15%" class="text-center">
       권한
              </th>
              <th style="width: 15%" class="text-center">
                상태
              </th>
              <th style="width: 10%" class="text-center">
                상세
              </th>
            </tr>
            </thead>
              <tbody id="empList">
              <c:if test="${not empty empList}">
                <c:forEach items="${empList}" var="emp">
                  <tr class="${emp.deptId} ${emp.jbgdId}" class="text-center ">
                    <td class="text-center">
                      <ul class="list-inline">
                        <li class="list-inline-item">
                        	<c:if test="${emp.empProfile eq null }">
                        		<img alt="" class="table-avatar" src="/resources/img/basicProfile.png">
                        	</c:if>
                          	<c:if test="${emp.empProfile ne null }">
                        		<img alt="" class="table-avatar" src="/everyware/admin/thumbnail?empId=${emp.empId }">
                        	</c:if>
                        </li>
                        <b>${emp.empName}</b>
                      </ul>
                    </td>
                    <td class="text-center">
                      <select name="selectEmp" id="${emp.empId}" class="posiSel" style="border:1px solid grey; border-radius: 7px">
                        <option value="0">-- 직급선택 --</option>
                        <c:forEach items="${posiList}" var="position">
                          <option class="text-center" value="${position.jbgdId}" <c:if test="${emp.position.jbgdNm eq position.jbgdNm}">selected</c:if>>${position.jbgdNm}</option>
                        </c:forEach>
                      </select>
                    </td>
                    <td class="project_progress text-center">
                      <select name="selectPosi" id="${emp.empId}" class="depSel" style="border:1px solid grey; border-radius: 7px">
                        <option value="0">-- 부서선택 --</option>
                        <c:forEach items="${depList}" var="depList">
                          <option class="text-center" value="${depList.deptId}" <c:if test="${emp.department.deptNm eq depList.deptNm}">selected</c:if>>${depList.deptNm}</option>
                        </c:forEach>
                      </select>
                    </td>

                    <td class="project-actions text-center">
                      <select name="selectAuth" id="${emp.empId}" class="authSel" style="border:1px solid grey; border-radius: 7px">
                        <option value="0">-- 권한선택 --</option>
                        <c:forEach items="${authList}" var="authList">
                          <option class="text-center" value="${authList.authrtId}" <c:if test="${emp.authrtId eq authList.authrtId}">selected</c:if>>${authList.authrtNm}</option>
                        </c:forEach>
                      </select>
                    </td>
                    <td class="project-state text-center">
                      	<select name="selectAuth" id="${emp.empId}" class="workGroupSel" style="border:1px solid grey; border-radius: 7px">
	                        <option value="0">-- 권한선택 --</option>
	                        <c:forEach items="${workGroupList}" var="workGroupList">
	                          <option class="text-center" value="${workGroupList.groupNo}" <c:if test="${emp.groupNo eq workGroupList.groupNo}">selected</c:if>>${workGroupList.groupNm}</option>
	                        </c:forEach>
                      </select>
                    </td>
                    
                    <td class="text-center">
                      <a class="btn btn-info btn-sm winopen" href="#" onclick="poopup('${emp.empId}')">
                        <i class="fas fa-pencil-alt">
                        </i>
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </c:if>

              </tbody>
            </table>
          </div>
          <!-- /.card-footer -->
        </div>
      </div>
  </div>
  </section>
 <ul class="contextmenu" id="">
  <!-- <li><a href="#">수정</a></li> -->
  <li><a href="#" id="dDel" onclick="dDel()">부서 삭제</a></li>
  <li><a href="#" id="pDel" onclick="pDel()">직급 삭제</a></li>
</ul>
  
<script>
      function poopup(empId){
        console.log(empId)
    	popupWindow = window.open("/everyware/popup/popupWindow?empId="+empId, "windowName", "resizeable");
    	popupWindow.resizeTo(980 , 470);
    	popupWindow.onresize = (_=>{
    	    popupWindow.resizeTo(980, 470);
    	});
    }

    function addPopup(custId){
      console.log(custId)
      popupWindow = window.open("/everyware/popup/empPopup?custId="+custId, "windowName", "resizeable");
      popupWindow.resizeTo(980 , 680);
      popupWindow.onresize = (_=>{
        popupWindow.resizeTo(980, 680);
      });
    }
    
    function addAuthPopup(custId){
    	console.log(custId)
        popupWindow = window.open("/everyware/popup/authPopup?custId="+custId, "windowName", "resizeable");
        popupWindow.resizeTo(980 , 550);
        popupWindow.onresize = (_=>{
          popupWindow.resizeTo(980, 550);
        });	
    }

  $(function() {
	//$(".dDell").hide()l


    $(".posiSel").on('change',function(){
      console.log($(this).val());
      console.log($(this).attr("id"));
      $.ajax({
        url: '/everyware/admin/editPosition',
        method: 'post',
        data:{jbgdId:  $(this).val(),
          empId: $(this).attr("id")
        },
        beforeSend : function(xhr){
          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success: function(res){
          if(res == 'OK') {
            alert("성공")
            // location.reload();
          }else{
            alert("실패1")
          }
        },
        error: function(xhr){
          console.log("실패",xhr.status);
        }
      })
    })

    $(".depSel").on('change',function(){
      console.log($(this).val());
      console.log($(this).attr("id"));
      $.ajax({
        url: '/everyware/admin/editDepartment',
        method: 'post',
        data:{deptId:  $(this).val(),
          empId: $(this).attr("id")
        },
        beforeSend : function(xhr){
          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success: function(res){
          if(res == 'OK') {
          alert("성공")
            // location.reload();
          }else{
            alert("실패1")
          }
        },
        error: function(xhr){
          console.log("실패",xhr.status);
        }
      })	
	})

	 $(".authSel").on('change',function(){
      console.log($(this).val());
      console.log($(this).attr("id"));
      $.ajax({
        url: '/everyware/admin/editAuth',
        method: 'post',
        data:{authrtId:  $(this).val(),
          		empId: $(this).attr("id")
        },
        beforeSend : function(xhr){
          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success: function(res){
          if(res == 'OK') {
            alert("성공")
            // location.reload();
          }else{
            alert("실패1")
          }
        },
        error: function(xhr){
          console.log("실패",xhr.status);
        }
      })
    })
	 $(".workGroupSel").on('change',function(){
      console.log($(this).val());
      console.log($(this).attr("id"));
      $.ajax({
        url: '/everyware/admin/editWorkGroup',
        method: 'post',
        data:{groupNo:  $(this).val(),
          		empId: $(this).attr("id")
        },
        beforeSend : function(xhr){
          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success: function(res){
          if(res == 'OK') {
            alert("성공")
            // location.reload();
          }else{
            alert("실패1")
          }
        },
        error: function(xhr){
          console.log("실패",xhr.status);
        }
      })
    })
	
    $("#dAdd").on('click', function () {
      $("#addDeptNm").val()
      $.ajax({
        url: '/everyware/admin/addDepartment',
        method: 'post',
        data:{deptNm:  $("#addDeptNm").val()
        },
        beforeSend : function(xhr){
          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success: function(res){
          if(res == 'OK') {
            location.reload();
          }else{
            alert("실패1")
          }
        },
        error: function(xhr){
          console.log("실패",xhr.status);
        }
      })
    })
    
    $("#pAdd").on('click', function () {
      $("#addPosiNm").val()
      $.ajax({
        url: '/everyware/admin/addPosition',
        method: 'post',
        data:{posiNm:  $("#addPosiNm").val()
        },
        beforeSend : function(xhr){
          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success: function(res){
          if(res == 'OK') {
            location.reload();
          }else{
            alert("실패1")
          }
        },
        error: function(xhr){
          console.log("실패",xhr.status);
        }
      })
    })

    $(".deptList").on('click', function () {
      var currentValue = $(this).attr("value"); // 현재 요소의 value 속성 값을 가져옵니다.
      // alert(currentValue)
      if (currentValue != 'total') {
        $(this).siblings().each(function () {
          var value = $(this).attr("value"); // 형제 요소의 value 속성 값을 가져옵니다.
          if (value !== currentValue) {
            $("." + value).hide()
          }
        });
        $("." + $(this).attr("value")).show();

      } else {
        $(this).siblings().each(function () {
          var value = $(this).attr("value"); // 형제 요소의 value 속성 값을 가져옵니다.
          $("." + value).show()
        });
        $("." + $(this).attr("value")).show();
      }
    })

    $(".posiList").on('click', function () {
      var currentValue = $(this).attr("value"); // 현재 요소의 value 속성 값을 가져옵니다.
      // alert(currentValue)
      if (currentValue != 'total') {
        $(this).siblings().each(function () {
          var value = $(this).attr("value"); // 형제 요소의 value 속성 값을 가져옵니다.
          if (value !== currentValue) {
            $("." + value).hide()
          }
        });
        $("." + $(this).attr("value")).show();

      } else {
        $(this).siblings().each(function () {
          var value = $(this).attr("value"); // 형제 요소의 value 속성 값을 가져옵니다.
          $("." + value).show()
        });
        $("." + $(this).attr("value")).show();
      }
    })
    
    $(".deptList").contextmenu('li',function(e){
    	console.log($(this).attr("value"))
    	$(".contextmenu").attr('id',$(this).attr("value"))
        //Get window size:
        var winWidth = $(document).width();
        var winHeight = $(document).height();
        //Get pointer position:
        var posX = e.pageX;
        var posY = e.pageY;
        //Get contextmenu size:
        var menuWidth = $(".contextmenu").width();
        var menuHeight = $(".contextmenu").height();
        //Security margin:
        var secMargin = 10;
        //Prevent page overflow:
        if(posX + menuWidth + secMargin >= winWidth
        && posY + menuHeight + secMargin >= winHeight){
          //Case 1: right-bottom overflow:
          posLeft = posX - menuWidth - secMargin + "px";
          posTop = posY - menuHeight - secMargin + "px";
        }
        else if(posX + menuWidth + secMargin >= winWidth){
          //Case 2: right overflow:
          posLeft = posX - menuWidth - secMargin + "px";
          posTop = posY + secMargin + "px";
        }
        else if(posY + menuHeight + secMargin >= winHeight){
          //Case 3: bottom overflow:
          posLeft = posX + secMargin + "px";
          posTop = posY - menuHeight - secMargin + "px";
        }
        else {
          //Case 4: default values:
          posLeft = posX + secMargin + "px";
          posTop = posY + secMargin + "px";
        };
        //Display contextmenu:
        $(".contextmenu").css({
            "left": posLeft,
            "top": posTop
          }).show();
        
        $("#dDel").show()
        $("#pDel").hide()
          return false;
        });
	
    $(".posiList").contextmenu('li',function(e){
    	console.log($(this).attr("value"))
    	$(".contextmenu").attr('id',$(this).attr("value"))
        //Get window size:
        var winWidth = $(document).width();
        var winHeight = $(document).height();
        //Get pointer position:
        var posX = e.pageX;
        var posY = e.pageY;
        //Get contextmenu size:
        var menuWidth = $(".contextmenu").width();
        var menuHeight = $(".contextmenu").height();
        //Security margin:
        var secMargin = 10;
        //Prevent page overflow:
        if(posX + menuWidth + secMargin >= winWidth
        && posY + menuHeight + secMargin >= winHeight){
          //Case 1: right-bottom overflow:
          posLeft = posX - menuWidth - secMargin + "px";
          posTop = posY - menuHeight - secMargin + "px";
        }
        else if(posX + menuWidth + secMargin >= winWidth){
          //Case 2: right overflow:
          posLeft = posX - menuWidth - secMargin + "px";
          posTop = posY + secMargin + "px";
        }
        else if(posY + menuHeight + secMargin >= winHeight){
          //Case 3: bottom overflow:
          posLeft = posX + secMargin + "px";
          posTop = posY - menuHeight - secMargin + "px";
        }
        else {
          //Case 4: default values:
          posLeft = posX + secMargin + "px";
          posTop = posY + secMargin + "px";
        };
        //Display contextmenu:
        $(".contextmenu").css({
            "left": posLeft,
            "top": posTop
          }).show();
        
        $("#dDel").hide()
        $("#pDel").show()
          return false;
        });
	
      $(document).click(function(){
        $(".contextmenu").hide();
      });
      
      $("#dDel").on("click",function(){
    	  alert("부서"+$(".contextmenu").attr('id'))
    	  
    	 $.ajax({
	        url: '/everyware/admin/delDepartment',
	        method: 'post',
	        data:{deptId:  $(".contextmenu").attr('id')
	        },
	        beforeSend : function(xhr){
	          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        success: function(res){
	          if(res == 'OK') {
	            location.reload();
	          }else{
	            alert("실패1")
	          }
	        },
	        error: function(xhr){
	          console.log("실패",xhr.status);
	        }
	      })
    	  
      })
      
       $("#pDel").on("click",function(){
    	  alert("직급"+$(".contextmenu").attr('id'))
    	  
    	  $.ajax({
	        url: '/everyware/admin/delPosition',
	        method: 'post',
	        data:{jbgdId:  $(".contextmenu").attr('id')
	        },
	        beforeSend : function(xhr){
	          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        success: function(res){
	          if(res == 'OK') {
	            location.reload();
	          }else{
	            alert("실패1")
	          }
	        },
	        error: function(xhr){
	          console.log("실패",xhr.status);
	        }
	      })
      })
  })

</script>