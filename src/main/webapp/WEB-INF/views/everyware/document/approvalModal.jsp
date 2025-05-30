<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
.approval-select-box{
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
.approval-select-box-content{
	padding: 0px;
	overflow-y: auto;
	overflow-x: hidden;
}
.approval-select-ul{
	border: 1px solid rgba(0,0,0,.125);
}
.approval-select-ul li{
	position: relative;
	height: 45px;
}
.approval-select-ul .select-box-checkbox{
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
.approval-search-box-wrap{
	width: 146px;
	height: 100%;
    margin-left: 60px;
    padding: 3px 0px;
}
.approval-search-box{
	height: 34px;
}
.jstree-default a.jstree-search{
	background-color: #007bff3d;
    color: black;
    font-style: normal;
}
.approver-select-box{
	z-index: 1;
}
.approver-switch-box{
	display: inline;
}
.approver-toggle{
	display: none !important;
}
.toggle {
	position: relative;
	display: inline-block;
	width: 46px;
	height: 16px;
	background-color: #ccc;
	border-radius: 15px;
	overflow: hidden;
	margin: 0px;
	margin-left: 6px;
	top: 2px;
}

.toggle .toggle-slider {
	position: absolute;
	top: 2px;
	left: 2px;
	width: 12px;
	height: 12px;
	background-color: #fff;
	border-radius: 50%;
	transition: transform 0.2s ease;
}

.toggle input[type="checkbox"]:checked + .toggle-slider {
	transform: translateX(30px);
}

.toggle input[type="checkbox"] {
	display: none;
}

.toggle .toggle-text {
	position: absolute;
	top: 50%;
	left: 6px;
	transform: translateY(-50%);
}

.toggle input[type="checkbox"]:checked + .toggle-slider + .toggle-text::before {
	content: "전결";
}
.toggle input[type="checkbox"]:checked .toggle {
	background-color: #007bff;
}

.toggle input[type="checkbox"]:not(:checked) + .toggle-slider + .toggle-text::before {
	content: "";
}
.toggle input[type="checkbox"]:not(:checked) .toggle {
	background-color: #ccc;
}
.toggle-text{
	font-size: 12px;
	font-weight: 500;
	color: white;
}
</style>
</head>
<body>
    <!-- 모달 시작 -->
    <div class="modal fade" id="approval-modal">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">결재선 선택</h4>

				<!-- 토글 버튼 HTML -->
  <!-- <label class="toggle">
    <input type="checkbox" id="toggleBtn">
    <span class="slider"></span>
    <span class="text" id="statusText"></span>
  </label> -->

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
									<a class="nav-link active approval-show-org-btn" id="approvalTree-tab" data-toggle="tab" href="#approvalTree" role="tab" aria-controls="approvalTree"
										aria-selected="true">조직도</a>
								</li>
								<li class="nav-item">
									<a class="nav-link approval-show-addr-btn" id="approval-addrbook-tab" data-toggle="tab" href="#approvalAddrbook" role="tab" aria-controls="approvalAddrbook"
										aria-selected="false">주소록</a>
								</li>
								<li class="nav-item">
									<div class="float-right approval-search-box-wrap">
										<input type="text" class="form-control approval-search-box" placeholder="검색" aria-label="searchWord" aria-describedby="searchWord" autofocus>
									</div>
								</li>
							</ul>
							<div class="card-body tab-content" id="myTabContent">
								<div class="tab-pane fade show active approval-chart-box" id="approvalTree" role="tabpanel" aria-labelledby="approvalTree-tab"></div>
								<div class="tab-pane fade approval-addrbook-box" id="approvalAddrbook" role="tabpanel" aria-labelledby="approval-addrbook-tab"></div>
							</div>
	
							<!-- <div class="approvalTree-btn-wrap">
								<button type="button" class="approval-show-org-btn selected-tab-btn">조직도</button>
								<button type="button" class="approval-show-addr-btn">주소록</button>
							</div>
							<div class="approvalTree-wrap">
								<div id="approvalTree" class="approval-chart-box selected-tab"></div>
								<div class="approval-addrbook-box"></div>
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
									<button type="button" class="btn btn-light btn-xs approval-reset-btn">
										<ion-icon name="reload-outline"></ion-icon>
									</button>
								</div>
							</div>
							<div class="col-md-11">
								<div class="card card-primary approval-select-box">
									<div class="card-header">
										<h3 class="card-title">선택된 사원</h3>
									</div>
									<div class="card-body approval-select-box-content">
										<ul class="list-group list-group-flush approval-select-ul"></ul>
									</div>
									<div class="card-footer">
										<span style="font-size: 13px; color: gray;">제일 상단에 선택된 사원이 최상위 결재자입니다.</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
              <button type="button" class="btn btn-primary approval-tree-return-btn" data-dismiss="modal">완료</button>
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
var approvalTree = $('.approval-chart-box');
var approvalAddrTree = $('.approval-addrbook-box');
var approvalSelectBox = $('.approval-select-box');
var approvalSelectUl = $('.approval-select-ul');
var approvalResetBtn = $('.approval-reset-btn');
var approvalReturnBtn = $('.approval-tree-return-btn');
var approvalShowOrgBtn = $('.approval-show-org-btn');
var approvalShowAddrBtn = $('.approval-show-addr-btn');

var approvalCurrentTab = approvalTree;

$(function(){
	$(document).on('change', '.toggle-btn', function(){
		var toggleBtn = this;
		var toggle = $(toggleBtn).parent('.toggle');

		if(toggleBtn.checked){
			toggleOn(toggle);
			return true;
		}else{
			toggleOff(toggle);
			return true;
		}
	})
	
	toggleOn = function(toggle){
		$(toggle).parent('.selected-emp').attr('dcrbYn', 'Y');
		toggle.css('background-color', '#007bff');
		return true;
	}
	
	toggleOff = function(toggle){
		$(toggle).parent('.selected-emp').attr('dcrbYn', 'N');
		toggle.css('background-color', '#ccc');
		return true;
	}




	$(".approval-select-ul").sortable({
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
			approvalShowOrgTree(approvalTree, rslt, 'text-secondary');
		}
	});

	// 주소록 가져오기
	$.ajax({
		url : "/everyware/addressbook",
		type: "GET",
		dataType: "json",
		success: function(rslt){
			var modifiedData = rslt.map(folder => approvalMergeContacts(folder));
			approvalShowOrgTree(approvalAddrTree, modifiedData, 'text-warning');
		}
	});	// ajax 끝

	// 선택 버튼 click
	$('.select-btn').on('click', function(){
		var clicked = approvalCurrentTab[0].querySelectorAll('.jstree-clicked');

		$.each(clicked, function(i){
			var parent = clicked[i].parentNode;
			var id = clicked[i].parentNode.id;
			
			var data = approvalFindMyData(id);
			if($(parent).hasClass('jstree-open')){
				return true;
			}
			if(data.type == 'emp'){
				var node = approvalEmpDataToNode(data);
				if (!approvalSelectUl.find('[empId="' + data.id + '"]').length) {
					approvalSelectUl.append(node);
				}
			} else {
				var datas = approvalFindChildrenDatas(id);
				$.each(datas, function(i){
					if(approvalCurrentTab.is(approvalAddrTree) && !('empTel' in datas[i])){
						approvalFolderTraversal(datas[i].id);
						return true;
					}
					var node = approvalEmpDataToNode(datas[i]);
					if (!approvalSelectUl.find('[empId="' + datas[i].id + '"]').length) {
						approvalSelectUl.append(node);
					}
				});
			}
		});
		approvalCurrentTab.jstree("deselect_all");
	});

	approvalFolderTraversal = function(id){
		var datas = approvalFindChildrenDatas(id);
		$.each(datas, function(i){
			if(approvalCurrentTab.is(approvalAddrTree) && !('empTel' in datas[i])){
				approvalFolderTraversal(datas[i].id);
			} else{
				var node = approvalEmpDataToNode(datas[i]);
				if (!approvalSelectUl.find('[empId="' + datas[i].id + '"]').length) {
					approvalSelectUl.append(node);
				}
			}
		});
	}

	$(document).on('change', '.approval-select-ul .select-box-checkbox', function(){
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

	approvalResetBtn.on('click', function(){
		approvalSelectUl.empty();
	});

	$(approvalShowOrgBtn).on('click', function(){
		approvalCurrentTab = approvalTree;
	});
	
	$(approvalShowAddrBtn).on('click', function(){
		approvalCurrentTab = approvalAddrTree;
	});

});

approvalModalReturn = function(callback){
	var empNodes = $('.approval-select-ul li');
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

		var aprvSeCd = 1;
		if(empNode.find('select').length > 0){
			var aprvSeCd = empNode.find('select').val();
		}

		var aprvOrder = i;
		var dcrbYn = $(empNode).attr('dcrbYn');
		

		emps.push({
			empId
			,empMail
			,empTel
			,empName
			,empProfile
			,jbgdNm
			,deptNm
			,aprvSeCd
			,aprvOrder
			,dcrbYn
		})
	});
	console.log(emps);

	callback(emps);
}

approvalFindMyData = function(id){
	var node = approvalCurrentTab.jstree().get_node(id);
	return node.original;
}

approvalFindChildrenDatas = function(id){
	var ids = approvalCurrentTab.jstree().get_node(id).children;
	var datas = [];
	$.each(ids, function(i){
		datas.push(approvalFindMyData(ids[i]));
	});
	return datas;
}

var agreeUseYn = '${config.agreeUseYn}';
var dcrbUseYn = '${config.dcrbUseYn}';

approvalEmpDataToNode = function(data){
	var node = document.createElement('li');
	$(node).addClass('list-group-item selected-emp');
	
	node.innerText = data.text;
	$(node).attr('empId', data.id);
	$(node).attr('empName', data.empName);
	$(node).attr('empProfile', data.icon);
	$(node).attr('jbgdNm', data.jbgdNm);
	$(node).attr('deptNm', data.deptNm);
	$(node).attr('dcrbYn', 'N');
	
	var checkbox = document.createElement('input');
	$(checkbox).attr('type', 'checkbox');
	$(checkbox).addClass('select-box-checkbox');
	
	node.prepend(checkbox);
		
	if(dcrbUseYn == 'Y'){
		var toggle = document.createElement('label');
		$(toggle).addClass('toggle');
		$(toggle).attr('value', 'Y');
	
		var toggelBtn = document.createElement('input');
		$(toggelBtn).attr('type', 'checkbox');
		$(toggelBtn).addClass('toggle-btn');
	
		var toggleSlider = document.createElement('span');
		$(toggleSlider).addClass('toggle-slider');
		
		var toggleText = document.createElement('span');
		$(toggleText).addClass('toggle-text');
	
		toggle.append(toggelBtn);
		toggle.append(toggleSlider);
		toggle.append(toggleText);
	
		node.append(toggle);
	}

	if(agreeUseYn == 'Y'){
		var selectBox = document.createElement('select');
		$(selectBox).addClass('custom-select custom-select-sm approver-select-box');
		// $(selectBox).attr('onchange', 'toggleBoxDisplay(this)');
		
		var option1 = document.createElement('option');
		$(option1).val('1');
		option1.innerText = '결재'
		
		var option2 = document.createElement('option');
		$(option2).val('3');
		option2.innerText = '합의'
		
		selectBox.append(option1);
		selectBox.append(option2);
	
		node.append(selectBox);
	}

	return node;
}

// toggleBoxDisplay = function(pthis){
// 	console.log($(pthis).val());
// }

$(document).on('change', '.approver-select-box', function(){
	var value = $(this).val();
	var toggle = $(this).prev('.toggle');
	var toggleBtn = toggle.find('.toggle-btn');

	$(toggleBtn).prop('checked', false);
	toggleOff(toggle);

	if(value == '1'){
		$(toggle).css('display', 'inline-block');
		return true;
	}else{
		$(toggle).css('display', 'none');
		return true;
	}
})


approvalMergeContacts = function (folder) {
	var { contacts, children, ...rest } = folder;
	var mergedContacts = contacts.map(({ empId, empProfile, ...contactRest }) => ({
		...contactRest,
		type: 'emp',
		id: empId,
		icon: empProfile,
		text: contactRest.empName + ' ' + contactRest.jbgdNm
	}));

	var mergedChildren = children.map(child => approvalMergeContacts(child));

	return {
		...rest,
		children: [...mergedChildren, ...mergedContacts]
	};
}
approvalSearchTree = function(){
	var word = $('.approval-search-box').val();
	approvalCurrentTab.jstree(true).search(word);
}

$('.approval-search-box').on('keyup', function(){
	approvalSearchTree();
})

$('.approval-search-box').on('focus', function(){
	approvalSearchTree();
})

approvalShowOrgTree = function(node, data, color){
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