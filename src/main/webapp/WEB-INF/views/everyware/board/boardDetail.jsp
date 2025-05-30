
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<style>
.<
style>table, td, th {
	border: 1px solid #ddd;
	text-align: left;
}

#tdn {
	border: 1px solid #f4f6f9;
}

#my_modal {
	display: none;
	width: 500px;
	padding: 40px 60px;
	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 3px;
}

#my_modal .modal_close_btn {
	position: absolute;
	top: 10px;
	right: 10px;
}

#btnUpd, #btnList, #btnSub {
	color: #fff;
	background-color: #007bff;
	border-color: #007bff;
	box-shadow: none;
	border: none;
	border-radius: 5px;
	padding: 8px;
}

.view_text {
	height: 300px;
}

.card-body {
	padding: 5px;
}

#board {
	display: flex;
	align-items: center;
	flex-direction: column;
}

#boardcontent {
	height: 150px;
}

td {
	border-bottom: 1px solid black;
	background-color: #b7def9;
	text-align: center;
}

#empName {
	width: 100%;
}
#content{
	height: 55px;
}
</style>

<div class="py-3 px-4" style="height: 690px;">
<div class="col-sm-6">
<h3>
<c:choose>
	<c:when test="${board.ctgryNo  eq '1'}">
								공지사항
							</c:when>
	<c:when test="${board.ctgryNo  eq '2'}">
								자유게시판
							</c:when>
	<c:when test="${board.ctgryNo  eq '3'}">
								양식함
							</c:when>
</c:choose>
</h3>
</div>
<div class="py-3">
	<!-- 현재 로그인 된 회원의 아이디 뽑아옴 -->
	<sec:authentication var="empId" property="principal.employee.empId" />
	<div class="">
		<div class="">

			<div class="card card-primary">
				<div class="card-header">
					<h3 class="card-title">
						<c:choose>
							<c:when test="${board.ctgryNo  eq '1'}">
								공지사항
							</c:when>
							<c:when test="${board.ctgryNo  eq '2'}">
								자유게시판
							</c:when>
							<c:when test="${board.ctgryNo  eq '3'}">
								양식함
							</c:when>
						</c:choose>
					</h3>
				</div>
				<form class="form-horizontal" action="/everyware/boardInsert"
					method="post" id="boardForm" enctype="multipart/form-data">
					<input type="hidden" name="ctgryNo" value="${board.ctgryNo}">
					<input type="hidden" name="pstId" value="${board.pstId }">


					<!-- line1 -->

					<div id="board">
						<div class="row g-3 col-11">
							<div class="col">
								<label for="suvyTtl"
									class="col-sm-5 col-form-label col-form-label-lg">글쓴이</label>
								<div class="form-control form-control-lg" name="empName">${emp.empName}</div>
							</div>
							<div class="col">
								<label for="suvyTtl"
									class="col-sm-5 col-form-label col-form-label-lg" class="col">조회수</label>
								<div class="form-control form-control-lg" name="empName">${board.pstCnt }</div>
							</div>
						</div>



						<div class="pt-3  col-11">
							<label for="suvyTtl"
								class="col-sm-2 col-form-label col-form-label-lg">제목</label>
							<div class="form-control form-control-lg">${board.pstTtl }</div>
						</div>

						<!-- line2 -->
						<div class="pt-3  col-11">
							<label class="col-sm-2 col-form-label col-form-label-lg">첨부파일</label>
							<div class="form-control form-control-lg">
								<a
									href="/everyware/board/filedownload?atchFileNo=${atch.atchFileNo }">${atch.fileNm }</a>
							</div>
						</div>

						<!-- line5 -->
						<div class="pt-3 col-11">
							<label for="" class="col-sm-2 col-form-label col-form-label-lg">내용</label>
							<div class="form-control form-control-lg" id="boardcontent">${board.pstCn }</div>
						</div>
						<!-- line6 -->
					</div>

					<sec:csrfInput />
				</form>
				<div class="card-footer d-flex justify-content-end">
					<button class="mx-1" type="button" id="btnUpd">수정</button>
					<button class="mx-1" type="button" id="btnList">목록</button>
				</div>

			</div>

		</div>
	</div>
	<br />
</div>
</div>


