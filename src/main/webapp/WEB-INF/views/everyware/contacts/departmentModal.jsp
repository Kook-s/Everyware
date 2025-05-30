<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조직도</title>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script> -->
<!-- <link rel="stylesheet" href="../../../../resources/bootstrap/dist/css/adminlte.min.css"> -->
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/themes/default/style.min.css" /> -->
<!-- <link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet" /> -->
<style type="text/css">
*{
	box-sizing: border-box;
}
.contact-wrap,
.dept-select-box{
	height: 450px;
	overflow-y: auto;
	overflow-x: hidden;
}
.select-button-wrap{
	height: 100px;
	right: 5px;
}
.row-flex{
	display: flex;
	align-items: center;
}
.temp-list-btn{
	min-width: 108px;
    padding-left: 13px;
}
.dept-select-box-content{
	padding: 0px;
	overflow-y: auto;
	overflow-x: hidden;
}
.dept-select-ul{
	border: 1px solid rgba(0,0,0,.125);
}
.dept-select-ul li{
	position: relative;
	height: 45px;
}
.dept-select-ul input[type=checkbox]{
	margin-right: 10px;
}
.selected-emp::before{
	font-family: 'Material Icons';
	content: '\e945';
	position: absolute;
	color: lightgray;
	left: 315px;
	top: 11px;
}
.custom-select-sm{
	float: right;
    width: 75px;
    height: 28px;
    right: 10px;
	bottom: 4px;
    position: relative;
    padding: 0px 10px;
    font-size: 15px;
}
.dept-search-box-wrap{
	width: 146px;
	height: 100%;
    margin-left: 60px;
    padding: 3px 0px;
}
.dept-search-box{
	height: 34px;
}
.jstree-default a.jstree-search{
	background-color: #007bff3d;
    color: black;
    font-style: normal;
}
</style>
</head>
<body>
    <!-- 모달 시작 -->
    <div class="modal fade" id="dept-modal">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">부서 선택</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
				<div class="row">
					<div class="col-md-6">
						<div class="card contact-wrap">
							<ul class="nav nav-tabs" id="myTab" role="tablist">
								<li class="nav-item">
									<a class="nav-link active dept-show-org-btn" id="deptTree-tab" data-toggle="tab" href="#deptTree" role="tab" aria-controls="deptTree"
										aria-selected="true">부서</a>
								</li>
							</ul>
							<div class="card-body tab-content" id="myTabContent">
								<div class="tab-pane fade show active dept-chart-box" id="deptTree" role="tabpanel" aria-labelledby="deptTree-tab"></div>
								<div class="tab-pane fade dept-addrbook-box" id="deptAddrbook" role="tabpanel" aria-labelledby="dept-addrbook-tab"></div>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="row">
							<div class="col-md-1 row-flex">
								<div class="btn-group-vertical select-button-wrap">
									<button type="button" class="btn btn-light btn-xs select-btn">
										<ion-icon name="chevron-forward-outline"></ion-icon>
									</button>
									<button type="button" class="btn btn-light btn-xs cancel-btn">
										<ion-icon name="chevron-back-outline"></ion-icon>
									</button>
									<button type="button" class="btn btn-light btn-xs dept-reset-btn">
										<ion-icon name="reload-outline"></ion-icon>
									</button>
								</div>
							</div>
							<div class="col-md-11">
								<div class="card card-primary dept-select-box">
									<div class="card-header">
										<h3 class="card-title">선택된 부서</h3>
									</div>
									<div class="card-body dept-select-box-content">
										<ul class="list-group list-group-flush dept-select-ul"></ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
              <button type="button" class="btn btn-primary dept-tree-return-btn" data-dismiss="modal">완료</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
      <!-- /.modal-dialog -->
    </div>
    <!-- 모달 끝 -->
<!-- <script type="text/javascript" src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script> -->
<!-- <script src="/resources/jstree/dist/jstree.min.js"></script> -->
<!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
<script type="text/javascript">
var deptTree = $('.dept-chart-box');
var deptAddrTree = $('.dept-addrbook-box');
var deptSelectBox = $('.dept-select-box');
var deptSelectUl = $('.dept-select-ul');
var deptResetBtn = $('.dept-reset-btn');
var deptReturnBtn = $('.dept-tree-return-btn');
var deptShowOrgBtn = $('.dept-show-org-btn');
var deptShowAddrBtn = $('.dept-show-addr-btn');

var deptCurrentTab = deptTree;

