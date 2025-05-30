<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
    let headerName = "${_csrf.headerName}"
    let token = "${_csrf.token}"
</script>

<style>
.content-wrapper.kanban .content {
    height: 98%;
    overflow-x: auto;
    overflow-y: hidden;
}

.container-fluid {
    padding: 20px;
    margin: 0;
}

.todoPlus {
    padding: 20px;
}
</style>

<div class="content-wrapper kanban m-0">
    <section class="content pb-1 d-flex justify-content-center">
        <div class="container-fluid h-100">

            <div class="card card-row card-default">
                <div class="card-header bg-light disabled color-palette">
                    <h3 class="card-title">
                        Summary
                    </h3>
                </div>

                <div class="card-body">
                    <!-- Total-->
                    <div class="info-box">
                        <span class="info-box-icon bg-primary"><i class="far fa-bookmark"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">Total</span>
                            <span class="info-box-number" id="totalRecode">0개</span>
                        </div>
                    
                    </div>
                    <!-- To Do -->
                    <div class="info-box">
                        <span class="info-box-icon bg-danger"><i class="far fa-star"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">To Do</span>
                            <span class="info-box-number" id="totalToDo">0개</span>
                        </div>
            
                    </div>

                    <!-- In Progress -->
                    <div class="info-box">
                        <span class="info-box-icon bg-info"><i class="far fa-copy"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">In Progress</span>
                            <span class="info-box-number" id="totalInProgress">0개</span>
                        </div>
                
                    </div>

                    <!-- Done -->
                    <div class="info-box" >
                        <span class="info-box-icon bg-success"><i class="far fa-flag"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">Done</span>
                            <span class="info-box-number" id="totalDone">0개</span>
                        </div>
                    
                    </div>

                    <!-- donutChart -->
                    <div class="card card-light card-outline">
                        <div class="card-body">
                            <canvas id="donutChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block;" width="394" height="250" class="chartjs-render-monitor"></canvas>
                        </div>
                    </div>

                </div>
                

            </div>

            <!-- To Do -->
            <div class="card card-row card-default">
                <div class="card-header bg-danger disabled color-palette">
                    <h3 class="card-title">
                        To Do
                    </h3>
                </div>
                
                <div class="card-body">
                    <div id="ToDo"></div>

                    <!-- PLUS -->
                    <button type="button" id="btnToDo" class="btn btn-tool d-block mx-auto todoPlus" data-toggle="modal" data-target="#modal-ToDo" style="background-color: white; border: none; font-size: 40px;">
                        <i class="fas fa-plus"></i>
                    </button>

                </div>
            </div>
            
            <!-- In Progress -->
            <div class="card card-row card-default">
                <div class="card-header bg-info disabled color-palette">
                    <h3 class="card-title">
                        In Progress
                    </h3>
                </div>

                <div class="card-body">
                    <div id="InProgress"></div>

                    <!-- PLUS -->
                    <button type="button" id="btnInProgress" class="btn btn-tool d-block mx-auto todoPlus" style="background-color: white; border: none; font-size: 40px;">
                        <i class="fas fa-plus"></i>
                    </button>

                </div>
            </div>

            <!-- Done -->
            <div class="card card-row card-default">
                <div class="card-header bg-success disabled color-palette">
                    <h3 class="card-title">
                        Done
                    </h3>
                </div>
                <div class="card-body">
                    <div id="Done"></div>

                    <!-- PLUS -->
                    <button type="button" id="btnDone" class="btn btn-tool d-block mx-auto todoPlus" style="background-color: white; border: none; font-size: 40px;">
                        <i class="fas fa-plus"></i>
                    </button>
                    
                </div>
                
            </div>

        </div>

    </section>
</div>

