<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
    let headerName = "${_csrf.headerName}"
    let token = "${_csrf.token}"
</script>

<section class="content-header">
	<div class="container-fluid">

		<div class="row">
			<div class="col">
				<h1 style="margin: 5px;">근속연수별 휴가일 수 관리</h1>
				<!-- <div style="color: gray; margin: 8px;"></div> -->
			</div>
		</div>

		<div class="row">
			<div class="col">
				<div class="card card-outline card-primary">

					<div class="card-header">
						<div class="card-tools">
							<button type="button" id="btnAdd" class="btn btn-primary">+ 휴가일수 추가하기</button>
							<!-- <button type="button" id="btnDel" class="btn btn-primary">삭제</button> -->
							<!-- <button type="button" id="btnSave" class="btn btn-primary">저장</button> -->
						</div>
					</div>

					<div class="card-body">
						<!-- <div class="card-body" style="overflow-Y: scroll; height: 820px;display: block; padding: 0%"> -->
						<table class="table table">
							<thead>
								<tr>
									<th class="text-center">순번</th>
									<th class="text-center">근속연수</th>
									<th class="text-center">휴가일수</th>
									<th class="text-center">비고</th>
									<th class="text-center"></th>
								</tr>
							</thead>
							<tbody id="workYearList">
								<!-- workYearList -->
							</tbody>
						</table>

					</div>

				</div>
			</div>

		</div>

	</div>
</section>

<script type="text/javascript">

$(function () {
	workYearList();
	
	// 추가
	$(document).on("click", "#btnAdd", function () {
		addRow();
	});

	// 수정 - 저장
	$(document).on("click", ".btnUpdate", function () {
		console.log("btnUpdate");

		const wyNo = $(this).data('wyno');
		const row = $(this).closest("tr");
		const wyYear = row.find("td:eq(1) input").val();
		const wyHldy = row.find("td:eq(2) input").val();
		const wyMemo = row.find("td:eq(3) input").val();

		let workYearData = {
			wyNo : wyNo
			, wyYear : wyYear
			, wyHldy : wyHldy
			, wyMemo : wyMemo
		};

		console.log("workYearData", workYearData);

		if (wyYear == null || wyYear == "") {
			Swal.fire(
				'근속연수를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		if (wyHldy == null || wyHldy == "") {
			Swal.fire(
				'휴가일수를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		$.ajax({
			type : "put",
			url : '/everyware/admin/workYear/editWorkYear',
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(workYearData),
			dataType:"text",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(headerName,token);
			},
			success: function(res){
				console.log(res);
				if (res == "success") {
					Swal.fire(
						'수정되었습니다.',
						'',
						'success'
					).then(function () {
						workYearList();
					});

				} else {
					Swal.fire(
						'다시 시도해 주세요.',
						'',
						'error'
					);
				}
			}
		});

	});


	// 수정 버튼 
	$(document).on("click", ".btnEdit", function () {
        console.log("btnEdit");

        const row = $(this).closest("tr");
        row.find("input").prop("disabled", false);

        $(this).text("저장");
        $(this).removeClass("btnEdit").addClass("btnUpdate");
        $(this).removeClass("btn-info").addClass("btn-primary"); 
    });


	// 삭제
	$(document).on('click', '.btnDel', function () {
		console.log("btnDel");

		const wyNo = $(this).data('wyno');
		console.log("wyNo : ", wyNo);

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
					url: `/everyware/admin/workYear/delWorkYear/\${wyNo}`,
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
								workYearList();
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



	// 취소
	$(document).on("click", ".btnCancel", function () {
		console.log("btnCancel");
		$(this).closest("tr").remove();
	});
	

	// 등록 - 저장
	$(document).on("click", ".btnSave", function () {
		console.log("btnSave")

		const row = $(this).closest("tr");
        const wyYear = row.find("td:eq(1) input").val();
        const wyHldy = row.find("td:eq(2) input").val();
        const wyMemo = row.find("td:eq(3) input").val();

		let workYearData = {
			wyYear : wyYear,
			wyHldy : wyHldy,
			wyMemo : wyMemo
		};

		console.log("workYearData", workYearData);

		if (wyYear == null || wyYear == "") {
			Swal.fire(
				'근속연수를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		if (wyHldy == null || wyHldy == "") {
			Swal.fire(
				'휴가일수를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		$.ajax({
			type : "POST",
			url : '/everyware/admin/workYear/addWorkYear',
			contentType: "application/json; charset=utf-8",
            data: JSON.stringify(workYearData),
            dataType:"text",
            beforeSend: function (xhr) {
                xhr.setRequestHeader(headerName,token);
            },
			success: function(res){
				console.log(res);
				if (res == "success") {
                    Swal.fire(
                        '등록되었습니다.',
                        '',
                        'success'
                    ).then(function () {
						workYearList();
                    });

                } else {
                    Swal.fire(
                        '다시 시도해 주세요.',
                        '',
                        'error'
                    );
                }
			}
		});

	});

});

	
	
// workYear목록
function workYearList() {
	$.ajax({
		url: `/everyware/admin/workYear/workYearList`,
		type: "GET",
		contentType: 'application/json; charset=utf-8',
		dataType: "json",
		beforeSend: function (xhr) {
			xhr.setRequestHeader(headerName, token);
		},
		success: function (res) {
			console.log(res);

			var workYearStr = "";
			var workYear = res.workYear;

			if (workYear.length != 0) {
				for (let i = 0; i < workYear.length; i++) {
					var rownum = i + 1;
					workYearStr +=
					`<tr>
						<input type="hidden" id="\${workYear[i].wyNo}" name="wyNo" value="\${workYear[i].wyNo}>
						<td class="text-center">\${workYear[i].rownum}</td>
						<td class="text-center">\${rownum}</td>
						<td class="text-center"><input type="text" class="" id="\${workYear[i].wyYear}" name="wyYear" value="\${workYear[i].wyYear}" disabled></td>
						<td class="text-center"><input type="text" class="" id="\${workYear[i].wyHldy}" name="wyHldy" value="\${workYear[i].wyHldy}" disabled></td>
						<td class="text-center"><input type="text" class="" id="\${workYear[i].wyMemo}" name="wyMemo" value="\${workYear[i].wyMemo != null ? workYear[i].wyMemo : ''}" disabled></td>
						<td class="text-center">
							<button type="button" id="btnDel" class="btn btn-info btnEdit" data-wyNo="\${workYear[i].wyNo}">수정</button>
							<button type="button" id="btnDel" class="btn btn-danger btnDel" data-wyNo="\${workYear[i].wyNo}">삭제</button>
						</td>
					</tr>`;
				}

			} else {
				workYearStr +=
				`<tr>
					<td colspan="5">조회하신 기록이 존재하지 않습니다.</td>
				</tr>`;
			}

			$("#workYearList").html(workYearStr);


		},
		error: function (xhr) {
			alert("Error: " + xhr.status);
		}
	});


}


// 행추가
function addRow() {
	const newRowHtml = 
		`<tr>
			<td class="text-center"></td>
			<td class="text-center"><input type="text"></td>
			<td class="text-center"><input type="text"></td>
			<td class="text-center"><input type="text"></td>
			<td class="text-center">
				<button type="button" id="btnSave" class="btn btn-primary btnSave">저장</button>	
				<button type="button" id="btnCancel" class="btn btn-warning btnCancel">취소</button>	
			</td>
		</tr>`;

		
	$("table tbody").append(newRowHtml);
}


</script>
