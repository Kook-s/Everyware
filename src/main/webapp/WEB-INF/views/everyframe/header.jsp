<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <div class="container position-sticky z-index-sticky top-0">
  <div class="row">
    <div class="col-12">
      <nav class="navbar navbar-expand-lg  blur border-radius-xl top-0 z-index-3 shadow position-absolute my-3 py-2 start-0 end-0 mx-4">
        <div class="container-fluid px-0">
          <a class="navbar-brand font-weight-bolder ms-sm-3  d-none d-md-block" href="/everysolution/home" rel="tooltip" title="Designed and Coded by Creative Tim" data-placement="bottom" target="_blank">
            EveryWare
          </a>

          <div class="collapse navbar-collapse w-100 pt-3 pb-2 py-lg-0" id="navigation">
            <ul class="navbar-nav navbar-nav-hover ms-auto">
              <li class="nav-item dropdown dropdown-hover mx-2">
                <a role="button" class="nav-link ps-2 d-flex cursor-pointer align-items-center" id="dropdownMenuDocs" data-bs-toggle="dropdown" aria-expanded="false">
                  <i class="material-icons opacity-6 me-2 text-md">article</i>
                  Menu
                  <img src=" ${pageContext.request.contextPath }/resources/assets/img/down-arrow-dark.svg  " alt="down-arrow" class="arrow ms-2 d-lg-block d-none">
                  <img src="${pageContext.request.contextPath }/resources/assets/img/down-arrow-dark.svg" alt="down-arrow" class="arrow ms-1 d-lg-none d-block ms-auto">
                </a>
                <div class="dropdown-menu dropdown-menu-end dropdown-menu-animation dropdown-md mt-0 mt-lg-3 p-3 border-radius-lg" aria-labelledby="dropdownMenuDocs">
                  <div class="d-none d-lg-block">
                    <ul class="list-group">
                      <li class="nav-item list-group-item border-0 p-0">
                        <a class="dropdown-item py-2 ps-3 border-radius-md" href="/everysolution/myPage">
                          <h6 class="dropdown-header text-dark font-weight-bolder d-flex justify-content-cente align-items-center p-0">마이페이지</h6>
                          <span class="text-sm">All about overview, quick start, license and contents</span>
                        </a>
                      </li>
                      <li class="nav-item list-group-item border-0 p-0">
                        <a class="dropdown-item py-2 ps-3 border-radius-md" href="/everysolution/membership">
                          <h6 class="dropdown-header text-dark font-weight-bolder d-flex justify-content-cente align-items-center p-0">맴버쉽</h6>
                          <span class="text-sm">See our colors, icons and typography</span>
                        </a>
                      </li>
                      <li class="nav-item list-group-item border-0 p-0">
                        <a class="dropdown-item py-2 ps-3 border-radius-md" href="/everysolution/board">
                          <h6 class="dropdown-header text-dark font-weight-bolder d-flex justify-content-cente align-items-center p-0">문의페이지</h6>
                          <span class="text-sm">Explore our collection of fully designed components</span>
                        </a>
                      </li>
					  <sec:authorize access="isAuthenticated()"> <!-- 현재 사용자가 인증되었는지 확인합니다. -->
				          <li class="nav-item list-group-item border-0 p-0">
				          		<form action="/everysolution/logout" method="post" id="logoutForm" style="display: none;"> 
									<sec:csrfInput />
								</form>
	                        <a class="dropdown-item py-2 ps-3 border-radius-md" href="#" id="logoutBtn">
	                          <h6 class="dropdown-header text-dark font-weight-bolder d-flex justify-content-cente align-items-center p-0">로그아웃</h6>
	                        </a>
	                      </li>
				      </sec:authorize>
                    </ul>
                  </div>
                </div>
              </li>
            </ul>
            <ul class="navbar-nav d-lg-block d-none">
              <li class="nav-item">
                <a href="/everysolution/payment" class="btn btn-sm  bg-gradient-info  mb-0" onclick="smoothToPricing('pricing-soft-ui')">Buy Now</a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
      <!-- End Navbar -->
    </div>
  </div>
</div>

<script type="text/javascript">
$(()=>{
	
	$("#logoutBtn").on("click",function(e){
		e.preventDefault();
		$("#logoutForm").submit()
	})
})
</script>