<!-- modal-ToDo-->
<div class="modal fade" id="modal-ToDo">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="modalTtl">TODO FORM</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <form class="form-horizontal" method="post" id="toDoForm">
                    <input type="hidden" id="tdNo" name="tdNo">
                    <div class="card-body">
                        <div class="form-group row">
                            <label for="tdTtl" class="col-sm-2 col-form-label">제목</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="tdTtl" name="tdTtl" placeholder="제목을 입력하세요.">
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label for="tdState" class="col-sm-2 col-form-label">상태</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="tdState" id="tdState">
                                    <option>To Do</option>
                                    <option>In Progress</option>
                                    <option>Done</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="tdCn" class="col-sm-2 col-form-label">내용</label>
                            <div class="col-sm-10">
                                <div class="input-group mb-3">
                                    <textarea class="form-control" id="tdCn" name="tdCn" rows="10" placeholder="내용을 입력하세요."></textarea>
                                </div>
                            </div>
                        </div>

                    </div>
                </form>
            </div>

            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                <div class="float-right" style="width: auto;">
                    <div class="row">
                        <div class="col">
                            <button type="button" class="btn btn-primary" id="btnToDoAdd" style="width: 60px;">저장</button>
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
    todoList();
    var btnToDo = $("#btnToDo");
    var btnInProgress = $("#btnInProgress");
    var btnDone = $("#btnDone");

    // 수정
    $(document).on("click", "#btnEdit", function () {

        var tdTtl = $("#tdTtl").val();
        var tdCn = $("#tdCn").val();
        var tdState = $("#tdState").val();
        var tdNo = $("#tdNo").val()

        let todoData =  {
            tdTtl: tdTtl,
            tdCn: tdCn, 
            tdState: tdState,
            tdNo: tdNo
        };
        console.log(todoData);

        if (tdTtl == null || tdTtl == '') {
			Swal.fire(
				'제목을 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

        if (tdCn == null || tdCn == '') {
			Swal.fire(
				'내용을 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

        if (tdState == null || tdState == '') {
			Swal.fire(
				'상태를 선택해주세요.',
				'',
				'warning'
			)
			return false;
		}


        $.ajax({
            type: "put",
            url: `/everyware/todo/editTodo`,
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(todoData),
            dataType:"text",
            beforeSend : function(xhr){
                xhr.setRequestHeader(headerName,token);
            },
            success: function(res){
                if (res == "success") {
                    Swal.fire(
                        '수정되었습니다.',
                        '',
                        'success'
                    ).then(function () {
                        $('#modal-ToDo').modal("hide");
                        todoList();
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
    });

    // 상세보기
    $(document).on("click", ".btnDetail", function () {
        var tdNo = $(this).closest(".card-header").find("input[name='tdNo']").val();
        $("#btnToDoAdd").text("저장").attr("id", "btnEdit");
        $(".btnDel").attr("data-tdNo", tdNo);

        $.ajax({
            type: "get",
            url: `/everyware/todo/getOneTodo/\${tdNo}`,
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            beforeSend : function(xhr){
                xhr.setRequestHeader(headerName,token);
            },
            success: function(res){
                const tdTtl = res.tdTtl;
                const tdCn = res.tdCn;
                const tdState = res.tdState;
                const tdNo = res.tdNo;
                var btnDelStr = "";
                console.log(tdTtl, tdCn, tdState, tdNo);

                $('#tdTtl').val(tdTtl);
                $(`#tdCn`).val(tdCn);
                $(`#tdState`).val(tdState);
                $(`#tdNo`).val(tdNo);
                
                btnDelStr += `<button type="button" class="btn btn-danger btnDel" data-tdNo="" style="width: 60px;">삭제</button>`;
                $(`#btn`).html(btnDelStr);

                $('#modal-ToDo').modal("show");


            },
            error: function (xhr) {
                alert("Error: " + xhr.status);
            }
        });

    });

    // todo 삭제
    $(document).on("click", ".btnDel", function () {
        var tdNo = $(this).closest(".card-header").find("input[name='tdNo']").val();

        if (tdNo == null) {
            var tdNo = $(this).attr("data-tdNo");
            tdNo = $("#tdNo").val();
        }

        console.log(tdNo);

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
                    url: `/everyware/todo/delTodo/\${tdNo}`,
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
                                $('#modal-ToDo').modal("hide");
                                todoList();
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

    // modal - btnToDoAdd 추가
    $(document).on("click", "#btnToDoAdd", function () {
        var tdTtl = $("#tdTtl").val();
        var tdCn = $("#tdCn").val();
        var tdState = $("#tdState").val();


        let todoData =  {
            tdTtl: tdTtl,		
            tdCn: tdCn,		
            tdState: tdState
        };
        console.log("누느로화긴", todoData);

        if (tdTtl == null || tdTtl == "") {
			Swal.fire(
				'제목을 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

        if (tdCn == null || tdCn == '') {
			Swal.fire(
				'내용을 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

        if (tdState == null || tdState == '') {
			Swal.fire(
				'상태를 선택해주세요.',
				'',
				'warning'
			)
			return false;
		}

        $.ajax({
            type: "POST",
            url: '/everyware/todo/addTodo',
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(todoData),
            dataType:"text",
            beforeSend: function (xhr) {
                xhr.setRequestHeader(headerName,token);
            },
            success:function(res){
                console.log(res)
                if (res == "success") {
                    Swal.fire(
                        '등록되었습니다.',
                        '',
                        'success'
                    ).then(function () {
                        $('#tdTtl').val('');
                        $('#tdCn').val('');
                        
                        $('#modal-ToDo').modal("hide");
                        todoList();
                    });

                } else {
                    Swal.fire(
                        '다시 시도해 주세요.',
                        '',
                        'error'
                    );
                }

            },
            error: function(xhr) {
                alert("Error: " + xhr.status);
            }
        });
    });

    // Done Plus 
    btnDone.on("click", function(){
        $("#btnEdit").text("저장").attr("id", "btnToDoAdd");
        $('#tdTtl').val('');
        $('#tdCn').val('');
        $(`#tdState`).val('Done');
        $(".btnDel").hide();
        $('#modal-ToDo').modal("show");
        
    });

    // InProgress Plus 
    btnInProgress.on("click", function(){
        $("#btnEdit").text("저장").attr("id", "btnToDoAdd");
        $('#tdTtl').val('');
        $('#tdCn').val('');
        $(`#tdState`).val('In Progress');
        $(".btnDel").hide();
        $('#modal-ToDo').modal("show");
        
    });
    
    // ToDo Plus 
    btnToDo.on("click", function(){
        $("#btnEdit").text("저장").attr("id", "btnToDoAdd");
        $('#tdTtl').val('');
        $('#tdCn').val('');
        $(`#tdState`).val('To Do');
        $(".btnDel").hide();
        $('#modal-ToDo').modal("show");
    });

});

// todo목록
function todoList(){
    $.ajax({
        url: `/everyware/todo/todoList`,
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        dataType: "json",
        beforeSend : function(xhr){
            // xhr.setRequestHeader("${_headerName}","${token}");
            xhr.setRequestHeader(headerName,token);
        },
        success: function(res){
            console.log(res);

            var dataList = res.dataList;
            var todoListstr = "";
            var inProgressListstr = "";
            var doneListstr = "";

            // todo 현황
            var totalRecode = res.totalRecode;
            var totalToDo = res.totalToDo;
            var totalInProgress = res.totalInProgress;
            var totalDone = res.totalDone;

            if(dataList.length != 0){
                for(let i=0; i<dataList.length; i++){
                    if(`\${dataList[i].tdState}` == 'To Do'){
                        todoListstr += 
                        `<div class="card card-light card-outline">
                            <div class="card-header">
                                <input type="hidden" id="\${dataList[i].tdNo}" name="tdNo" value="\${dataList[i].tdNo}">
                                <h5 class="card-title">\${dataList[i].tdTtl}</h5>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool btnDetail"><i class="fas fa-pen"></i></button>
                                    <button type="button" class="btn btn-tool btnDel"><i class="fas fa-times"></i></button>
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
                                </div>
                            </div>
    
                            <div class="card-body">
                                <p>\${dataList[i].tdCn}</p>
                            </div>
                        </div>`;
                    }

                    if(`\${dataList[i].tdState}` == 'In Progress'){
                        inProgressListstr += 
                        `<div class="card card-light card-outline">
                            <div class="card-header">
                                <input type="hidden" id="\${dataList[i].tdNo}" name="tdNo" value="\${dataList[i].tdNo}">
                                <h5 class="card-title">\${dataList[i].tdTtl}</h5>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool btnDetail"><i class="fas fa-pen"></i></button>
                                    <button type="button" class="btn btn-tool btnDel"><i class="fas fa-times"></i></button>
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
                                </div>
                            </div>
    
                            <div class="card-body">
                                <p>\${dataList[i].tdCn}</p>
                            </div>
                        </div>`;
                    }

                    if(`\${dataList[i].tdState}` == 'Done'){
                        doneListstr += 
                        `<div class="card card-light card-outline">
                            <div class="card-header">
                                <input type="hidden" id="\${dataList[i].tdNo}" name="tdNo" value="\${dataList[i].tdNo}">
                                <h5 class="card-title">\${dataList[i].tdTtl}</h5>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool btnDetail"><i class="fas fa-pen"></i></button>
                                    <button type="button" class="btn btn-tool btnDel"><i class="fas fa-times"></i></button>
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
                                </div>
                            </div>
    
                            <div class="card-body">
                                <p>\${dataList[i].tdCn}</p>
                            </div>
                        </div>`;
                    }

                    //-------------
                    //- DONUT CHART -
                    //-------------
                    // Get context with jQuery - using jQuery's .get() method.
                    var donutChartCanvas = $('#donutChart').get(0).getContext('2d')
                    var donutData        = {
                    labels: [
                        'To Do',
                        'In Progress',
                        'Done'
                    ],
                    datasets: [
                        {
                        data: [totalToDo,totalInProgress,totalDone],
                        backgroundColor : ['#dc3545', '#17a2b8', '#28a745'],
                        }
                    ]
                    }
                    var donutOptions     = {
                    maintainAspectRatio : false,
                    responsive : true,
                    }
                    //Create pie or douhnut chart
                    // You can switch between pie and douhnut using the method below.
                    new Chart(donutChartCanvas, {
                    type: 'doughnut',
                    data: donutData,
                    options: donutOptions
                    })

                }
            }

            $("#ToDo").html(todoListstr);
            $("#InProgress").html(inProgressListstr);
            $("#Done").html(doneListstr);

            // Todo 현황
            $("#totalRecode").text(totalRecode + '개');
            $("#totalToDo").text(totalToDo + '개');
            $("#totalInProgress").text(totalInProgress + '개');
            $("#totalDone").text(totalDone + '개');

        },
        error: function(xhr) {
            alert("Error: " + xhr.status);
        }
    });
}
</script>