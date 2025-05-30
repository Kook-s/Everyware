<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="index3.html" class="brand-link">
      <img src="/resources/img/EveryWarePageIcon.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">EveryWare</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar os-host os-theme-light os-host-overflow os-host-overflow-y os-host-resize-disabled os-host-scrollbar-horizontal-hidden os-host-transition"><div class="os-resize-observer-host observed"><div class="os-resize-observer" style="left: 0px; right: auto;"></div></div><div class="os-size-auto-observer observed" style="height: calc(100% + 1px); float: left;"><div class="os-resize-observer"></div></div><div class="os-content-glue" style="margin: 0px -8px; width: 249px; height: 780px;"></div><div class="os-padding"><div class="os-viewport os-viewport-native-scrollbars-invisible" style="overflow-y: scroll;"><div class="os-content" style="padding: 0px 8px; height: 100%; width: 100%;">
     

      <!-- SidebarSearch Form -->
     
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <sec:authentication var="principal" property="principal"/>
		  <%-- <c:if test="${not empty principal.employee }">
          	<sec:authentication var="menuList" property='principal.employee.authMenuList.menu' />
          </c:if>
          <c:if test="${not empty principal.client }">
          	<sec:authentication var="menuList" property='principal.client.authMenuList' />
          </c:if> --%>
		  <sec:authorize access="hasAuthority('custauth')">  
          	<sec:authentication var="menuList" property='principal.client.authMenuList' />
		  </sec:authorize>
		  <c:if test="${menuList eq null}">
		  	
		 
		  <sec:authorize access="not hasAuthority('custauth')">  
          	<sec:authentication var="menuList" property='principal.employee.authMenuList' />
		  </sec:authorize>
		  
		  <sec:authorize access="hasAuthority('HOME_AD')">  
			  <c:forEach items="${menuList }"  var="authmenu">
		      	<c:if test="${authmenu.menu.menuId eq 'HOME_AD'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
		      </c:forEach>
	      </sec:authorize>
	      <sec:authorize access="hasAuthority('EM_AD')">  
			  <c:forEach items="${menuList }"  var="authmenu">
		      	<c:if test="${authmenu.menu.menuId eq 'EM_AD'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
		      </c:forEach>
	      </sec:authorize>
	      <sec:authorize access="hasAuthority('MAIL_AD')">  
			  <c:forEach items="${menuList }"  var="authmenu">
		      	<c:if test="${authmenu.menu.menuId eq 'MAIL_AD'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
		      </c:forEach>
	      </sec:authorize>
	      <sec:authorize access="hasAuthority('APPROVAL_AD')">  
			  <c:forEach items="${menuList }"  var="authmenu">
		      	<c:if test="${authmenu.menu.menuId eq 'APPROVAL_AD'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
		      </c:forEach> 
	      </sec:authorize>
	      <sec:authorize access="hasAuthority('HR_AD')">  
			  <c:forEach items="${menuList }"  var="authmenu">
		      	<c:if test="${authmenu.menu.menuId eq 'HR_AD'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
		      </c:forEach>
	      </sec:authorize>
	      <sec:authorize access="hasAuthority('ADDRESSBOOK_AD')">  
			  <c:forEach items="${menuList }"  var="authmenu">
		      	<c:if test="${authmenu.menu.menuId eq 'ADDRESSBOOK_AD'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
		      </c:forEach>
	      </sec:authorize>
		  <sec:authorize access="hasAuthority('CALENDAR_AD')">  
		  <c:forEach items="${menuList }"  var="authmenu">
	      	<c:if test="${authmenu.menu.menuId eq 'CALENDAR_AD'}">
				<li class="nav-item">
		            <a href="${authmenu.menu.menuUrl }" class="nav-link">
		              ${authmenu.menu.menuIcon }
		              <p>
		              			${authmenu.menu.menuNm }
		              </p>
		            </a>
		        </li>
	        </c:if>
	      </c:forEach>
		  </sec:authorize> 
		  <sec:authorize access="hasAuthority('CLOUD_AD')">
			  <c:forEach items="${menuList }"  var="authmenu">
			      <c:if test="${authmenu.menu.menuId eq 'CLOUD_AD'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
			      </c:if>
		      </c:forEach>
		  </sec:authorize> 
		  <sec:authorize access="hasAuthority('BOARD_AD')">
		  <c:forEach items="${menuList }"  var="authmenu">
	        <c:if test="${authmenu.menu.menuId eq 'BOARD_AD'}">
				<li class="nav-item">
		            <a href="${authmenu.menu.menuUrl }" class="nav-link">
		              ${authmenu.menu.menuIcon }
		              <p>
		              			${authmenu.menu.menuNm }
		              </p>
		            </a>
		        </li>
	        </c:if>
	      </c:forEach>
		  </sec:authorize> 
		  <sec:authorize access="hasAuthority('RESERVATION_AD')">
		  	<c:forEach items="${menuList }"  var="authmenu">
		        <c:if test="${authmenu.menu.menuId eq 'RESERVATION_AD'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
	      	</c:forEach>
		  </sec:authorize> 
		  <sec:authorize access="hasAuthority('TODO_AD')">
			  <c:forEach items="${menuList }"  var="authmenu">
		        <c:if test="${authmenu.menu.menuId eq 'TODO_AD'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link">
			              ${authmenu.menu.menuIcon }
			              <p>
			              			${authmenu.menu.menuNm }
			              		
			              </p>
			            </a>
			        </li>
		        </c:if>
	        </c:forEach>
		  </sec:authorize> 
		  <sec:authorize access="hasAuthority('SUVY_AD')">
		  	<c:forEach items="${menuList }"  var="authmenu">
		  		<c:if test="${authmenu.menu.menuId eq 'SUVY_AD'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link">
			              ${authmenu.menu.menuIcon }
			              <p>
			              	${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
		     </c:forEach>
		  </sec:authorize>
		  <sec:authorize access="hasAuthority('CHAT_AD')">
		  	<c:forEach items="${menuList }"  var="authmenu">
		  		<c:if test="${authmenu.menu.menuId eq 'CHAT_AD'}">
					<li class="nav-item">
			            <a href="${authmenu.menu.menuUrl }" class="nav-link">
			              ${authmenu.menu.menuIcon }
			              <p>
			              	${authmenu.menu.menuNm }
			              </p>
			            </a>
			        </li>
		        </c:if>
		     </c:forEach>
		  </sec:authorize>   
		   </c:if>
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div></div></div><div class="os-scrollbar os-scrollbar-horizontal os-scrollbar-unusable os-scrollbar-auto-hidden"><div class="os-scrollbar-track"><div class="os-scrollbar-handle" style="width: 100%; transform: translate(0px, 0px);"></div></div></div><div class="os-scrollbar os-scrollbar-vertical os-scrollbar-auto-hidden"><div class="os-scrollbar-track"><div class="os-scrollbar-handle" style="height: 57.4687%; transform: translate(0px, 0px);"></div></div></div><div class="os-scrollbar-corner"></div></div>
    <!-- /.sidebar -->
  </aside>