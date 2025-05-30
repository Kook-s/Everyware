<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Dashboard</title>
  
  <!-- 메신저 css -->
  <link rel="stylesheet" href="/resources/css/chat.css">

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="/resources/bootstrap/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- JQVMap -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/jqvmap/jqvmap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/resources/bootstrap/dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/daterangepicker/daterangepicker.css">
  <!-- summernote -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/summernote/summernote-bs4.min.css">
  <!-- fullCalendar -->
  <link rel="stylesheet" href="/resources/bootstrap/plugins/fullcalendar/main.css">
  <!-- Theme style -->
  <!-- tippy 툴팁 -->
<link rel="stylesheet"
	href="https://unpkg.com/tippy.js@6.3.3/dist/tippy.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<body class="hold-transition sidebar-mini layout-fixed sidebar-closed sidebar-collapse">
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

<div class="content-wrapper">
  <section class="content-header">
  </section>
  <section class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-3">

          <!-- Profile Image -->
          <div class="card card-primary card-outline">
            <div class="card-body box-profile">
              <div class="text-center">
                <c:if test="${emp.empProfile eq null }">
                  <img alt="" class="table-avatar" src="/resources/img/basicProfile.png">
                </c:if>
                <c:if test="${emp.empProfile ne null }">
                  <img alt="" class="table-avatar" src="${emp.empProfile}">
                </c:if>
              </div>

              <h3 class="profile-username text-center">${emp.empName}</h3>


              <ul class="list-group list-group-unbordered mb-3">
                <li class="list-group-item">
                  <b>부서</b>
                  <a class="float-right">
                      <select name="selectPosi" id="${emp.empId}" class="depSel" style="border:1px solid grey; border-radius: 7px">
                        <option value="0">-- 부서선택 --</option>
                        <c:forEach items="${deptList}" var="dept">
                          <option class="text-center" value="${dept.deptId}" <c:if test="${emp.deptId eq dept.deptId}">selected</c:if>>${dept.deptNm}</option>
                        </c:forEach>
                      </select>
                  </a>
                </li>
                <li class="list-group-item">
                  <b>직급</b>
                  <a class="float-right">
                    <select name="selectEmp" id="${emp.empId}" class="posiSel" style="border:1px solid grey; border-radius: 7px">
                        <option value="0">-- 직급선택 --</option>
                        <c:forEach items="${posiList}" var="posi">
                          <option class="text-center" value="${posi.jbgdId}" <c:if test="${emp.jbgdId eq posi.jbgdId}">selected</c:if>>${posi.jbgdNm}</option>
                        </c:forEach>
                      </select>
                  </a>
                </li>
                <li class="list-group-item">
                  <b>사번</b> <a class="float-right">${emp.empId}</a>
                </li>
              </ul>

            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
        <div class="col-md-9">
          <div class="card">
            <div class="card-header p-2">
              <ul class="nav nav-pills">
                <li class="nav-item"><a class="nav-link active" href="#activity" data-toggle="tab">정보</a></li>
                <li class="nav-item"><a class="nav-link" href="#settings" data-toggle="tab">권한</a></li>
              </ul>
            </div><!-- /.card-header -->
            <div class="card-body">
              <div class="tab-content">
                <div class="active tab-pane" id="activity">

                  <table class="table table-striped projects">
                    <tr>
                      <th style="width: 15%;" class="text-center pt-3">
                        아이디(사번)
                      </th>
                      <th style="width: 25%" class="text-left pt-2">
                        <div class="input-group">
                          <input type="text" class="form-control" placeholder="입력 해주세요." value="${emp.empId}" name="empId">
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                      <th style="width: 15%;" class="text-center pt-3">
                        비밀번호
                      </th>
                      <th style="width: 25%" class="text-left pt-2">
                        <div class="input-group">
                          <input type="text" class="form-control" placeholder="입력 해주세요." value="${emp.empPw}" name="empPw">
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                    </tr>
                    <tr>
                      <th style="width: 15%;" class="text-center pt-3">
                        전화번호
                      </th>
                      <th style="width: 25%" class="text-left pt-2">
                        <div class="input-group">
                          <input type="text" class="form-control" placeholder="입력 해주세요." value="${emp.empTel}" name="empTel">
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                      <th style="width: 15%;" class="text-center pt-3">
                        E-mail
                      </th>
                      <th style="width: 25%" class="text-left pt-2">
                        <div class="input-group">
                          <input type="email" class="form-control" placeholder="입력 해주세요." value="${emp.empMail}" name="empMail">
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                    </tr>
                    </tr>
                    <tr>
                      <th style="width: 15%;" class="text-center pt-3">
                        주소
                      </th>
                      <th style="width: 25%" class="text-left pt-2" colspan="3">
                        <div class="input-group">
                          <input type="text" class="form-control" placeholder="입력 해주세요." value="${emp.empAddr1}" name="empAddr1">
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                    </tr>
                    <tr>
                      <th style="width: 15%;" class="text-center pt-3">
                        우편번호
                      </th>
                      <th style="width: 25%" class="text-left pt-2">
                        <div class="input-group">
                          <input type="text" class="form-control" placeholder="입력 해주세요." value="${emp.empPost}" name="empPost">
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                      <th style="width: 15%;" class="text-center pt-3">
                        상세주소
                      </th>
                      <th style="width: 25%" class="text-left pt-2">
                        <div class="input-group">
                          <input type="text" class="form-control" placeholder="입력 해주세요." value="${emp.empAddr2}" name="empAddr2">
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary modiBtn">
                              <i class="fas fa-pencil-alt"></i>
                            </button>
                          </div>
                        </div>
                      </th>
                    </tr>
                  </table>
                </div>
                <!-- /.tab-pane -->

                <!-- /.tab-pane -->

                <div class="tab-pane" id="settings">
                  <form class="form-horizontal">
                    <div class="form-group row">
                      <label for="inputName" class="col-sm-2 col-form-label">Name</label>
                      <div class="col-sm-10">
                        <input type="email" class="form-control" id="inputName" placeholder="Name">
                      </div>
                    </div>

                    <div class="offset-sm-2 col-sm-10">
                      <button type="submit" class="btn btn-danger">Submit</button>
                    </div>
                  </form>
                </div>
              </div>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div><!-- /.card-body -->
        </div>
        <!-- /.card -->
      </div>
      <!-- /.col -->
    </div>
  </section>
