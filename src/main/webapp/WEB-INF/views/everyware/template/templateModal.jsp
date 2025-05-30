<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조직도</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- <link rel="stylesheet" href="../../../../resources/bootstrap/dist/css/adminlte.min.css"> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/themes/default/style.min.css" />
<!-- <link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet" /> -->
<style type="text/css">
*{
	box-sizing: border-box;
}
.contact-wrap,
.template-select-box{
	height: 450px;
	overflow-y: auto;
	overflow-x: hidden;
}
/* li{
	list-style: none;
} */
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
.template-select-box-content{
	display: none;
	overflow-y: hidden;
	overflow-x: hidden;
}
.template-select-ul{
	border: 1px solid rgba(0,0,0,.125);
}
.template-select-ul li{
	position: relative;
	height: 45px;
}
.template-select-ul input[type=checkbox]{
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
ul{
	list-style: none;
}
.templat-preview-wrap{
	margin: 8px auto;
	border: 1px solid rgba(0, 0, 0, 0.300);
	width: 240px;
    height: 250px;
}
.template-preview{
	zoom: 0.33;
	overflow: auto;
}
</style>
</head>
<body>
    <!-- 모달 시작 -->
    <div class="modal fade" id="template-modal">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">문서양식 선택</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
				<div class="row">
					<div class="col-md-6">
						<div class="card card-light contact-wrap">
							<div class="card-header">
								<h3 class="card-title">문서양식</h3>
							</div>
							<div class="card-body">
								<div class="template-chart-box"></div>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<!-- <div class="row">
							<div class="col-md-1 row-flex">
								<div class="btn-group-vertical select-button-wrap">
									<button type="button" class="btn btn-light btn-xs select-btn">
										<ion-icon name="chevron-forward-outline"></ion-icon>
									</button>
									<button type="button" class="btn btn-light btn-xs cancel-btn">
										<ion-icon name="chevron-back-outline"></ion-icon>
									</button>
									<button type="button" class="btn btn-light btn-xs template-reset-btn">
										<ion-icon name="reload-outline"></ion-icon>
									</button>
								</div>
							</div>
							<div class="col-md-11"> -->
								<div class="card card-primary template-select-box">
									<div class="card-header">
										<h3 class="card-title">상세정보</h3>
									</div>
									<div class="card-body">
										<div class="template-select-box-content">
											<strong><i class="far fa-file-alt mr-1"></i>양식명</strong>
											<p class="text-muted template-name"></p>
											<hr>
											<span style="font-size: 13px; color:gray">미리보기</span>
											<div class="templat-preview-wrap">
												<div class="template-preview"></div>
											</div>
										</div>
									</div>
								</div>
							<!-- </div>
						</div> -->
					</div>
				</div>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
              <button type="button" class="btn btn-primary template-tree-return-btn" data-dismiss="modal">완료</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
      <!-- /.modal-dialog -->
    </div>
    <!-- 모달 끝 -->
<!-- <script type="text/javascript" src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script> -->
<script src="/resources/jstree/dist/jstree.min.js"></script>
<!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
<script type="text/javascript">
var templateTree = $('.template-chart-box');
var templateSelectBox = $('.template-select-box');
var templateSelectUl = $('.template-select-ul');
var templateResetBtn = $('.template-reset-btn');
var templateReturnBtn = $('.template-tree-return-btn');
var templateShowOrgBtn = $('.template-show-org-btn');
var templateShowAddrBtn = $('.template-show-addr-btn');

var templateCurrentTab = templateTree;

var custId = 'cust';

$(function(){
	$(".template-select-ul").sortable({
        placeholder: "placeholder",
        tolerance: "pointer",
        update: function(event, ui) {
          var sortedIDs = $(this).sortable("toArray");
        }
	}).disableSelection();

	$('.modal-content').draggable();

	// 템플릿 가져오기
	$.ajax({
		url : "/everyware/templates",
		type: "GET",
		dataType: "json",
		success: function(rslt){
			$.each(rslt, function(i){
				var children = rslt[i].templates;

				rslt[i].id = rslt[i].clsfNm;
				rslt[i].text = rslt[i].clsfNm;
				rslt[i].children = children;

				$.each(children, function(i, child){
					child.type = 'template';
					child.id = child.tmpltCd;
					child.text = child.tmpltNm;
				})
			})
			templateShowOrgTree(templateTree, rslt, 'text-warning');
		}
	});

	$('.cancel-btn').on('click', function(){
		var selected = $('.selected');
		selected.remove();
	});

	templateResetBtn.on('click', function(){
		templateSelectUl.empty();
	});

});

templateModalReturn = function(callback){
	var clickedData = templateTree.jstree('get_selected',true)[0];
	console.log(clickedData);

	callback(clickedData);
}

templateFindMyData = function(id){
	var node = templateCurrentTab.jstree().get_node(id);
	return node.original;
}

templateShowOrgTree = function(node, data, color){
	node.jstree({
		// 트리 설정
		'core': {
			"themes" : {
				"theme" : "default",
           		"dots" : true,
				"icon" : true
	        },
			'data': data,
			"multiple" : false
		},
		'checkbox': {
			'keep_selected_style': false
		},
		'types' : {
			'default' : {
				'icon' : 'fa fa-folder ' + color
			},
			'template' : {
				'icon' : 'fa fa-file text-info'
			}
		},
		'plugins': [
			// 'wholerow',
			"themes",
			'types',
			'search'
			]
	}).on("select_node.jstree",
		function(evt, data){
			var origin = data.node.original;

			if(origin.type == 'template'){
				$('.template-select-box-content').css('display', 'block');
				$('.template-name').text(origin.text);

				$.ajax({
					url: '/everyware/templates/' + origin.id,
					dataType: 'json',
					success: function(rslt){
						var content = rslt.tmpltCn;
						$('.template-preview').html(content);
					}
				})

				return true;
			}
			return false;
		}
	);
}
</script>
</body>
</html>