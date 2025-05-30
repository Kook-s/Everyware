<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
    let headerName = "${_csrf.headerName}"
    let token = "${_csrf.token}"
</script>

<section class="content-header py-3">
  <div class="container-fluid">
    <div class="row">
      <div class="col">
        <h1 style="margin: 5px;">근로그룹관리</h1>
        <div style="color: gray; margin: 8px;">
          <!-- <h5>근로제 알아보기</h5> -->
          <span style="width: 120px;">일반근로제</span>
          <span> | 유연근로제를 아직 시행되지 않은 기업이나 주 근로시간이 40시간 미만 근무제도</span><br>
          <span style="width: 120px;">시차출퇴근제</span>
          <span> | 1일 8시간 1주 40시간 정해진 근로시간의 양은 지키되, 근로자별로 출퇴근시각에 차이를 두어 근무하는 제도</span><br>
          <span style="width: 120px;">간주근로시간제</span>
          <span> | 외근 및 출장이 빈번할 경우, 간주근로를 사용하면 출퇴근 체크를 하지 않더라도 실제 근로시간으로 간주하는 제도</span><br>
          <span style="color: red;">*근로기준법 최종공포내용 확인 http://www.law.go.kr/법령/근로기준법</span>
        </div>
      </div>
      <!-- <div class="col">
        <button type="button" id="btnWrite" class="btn btn-primary float-right">근로그룹 추가하기
      </div> -->

    </div>


    <div class="row">
      <div class="col">
        <div class="card card-outline card-primary">

          <div class="card-header">
            <h3 class="card-title">등록된 근로그룹<span style="color: #007bff; margin-left: 5px;">${totalWorkGroup}개</span></h3>

            <div class="card-tools">
              <button type="button" id="btnWrite" class="btn btn-primary">근로그룹 추가하기
            </div>
          </div>


          <div class="card-body">
          <!-- <div class="card-body" style="overflow-Y: scroll; height: 820px;display: block; padding: 0%"> -->
            <table class="table table">
              <thead>
                <tr>
                  <th class="text-center">그룹명</th>
                  <th class="text-center">근무시간</th>
                  <th class="text-center">휴게시간</th>
                  <th class="text-center">그룹정보</th>
                  <th class="text-center">상세</th>
                </tr>
              </thead>

              <tbody>
                <!-- <tr class="groupList">
                  <td class="text-center">일반근로제</td>
                  <td class="text-center">09:00 - 18:00</td>
                  <td class="text-center">12:00 - 13:00</td>
                  <td class="text-center">인원:_명</td>
                  <td class="text-center">
                    <button type="button" class="btn btn-info">
                      <i class="fas fa-pencil-alt"></i>
                    </button>
                  </td>
                </tr> -->

                <c:set value="${workGroup}" var="workGroup" />
                <c:choose>
                  <c:when test="${empty workGroup}">
                    <tr>
                      <td colspan="5">조회하신 기록이 존재하지 않습니다.</td>
                    </tr>
                  </c:when>
                  <c:otherwise>
                    <c:forEach items="${workGroup}" var="w">
                      <tr class="groupList">
                        <input type="hidden" id="groupNo" name="groupNo" value="${w.groupNo}">
                        <td class="text-center">${w.groupNm}</td>
                        <td class="text-center">${w.groupWorkBgngDt} ~ ${w.groupWorkEndDt}</td>
                        <td class="text-center">${w.groupRestBgngDt} ~ ${w.groupRestEndDt}</td>
                        <td class="text-center">인원 : ${w.headCount}명</td>
                        <td class="text-center">
                          <button type="button" class="btn btn-info btnDetail">
                            <i class="fas fa-pencil-alt"></i>
                          </button>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>

              </tbody>

            </table>

          </div>

        </div>

      </div>


    </div>

  </div>
</section>






