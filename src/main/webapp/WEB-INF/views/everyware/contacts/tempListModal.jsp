<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
    .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        padding-top: 200px; /* Location of the box */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: hsla(0, 0%, 100%, .8); /* Fallback color */
        background-color: hsla(0, 0%, 100%, .8); /* Black w/ opacity */
    }
    
    .modal-content {
        width: 35%;
        background-color: #fefefe;
        margin: auto;
        border: 1px solid lightgray;
        padding-top: 7px;
        padding-left: 14px;
        padding-right: 14px;
        padding-bottom: 14px;
        box-shadow: 0px 2px 2px 0px rgba(0, 0, 0, 0.2);
    }
    
    .close {
        color: #04AA6D99;
        float: right;
        font-size: 28px;
        font-weight: bold;
        opacity: 1;
    }
    
    .close:hover, .close:focus {
        color: #00894F;
        text-decoration: none;
        cursor: pointer;
    }
    
    .temp-caption {
        font-size: 1.5em;
        font-weight: 500;
        margin-left: 10px;
        margin-bottom: 5px;
    }
    
    .modal-content-container {
        margin: 35px 0px;
    }
    
    .temp-list {
        cursor: pointer;
        padding: 0px;
    }
    
    .temp-item {
        cursor: point;
        border-top: 1px solid #e3e2e2;
        padding: 17px 25px;
    }
    
    .temp-item:hover {
        background: #F6F6F6;
    }
    
    .temp_date {
        font-size: 0.9em;
        color: gray;
    }
    
    .temp-delete-btn {
        display: none;
        cursor: pointer;
        float: right;
        bottom: 19px;
        position: relative;
        color: #c5c3c3;
        font-size: 22px;
    }
    
    .temp-delete-btn:hover {
        color: gray;
    }
    
    </style>
</head>
<body>
    
<!-- 임시저장 리스트 모달 -->
<div class="temp-modal modal">
    <!-- Modal content -->
    <div class="temp-modal-content modal-content">
          <span class="close">&times;</span>
          <div class="modal-content-container">
              <span class="temp-caption">임시저장 문서</span>
              <ul class="temp-list">
                <li id="id" class="temp-item">
                    <span class="temp-title">제목</span><br>
                    <span class="temp_date">저장일시</span>
                    <span class="temp-delete-btn">
                        <i class="fa fa-trash"></i>
                    </span>
                </li>
              </ul>
          </div>
    </div>
  </div>
  <script>
$(function(){

    tempList = function(){
        $('.modal').css('display', 'block');
    }

    $('.close').on('click', function(){
        $('.modal').css('display', 'none');
    })
    
    $(document).mouseup(function (e){
        var container = $('.modal');

        if( container.has(e.target).length === 0){
            container.css('display','none');
        }
    })

    $('.temp-item').mouseover(function(){
		$('.temp-delete-btn').css('display', 'inline');
	})
	
	$('.temp-item').mouseout(function(){
		$('.temp-delete-btn').css('display', 'none');
	})
	
	$('.temp-item').on('click', function(){
		idv = $(this).attr('id');
		console.log(idv);
		
        // 리스트 가져오기
		// $.ajax({
		// 	url: `<%=request.getContextPath()%>/selectDoc.do`,
		// 	type: 'get',
		// 	data: { "id" : idv,
		// 					"isTemp" : 1 },
		// 	success: function(res){
		// 		console.log(res);
				
		// 		title = res.doc_title;
		// 		content = res.doc_content;
				
		// 		$('#doc-title').val(title);
		// 		console.log(content);
		// 		$('#summernote').summernote('pasteHTML', content);
				
		// 		$('.modal').css('display', 'none');
		// 	},
		// 	error: function(xhr){
		// 		alert('상태 : ' + xhr.status);
		// 	},
		// 	dataType: 'json'
		// })
	})
})
  </script>
</body>
</html>