<c:choose>
	<c:when test="${board.ctgryNo == 2}">

		<div class="d-flex">
			<!-- Content Header (Page header) -->
			<div class="col-12 d-flex justify-content-center p-5">
				<div class="col-10" style="max-width: 68%; font-size: 17px;">
					<form:form modelAttribute="cmnt" method="post" class="mb-4"
						action="/everyware/cmntInsert">
						<div class="card card-primary py-2"
							style="margin: 0; color: #fff; background: #007bff;">
							<h5 class="card-title">댓글</h5>
						</div>
						<input type="hidden" id="perPageNum" name="pstId"
							value="${board.pstId}">
						<div class="input-group">
							<input id="content" name="cmntCn" class="form-control"
								placeholder="댓글을 입력해주세요">
							<div class="input-group-append">
								<button type="submit" id="btnInsert"
									class="btn btn-primary replyWriteBtn">등록</button>
							</div>
						</div>
						<input type="hidden" id="writer" name="ctgryNo"
							value="${board.ctgryNo }">
						<sec:csrfInput />
					</form:form>
					<c:choose>
						<c:when test="${empty CpagingVO.dataList}">
							<div class="card-primary p-0">
								<div class="d-flex justify-content-between px-2"></div>
								<div class="px-2 card-body">등록된 댓글이 없습니다.</div>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach items="${CpagingVO.dataList}" var="cmnt">
								<div class="card mb-4" id="${cmnt.cmntId}"
									style="margin-bottom: 0px;">
									<div class="d-flex justify-content-between px-2 id"
										style="align-items: center;" id="${cmnt.empId}">
										<c:if test="${not empty cmnt.empProfile }">
											<img src="/everyware/mypage/thumbnail?empId=${cmnt.empId }"
												alt="User Image"
												style="width: 35px; margin-left: 15px; margin-bottom: 20px; margin-top: 20px;">
										</c:if>
										<c:if test="${empty cmnt.empProfile }">
											<img src="/resources/img/basicProfile.png" alt="User Image"
												style="width: 35px; margin-left: 15px; margin-bottom: 20px; margin-top: 15px;">
										</c:if>
										<b style="width: 85%;">${cmnt.empName}${cmnt.jbgdNm}</b> <b>${cmnt.cmntDt}</b>
									</div>
									<div class="px-2 card-body cn" style="font-size: 20px;">${cmnt.cmntCn}</div>
									<div class="p-2 card-footer d-flex justify-content-end">
										<button class="btn btn-sm bg-info popup_open_btn">수정
										</button>
										<button class="btn btn-sm bg-danger delete_btn">삭제</button>
									</div>
								</div>
								<sec:csrfInput />
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</c:when>
	<c:otherwise>
		<!-- Placeholder for other content or no content -->
	</c:otherwise>
</c:choose>


<!-- 여기부턴 수정 모달 -->

<div id="my_modal">
	<form:form method="post" action="/everyware/cmntUpdate">
		<input type="hidden" name="empName" value="${emp.empName}">
		<h3>댓글 수정</h3>
		<table
			style="border-collapse: collapse; border-bottom: 0px solid black;">
			<tr>
				<td>작성자</td>
				<td><input type="text" id="empName"
					value="${emp.empName}${emp.jbgdNm}" readonly="readonly" /> <input
					type="hidden" id="empName" name="empName"
					value="${emp.empName}${emp.jbgdNm}"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="10" cols="30" name="cmntCn"
						id="updateContent">
                            </textarea></td>

			</tr>
			<!-- <tr>
				<td>내용</td>
				<td><textarea rows="10" cols="30" name="cmntCn"
						id="updateContent">
                            </textarea></td>
			</tr> -->

		</table>
		<div>
			<button type="submit" id="btnSub" value="수정">수정</button>
		</div>
		<sec:csrfInput />
		<a class="modal_close_btn">닫기</a>
	</form:form>
</div>



<!-- 댓글 삭제 폼 display none -->
<form id="delForm" action="/everyware/cmntDelete" style="display: none;">
	<input type="hidden" name=cmntId id="delCmntInput"> <input
		type="hidden" name="pstId" value="${board.pstId }">
	<sec:csrfInput />
</form>


