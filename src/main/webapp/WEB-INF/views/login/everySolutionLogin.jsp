<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html lang="en" itemscope itemtype="http://schema.org/WebPage">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath }/resources/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath }/resources/assets/img/favicon.png">
    <title>
        Material Kit 2 PRO by Creative Tim
    </title>
    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
    <!-- Nucleo Icons -->
    <link href="${pageContext.request.contextPath }/resources/assets/css/nucleo-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath }/resources/ssets/css/nucleo-svg.css" rel="stylesheet" />
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    <!-- CSS Files -->
    <link id="pagestyle" href="${pageContext.request.contextPath }/resources/assets/css/material-kit-pro.css?v=3.0.3" rel="stylesheet" />
</head>

<body class="sign-up-cover bg-gray-200">
<!-- Navbar -->
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
</div>
<div class="page-header align-items-start min-height-300 m-0  bg-gray-200" style="background-image: url('https://images.unsplash.com/photo-1545569341-9eb8b30979d9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80'); background-size: cover; background-position:center;" loading="lazy">
    <span class="mask bg-gradient-dark opacity-4"></span>
</div>
<div class="container">
    <div class="row mt-lg-n12 mt-md-n12 mt-n11 justify-content-center">
        <div class="col-xl-4 col-lg-5 col-md-7 mx-auto">
            <div class="card mt-8">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                    <div class="bg-gradient-info shadow-info border-radius-lg py-3 pe-1 text-center py-4">
                        <h4 class="font-weight-bolder text-white mt-1">Login</h4>
                    </div>
                </div>
                <div class="card-body pb-3">
                    <form role="form" id="form" method="post" action="/everysolution/login">
                        <div class="input-group input-group-outline mb-3">
                            <label class="form-label">아이디</label>
                            <input type="text" class="form-control" id="empId" name="username">
                        </div>
                        <div class="input-group input-group-outline mb-3">
                            <label class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="empPass" name="password">
                        </div>

                        <div class="text-center">
                            <input type="submit" class="btn bg-gradient-info w-100 mt-4 mb-0" value="Login"/>
                        </div>
                        <sec:csrfInput/>
                    </form>
                </div>
                <div class="card-footer text-center pt-0 px-sm-4 px-1">
                    <p class="mb-4 mx-auto">
                        EveryWare 회원이 아니신가요?
                        <a href="/everysolution/signup" class="text-info text-gradient font-weight-bold">회원가입</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<footer class="footer my-auto py-2 position-absolute w-100 bottom-0">
    <div class="container-fluid">
        <div class="row align-items-center justify-content-lg-between">
            <div class="col-12 col-md-6 my-auto">
                <div class="copyright text-center text-sm text-muted text-lg-start">
                    © <script>
                    document.write(new Date().getFullYear())
                </script>,
                    made with <i class="fa fa-heart" aria-hidden="true"></i> by
                    <a href="https://www.creative-tim.com" class="font-weight-bold" target="_blank">Creative Tim</a>
                    for a better web.
                </div>
            </div>
            <div class="col-12 col-md-6">
                <ul class="nav nav-footer justify-content-center justify-content-lg-end">
                    <li class="nav-item">
                        <a href="https://www.creative-tim.com" class="nav-link text-muted" target="_blank">Creative Tim</a>
                    </li>
                    <li class="nav-item">
                        <a href="https://www.creative-tim.com/presentation" class="nav-link text-muted" target="_blank">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a href="https://www.creative-tim.com/blog" class="nav-link text-muted" target="_blank">Blog</a>
                    </li>
                    <li class="nav-item">
                        <a href="https://www.creative-tim.com/license" class="nav-link pe-0 text-muted" target="_blank">License</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</footer>
<!--   Core JS Files   -->
<script src="${pageContext.request.contextPath }/resources/assets/js/core/popper.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/resources/assets/js/core/bootstrap.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/resources/assets/js/plugins/perfect-scrollbar.min.js"></script>
<!--  Plugin for TypedJS, full documentation here: https://github.com/mattboldt/typed.js/ -->
<script src="${pageContext.request.contextPath }/resources/assets/js/plugins/typedjs.js"></script>
<!--  Plugin for Parallax, full documentation here: https://github.com/wagerfield/parallax  -->
<script src="${pageContext.request.contextPath }/resources/assets/js/plugins/parallax.min.js"></script>
<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
<script src="${pageContext.request.contextPath }/resources/assets/js/plugins/nouislider.min.js" type="text/javascript"></script>
<!--  Plugin for the blob animation -->
<script src="${pageContext.request.contextPath }/resources/assets/js/plugins/anime.min.js" type="text/javascript"></script>
<!-- Control Center for Material UI Kit: parallax effects, scripts for the example pages etc -->
<!--  Google Maps Plugin    -->
<script src="https://maps.googleapis.com/maps/api/js?key="></script>
<script src="${pageContext.request.contextPath }/resources/assets/js/material-kit-pro.min.js?v=3.0.3" type="text/javascript"></script>
</body>

</html>