<!-- modal-workGroup-->
<div class="modal fade" id="modal-workGroup">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="modalTtl">새 근로그룹 등록</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <form class="form-horizontal" method="post" id="workGroupForm">
          <input type="hidden" id="groupNo" name="groupNo">
          <input type="hidden" id="custId" name="custId">

          <div class="card-body">
            <div class="form-group row">
              <label for="" class="col-sm-4 col-form-label">근로제 그룹명</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" id="groupNm" name="groupNm" placeholder="그룹명을 입력하세요.">
              </div>
            </div>

            <div class="form-group row">
              <label for="" class="col-sm-4 col-form-label">출근시간</label>
              <div class="col-sm-4">
                <input type="time" name="groupWorkBgngDt" id="groupWorkBgngDt" value="09:00:00">
              </div>
            </div>
            
            <div class="form-group row">
              <label for="" class="col-sm-4 col-form-label">퇴근시간</label>
              <div class="col-sm-4">
                <input type="time" name="groupWorkEndDt" id="groupWorkEndDt" value="18:00:00">
              </div>
            </div>

            <div class="form-group row">
              <label for="" class="col-sm-4 col-form-label">휴게시작시간</label>
              <div class="col-sm-4">
                <input type="time" name="groupRestBgngDt" id="groupRestBgngDt" value="12:00:00">
              </div>
            </div>
            
            <div class="form-group row">
              <label for="" class="col-sm-4 col-form-label">휴게종료시간</label>
              <div class="col-sm-4">
                <input type="time" name="groupRestEndDt" id="groupRestEndDt" value="13:00:00">
              </div>
            </div>

            <div class="form-group row">
              <label for="" class="col-sm-4 col-form-label">총 근무시간</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" id="workingHours" name="workingHours">
              </div>
            </div>

            <div class="" id=""></div>

          </div>
        </form>
      </div>

      <div class="modal-footer justify-content-between">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>

        <div class="float-right">
          <div class="row">
            <div class="col">
              <button type="button" class="btn btn-primary" id="btnAdd" style="width: 60px;">등록</button>
            </div>
            <div class="col" id="btn"></div>
          </div>
        </div>

      </div>

    </div>
  </div>
</div>





