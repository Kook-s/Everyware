<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<style>
.nav {
	display: flex;
	-ms-flex-wrap: wrap;
	flex-wrap: wrap;
	padding-left: 0;
	margin-bottom: 0;
	list-style: none;
	align-items: center;
}
</style>
<section class="content-header">
  <div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1>양식함</h1>
			</div>
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">Cloud</li>
				</ol>
			</div>
		</div>
	</div>
<div class="wrapper">
	<div class="py-3" style="margin-left: 0px;">
		<div class="container-fluid">
			<div class="col-md-12">
				<div class="card card-primary card-tabs">
					<div class="card-header p-0 pt-1">
						<ul class="nav nav-tabs" id="custom-tabs-five-tab" role="tablist">
							<li class="nav-item"><a class="nav-link"
								id="custom-tabs-five-overlay-tab" data-toggle="pill"
								aria-selected="true">공지사항 </a></li>

							<li class="nav-item"><a class="nav-link" data-toggle="pill"
								id="custom-tabs-five-overlay-dark-tab" aria-selected="false">자유게시판
							</a></li>

							<li class="nav-item"><a class="nav-link active"
								data-toggle="pill" id="custom-tabs-five-normal-tab"
								aria-selected="false">양식함 </a></li>



							<form method="post" id="searchForm"
								class="input-group input-group-sm"
								style="width: 440px; margin-left: 54.5%;">
								<input type="hidden" name="page" id="page" /> <select
									class="form-control" name="searchType">
									<option value="title"
										<c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
									<option value="writer"
										<c:if test="${searchType eq 'writer' }">selected</c:if>>작성자</option>
								</select> <input type="text" name="searchWord" value="${searchWord }"
									class="form-control float-right" placeholder="Search Board">
								<div class="input-group-append" style="height: 31px;">
									<button type="submit" class="btn btn-default"
										style="color: #007bff;">
										<i class="fas fa-search"></i>
									</button>
								</div>
								<sec:csrfInput />
							</form>
						</ul>
					</div>
					<div class="card-body p-0">
						<div class="tab-content" id="custom-tabs-five-tabContent">
							<div class="tab-pane fade show active"
								id="custom-tabs-five-overlay" role="tabpanel"
								aria-labelledby="custom-tabs-five-overlay-tab">
								<div style="height: 657px; font-size: 23px;">
									<table class="table table-bordered" style="border: none;">
										<thead>
											<tr>
												<th style="width: 1%" class="text-center"><input
													type="checkbox" style="ransform: scale(1.5);"></th>
												<th style="width: 5%" class="text-center">번호</th>
												<th style="width: 20%" class="text-center">제목</th>
												<th style="width: 15%; text-align: center;"
													class="text-center">작성자</th>
												<th style="width: 15%" class="text-center">작성일</th>
												<th style="width: 10%" class="text-center">조회수</th>
											</tr>
										</thead>
										<tbody>
										<c:choose>
												<c:when test="${empty pagingVO.dataList}">
													<tr>
														<td colspan="6">조회하실 게시물이 존재하지 않습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach items="${pagingVO.dataList}" var="board">
														<tr>
															<td><input name="RowCheck" type="checkbox"
																value="${board.pstId}" style="ransform: scale(1.5);"></td>
															<td style="text-align: center;">${board.pstId}</td>
															<td><a
																href="/everyware/boardDetail?pstId=${board.pstId}">${board.pstTtl}</a></td>
															<td style="text-align: center;">
																<c:forEach items="${empList}" var="empList">
																	<c:if test="${empList.empId eq board.empId }">
																		${empList.empName }
																	</c:if>
																</c:forEach>
															</td>
															<td style="text-align: center;">${board.pstgBgngDt}</td>
															<td style="text-align: center;">${board.pstCnt}</td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>

							</div>

						</div>
						<!-- <button type="button" class="btn btn-primary" id="newBtn">등록</button>
						<button type="button" class="btn btn-primary" id="newDel">삭제</button> -->
					</div>
					<div class="card-footer clearfix" id="pagingArea">
						${pagingVO.pagingHTML}</div>
				</div>
			</div>
		</div>
	</div>
</div>
</section>
<script>
	$(function() {

		var Toast = Swal.mixin({
			toast : true,
			position : 'top-end',
			showConfirmButton : false,
			timer : 3000
		});

		var newBtn = $("#newBtn");

		newBtn.on("click", function() {
			location.href = "/everyware/boardInsert?ctgryNo=${ctgryNo}";
		});
		$('#newDel')
				.on(
						'click',
						function() {
							var $checked = $('table input[type=checkbox]:checked');
							console.log($checked.length)
							console.log($checked)
							if ($checked.length < 1) {
								alert("삭제할 데이터를 선택해주세요");
								return false;
							}
							var idList = [];
							$.each($checked, function(k, v) {
								idList.push($(this).val());
								console.log(idList)
							})
							var jsonData = JSON.stringify(idList);
							console.log(jsonData)
							$
									.ajax({
										type : "POST",
										url : "/everyware/boardDelete",
										data : jsonData,
										dataType : "json",
										contentType : "application/json",
										beforeSend : function(xhr) {
											xhr.setRequestHeader(
													"${_csrf.headerName}",
													"${_csrf.token}")
										},
										success : function(response) {
											console.log(response);
											if (response == "OK") {
												Toast.fire({
													icon : 'success',
													title : '삭제가 성공되었습니다!'
												})
												location.href = "/everyware/boardList?category=3";
											} else {
												Toast.fire({
													icon : 'success',
													title : '삭제가 성공되었습니다!'
												})
												location.href = "/everyware/boardList?category=3"
											}
										},
										error : function(xhr, textStatus,
												errorThrown) {
											alert("시스템 실패");
											console.log(xhr.status);
										}
									});
						});

		document.getElementById("custom-tabs-five-overlay-tab")
				.addEventListener("click", function() {
					window.location.href = "/everyware/boardList?category=1";
				});

		// 자유게시판 버튼 클릭 시
		document.getElementById("custom-tabs-five-overlay-dark-tab")
				.addEventListener("click", function() {
					window.location.href = "/everyware/boardList?category=2";
				});

		// 양식함 버튼 클릭 시
		document.getElementById("custom-tabs-five-normal-tab")
				.addEventListener("click", function() {
					window.location.href = "/everyware/boardList?category=3";
				});
	});
	$(function() {
		var searchForm = $("#searchForm");
		var pagingArea = $("#pagingArea");

		pagingArea.on("click", "a", function(event) {
			event.preventDefault();
			var pageNo = $(this).data("page"); // Fix typo: use data() instead of date()
			searchForm.find("#page").val(pageNo);
			searchForm.submit();
		});

	});
</script>
