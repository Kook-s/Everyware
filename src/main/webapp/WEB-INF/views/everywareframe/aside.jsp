<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
.aside_profile{
	height: 2.1rem!important
}

/* #sideImg{
position: absolute; 
bottom: 1%;
left: 3%;
z-index: 999;
} */
</style>

<aside class="main-sidebar elevation-4 sidebar-light-primary">
    <sec:authentication var="employee" property="principal.employee"/>
    
    <!-- Brand Logo -->
    <a href="/everyware/main" class="brand-link bg-primary">
      <!-- <img src="/resources/img/EveryWarePageIcon.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">EveryWare</span> -->
     <img src="/resources/img/EveryWare LogoWH.png" alt="AdminLTE Logo" class="brand-image" style="opacity: 1">
    </a>
	
    <!-- Sidebar -->
    <div class="sidebar os-host os-theme-light os-host-overflow os-host-overflow-y os-host-resize-disabled os-host-scrollbar-horizontal-hidden os-host-transition"><div class="os-resize-observer-host observed"><div class="os-resize-observer" style="left: 0px; right: auto;"></div></div><div class="os-size-auto-observer observed" style="height: calc(100% + 1px); float: left;"><div class="os-resize-observer"></div></div><div class="os-content-glue" style="margin: 0px -8px; width: 249px; height: 780px;"></div><div class="os-padding"><div class="os-viewport os-viewport-native-scrollbars-invisible" style="overflow-y: scroll;"><div class="os-content" style="padding: 0px 8px; height: 100%; width: 100%;">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex aside_img_div">
        <div class="image">
        	<c:if test="${not empty employee.empProfile}">
	        		<img src="/everyware/mypage/thumbnail" class="img-circle elevation-2 aside_profile" alt="User Image">
	       	</c:if>
	       	<c:if test="${empty employee.empProfile}">
	       			<img src="/resources/img/basicProfile.png" class="img-circle elevation-2 aside_profile" alt="User Image">
	       	</c:if>
        </div>
        <div class="info d-flex">
          <a href="/everyware/mypage" class="d-block">${employee.empName } ${employee.jbgdNm }</a>
        </div>
      </div>

      <!-- SidebarSearch Form -->
      <div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
          <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
          <div class="input-group-append">
            <button class="btn btn-sidebar">
              <i class="fas fa-search fa-fw"></i>
            </button>
          </div>
        </div><div class="sidebar-search-results"><div class="list-group"><a href="#" class="list-group-item"><div class="search-title"><strong class="text-light"></strong>N<strong class="text-light"></strong>o<strong class="text-light"></strong> <strong class="text-light"></strong>e<strong class="text-light"></strong>l<strong class="text-light"></strong>e<strong class="text-light"></strong>m<strong class="text-light"></strong>e<strong class="text-light"></strong>n<strong class="text-light"></strong>t<strong class="text-light"></strong> <strong class="text-light"></strong>f<strong class="text-light"></strong>o<strong class="text-light"></strong>u<strong class="text-light"></strong>n<strong class="text-light"></strong>d<strong class="text-light"></strong>!<strong class="text-light"></strong></div><div class="search-path"></div></a></div></div>
      </div>
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <sec:authentication var="menuList" property='principal.employee.authMenuList' />
		  <sec:authorize access="hasAuthority('HOME')">  
			  <c:forEach items="${menuList }"  var="authmenu">
		      	<c:if test="${authmenu.menu.menuId eq 'HOME'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link ${mainActive }">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
		      </c:forEach>
	      </sec:authorize>
	      <sec:authorize access="hasAuthority('MAIL')">  
			  <c:forEach items="${menuList }"  var="authmenu">
		      	<c:if test="${authmenu.menu.menuId eq 'MAIL'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link ${mailActive }">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
		      </c:forEach>
	      </sec:authorize>
	      <sec:authorize access="hasAuthority('APPROVAL')">  
			  <c:forEach items="${menuList }"  var="authmenu">
		      	<c:if test="${authmenu.menu.menuId eq 'APPROVAL'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link ${approvalActive }">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
		      </c:forEach>
	      </sec:authorize>
	      <sec:authorize access="hasAuthority('HR')">  
			  <c:forEach items="${menuList }"  var="authmenu">
		      	<c:if test="${authmenu.menu.menuId eq 'HR'}">
					<%-- <li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link ${authmenuActive }">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li> --%>
			         <li class="nav-item">
			            <a href="#" class="nav-link">
			              <!-- <i class="nav-icon fas fa-copy"></i> -->
			               ${authmenu.menu.menuIcon }
			              <p>
			               ${authmenu.menu.menuNm }
			                <i class="fas fa-angle-left right"></i>
			              </p>
			            </a>
			            <ul class="nav nav-treeview">
			              <li class="nav-item">
			                <a href="${authmenu.menu.menuUrl }" class="nav-link">
			                  <i class="far fa-circle nav-icon"></i>
			                  <p>근태기록</p>
			                </a>
			              </li>
			              <li class="nav-item">
			                <a href="/everyware/workStats" class="nav-link">
			                  <i class="far fa-circle nav-icon"></i>
			                  <p>근태통계</p>
			                </a>
			              </li>
			              <li class="nav-item">
			                <a href=" /everyware/workAdj" class="nav-link">
			                  <i class="far fa-circle nav-icon"></i>
			                  <p>근태조정</p>
			                </a>
			              </li>
			              <li class="nav-item">
			                <a href="/everyware/vacation" class="nav-link">
			                  <i class="far fa-circle nav-icon"></i>
			                  <p>휴가관리</p>
			                </a>
			              </li>
			            </ul>
			          </li>
		        </c:if>
		      </c:forEach>
	      </sec:authorize>
	      <sec:authorize access="hasAuthority('ADDRESSBOOK')">  
			  <c:forEach items="${menuList }"  var="authmenu">
		      	<c:if test="${authmenu.menu.menuId eq 'ADDRESSBOOK'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link ${addressbookActive }">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
		      </c:forEach>
	      </sec:authorize>
	      
		  <sec:authorize access="hasAuthority('CALENDAR')">  
		  <c:forEach items="${menuList }"  var="authmenu">
	      	<c:if test="${authmenu.menu.menuId eq 'CALENDAR'}">
				<li class="nav-item">
		            <a href="${authmenu.menu.menuUrl }" class="nav-link ${calendarActive }">
		              ${authmenu.menu.menuIcon }
		              <p>
		              			${authmenu.menu.menuNm }
		              </p>
		            </a>
		        </li>
	        </c:if>
	      </c:forEach>
		  </sec:authorize> 
		  <sec:authorize access="hasAuthority('CLOUD')">
			  <c:forEach items="${menuList }"  var="authmenu">
			      <c:if test="${authmenu.menu.menuId eq 'CLOUD'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link ${cloudActive }">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
			      </c:if>
		      </c:forEach>
		  </sec:authorize> 
		  <sec:authorize access="hasAuthority('BOARD')">
		  <c:forEach items="${menuList }"  var="authmenu">
	        <c:if test="${authmenu.menu.menuId eq 'BOARD'}">
				<li class="nav-item">
		            <a href="${authmenu.menu.menuUrl }" class="nav-link ${boardActive }">
		              ${authmenu.menu.menuIcon }
		              <p>
		              			${authmenu.menu.menuNm }
		              </p>
		            </a>
		        </li>
	        </c:if>
	      </c:forEach>
		  </sec:authorize> 
		  <sec:authorize access="hasAuthority('RESERVATION')">
		  	<c:forEach items="${menuList }"  var="authmenu">
		        <c:if test="${authmenu.menu.menuId eq 'RESERVATION'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link ${reservationActive }">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
	      	</c:forEach>
		  </sec:authorize> 
		  <sec:authorize access="hasAuthority('TODO')">
			  <c:forEach items="${menuList }"  var="authmenu">
		        <c:if test="${authmenu.menu.menuId eq 'TODO'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link ${todoActive }">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              		
			              </p>
			            </a>
			        </li>
		        </c:if>
	        </c:forEach>
		  </sec:authorize> 
		  <sec:authorize access="hasAuthority('SUVY')">
		  	<c:forEach items="${menuList }"  var="authmenu">
		  		<c:if test="${authmenu.menu.menuId eq 'SUVY'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link ${suvyActive }">
			              ${authmenu.menu.menuIcon }
			              <p>
			              	${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
		     </c:forEach>
		  </sec:authorize>  
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div></div></div><div class="os-scrollbar os-scrollbar-horizontal os-scrollbar-unusable os-scrollbar-auto-hidden"><div class="os-scrollbar-track"><div class="os-scrollbar-handle" style="width: 100%; transform: translate(0px, 0px);"></div></div></div><div class="os-scrollbar os-scrollbar-vertical os-scrollbar-auto-hidden"><div class="os-scrollbar-track"><div class="os-scrollbar-handle" style="height: 57.4687%; transform: translate(0px, 0px);"></div></div></div><div class="os-scrollbar-corner"></div></div>
    <!-- /.sidebar -->
    
<!--     <div id=sideImg>
    	<img alt="/resources/img/sideBar.png" src="/resources/img/sideBar.png" height="210">
    </div> -->
  </aside>