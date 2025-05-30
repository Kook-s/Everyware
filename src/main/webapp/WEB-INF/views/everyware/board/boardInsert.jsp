<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
<style>
.<
style>table, td, th {
	border: 1px solid #ddd;
	text-align: left;
}

table {
	width: 50%;
}

th {
	width: 140px;
	text-align: center;
	color: #fff;
	background-color: #8da9c2;;
	border-color: #007bff;
	box-shadow: none;
	font-size: 150%;
}

th, td {
	height: 70px;
}


td {
	font-size: 20px;
}

table {
	margin-left: auto;
	margin-right: auto;
	width: 65%;
	height: 200px;
}

#tdn {
	border: 1px solid #f4f6f9;
}

table, td, th {
	border-collapse: collapse;
	border-bottom: 3px inset;
}

#my_modal {
	display: none;
	width: 470px;
	padding: 20px 60px;
	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 3px;
	border-radius: 5px;
}

#my_modal .modal_close_btn {
	position: absolute;
	top: 10px;
	right: 10px;
}

#btnSub, #btnCancel,#labels {
	color: #fff;
	background-color: #007bff;
	border-color: #007bff;
	box-shadow: none;
	border: none;
	border-radius: 5px;
	padding: 8px;
}

#label{
	padding-left: 5%;
}
#suvyTtl,#group {
	width: 73%;
}

textarea {
    width: 100%;
    border: none;
    resize: none;
}
</style>
<section class="content">
	<div class="py-3">
		<div class="row" style="padding: 10px;">
			<div class="col">

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
						<div class="card-body">
							<!-- line1 -->
							<div class="form-group row">
								<label for="suvyTtl"  id="label" class="col-sm-2 col-form-label">제목</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="suvyTtl"
										name="pstTtl" placeholder="제목을 입력하세요." value="">
								</div>
							</div>

							<!-- line2 -->
							<div class="form-group row">
								<label id="label" class="col-sm-2 col-form-label">첨부파일</label>
								<div class="col-sm-10">
									<div class="input-group" id="group">
										<input  class="form-control" id="boardFilePath"
											placeholder="첨부파일을 올려주세요"> <input type="file"
											id="fileBoard" name="file">
										<div class="input-group-append">
											<label id="labels" for="fileBoard" class="btn btn-outline-secondary"
												type="button" data-toggle="modal" data-target="#tree-modal"
												id="boardFile">첨부파일</label>
										</div>
									</div>
								</div>
							</div>

							<!-- line5 -->
							<div class="form-group row">
								<label id="label" for="" class="col-sm-2 col-form-label">내용</label>
								<div class="col-sm-10">
									<div class="input-group mb-3">
										<textarea class="form-control" id="pstCn" name="pstCn"
											rows="10" placeholder="내용을 입력하세요."></textarea>
									</div>
								</div>
							</div>

							<!-- line6 -->




						</div>

						<div class="card-footer d-flex justify-content-end" style="padding-left: 71%;">
							<button type="button" class="btn btn-primary mx-1" id="btnBoardAdd">등록</button>
							<button type="button" class="btn btn-default float-right mx-1"
								id="btnCancel">목록</button>
						</div>
						<sec:csrfInput />
					</form>

				</div>

			</div>

		</div>

	</div>
</section>

<script type="text/javascript">
	$(function() {
		CKEDITOR
				.replace(
						"pstCn",
						{
							footnotesPrefix : "a", // 속성 태그 <a>
							filebrowserUploadUrl : '/imageUpload.do?${_csrf.parameterName }=${_csrf.token}'
						})

		$("#fileBoard").hide();

		$("#fileBoard").on('change', function(e) {
			var file = e.target.files[0]
			$("#boardFilePath").val(file.name);
		})

		var btnCancel = $("#btnCancel");
		var btnSub = $("#btnSub");
		var board = $("#board");

		$("#btnBoardAdd").on('click', function() {
			$("#boardForm").submit();
		})

		btnSub.on("click", function() {

			var title = $("#title").val(); // 제목을 가져온다
			var content = $("#content").val(); // 내용을 가져온다
			var writer = $("#writer").val(); // 작성자를 가져온다.

			if (title == null || title === "") {
				alert("제목을 입력해주세요");
				return false;
			}

			if (content == null || content === "") {
				alert("내용을 입력해주세요");
				return false;
			}

			if (writer == null || writer === "") {
				alert("작성자를 입력해주세요");
				return false;
			} else {
				alert("등록이 완료되었습니다")
			}
			board.submit();
		});

		// 목록 버튼 클릭 시 이벤트
		btnCancel.on("click", function() {
			location.href = "/everyware/boardList?category=${board.ctgryNo}";
		});
	});
</script>