</div>

<!-- jQuery -->
<script src="/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="/resources/bootstrap/plugins/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript">
window.messengerCsrf = "${_csrf.headerName}";
window.messengerCsrfToken = "${_csrf.token}";
window.messengerEmpId = "${empId}";
console.log("asdasd")
console.log("empId : " + window.messengerEmpId);
console.log("csrf : " + window.messengerCsrf);
console.log("token : " + window.messengerCsrfToken);
</script>
<script>
   $.widget.bridge('uibutton', $.ui.button)
  
</script>
<script src="/resources/js/chat.js"></script>
<!-- Bootstrap 4 -->
<script src="/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="/resources/bootstrap/plugins/chart.js/Chart.min.js"></script>
<script src="/resources/bootstrap/plugins/sweetalert2/sweetalert2.min.js"></script>
<!-- Sparkline -->
<script src="/resources/bootstrap/plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="/resources/bootstrap/plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="/resources/bootstrap/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="/resources/bootstrap/plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="/resources/bootstrap/plugins/moment/moment.min.js"></script>
<script src="/resources/bootstrap/plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="/resources/bootstrap/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="/resources/bootstrap/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="/resources/bootstrap/dist/js/adminlte.js"></script>

</body>
<script>
  $(function(){
    var Toast = Swal.mixin({
      toast: true,
      position: 'top-end',
      showConfirmButton: false,
      timer: 3000
    });

    $(".modiBtn").on("click", function(){
      console.log($(this).parent().prev().val())
      console.log($(this).parent().prev().attr('name'))

      $.ajax({
        url:'/everyware/popup/modify',
        method: 'post',
        data: { empId: "${emp.empId}",
                empData:  $(this).parent().prev().val(),
                empType: $(this).parent().prev().attr('name')
        },
        beforeSend : function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
          },
        success: function(res){
          if(res == 'OK') {
            Toast.fire({
              icon: 'success',
              title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
            })
          }else{
            alert("실패1")
          }
        },
        error: function(xhr){
          console.log("실패: ",xhr.status);
          Toast.fire({
            icon: 'error',
            title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
          })
        }
      })

    })
    
     $(".posiSel").on('change',function(){
      console.log($(this).val());
      console.log($(this).attr("id"));
      $.ajax({
        url: '/everyware/admin/aditPosition',
        method: 'post',
        data:{jbgdId:  $(this).val(),
          empId: $(this).attr("id")
        },
        beforeSend : function(xhr){
          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success: function(res){
          if(res == 'OK') {
            Toast.fire({
              icon: 'success',
              title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
            })
            // location.reload();
          }else{
            Toast.fire({
              icon: 'error',
              title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
            })
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
        url: '/everyware/admin/aditDepartment',
        method: 'post',
        data:{deptId:  $(this).val(),
          empId: $(this).attr("id")
        },
        beforeSend : function(xhr){
          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success: function(res){
          if(res == 'OK') {
            Toast.fire({
              icon: 'success',
              title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
            })
          }else{
            Toast.fire({
              icon: 'error',
              title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
            })
          }
        },
        error: function(xhr){
          console.log("실패",xhr.status);
        }
      })	
	})

  })
</script>


</html>