var custId = 'cust';

$(function(){
	$(".dept-select-ul").sortable({
        placeholder: "placeholder",
        tolerance: "pointer",
        update: function(event, ui) {
          var sortedIDs = $(this).sortable("toArray");
        }
	}).disableSelection();


	$('.modal-content').draggable();

	// 조직도 가져오기
	$.ajax({
		url : "/everyware/departments",
		type: "GET",
		dataType: "json",
		success: function(rslt){
			$.each(rslt, function(i){
				var children = rslt[i].children;
				rslt[i].id = rslt[i].deptId;
				rslt[i].text = rslt[i].deptNm;
			})
			deptShowOrgTree(deptTree, rslt, 'text-info');
		}
	});

	// 선택 버튼 click
	$('.select-btn').on('click', function(){
		var clicked = deptCurrentTab[0].querySelectorAll('.jstree-clicked');

		$.each(clicked, function(i){
			var parent = clicked[i].parentNode;
			var id = clicked[i].parentNode.id;
			
			var data = deptFindMyData(id);
			var node = deptEmpDataToNode(data);
			deptSelectUl.append(node);
		});

		deptCurrentTab.jstree("deselect_all");
	});

	deptFolderTraversal = function(id){
		var datas = deptFindChildrenDatas(id);
		$.each(datas, function(i){
			if(deptCurrentTab.is(deptAddrTree) && !('empTel' in datas[i])){
				deptFolderTraversal(datas[i].id);
			} else{
				var node = deptEmpDataToNode(datas[i]);
				if (!deptSelectUl.find('[empId="' + datas[i].id + '"]').length) {
					deptSelectUl.append(node);
				}
			}
		});
	}

	$(document).on('change', '.dept-select-ul input', function(){
		var input = $(this);
		var li = input.parent('li');

		if(input.prop('checked')){
			li.addClass('selected');
		}else{
			li.removeClass('selected');
		}
    });

	$('.cancel-btn').on('click', function(){
		var selected = $('.selected');
		selected.remove();
	});

	deptResetBtn.on('click', function(){
		deptSelectUl.empty();
	});

	$(deptShowOrgBtn).on('click', function(){
		deptCurrentTab = deptTree;
	});
	
	$(deptShowAddrBtn).on('click', function(){
		deptCurrentTab = deptAddrTree;
	});

});

deptModalReturn = function(callback){
	var empNodes = $('.dept-select-ul li');
	var emps = [];

	$.each(empNodes, function(i){
		var empNode = $(empNodes[i]);

		var deptId = $(empNode).attr('deptId');
		var deptNm = $(empNode).attr('deptNm');

		emps.push({
			deptId
			,deptNm
		})
	});
	console.log(emps);

	callback(emps);
}

deptFindMyData = function(id){
	var node = deptCurrentTab.jstree().get_node(id);
	return node.original;
}

deptFindChildrenDatas = function(id){
	var ids = deptCurrentTab.jstree().get_node(id).children;
	var datas = [];
	$.each(ids, function(i){
		datas.push(deptFindMyData(ids[i]));
	});
	return datas;
}

deptEmpDataToNode = function(data){
	var node = document.createElement('li');
	$(node).addClass('list-group-item selected-emp');
	
	node.innerText = data.text;
	$(node).attr('deptId', data.id);
	$(node).attr('deptNm', data.deptNm);
	
	return node;
}
searchTree = function(){
	var word = $('.dept-search-box').val();
	deptCurrentTab.jstree(true).search(word);
}

$('.dept-search-box').on('keyup', function(){
	searchTree();
})

$('.dept-search-box').on('focus', function(){
	searchTree();
})

deptShowOrgTree = function(node, data, color){
	node.jstree({
		// 트리 설정
		'core': {
			"themes" : {
				"theme" : "default",
           		"dots" : true,
				"icon" : true
	        },
			'data': data
		},
		'checkbox': {
			'keep_selected_style': false
		},
		'types' : {
			'default' : {
				'icon' : 'fa fa-users ' + color
			}
		},
		'plugins': [
			'themes',
			'checkbox',
			// 'wholerow',
			'types',
			'search'
			],
		"search" : {
		"show_only_matches" : true,
		"show_only_matches_children" : true
		},
		'icon': function (node) {
        if (node.icon && node.icon.image) {
				return {
					'image': node.icon,
					'width': '24px',
					'height': '24px'
				};
			}
		}
	});
}
</script>
</body>
</html>