<script type="text/javascript">
	$(function() {
		var btnList = $("#btnList");
		var btnUpd = $("#btnUpd");
		var btnSub = $("#btnSub")

		// 목록 버튼 클릭 시 이벤트
		btnList.on("click", function() {
			location.href = "/everyware/boardList?category=${board.ctgryNo}";
		});
		btnUpd
				.on(
						"click",
						function() {
							location.href = "/everyware/boardUpdate/${board.pstId}/${board.ctgryNo}";
						})
		$(document).on("click", '.popup_open_btn', function() {
			// 모달창 띄우기
			console.log("나옴")
			var cmnt = $(this).parents(".cmnt")
			var id = cmnt.attr("id")
			var empId = $(".id", cmnt).attr("id")
			var cn = $(".cn", cmnt).text()

			console.log(id)
			console.log(cn)

			var updateContent = $("#updateContent")

			$("#empId").val(empId)
			$("#cmntId").val(id)
			updateContent.text(cn)

			modal('my_modal');
		})

		btnSub.on("click", function() {
			var cmntEmpId = $("#empId").val()
			var updateContent = $("#updateContent")
			var updateTitle = $("#updateTitle")

			if (cmntEmpId != "${empId}") {
				alert("회원님의 댓글이 아닙니다.")
				return false;
			}
			if (updateContent == null || updateContent === "") {
				alert("내용을 입력해주세요");
				return false;
			}
		})

		$(document).on("click", '.delete_btn', function() {

			if (confirm("해당 댓글을 삭제 하시겠습니까?")) {
				var cmnt = $(this).parents(".cmnt")
				var id = cmnt.attr("id")
				var empId = $(".id", cmnt).attr("id")

				if (empId != "${empId}") {
					alert("회원님의 댓글이 아닙니다.")
					return false;
				}
				$("#delCmntInput").val(id)
				$("#delForm").submit()
			}
		})

	});

	$(function() {
		var searchForm = $("#searchForm");
		var pagingArea = $("#pagingArea");
		var btnInsert = $("#btnInsert")

		pagingArea.on("click", "a", function(event) {
			event.preventDefault();
			var pageNo = $(this).data("page"); // Fix typo: use data() instead of date()
			searchForm.find("#page").val(pageNo);
			searchForm.submit();
		});
		btnInsert.on("click", function() {

			var title = $("#title").val(); // 제목을 가져온다
			var content = $("#content").val(); // 내용을 가져온다
			var writer = $("#writer").val(); // 작성자를 가져온다.

			if (content == null || content === "") {
				alert("내용을 입력해주세요");
				return false;
			} else {
				alert("등록이 완료되었습니다")
			}
			CpagingVO.submit();
		});
	});

	function modal(id) {
		var zIndex = 9999;
		var modal = document.getElementById(id);

		// 모달 div 뒤에 희끄무레한 레이어
		var bg = document.createElement('div');
		bg.setStyle({
			position : 'fixed',
			zIndex : zIndex,
			left : '0px',
			top : '0px',
			width : '100%',
			height : '100%',
			overflow : 'auto',
			// 레이어 색갈은 여기서 바꾸면 됨
			backgroundColor : 'rgba(0,0,0,0.4)'
		});
		document.body.append(bg);

		// 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
		modal.querySelector('.modal_close_btn').addEventListener('click',
				function() {
					bg.remove();
					modal.style.display = 'none';
				});

		modal
				.setStyle({
					position : 'fixed',
					display : 'block',
					boxShadow : '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

					// 시꺼먼 레이어 보다 한칸 위에 보이기
					zIndex : zIndex + 1,

					// div center 정렬
					top : '35%',
					left : '50%',
					transform : 'translate(-50%, -50%)',
					msTransform : 'translate(-50%, -50%)',
					webkitTransform : 'translate(-50%, -50%)'
				});
	}
	// Element 에 style 한번에 오브젝트로 설정하는 함수 추가
	Element.prototype.setStyle = function(styles) {
		for ( var k in styles)
			this.style[k] = styles[k];
		return this
	}

	function convertFileSize(sizeInKB) {
		if (sizeInKB < 1024) {
			return sizeInKB + ' KB';
		} else if (sizeInKB < 1024 * 1024) {
			const sizeInMB = (sizeInKB / 1024).toFixed(2);
			return sizeInMB + ' MB';
		} else {
			const sizeInGB = (sizeInKB / (1024 * 1024)).toFixed(2);
			return sizeInGB + ' GB';
		}
	}
</script>

