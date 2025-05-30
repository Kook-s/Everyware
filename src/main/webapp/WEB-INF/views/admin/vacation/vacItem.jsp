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
				<h1 style="margin: 5px;">휴가항목관리</h1>
				<!-- <div style="color: gray; margin: 8px;"></div> -->
			</div>
		</div>

		<div class="row">
			<div class="col">
				<div class="card card-outline card-primary">

					<div class="card-header">
						<div class="card-tools">
							<button type="button" id="btnAdd" class="btn btn-primary">+ 휴가항목 추가하기</button>
						</div>
					</div>

					<div class="card-body">
						<table class="table table">
							<thead>
								<tr>
									<th class="text-center">순번</th>
									<th class="text-center">휴가구분</th>
									<th class="text-center">차감일수</th>
									<th class="text-center">휴가설명</th>
									<th></th>
								</tr>
							</thead>
							<tbody id="vacItemList">
								<!-- vacItemList -->
							</tbody>
						</table>

					</div>

				</div>
			</div>

		</div>
	</div>
</section>



<script type="text/javascript">
$(function(){
	vacItemList();
	
	// 수정 - 저장
	$(document).on("click", ".btnUpdate", function () {
		console.log("btnUpdate");

		const viNo = $(this).data('vino');
		const row = $(this).closest("tr");
		const viType = row.find("td:eq(1) input").val();
		const viDay = row.find("td:eq(2) input").val();
		const viMemo = row.find("td:eq(3) input").val();

		let vacItemData = {
			viNo : viNo,
			viType : viType,
			viDay : viDay,
			viMemo : viMemo
		};

		console.log("vacItemData", vacItemData);

		if (viType == null || viType == "") {
			Swal.fire(
				'휴가항목를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		if (viDay == null || viDay == "") {
			Swal.fire(
				'차감일수를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}



		$.ajax({
			type : "put",
			url : '/everyware/admin/vacation/vacItem/editVacItem',
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(vacItemData),
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
						vacItemList();
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

		const viNo = $(this).data('vino');
        console.log("viNo : ", viNo);
		
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
					url: `/everyware/admin/vacation/vacItem/delVacItem/\${viNo}`,
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
								vacItemList();
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


	// 등록 - 저장
	$(document).on("click", ".btnSave", function () {
		console.log("btnSave")

		const row = $(this).closest("tr");
		const viType = row.find("td:eq(1) input").val();
		const viDay = row.find("td:eq(2) input").val();
		const viMemo = row.find("td:eq(3) input").val();

		let vacItemData = {
			viType : viType,
			viDay : viDay,
			viMemo : viMemo
		};

		console.log("workYearData", vacItemData);

		if (viType == null || viType == "") {
			Swal.fire(
				'휴가항목를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		if (viDay == null || viDay == "") {
			Swal.fire(
				'차감일수를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		$.ajax({
			type : "POST",
			url : '/everyware/admin/vacation/vacItem/addVacItem',
			contentType: "application/json; charset=utf-8",
            data: JSON.stringify(vacItemData),
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
						vacItemList();
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


	// 취소
	$(document).on("click", ".btnCancel", function () {
		console.log("btnCancel");
		$(this).closest("tr").remove();
	});
	
    
	// 추가
	$(document).on("click", "#btnAdd", function () {
		console.log("btnAdd");
		addRow();
	});
	
	
});


// vacItemList 
function vacItemList() {

	$.ajax({
		url: `/everyware/admin/vacation/vacItem/vacItemList`,
		type: "GET",
		contentType: 'application/json; charset=utf-8',
		dataType: "json",
		beforeSend: function (xhr) {
			xhr.setRequestHeader(headerName, token);
		},
		success: function (res) {
			console.log(res);

			var vacItemStr = "";
			var vacItem = res.vacItem;

			if (vacItem.length != 0) {
				for (let i = 0; i < vacItem.length; i++) {
					var rownum = i + 1;
					vacItemStr +=
					`<tr>
						<input type="hidden" id="\${vacItem[i].viNo}" name="viNo" value="\${vacItem[i].viNo}>
						<td class="text-center">\${vacItem[i].rownum}</td>
						<td class="text-center">\${rownum}</td>
						<td class="text-center"><input type="text" class="" id="\${vacItem[i].viType}" name="viType" value="\${vacItem[i].viType}" disabled></td>
						<td class="text-center"><input type="text" class="" id="\${vacItem[i].viDay}" name="viDay" value="\${vacItem[i].viDay}" disabled></td>
						<td class="text-center"><input type="text" class="" id="\${vacItem[i].viMemo}" name="viDay" value="\${vacItem[i].viMemo != null ? vacItem[i].viMemo : ''}" disabled></td>
						<td class="text-center">
							<button type="button" id="btnDel" class="btn btn-info btnEdit" data-viNo="\${vacItem[i].viNo}">수정</button>
							<button type="button" id="btnDel" class="btn btn-danger btnDel" data-viNo="\${vacItem[i].viNo}">삭제</button>
						</td>
					</tr>`;
				}

			} else {
				vacItemStr +=
				`<tr>
					<td colspan="5">조회하신 기록이 존재하지 않습니다.</td>
				</tr>`;
			}

			$("#vacItemList").html(vacItemStr);


		},
		error: function (xhr) {
			alert("Error: " + xhr.status);
		}
	});

};


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