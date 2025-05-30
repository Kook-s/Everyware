<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조직도</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<link rel="stylesheet" href="../../../../resources/bootstrap/dist/css/adminlte.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/themes/default/style.min.css" />
<link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet" />
<style type="text/css">
*{
	box-sizing: border-box;
}
.contact-wrap,
.select-box{
	height: 450px;
	overflow: auto;
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
.select-box-content{
	padding: 0px !important;
	overflow-y: auto;
	overflow-x: hidden;
}
.select-ul{
	border: 1px solid rgba(0,0,0,.125);
}
.select-ul li{
	position: relative;
	height: 45px;
}
.select-ul input[type=checkbox]{
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
.search-box-wrap{
	width: 146px;
	height: 100%;
    margin-left: 60px;
    padding: 3px 0px;
}
.search-box{
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
    <div class="modal fade" id="tree-modal">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">조직도/주소록</h4>
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
									<a class="nav-link active show-org-btn" id="tree-tab" data-toggle="tab" href="#tree" role="tab" aria-controls="tree"
										aria-selected="true">조직도</a>
								</li>
								<li class="nav-item">
									<a class="nav-link show-addr-btn" id="addrbook-tab" data-toggle="tab" href="#addrbook" role="tab" aria-controls="addrbook"
										aria-selected="false">주소록</a>
								</li>
								<li class="nav-item">
									<div class="float-right search-box-wrap">
										<input type="text" class="form-control search-box" placeholder="검색" aria-label="searchWord" aria-describedby="searchWord" autofocus>
									</div>
								</li>
							</ul>
							<div class="card-body tab-content" id="myTabContent">
								<div class="tab-pane fade show active chart-box" id="tree" role="tabpanel" aria-labelledby="tree-tab"></div>
								<div class="tab-pane fade addrbook-box" id="addrbook" role="tabpanel" aria-labelledby="addrbook-tab"></div>
							</div>
	
							<!-- <div class="tree-btn-wrap">
								<button type="button" class="show-org-btn selected-tab-btn">조직도</button>
								<button type="button" class="show-addr-btn">주소록</button>
							</div>
							<div class="tree-wrap">
								<div id="tree" class="chart-box selected-tab"></div>
								<div class="addrbook-box"></div>
							</div> -->
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
									<button type="button" class="btn btn-light btn-xs reset-btn">
										<ion-icon name="reload-outline"></ion-icon>
									</button>
								</div>
							</div>
							<div class="col-md-11">
								<div class="card card-primary select-box">
									<div class="card-header">
										<h3 class="card-title">선택된 사원</h3>
									</div>
									<div class="card-body select-box-content">
										<ul class="list-group list-group-flush select-ul"></ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
              <button type="button" class="btn btn-primary tree-return-btn" data-dismiss="modal">완료</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
      <!-- /.modal-dialog -->
    </div>
    <!-- 모달 끝 -->
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<script src="/resources/jstree/dist/jstree.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
var tree = $('.chart-box');
var addrTree = $('.addrbook-box');
var selectBox = $('.select-box');
var selectUl = $('.select-ul');
var resetBtn = $('.reset-btn');
var returnBtn = $('.tree-return-btn');
var showOrgBtn = $('.show-org-btn');
var showAddrBtn = $('.show-addr-btn');
var searchBox = $('.search-box');

var currentTab = tree;

var custId = 'cust';

$(function(){
	$('#tree-modal').on('shown.bs.modal', function () {
		$('.search-box').focus();
	})
	$('#tree-modal').on('hidden.bs.modal', function () {
		$('.search-box').focus();
		$('.search-box').val('');
	})

	searchTree = function(){
		var word = $('.search-box').val();
		currentTab.jstree(true).search(word);
	}

	$('.search-box').on('keyup', function(){
		searchTree();
	})

	$('.search-box').on('focus', function(){
		searchTree();
	})

	$(".select-ul").sortable({
        placeholder: "placeholder",
        tolerance: "pointer",
        update: function(event, ui) {
          var sortedIDs = $(this).sortable("toArray");
        }
	}).disableSelection();


	$('.modal-content').draggable();

	// 조직도 가져오기
	$.ajax({
		url : "/everyware/org",
		type: "GET",
		dataType: "json",
		success: function(rslt){
			$.each(rslt, function(i){
				var children = rslt[i].children;
				rslt[i].id = rslt[i].deptId;
				rslt[i].text = rslt[i].deptNm;
				
				$.each(children, function(i){
					// 수정함
					var child = children[i];
					child.type = 'emp';
					child.text = child.empName + ' ' + child.jbgdNm;
				});
				
				delete rslt[i].deptId;
				delete rslt[i].deptNm;
			})
			showOrgTree(tree, rslt, 'text-secondary');
		}
	});

	// 주소록 가져오기
	$.ajax({
		url : "/everyware/addressbook",
		type: "GET",
		dataType: "json",
		success: function(rslt){
			var modifiedData = rslt.map(folder => mergeContacts(folder));
			showOrgTree(addrTree, modifiedData, 'text-warning');
		}
	});	// ajax 끝

	$('.select-btn').on('click', function(){
		var clicked = currentTab[0].querySelectorAll('.jstree-clicked');

		$.each(clicked, function(i){
			var parent = clicked[i].parentNode;
			var id = clicked[i].parentNode.id;
			
			var data = findMyData(id);
			if($(parent).hasClass('jstree-open')){
				return true;
			}
			if(data.type == 'emp'){
				var node = empDataToNode(data);
				if (!selectUl.find('[empId="' + data.id + '"]').length) {
					selectUl.append(node);
				}
			} else {
				var datas = findChildrenDatas(id);
				$.each(datas, function(i){
					if(currentTab.is(addrTree) && !('empTel' in datas[i])){
						folderTraversal(datas[i].id);
						return true;
					}
					var node = empDataToNode(datas[i]);
					if (!selectUl.find('[empId="' + datas[i].id + '"]').length) {
						selectUl.append(node);
					}
				});
			}
		});

		currentTab.jstree("deselect_all");
	});

	folderTraversal = function(id){
		var datas = findChildrenDatas(id);
		$.each(datas, function(i){
			if(currentTab.is(addrTree) && !('empTel' in datas[i])){
				folderTraversal(datas[i].id);
			} else{
				var node = empDataToNode(datas[i]);
				if (!selectUl.find('[empId="' + datas[i].id + '"]').length) {
					selectUl.append(node);
				}
			}
		});
	}

	$(document).on('change', '.select-ul input', function(){
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

	resetBtn.on('click', function(){
		selectUl.empty();
	});

	$(showOrgBtn).on('click', function(){
		currentTab = tree;
	});
	
	$(showAddrBtn).on('click', function(){
		currentTab = addrTree;
	});

});

modalReturn = function(callback){
	var empNodes = $('.select-ul li');
	var emps = [];

	$.each(empNodes, function(i){
		var empNode = $(empNodes[i]);

		var empId = $(empNode).attr('empid');
		var empMail = $(empNode).attr('empmail');
		var empTel = $(empNode).attr('emptel');
		var empName = $(empNode).attr('empName');
		var empProfile = $(empNode).attr('empProfile');
		var jbgdNm = $(empNode).attr('jbgdNm');
		var deptNm = $(empNode).attr('deptNm');

		emps.push({
			empId
			,empMail
			,empTel
			,empName
			,empProfile
			,jbgdNm
			,deptNm
		})
	});
	console.log(emps);

	callback(emps);
}

findMyData = function(id){
	var node = currentTab.jstree().get_node(id);
	return node.original;
}

findChildrenDatas = function(id){
	var ids = currentTab.jstree().get_node(id).children;
	var datas = [];
	$.each(ids, function(i){
		datas.push(findMyData(ids[i]));
	});
	return datas;
}

empDataToNode = function(data){
	var node = document.createElement('li');
	$(node).addClass('list-group-item selected-emp');
	
	node.innerText = data.text;
	$(node).attr('empId', data.id);
	$(node).attr('empName', data.empName);
	$(node).attr('empMail', data.empMail);
	$(node).attr('empTel', data.empTel);
	$(node).attr('empProfile', data.icon);
	$(node).attr('jbgdNm', data.jbgdNm);
	$(node).attr('deptNm', data.deptNm);
	
	var checkbox = document.createElement('input');
	$(checkbox).attr('type', 'checkbox');
	node.prepend(checkbox);



	return node;
}

mergeContacts = function (folder) {
	var { contacts, children, ...rest } = folder;
	var mergedContacts = contacts.map(({ empId, empProfile, ...contactRest }) => ({
		...contactRest,
		type: 'emp',
		id: empId,
		icon: empProfile,
		text: contactRest.empName + ' ' + contactRest.jbgdNm
	}));

	var mergedChildren = children.map(child => mergeContacts(child));

	return {
		...rest,
		children: [...mergedChildren, ...mergedContacts]
	};
}

showOrgTree = function(node, data, color){
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
				'icon' : 'fa fa-folder ' + color
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