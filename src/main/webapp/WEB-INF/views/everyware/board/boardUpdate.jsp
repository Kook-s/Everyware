<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<script src="/resources/ckeditor/ckeditor.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
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
}

#my_modal .modal_close_btn {
	position: absolute;
	top: 10px;
	right: 10px;
}

#btnSub, #btnCancel {
	color: #fff;
	background-color: #007bff;
	border-color: #007bff;
	box-shadow: none;
	border: none;
	border-radius: 5px;
	padding: 8px;
}
</style>
<form:form method="post" action="/everyware/boardUpdate" id="Update">
		<div class="py-3" style="padding: 10px;">
			<div class="col">

				<div class="card card-primary">
					<div class="card-header">
						<h3 class="card-title">${board.ctgryNo }</h3>
					</div>
					<form class="form-horizontal" action="/everyware/boardInsert"
						method="post" id="boardForm" enctype="multipart/form-data">
						<input type="hidden" name="ctgryNo" value="${board.ctgryNo}">
						<input type="hidden" name="pstId" value="${board.pstId }">
						<div class="card-body">
							<!-- line1 -->

							<div class="form-group row">
								<label for="suvyTtl" class="col-sm-2 col-form-label">글쓴이</label>
								<div class="col-sm-10" name="empName">
									${emp.empName}${emp.jbgdNm}</div>
							</div>

							<div class="form-group row">
								<label for="suvyTtl" class="col-sm-2 col-form-label">제목</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="title"
										name="pstTtl" value="${board.pstTtl }">
								</div>
							</div>

							<!-- line2 -->
							<div class="form-group row">
								<label class="col-sm-2 col-form-label">첨부파일</label>
								<div class="col-sm-10">
									<div class="input-group">
										<input class="form-control" id="boardFilePath"
											placeholder="첨부파일을 올려주세요"> <input type="file"
											id="fileBoard" name="file">
										<div class="input-group-append">
										</div>
									</div>
								</div>
							</div>

							<!-- line5 -->
							<div class="form-group row">
								<label for="" class="col-sm-2 col-form-label">내용</label>
								<div class="col-sm-10">
									<div class="input-group mb-3">
										<textarea class="form-control" id="pstCn" name="pstCn"
											rows="5">${board.pstCn }</textarea>
									</div>
								</div>
							</div>
							<!-- line6 -->
						<div style="padding-left: 76%; padding-top: 20px;">
							<button type="submit" id="btnSub" value="수정">수정</button>
							<button type="button" id="btnCancel" >뒤로가기</button>
						</div>
						</div>

						<sec:csrfInput />
					</form>

				</div>

			</div>

		</div>

	<sec:csrfInput />
</form:form>
<script>
	$(function() {
		
		CKEDITOR
		.replace("pstCn",
		{
			footnotesPrefix : "a", // 속성 태그 <a>
			filebrowserUploadUrl : '/imageUpload.do?${_csrf.parameterName }=${_csrf.token}'
		})

		
		var btnList = $("#btnList");
		var btnSub = $("#btnSub");
		var Update = $("#Update");
		var btnCancel = $("#btnCancel");
		
		
		btnSub.on("click", function() {

			var title = $("#title").val(); // 제목을 가져온다
			var pstCn = $("#pstCn").val(); // 내용을 가져온다

			if (title == null || title === "") {
				alert("제목을 입력해주세요");
				return false;
			}
			if (pstCn == null || content === "") {
				alert("내용을 입력해주세요");
				return false;
			}
			else {
				alert("수정이 완료되었습니다")
			}
			Update.submit();
		});
		btnCancel.on("click", function() {
			location.href = "/everyware/boardDetail?pstId=${board.pstId}";
		});

	});
</script>