<script>
$(function () {
  // 삭제
  $(document).on("click", ".btnDel", function () {
    var groupNo = $("#groupNo").val();
    console.log(groupNo);

    Swal.fire({
      title: '삭제하시겠습니까?',
      icon: 'warning',

      showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
      confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
      cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
      confirmButtonText: '확인', // confirm 버튼 텍스트 지정
      cancelButtonText: '취소', // cancel 버튼 텍스트 지정

      reverseButtons: true, // 버튼 순서 거꾸로

    }).then(result => {
      // 만약 Promise리턴을 받으면,
      if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면



        $.ajax({
          type: "delete",
          url: `/everyware/admin/workGroup/delWorkGroup/\${groupNo}`,
          contentType: "application/json; charset=utf-8",
          dataType: "text",
          beforeSend: function (xhr) {
            xhr.setRequestHeader(headerName, token);
          },
          success: function (res) {
            if (res == "success") {
              Swal.fire(
                '삭제되었습니다.',
                '',
                'success'
              ).then(function () {
                location.href = `/everyware/admin/workGroup`;
              });
            } else {
              Swal.fire(
                '다시 시도해 주세요.',
                '',
                'error'
              );
            }
          },
          error: function (xhr) {
            alert("Error: " + xhr.status);
          }
        });
      }
    });



  });


  // 수정
  $(document).on("click", "#btnEdit", function(){
    var groupNo = $("#groupNo").val();
    var groupNm = $("#groupNm").val();
    var groupWorkBgngDt = $("#groupWorkBgngDt").val();
    var groupWorkEndDt = $("#groupWorkEndDt").val();
    var groupRestBgngDt = $("#groupRestBgngDt").val();
    var groupRestEndDt = $("#groupRestEndDt").val();
    var custId = $("#custId").val();

    let groupData = {
      groupNo : groupNo,
      groupNm : groupNm,
      groupWorkBgngDt : groupWorkBgngDt,
      groupWorkEndDt : groupWorkEndDt,
      groupRestBgngDt : groupRestBgngDt,
      groupRestEndDt : groupRestEndDt
    };
    console.log(groupData);

    if(groupNm == null || groupNm == ""){
      Swal.fire(
        '그룹명을 입력해주세요.',
        '',
        'warning'
      )
      return false;
    }
    
    if(groupWorkBgngDt == null || groupWorkBgngDt == ""){
      Swal.fire(
        '출근시간을 선택해주세요.',
        '',
        'warning'
      )
      return false;
    }

    if(groupWorkEndDt == null || groupWorkEndDt == ""){
      Swal.fire(
        '퇴근시간을 선택해주세요.',
        '',
        'warning'
      )
      return false;
    }

    if(groupRestBgngDt == null || groupRestBgngDt == ""){
      Swal.fire(
        '휴게시각시간을 선택해주세요.',
        '',
        'warning'
      )
      return false;
    }

    if(groupRestEndDt == null || groupRestEndDt == ""){
      Swal.fire(
        '휴게종료시간을 선택해주세요.',
        '',
        'warning'
      )
      return false;
    }

    $.ajax({
      type: "put",
      url: `/everyware/admin/workGroup/editWorkGroup`,
      contentType: 'application/json; charset=utf-8',
      data: JSON.stringify(groupData),
      dataType:"text",
      beforeSend : function(xhr){
        xhr.setRequestHeader(headerName,token);
      },
      success: function(res){
        console.log("res",res)
        if(res == "success") {
          Swal.fire(
            '수정되었습니다.',
            '',
            'success'
          ).then(function(){
            location.href = `/everyware/admin/workGroup`;
          });
        } else {
          Swal.fire(
            '다시 시도해 주세요.',
            '',
            'error'
          );
        }
          // $('#modal-ToDo').modal("hide");

          // todoList();
          // alert("수정되었습니다.");
      },
      error: function (xhr) {
          alert("Error: " + xhr.status);
      }
    });

  });


  // 상세보기
  $(document).on("click", ".btnDetail", function(){
    var groupNo = $(this).closest(".groupList").find("input[name='groupNo']").val();
    $("#btnAdd").text("저장").attr("id", "btnEdit");
    $("#modalTtl").text("그룹 상세보기")
    $(".btnDel").attr("data-groupNo", groupNo);

    console.log(groupNo);

    $.ajax({
      type: "get",
      url: `/everyware/admin/workGroup/getOneWorkGroup/\${groupNo}`,
      contentType: 'application/json; charset=utf-8',
      dataType: "json",
      beforeSend: function (xhr) {
        xhr.setRequestHeader(headerName, token);
      },
      success: function (res){
        console.log("res", res);

        var custId = res.custId;
        var groupNo = res.groupNo;
        var groupNm = res.groupNm;
        var groupWorkBgngDt = res.groupWorkBgngDt;
	      var groupWorkEndDt = res.groupWorkEndDt;
	      var groupRestBgngDt = res.groupRestBgngDt;
	      var groupRestEndDt = res.groupRestEndDt;
        var btnDelStr = "";

        $('#custId').val(custId);
        $('#groupNo').val(groupNo);
        $('#groupNm').val(groupNm);
        $('#groupWorkBgngDt').val(groupWorkBgngDt);
        $('#groupWorkEndDt').val(groupWorkEndDt);
        $('#groupRestBgngDt').val(groupRestBgngDt);
        $('#groupRestEndDt').val(groupRestEndDt);

        btnDelStr += `<button type="button" class="btn btn-danger btnDel" data-groupNo="" style="width: 60px;">삭제</button>`;
        $(`#btn`).html(btnDelStr);

        $('#modal-workGroup').modal("show");
      },
      error: function (xhr) {
        alert("Error: " + xhr.status);
      }
    });
  });


  // 근로그룹 추가
  $(document).on("click", "#btnAdd", function(){
    var groupNm = $("#groupNm").val();
    var groupWorkBgngDt = $("#groupWorkBgngDt").val();
    var groupWorkEndDt = $("#groupWorkEndDt").val();
    var groupRestBgngDt = $("#groupRestBgngDt").val();
    var groupRestEndDt = $("#groupRestEndDt").val();

    let workGroupData = {
      groupNm : groupNm,
      groupWorkBgngDt : groupWorkBgngDt,
      groupWorkEndDt : groupWorkEndDt,
      groupRestBgngDt : groupRestBgngDt,
      groupRestEndDt : groupRestEndDt
    };
    
    console.log(groupNm);

    if(groupNm == null || groupNm == ""){
      Swal.fire(
        '그룹명을 입력해주세요.',
        '',
        'warning'
      )
      return false;
    }
    
    if(groupWorkBgngDt == null || groupWorkBgngDt == ""){
      Swal.fire(
        '출근시간을 선택해주세요.',
        '',
        'warning'
      )
      return false;
    }

    if(groupWorkEndDt == null || groupWorkEndDt == ""){
      Swal.fire(
        '퇴근시간을 선택해주세요.',
        '',
        'warning'
      )
      return false;
    }

    if(groupRestBgngDt == null || groupRestBgngDt == ""){
      Swal.fire(
        '휴게시각시간을 선택해주세요.',
        '',
        'warning'
      )
      return false;
    }

    if(groupRestEndDt == null || groupRestEndDt == ""){
      Swal.fire(
        '휴게종료시간을 선택해주세요.',
        '',
        'warning'
      )
      return false;
    }
    
    $.ajax({
      type: "POST",
      url: `/everyware/admin/workGroup/addWorkGroup`,
      contentType : 'application/json; charset=utf-8',
      data: JSON.stringify(workGroupData),
      dataType: "text",
      beforeSend: function (xhr) {
        xhr.setRequestHeader(headerName, token);
      },
      success: function (res) {
        console.log("res", res);
        if( res == "success"){
          Swal.fire(
            '등록되었습니다.',
            '',
            'success'
          ).then(function(){
            location.href = `/everyware/admin/workGroup`;
            // window.location.reload();
          });
          
        } else {
          Swal.fire(
            '다시 시도해 주세요.',
            '',
            'error'
          );
        }
          // $('#modal-workGroup').modal("hide");
      },
      error: function(xhr){
        alert("Error: " + xhr.status);
      }
    
    });
  });
    
  // 근로그룹 추가버튼(모달창 띄우기)
  $(document).on("click", "#btnWrite", function(){
    $('#custId').val('');
    $('#groupNm').val('');
    $('#groupWorkBgngDt').val('');
    $('#groupWorkEndDt').val('');
    $('#groupRestBgngDt').val('');
    $('#groupRestEndDt').val('');
    $(".btnDel").hide();
    $("#btnEdit").text("등록").attr("id", "btnAdd");

    $('#modal-workGroup').modal("show");
  });

});

// 
function calculateWorkingHours() {
  const startTime = $("#groupWorkBgngDt").val();
  const endTime = $("groupWorkEndDt").val();

  // const startTime = document.getElementById("groupWorkBgngDt").value;
  // const endTime = document.getElementById("groupWorkEndDt").value;

  const startDate = new Date(`${startTime}`);
  const endDate = new Date(`${endTime}`);

  const timeDifference = endDate - startDate;

  const hours = Math.floor(timeDifference / 3600000);
  const minutes = Math.floor((timeDifference % 3600000) / 60000);

  const workingHoursInput = document.getElementById("workingHours");
  workingHoursInput.value = `${hours}시간 ${minutes}분`;
}

</script>