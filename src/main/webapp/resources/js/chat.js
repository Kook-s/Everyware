/**
 * 
 */
 
 $(()=>{
	var createRoomBtn = $("#createRoomBtn")	// 프로필에서의 방생성버튼
	var createRoomBtn2= $("#create_room_btn")	//방생성 클릭 후 프로필 검색창에서의 생성버튼
	createRoomBtn.on("click",function(){
		if($("#search_list").hasClass("btnOn")){
			$("#search_list").removeClass("btnOn")
			$("#search_list").css("transform","translateY(-1000px)")
			setTimeout(() => {
				if($(".on").hasClass("on_profile_list")){
					$("#chatprofile_list").css("display","block")
				}else{
					$("#chatroom_list").css("display","block")
				}	
				$("#search_list").css("position","absolute")
			}, 150);
		}else{
			$("#search_list").addClass("btnOn")
			$("#search_list").css("transform","translateY(0px)")
			setTimeout(() => {
				$("#chatprofile_list").css("display","none")
				$("#chatroom_list").css("display","none")
				$("#search_list").css("position","static")
			}, 200);
			
		}
		resetNone()

	})
	
	$("#search_list_input").on("input",function(){
		var searchWord = $(this).val()
		
		var profiles=$("#search_list .emp_name")
		$.each(profiles,function(i,v){
			if(!v.innerText.includes(searchWord)){
				$(this).parent().fadeOut('fast')
			}else{
				$(this).parent().fadeIn("fast")
			}
		})
	})
	$("#input_search").on("input",function(){
		var searchWord = $(this).val()
		if($("#search_list").hasClass("btnOn")){
			var profiles=$("#search_list .profile_name")
    		$.each(profiles,function(i,v){
    			if(!v.innerText.includes(searchWord)){
    				$(this).parents("#search_list a").fadeOut('fast')
    			}else{
    				$(this).parents("#search_list a").fadeIn('fast')
    			}
    		})
		}else if($(".on_profile_list").hasClass("on")){
			var profiles=$("#chatprofile_list .profile_name")
    		$.each(profiles,function(i,v){
    			if(!v.innerText.includes(searchWord)){
    				$(this).parents("#chatprofile_list a").fadeOut('fast')
    			}else{
    				$(this).parents("#chatprofile_list a").fadeIn('fast')
    			}
    		})
		}else{
			var profiles=$("#chatroom_list .chatroom_name .chatroom_name_info")
    		$.each(profiles,function(i,v){
    			if(!v.innerText.includes(searchWord)){
    				$(this).parents(".chatrooms").fadeOut('fast')
    			}else{
    				$(this).parents(".chatrooms").fadeIn('fast')
    			}
    		})	
		}
	})
	
	$("#search_list").on("click",".chat_profile",function(){
		var checkFlag = $(this).siblings('input').is(':checked')
		if(checkFlag){
			$(this).siblings('input').prop('checked', false).trigger('change');
		}else{
			$(this).siblings('input').prop('checked', true).trigger('change');
		}
		
	})
	
	$("#search_list").on("change",".empcheck",function(){
		
		var id = $(this).siblings('.chat_profile').attr("id")
		var totalChecked = $(".empcheck:checked").length
		if(totalChecked==0){
			if($("#selected_search_list").length!=0){
				$("#selected_div").empty()
			}
		}else{
			if($(this).is(":checked")){
				if($("#selected_search_list").length!=0){
    				var profileImg=$("#search_list #"+id+" .profile_img").clone()
    				profileImg.addClass("added_profile_img")
    				var li = $("<li id='"+id+"'></li>")
    				var textName = $("#search_list #"+id+" .profile_name").text()
    				$(".selected_count").text(totalChecked+"명")
    				if(textName.length>3){
    					textName = textName.substr(0,3)+".."
    				}else{
    					textName = textName.substr(0,3)
    				}
    				li.append(profileImg)
    				li.append(textName)
    				$("#selected_search_list").append(li)
				}else{
	    			var ssl = $("<ul id='selected_search_list'></ul>")
	    			var createBtnAndCount= $("<div id='create_btn_and_count'></div>")
	    			var createBtn = $("<button type='button' id='create_room_btn' class='btn btn-info'>생성</button>")
	    			var count = $("<span class='selected_count'>"+totalChecked+"명</div>")
	    			var profileImg=$("#search_list #"+id+" .profile_img").clone()
	    			profileImg.addClass("added_profile_img")
    				var li = $("<li id='"+id+"'></li>")
    				var textName = $("#search_list #"+id+" .profile_name").text()
    				if(textName.length>3){
    					textName = textName.substr(0,3)+".."
    				}else{
    					textName = textName.substr(0,3)
    				}
    				li.append(profileImg)
    				li.append(textName)
	    			ssl.append(li)
	    			createBtnAndCount.append(createBtn).append(count)
	    			$("#selected_div").prepend(createBtnAndCount)
	    			$("#selected_div").prepend(ssl)
				}
			}else{
				$("#selected_search_list #"+id).remove()
				$(".selected_count").text(totalChecked+"명")
			}
			
		}
		
	})

	$(".msgBtn").on("click",function(){
		if(onMessenger){
			$("#messenger").css("display","none")
			onMessenger=false;
			if(curRoomId!=""){
				sendRoomOut(curRoomId)
				curRoomId=""
				
				$(".chatroom_header_profile").empty()
				$(".chat_list").empty()
				$(".on_profile_list").click()
			}
			
			return;
		} 
				  
				  
	
		$.ajax({
			  url: '/everyware/chat/messengerInfo',
			  method: 'get',
			  dataType: 'json',
			  beforeSend : function(xhr){
	  			  xhr.setRequestHeader(window.messengerCsrf,window.messengerCsrfToken);
	  	  	  },
			  success: function(res) {
				  // 채팅프로필 목록 넣는작업 시작
				  $("#search_list").children().not(':first').remove()
				  $("#chatprofile_list").empty()
				  $("#search_list").append($(`<div id="selected_div"></div>`))
				  $.each(res.empList,function(i,v){
				  	
						if(v.empId==window.messengerEmpId){
					  		return true;
					  	}
						var profileImg = ""
						if(v.empProfile==null){
							profileImg="/resources/img/basicProfile.png"
						}else{
							profileImg="/everyware/mypage/thumbnail?empId="+v.empId
						}
						 
		    			var search_profile =`<a  class="p-2 profile_element">
							                  <div class="d-flex chat_profile" id="${v.empId }">
							                    <img alt="Image" src="${profileImg}" class="avatar shadow profile_img">
							                    <div class="ms-3 profile_div">
							                      <h6 class="mb-0 profile_name">${v.empName }(${v.jbgdNm })</h6>
							                      <p class="text-muted text-xs mb-2"><i class="fa fa-circle offline"></i> offline</p>
							                      <span class="text-muted text-sm col-11 p-0 text-truncate d-block">${window.messengerConm} ${v.deptNm}</span>
							                    </div>
							                  </div>
							                  <input type="checkbox" class="empcheck">
							                </a>`
		    				
	
						var profile_list	=	`<a  class="p-2 profile_element">
								                  <div class="d-flex chat_profile" id="${v.empId }">
							                    <img alt="Image" src="${profileImg}" class="avatar shadow">
							                    <div class="ms-3 profile_div">
							                      <h6 class="mb-0 profile_name">${v.empName }(${v.jbgdNm })</h6>
							                      <p class="text-muted text-xs mb-2"><i class="fa fa-circle offline"></i> offline</p>
							                      <span class="text-muted text-sm col-11 p-0 text-truncate d-block">${window.messengerConm} ${v.deptNm}</span>
							                    </div>
							                  </div>
							                </a>`
	
										
		    			$("#search_list").append(search_profile)
		    			$("#chatprofile_list").append(profile_list)
			    		})
		    			// 채팅프로필 목록 넣는작업 끝
		    			// 로그인 상태 변경작업
		    			loginUsers.forEach(empId => {
							var userProfile = $("#chatprofile_list #"+empId).parent();
							$("#chatprofile_list #"+empId+" p").text("");
							$("#chatprofile_list #"+empId+" p").html(`<i class="fa fa-circle online"></i> online`)
							$("#chatprofile_list").prepend(userProfile)
						 });
						 loginUsers.forEach(empId => {
							var userProfile = $("#search_list #"+empId).parent();
							$("#search_list #"+empId+" p").text("");
							$("#search_list #"+empId+" p").html(`<i class="fa fa-circle online"></i> online`)
							$("#selected_div").after(userProfile)
						 });
		
		    			// 채팅방 목록 넣는작업 시작
		    			$("#chatroom_list").empty()
						$.each(res.chatroomList,function(i,v){
								addChatroom(v,'append');
			    		})
		    			// 채팅방 목록 넣는작업 끝
		    				
		    				
  				
				    	$("#messenger").css("display","block")
				    	onMessenger=true;

			   
  				  
			  },
			  error: function(xhr, status, error) {
			    // 요청이 실패했을 때 실행할 코드
			    console.log('요청 실패: ' + error);
			  }
		});
	})
	
	$("#chatroom_list").on("click",".chatrooms",function(){
		var roomId = $(this).attr("id")
		var profileImg=$(".chatroom_profile",this).clone().addClass("chatroom_header_profile_img")
		var chatroom_unread_count = $(".chatroom_unread_count",this)
		$.ajax({
	    	  url: '/everyware/chat/roomDetail/'+roomId,
	    	  type: 'post',
	    	  contentType: 'application/json',
	    	  beforeSend : function(xhr){
	  			  xhr.setRequestHeader(window.messengerCsrf,window.messengerCsrfToken);
	  	  	  },
	    	  success: function(res) {
	    	  	if(chatroom_unread_count.hasClass("chatroom_unread_count_active")){
	    	  		chatroom_unread_count.removeClass("chatroom_unread_count_active")
	    	  		chatroom_unread_count.text("1")
	    	  	}

	    	  
	    		$(".chat_list").empty()
	    	    res = JSON.parse(res)
	    	    var chatroomUsers=res.chatroomInfo.chatroomUsers
	    	    
	    	    //현재 누른 채팅방의 헤더에 정보넣기
	    	    	
	    	    var totalCount = res.chatroomInfo.chatroomUsers.length
	    	    var temp="("
	    	    var chatroomUsers=res.chatroomInfo.chatroomUsers
	    	    for(let i=0; i<chatroomUsers.length; i++){
	    	    	if(chatroomUsers[i].employee.empName==window.messengerEmpId){
	    	    		continue;
	    	    	}
	    	    	if(i!=0){
	    	    		temp+=", "
	    	    	}
	    	    	temp+=chatroomUsers[i].employee.empName;
	    	    }
	    	    /*
	    	    $.each(res.chatroomInfo.chatroomUsers,function(i,v){
	    	    	if(v.employee.empName==window.messengerEmpId){
	    	    		return true;
	    	    	}
	    	    	if(i!=0){
	    	    		temp+=", "
	    	    	}
	    	    	temp+=v.employee.empName;
	    	    })
	    	    */
	    	    // 위코드는 그 위의코드(일반for문)으로 변경	
	    	    if(temp.length>20){
	    	    	temp=temp.substr(0,18)+".."
	    	    }
	    	    temp+=")"
	    	    var roomName=`<div class="ms-3 chatroom_header_name" id='${roomId}'>
					<h6 class="mb-0 d-block text-white">${res.chatroomInfo.roomNm} ${temp}</h6>
					<span class="text-sm text-white opacity-8">${formatDate(res.chatroomInfo.roomCrtDt)}</span>
				 </div>`
    	
	    	    totalCountEl= $("<span style='color:white; margin-left:10px;'>"+totalCount+"</span>")
	    	    $(".chatroom_header_profile").empty()
	    	    $(".chatroom_header_profile").append(profileImg)
	    	    $(".chatroom_header_profile").append(roomName).append(totalCountEl)
	    		//현재 누른 채팅방의 헤더에 정보넣기 끝
	    		//현재 누른 채팅방에  메세지 정보넣기
	    		if(res.messageList!=null&& res.messageList.length>0){
	    			
	    			var empId = window.messengerEmpId//테스트용 현제 접속empid변수
	    			var chattingList = $(".chat_list")
	    			var date = "";
	    			$.each(res.messageList,function(i,v){
	    				var profileImg = "/everyware/mypage/thumbnail?empId="+v.employee.empId
	    				if(v.employee.empProfile==null){
	    					profileImg="/resources/img/basicProfile.png"
	    				}
	    				var dateObj=new Date(v.msgCrtDt)
	    				var dateOpt={ year: 'numeric', month: 'long', day: 'numeric', weekday: 'long' };
	    				var formattedDate = dateObj.toLocaleDateString('ko-KR', dateOpt);		// 포맷: "2023년 6월 10일 토요일"
	    				if(date!=formattedDate){
	    					date=formattedDate;
	    					var dateP = $(`<div class="col-md-12 text-center"><span class="badge text-dark chatroom_date">${formattedDate}</span></div>`)
	    					chattingList.append(dateP);
	    				}
	    				var senderId = v.employee.empId
	    				var isOtherMessage = false;
	    				if(senderId!=empId){
	    					isOtherMessage = true;
	    				}
	    			
	    				if(isOtherMessage){			//남이 보낸 메세지면(프로필 메세지 등이 왼쪽에 치우쳐야하며 순서가 프로필,메세지,읽음유무 순이여야함)
	    					var fileMessage="";
	    					if(v.msgType=='1'){
	    						fileMessage="<div class='chat_message_img'><a href='/everyware/chat/originChatImgRead/"+v.msgId+"' target='_blank'><img src='/everyware/chat/chatImgRead/"+v.msgId+"'></a></div>"
		    				}
	    					
	    					var tempCnt=0;
	    					$.each(chatroomUsers,function(j,k){
		    					if(v.msgId>k.lastReadMsgId && k.empId!=empId){
		    						tempCnt++;
		    					}
		    				})
	    					if(tempCnt==0){
	    						tempCnt=`<ion-icon name="checkmark-done-outline"></ion-icon>`
	    					}
	    					var messageTime = dateFormatTime(v.msgCrtDt)
	    					var messageContent = ""
			    			if(typeof v.msgCn!=='undefined'){
			    				messageContent=v.msgCn
				    		}
	    					
	    					var message=$(`<div class="row justify-content-start mb-4 messages" id="${v.msgId}">
	    									<div class="col-1.5 justify-content-center profile_col">
					    						<div class='row-2 chat_message_profile'><img class='chat_message_profile_img' src='${profileImg}'></div>
			    								<div class='row-2 chat_message_name'>${v.employee.empName}</div>	
											</div>
			    							<div class="col-auto custom_max_width">
												<div class="card ">
													<div class="card-body p-2">
													<p class="mb-1">
														${messageContent}
														${fileMessage}
													</p>
														<div class="d-flex align-items-center text-sm opacity-6">
														<ion-icon name="time-outline"></ion-icon> <small class="others_time">${messageTime}</small>
															 · <span class="unreadCount">${tempCnt}</span>
														</div>
													</div>
												</div>
											</div>
										</div>`)
												
	    				
		    				

		    				chattingList.append(message)
	    				}else{						//내가 보낸 메세지면(프로필 메세지 등이 오른쪽으로 치우쳐야하며 순서도 읽음유무,메세지,프로필 순이여야함)
	    											// 제일 바깥 변수명 message만 class에 my_message로 되어있고 append순서만 다를뿐 위와 같다.
	    					var fileMessage="";
	    					if(v.msgType=='1'){
	    						fileMessage="<div class='chat_message_img'><a href='/everyware/chat/originChatImgRead/"+v.msgId+"' target='_blank'><img src='/everyware/chat/chatImgRead/"+v.msgId+"'></a></div>"
		    				}
	    					
	    					var messageTime = dateFormatTime(v.msgCrtDt)
		    				var messageContent = ""
		    				if(typeof v.msgCn!=='undefined'){
		    					messageContent=v.msgCn
			    			}
	    					
	    					var tempCnt=0;
	    					$.each(chatroomUsers,function(j,k){
		    					if(v.msgId>k.lastReadMsgId && k.empId!=empId){
		    						tempCnt++;
		    					}
		    				})
	    					if(tempCnt==0){
	    						tempCnt=`<ion-icon name="checkmark-done-outline"></ion-icon>`
	    					}
	    					var message=$(`<div class="row justify-content-end text-right mb-4 messages myMessage" id="${v.msgId}">
						    					<div class="col-auto custom_max_width">
													<div class="card bg-gradient-primary text-white">
														<div class="card-body p-2">
															<p class="mb-1">
																${messageContent}
																${fileMessage}
															</p>
															<div class="d-flex align-items-center justify-content-end text-sm opacity-6">
																<span class="unreadCount">${tempCnt}</span> ·
																<ion-icon name="time-outline"></ion-icon> <small>${messageTime}</small>
															</div>
														</div>
													</div>
												</div>
												<div class="col-1.5 justify-content-center profile_col">
						    						<div class='row-2 chat_message_profile'><img class='chat_message_profile_img' src='${profileImg}'></div>
				    								<div class='row-2 chat_message_name'>${v.employee.empName}</div>	
												</div>
											</div>`)
		    											
	    											
		    				chattingList.append(message);
	    				}
	    			})
	    		}
	    		//현재 누른 채팅방에  메세지 정보넣기 끝
	    	    	
	    	    setTimeout(function() {
	    	    	 var element = document.getElementsByClassName('chat_list')[0];
					element.scrollTop = element.scrollHeight;
				}, 100);
	    	    $(".cur_chatroom").css("display","block") 
	    	  
	    	  	
	    	  	
	    	  	//안읽음 메세지가 읽었을경우 알람수정되야함
	    	  	getAlarmList(alarmCountModify)
	    	  },
	    	  error: function(xhr, status, error) {
	    	    console.log("error :"+status)
	    	  }
	    });
		
		
	})

	
	$(document).on("click","#create_room_btn",async function(){
		var selected = $("#selected_search_list li")
		var selectedList = selected.map(function() {
		    return $(this).attr('id');
		  }).get();
		selectedList.push(window.messengerEmpId)		//임시 본인아이디
		var roomName=""
		var nameRes=await showInputDialog();
		if(nameRes.isConfirmed){
			roomName=nameRes.value;
		}else{
			return;
		}
	
		var obj = {
				selectedList:selectedList,
				roomName : roomName
		}
		

	    $.ajax({
	    	  url: '/everyware/chat/chatroom/create',
	    	  type: 'post',
	    	  data: JSON.stringify(obj),
	    	  contentType: 'application/json',
	    	  beforeSend : function(xhr){
	  			  xhr.setRequestHeader(window.messengerCsrf,window.messengerCsrfToken);
	  	  	  },
	    	  success: function(res) {
	    	    if(res!=''){
	    	    	res=JSON.parse(res);
	    	    	var tmpArr=res.chatroomUsers
	    	    	for(let i=0; i<tmpArr.length; i++){
	    	    		if(typeof tmpArr[i]=='undefined'){
	    	    			continue;
	    	    		}
	    	    		if(tmpArr[i].empId==window.messengerEmpId){
	    	    			tmpArr.splice(i,1);
	    	    			break;
	    	    		}
	    	    	}
	    	    	/*
	    	    	$.each(tmpArr,function(i,v){
	    	    		if(typeof v=='undefined'){
	    	    			return true;
	    	    		}
	    	    		if(v.empId==window.messengerEmpId){
	    	    			tmpArr.splice(i,1);
	    	    			return false;
	    	    		}
	    	    	})
	    	    	*/
	    	    	// 성능때문에 그 위의코드(일반for문)으로 변경
	    	    	res.chatroomUsers=tmpArr;
	    	    	addChatroom(res,"prepend")
	    	    	$('#createRoomBtn').trigger('click');
	    	    }else{
	    	    	alertError("서버에러, 다시시도해주세요.")
	    	    }
	    	  },
	    	  error: function(xhr, status, error) {
	    	    console.log("error :"+status)
	    	  }
	    });
		
		
	})
	
	
	
	$(".chat_switch div").on("click",function(){
		$(".chat_switch div").removeClass("on");
		$(this).addClass("on")
		if($(this).text()=="프로필"){
			$("#chatroom_list").css("transform","translateX(500px)")
    		$("#chatprofile_list").css("transform","translateX(0px)")
    		setTimeout(() => {
				$("#chatroom_list").css("display","none")
				$("#chatprofile_list").css("display","block")
			},150);
		}
		else{
    		$("#chatroom_list").css("transform","translateX(0px)")
    		$("#chatprofile_list").css("transform","translateX(-500px)")
    		setTimeout(() => {
    			$("#chatprofile_list").css("display","none")	
	    		$("#chatroom_list").css("display","block")
			}, 150);
		}
		resetNone()
		if($("#search_list").hasClass("btnOn")){
			$("#search_list").removeClass("btnOn")
			$("#search_list").css("transform","translateY(-1000px)")
			setTimeout(() => {
				if($(".on").hasClass("on_profile_list")){
					$("#chatprofile_list").css("display","block")
				}else{
					$("#chatroom_list").css("display","block")
				}	
				$("#search_list").css("position","absolute")
			}, 150);
		}
	})
	
	/* $("#cur_chatroom_close_btn").on("click",function(){
		$(".cur_chatroom").css("display","none")
	})
	$(".login-link").on("click",function(){
		$("#selected_search_list").remove()
		$(".empcheck").prop("checked",false)
		$("#create_room").css("transform","translateY(-400px)")
	})
	$("#msgClose").on("click",function(){
		$("#selected_search_list").remove()
		$("#create_room").css("transform","translateY(-400px)")
		$(".cur_chatroom").css("display","none")
	}) */
	
	
	
		wsOpen();
/* 	$(document).on("click",".msgBtn",function(){
		onMessenger=true;	//메신저를 킴
	}) */
	
	$("#send_btn").on("click",function(){
		sendMessage()
	})
	$("#chatroom_list").on("click",".chatrooms",function(){
		if(curRoomId!=""){
			sendRoomOut(curRoomId);
			curRoomId = $(this).attr("id")
			sendRoomIn(curRoomId);
		}else{
			curRoomId = $(this).attr("id")
			sendRoomIn(curRoomId);
		}
		
	})
	
			// 메신저를 닫았을 때 해줘야 할 것들
			// 메신저 안 모든 css 제위치
			// onMessenger 를 false로 해줘야함
			
	$("#image_send_btn").on("click",function(){
		if($(".pre_img").css("display")=="none"){
			$("#fileSelector").remove()
			var fileSelector=`<input type="file" name="file" id="fileSelector">`
			$(".send_btn_group").append(fileSelector)
			$("#fileSelector").trigger('click')
		}else{
			selectedFileEvent="";
			$(".pre_img").css("display","none")
			$("#send_text").prop("readonly",false);
		}
		
	})
	$(".send_btn_group").on("change","#fileSelector", function(e){
		var file = e.target.files[0];
		if(isImageFile(file)){
			var reader = new FileReader();
			reader.onload = function(e){
				$(".pre_img img").attr("src",e.target.result)
				$(".pre_img").css("display","block")
			}
			reader.readAsDataURL(file);
			selectedFileEvent=e;
			$("#send_text").prop("readonly",true);
		}else{
			alertError("이미지파일이 아닙니다.")
		}
	})
})

function dateFormatTime(date){	// 오후 3:25 이런식의 포맷으로 바꿔주는 함수
	var dateString = date;

	var dateObj = new Date(dateString);

	var hours = dateObj.getHours();
	var minutes = dateObj.getMinutes();
	var amPm = hours >= 12 ? '오후' : '오전';
	hours = hours % 12;
	hours = hours ? hours : 12; // 0시를 12시로 변경

	var formattedTime = amPm + ' ' + hours + ':' + (minutes < 10 ? '0' + minutes : minutes);
	return formattedTime;
}
function resetNone(){
$(".chatrooms").css("display","flex");
$("#chatprofile_list a").css("display","block");
$("#search_list input[type=checkbox]").prop('checked', false);
$("#search_list a").css("display","block");
$("#selected_div").empty()
$("#input_search").val("");
}
 
function addChatroom(chatroomJson,opt){
	var v = chatroomJson
	var chatroomEl=""
	var users=""
	$.each(v.chatroomUsers,function(i,v){
		if(i>0){
			users+=","
		}
		users+=v.employee.empName;
	})
	 
	if(users.length>10){
		users=users.substr(0,10)+".."
	}
	var option=""	
	if(v.chatroomUsers.length==1){
		option=" chatroom_profile_only"
	}else if(v.chatroomUsers.length==2){
		option=" chatroom_profile_two"
	}else if(v.chatroomUsers.length==3){
		option=" chatroom_profile_three"
	}
	
	var unreadCount=1;
	var unreadCountOpt=""
	if(v.unreadCount!=0){
		unreadCount=v.unreadCount;
		unreadCountOpt=" chatroom_unread_count_active";
	}
	chatroomEl =`<div class="chatrooms" id="${v.roomId }">
					 <div class="chatroom_unread_count${unreadCountOpt}">${unreadCount}</div>
					 <div class="chatroom_profile${option}">`
	for(var i=0; i<v.chatroomUsers.length; i++){
		var profileImg ="/everyware/mypage/thumbnail?empId="+v.chatroomUsers[i].employee.empId
		if(v.chatroomUsers[i].employee.empProfile==null){
			profileImg="/resources/img/basicProfile.png"
		}
	
		if(i>3){
			break;
		}
		option2=""
		if(v.chatroomUsers.length==2){
			if(i==0){
				option2=" chatroom_profile_img_one"
			}else{
				option2=" chatroom_profile_img_two"
			}	
		}
		
		if(v.chatroomUsers.length==3){
			if(i==0){
				option2=" chatroom_profile_img_1"
			}else if(i==1){
				option2=" chatroom_profile_img_2"
			}else{
				option2=" chatroom_profile_img_3"
			}	
		}
		
		if(v.chatroomUsers.length>=4){
				option2=" chatroom_profile_img_four"
		}
		chatroomEl+=`<div class="chatroom_profile_element">
						<img class="chatroom_profile_img ${option2}" src="${profileImg}">
					</div>`
	}				
	var messageContent ="";
	var messageCreateDate="";
	if(v.lastMessage.msgId>0){
		if(v.lastMessage.msgType==1 || typeof v.lastMessage.msgCn =='undefined'){
			messageContent="사진"
		}else{
			messageContent = v.lastMessage.msgCn
		}
		messageContent=v.lastMessage.employee.empName+":"+messageContent
		messageCreateDate = LastDateFormat(v.lastMessage.msgCrtDt)
	}else{
		messageContent=""
	}	 
	chatroomEl +=   `</div>
						<div class="chatroom_name">
	                      <div class="chatroom_name_info">${v.roomNm }(${users })</div>
	                      <div class="chatroom_last_date">${messageCreateDate}</div>
	                      <div class="chatroom_last_message">${messageContent}</div>
	                    </div>
					</div>`


	if(opt=='prepend'){
		$("#chatroom_list").prepend(chatroomEl)
	}else if(opt=='append'){
		$("#chatroom_list").append(chatroomEl)
	}
	  
}
var selectedFileEvent="";
var curRoomId=""
var onMessenger=false; //메신저를 켠 상태인지
var loginUsers=new Set();
function wsOpen(){	
ws = new WebSocket("ws://"+location.host+"/chatting");
wsEvt();
}
function wsEvt(){
ws.onopen=function(data){
	sendState("login")
}
ws.onmessage = function(data){
	var msg = JSON.parse(data.data);
	if(msg !=null&&msg!=""){	
	console.log(msg)
		switch (msg.type) {
			case 'nl':
				msg.loginUsers.forEach(element => {
					loginUsers.add(element);
				});
				if(onMessenger){
					$.each(msg.loginUsers,function(i,v){
						var userProfile = $("#"+v).parent();
						$("#"+v+" p").text("");
						$("#"+v+" p").html(`<i class="fa fa-circle online"></i> online`)
						$("#chatprofile_list").prepend(userProfile)
					})
				}
				
			    break;
			case 'ol':
				if(msg.state=="login"){
					loginUsers.add(msg.sender)
					if(onMessenger){
						var sender = msg.sender
						var userProfile = $("#chatprofile_list #"+sender).parent();
						$("#chatprofile_list #"+sender+" p").text("");
						$("#chatprofile_list #"+sender+" p").html(`<i class="fa fa-circle online"></i> online`)
						$("#chatprofile_list").prepend(userProfile)
					}
				}else{
					loginUsers.delete(msg.sender)
					if(onMessenger){
						var sender = msg.sender
						var userProfile = $("#chatprofile_list #"+sender).parent();
						$("#chatprofile_list #"+sender+" p").text("");
						$("#chatprofile_list #"+sender+" p").html(`<i class="fa fa-circle offline"></i> offline`)
						if($("#chatprofile_list .online:last").length==0){
							$("#chatprofile_list").prepend(userProfile)
						}else{
							$("#chatprofile_list .online:last").parents(".chat_profile").parent().after(userProfile)
						}
					}
				}
			  break;
			case 'in':
				if(onMessenger){
					if(msg.room==curRoomId){
						updateReadCount(curRoomId)
					}
				}
				break;
			case '2':
				if(onMessenger){
					if(msg.room==curRoomId){
						addMessage(msg)
					}
						updateChatroomList(msg)

				}else{
					messengerAlarmProcess()
					if(!$(".dropdown_menu").hasClass("show")){
						getAlarmList(alarmCountModify)
					}else{
						getAlarmList(alarmListAdd)
					}
				}
				break;
			case '1':
				if(onMessenger){
					if(msg.room==curRoomId){
						addMessage(msg)
					}
						updateChatroomList(msg)

				}else{
					messengerAlarmProcess()
					if(!$(".dropdown_menu").hasClass("show")){
						getAlarmList(alarmCountModify)
					}else{
					getAlarmList(alarmListAdd)
					}
				}
			break;
			case 'ca':
				if(onMessenger){
					updateChatroomList(msg)
				}else{
					messengerAlarmProcess()
					if(!$(".dropdown_menu").hasClass("show")){
						getAlarmList(alarmCountModify)
					}else{
					getAlarmList(alarmListAdd)
					}
				}
				break;
			case 'cr':
				if(onMessenger){
					var tmpArr=msg.chatroom.chatroomUsers
					for(let i=0; i<tmpArr.length; i++){
	    	    		if(typeof tmpArr[i]=='undefined'){
	    	    			continue;
	    	    		}
	    	    		if(tmpArr[i].empId==window.messengerEmpId){
	    	    			tmpArr.splice(i,1);
	    	    			break;
	    	    		}
	    	    	}
	    	    	/*
					$.each(tmpArr,function(i,v){
	    	    		if(typeof v=='undefined'){
	    	    			return true;
	    	    		}
	    	    		if(v.empId==window.messengerEmpId){
	    	    			tmpArr.splice(i,1);
	    	    			return false;
	    	    		}
	    	    	})
	    	    	*/
	    	    	//성능떄문에 일반for문으로 바꿈
	    	    	msg.chatroom.chatroomUsers=tmpArr;
					addChatroom(msg.chatroom,"prepend")
				}
				break;
			case 'al':
				alarmProccess(msg)
				if(!$(".dropdown_menu").hasClass("show")){
					getAlarmList(alarmCountModify)	
				}else{
					getAlarmList(alarmListAdd)
				}
				break;
			default:
			  // expression과 일치하는 값이 없을 때의 동작
		}
	}
}
window.addEventListener('beforeunload', function() {
	sendState("logout")
})
ws.onclose=function(data){
	sendState("logout")
}
}
function sendState(state){
var uN=window.messengerEmpId	//이부분에 html에 있는 값을 가져오는게 아닌 session에서 로그인 정보를 뿌려야함
var obj={					//왜냐하면 사용자가 로그아웃이나 창을 닫았을 때 html이 먼저 바뀌거나 닫혀서 sender에 빈값이 들어감
		sender:uN,
		state: state,
		type:"l"
}
ws.send(JSON.stringify(obj));
}
function sendMessage(){
if(selectedFileEvent==""){
	var uN=window.messengerEmpId
	var msg = $("#send_text").val();
	var roomId = $(".chatroom_header_name").attr("id")
	if($(".pre_img").css("display")=="none"&&(msg==""||msg==null)){
		alertWarning("메세지를 입력해주세요.")
		return false;
	}
	if(roomId==""||roomId==null){
		return false;
	}
	var obj={
			sender:uN,
			content:msg,
			room:roomId,
			type:"2"
	}
	ws.send(JSON.stringify(obj));
	$("#send_text").val("");
}else{
	processChatImage()
}
}
function sendRoomIn(roomId){
var uN=window.messengerEmpId

if(roomId==""||roomId==null){
	return false;
}
var obj={
		sender:uN,
		room:roomId,
		type:"in"
}
ws.send(JSON.stringify(obj));
$("#send_text").val("");
}
function sendRoomOut(roomId){
var uN=window.messengerEmpId

if(roomId==""||roomId==null){
	return false;
}
var obj={
		sender:uN,
		room:roomId,
		type:"out"
}
ws.send(JSON.stringify(obj));
$("#send_text").val("");
}
function updateReadCount(curRoomId){
$.ajax({
	  url: '/everyware/chat/chatroom/unreadUpdate/'+curRoomId, 
	  method: 'post',
	  contentType: 'application/json',
	  beforeSend : function(xhr){
			  xhr.setRequestHeader(window.messengerCsrf,window.messengerCsrfToken);
	  	  },
	  success: function(res) {
	  	res = JSON.parse(res)
	  	var messages = $(".messages").get()
	  	$.each(messages.reverse(),function(i,v){
	  		v=$(v);
	  		if(v.find(".unreadCount").html()=='<ion-icon name="checkmark-done-outline"></ion-icon>'){
	  			return false;
	  		}
	  		var curMessageId = v.attr("id")
	  		var updatedCount=0;
	  		$.each(res,function(j,k){
	  			if(k.lastReadMsgId<curMessageId){
	  				updatedCount++;
	  			}
	  		})
	  		if(updatedCount==0){
	  			updatedCount=`<ion-icon name="checkmark-done-outline"></ion-icon>`
	  		}
	  		v.find(".unreadCount").html(updatedCount)
	  	})
	  },
	  error: function(xhr, status, error) {
		  alertError("에러")
	  }
});

}
function addMessage(msg){
var chattingList = $(".chat_list")
var date = $(".chatroom_date:last")
var dateObj=new Date(msg.message.msgCrtDt)
var dateOpt={ year: 'numeric', month: 'long', day: 'numeric', weekday: 'long' };
var formattedDate = dateObj.toLocaleDateString('ko-KR', dateOpt);		// 포맷: "2023년 6월 10일 토요일"
if(date==null || date.length==0 || date.text()!=formattedDate){
	var dateP = $(`<div class="col-md-12 text-center"><span class="badge text-dark chatroom_date">${formattedDate}</span></div>`)
	chattingList.append(dateP);
}

var empId = window.messengerEmpId
var isOtherMessage=true;

var profileImg = "/everyware/mypage/thumbnail?empId="+msg.employee.empId
if(profileImg==null){
	profileImg = "/resources/img/basicProfile.png"
}

if(empId == msg.sender){
	isOtherMessage = false;
}

if(isOtherMessage){			//남이 보낸 메세지면(프로필 메세지 등이 왼쪽에 치우쳐야하며 순서가 프로필,메세지,읽음유무 순이여야함)

	var tempCnt=msg.unreadCount;
	if(tempCnt==0){
		tempCnt=`<ion-icon name="checkmark-done-outline"></ion-icon>`
	}
	var fileMessage="";
	if(msg.message.msgType=='1'){
		fileMessage="<div class='chat_message_img'><a href='/everyware/chat/originChatImgRead/"+msg.message.msgId+"' target='_blank'><img src='/everyware/chat/chatImgRead/"+msg.message.msgId+"'></a></div>"
	}
	var messageTime = dateFormatTime(msg.message.msgCrtDt)
	var messageContent = ""
	if(typeof msg.content!=='undefined'){
		messageContent=msg.content
	}
	
	var message=$(`<div class="row justify-content-start mb-4 messages" id="${msg.message.msgId}">
					<div class="col-1.5 justify-content-center profile_col">
						<div class='row-2 chat_message_profile'><img class='chat_message_profile_img' src='${profileImg}'></div>
						<div class='row-2 chat_message_name'>${msg.employee.empName}</div>	
					</div>
					<div class="col-auto custom_max_width">
						<div class="card ">
							<div class="card-body p-2">
							<p class="mb-1">
								${messageContent}
								${fileMessage}
							</p>
								<div class="d-flex align-items-center text-sm opacity-6">
								<ion-icon name="time-outline"></ion-icon> <small class="others_time">${messageTime}</small>
									 · <span class="unreadCount">${tempCnt}</span>
								</div>
							</div>
						</div>
					</div>
				</div>`)
						

	

	chattingList.append(message)
}else{						//내가 보낸 메세지면(프로필 메세지 등이 오른쪽으로 치우쳐야하며 순서도 읽음유무,메세지,프로필 순이여야함)

	var tempCnt=msg.unreadCount;
	if(tempCnt==0){
		tempCnt=`<ion-icon name="checkmark-done-outline"></ion-icon>`
	}
	var fileMessage="";
	if(msg.message.msgType=='1'){
		fileMessage="<div class='chat_message_img'><a href='/everyware/chat/originChatImgRead/"+msg.message.msgId+"' target='_blank'><img src='/everyware/chat/chatImgRead/"+msg.message.msgId+"'></a></div>"
	}
	var messageTime = dateFormatTime(msg.message.msgCrtDt)
	var messageContent = ""
	if(typeof msg.content!=='undefined'){
		messageContent=msg.content
	}
	
	var message=$(`<div class="row justify-content-end text-right mb-4 messages myMessage" id="${msg.message.msgId}">
    					<div class="col-auto custom_max_width">
							<div class="card bg-gradient-primary text-white">
								<div class="card-body p-2">
									<p class="mb-1">
										${messageContent}
										${fileMessage}
									</p>
									<div class="d-flex align-items-center justify-content-end text-sm opacity-6">
										<span class="unreadCount">${tempCnt}</span> ·
										<ion-icon name="time-outline"></ion-icon> <small>${messageTime}</small>
									</div>
								</div>
							</div>
						</div>
						<div class="col-1.5 justify-content-center profile_col">
    						<div class='row-2 chat_message_profile'><img class='chat_message_profile_img' src='${profileImg}'></div>
							<div class='row-2 chat_message_name'>${msg.employee.empName}</div>	
						</div>
					</div>`)
								
							
	chattingList.append(message);
}
setTimeout(function() {
	 var element = document.getElementsByClassName('chat_list')[0];
	element.scrollTop = element.scrollHeight;
}, 50);
}

function updateChatroomList(msg){

	var chatroomEl = $(".chatrooms#"+msg.room)
	var chatroomLastMessage=$(".chatrooms#"+msg.room+" .chatroom_last_message")
	var chatroomLastDate=$(".chatrooms#"+msg.room+" .chatroom_last_date")
	
	if(chatroomEl.length){	//채팅방 목록에 채팅방이 존재하는 경우(수정)
	
		var text ="";
		text += msg.employee.empName+":"
		if(msg.content=="" || typeof msg.content=="undefined"){
			text+="사진"
		}else{
			text += msg.content;
		}
		
		if(text.length>12){
			text = text.substr(0,12)+".."
		}
		
		var date = "";
		date+=LastDateFormat(msg.message.msgCrtDt)

		
		chatroomLastMessage.text(text)
		chatroomLastDate.text(date)
		$("#chatroom_list").prepend(chatroomEl)
		
		if(msg.room!=curRoomId){
			var chatroomUnreadCount=$(".chatrooms#"+msg.room+" .chatroom_unread_count")
			
			if (!chatroomUnreadCount.hasClass("chatroom_unread_count_active")) {
				chatroomUnreadCount.addClass("chatroom_unread_count_active")
			} else {
				var count = parseInt(chatroomUnreadCount.text())+1;
				chatroomUnreadCount.text(count);
			}
			
		}
	}else{	//채팅방 목록에 채팅방이 존재하지 않는경우(상대방이 나와 채팅방을 생성후 메세지를 보냈을 때)
		
	}

}	


function processChatImage(){
	
	
	var files = selectedFileEvent.target.files;
	var file = files[0];
	
	
	if(isImageFile(file)){//이미지 파일인 경우
		//비동기 처리시, 파일데이터를 전송할 때에는 formData()를 이용하여 데이터를 전송한다.
		var uN=window.messengerEmpId
		var roomId = $(".chatroom_header_name").attr("id")
		
		var formData = new FormData();
		formData.append("file",file);
		formData.append("sender",uN)
		formData.append("roomId",roomId)
		formData.append("fileType",file.type)
		// formData는 key/value 형식으로 데이터가 저장된다.
		// datatype : 응답(response) 데이터를 내보낼 때 보내줄 데이터 타입
		// processData : 데이터 파라미터를 data라는 속성으로 넣는데, 제이쿼리 내부적으로 쿼리스트링을 구성합니다.
		//				파일 전송의 경우 쿼리스트링을 사용하지 않으므로 해당 설정을 false로 비활성화 한다.
		// contentType : content-type을 설정시, 사용하는데 해당 설정의 기본값은
		//					'application/x-www-form-urelencoded; charset=utf-8'입니다.
		//					하여, 기본값으로 나가지 않고 'multipart/form-data'로 나갈 수 있도록 설정을 false 합니다.
		//					request 요청에서 Content-type을 확인해 보면 'multipart/form-data; boundary======webkitFormBoundary[hash key]'
		//					와 같은 값으로 전송된 것을 확인할 수 있습니다.
	
		$.ajax({
			type : "post",
			url : "/everyware/chat/imageMessage",
			data : formData,
			processData : false,
			contentType : false,
			beforeSend : function(xhr){
	  			  xhr.setRequestHeader(window.messengerCsrf,window.messengerCsrfToken);
	  	  	  },
			success: function(res){
				if(res>0){
					var uN=window.messengerEmpId
					var roomId = $(".chatroom_header_name").attr("id")
	
					var obj={
							sender:uN,
							room:roomId,
							type:"1",
							messageId : res
					}
					ws.send(JSON.stringify(obj));
				}
			}
		}).always(function() {
		    // 항상 실행되는 함수
		 	selectedFileEvent="";
			$("#send_text").prop("readonly",false);
		    $(".pre_img").css("display","none");
		  });
		
	}else{				  //이미지 파일이 아닌경우
		alertError("이미지파일이 아닙니다.")
	}
}
function isImageFile(file){
	var ext = file.name.split(".").pop().toLowerCase();//파일명에서 확장자를 가져온다.
	return($.inArray(ext,["jpg","jpeg","gif","png"])===-1)?false:true;

}
function formatDate(dateString) {
  const months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  // 주어진 날짜 값을 Date 객체로 변환합니다.
  const date = new Date(dateString);

  // 날짜 값을 원하는 형식으로 포맷팅합니다.
  const formattedDate = `created on ${date.getFullYear()}.${formatNumber(date.getMonth() + 1)}.${formatNumber(date.getDate())} at ${chatFormatTime(date)}`;

  return formattedDate;
}

function chatFormatTime(date) {
  let hours = date.getHours();
  let minutes = date.getMinutes();
  let amOrPm = "AM";

  // 시간을 12시간 형식으로 변환합니다.
  if (hours >= 12) {
    amOrPm = "PM";
    hours %= 12;
  }

  // 시간과 분이 한 자리 수일 경우 앞에 0을 붙여줍니다.
  hours = hours < 10 ? `0${hours}` : hours;
  minutes = minutes < 10 ? `0${minutes}` : minutes;

  return `${hours}:${minutes} ${amOrPm}`;
}

function formatNumber(num) {
  return num < 10 ? `0${num}` : num;
}







function LastDateFormat(date){

	var date = new Date(date);


	var formattedDate =
		  ("0" + date.getFullYear()).slice(-4) + "." +
		  ("0" + (date.getMonth() + 1)).slice(-2) + "." +
		  ("0" + date.getDate()).slice(-2) + " " +
		  ("0" + date.getHours()).slice(-2) + ":" +
		  ("0" + date.getMinutes()).slice(-2) + ":" +
		  ("0" + date.getSeconds()).slice(-2) + " " +
		  (date.getHours() < 12 ? "AM" : "PM");
		  
	return formattedDate; // 예시 출력: "2시간 전"
}

function messengerAlarmProcess(){
	toastr.info("새로운 메세지가 도착하였습니다.", '', { 
		timeOut: 3000,
		onclick: function() {
		    $("#msgBtn").click();
		  } 
	});
}

function alarmProccess(msg){
	var content=""
	if(msg.alarmType==1){
		content=`${msg.sender.empName} 님으로부터 메일이 도착하였습니다.`
	}else if(msg.alarmType==2){
		content=`메일이 성공적으로 전송되었습니다.`
	}else if(msg.alarmType==7){
		content=`'${msg.sndrNm}'이 등록되었습니다.`
	}else if(msg.alarmType==8){
		content=`'${msg.sndrNm}'이 변경되었습니다.`
	}else if(msg.alarmType==9){
		content=`'${msg.sndrNm}'일정의 수행인원으로 등록 되었습니다.`
	}
	toastr.info(content, '', { 
		timeOut: 2000,
		onclick: function() {
		    window.location.href = `${msg.urlAddr}`;
		  } 
	});
}

function showInputDialog() {
  return Swal.fire({
    title: '방 제목 입력',
    input: 'text',
    inputPlaceholder: '방 제목을 입력하세요',
    showCancelButton: true,
    cancelButtonText: '취소',
    confirmButtonText: '등록',
    allowOutsideClick: false,
    customClass: {
    container: 'my-swal'
  },
    inputValidator: (value) => {
      if (!value) {
        return '방 제목을 입력하세요!';
      }
    }
  });
}

function alertError(data){
	Swal.fire({
	  title: 'Error!',
	  timer: 1000,
	  text: data,
	  icon: 'error',
	  customClass: {
    	container: 'my-swal'
  	  },
	})
}
function alertSuccess(data){
	Swal.fire({
	  title: 'Success!',
	  timer: 1000,
	  text: data,
	  icon: 'success',
	  customClass: {
    	container: 'my-swal'
  	  },
	})
}
function alertWarning(data){
	Swal.fire({
	  title: 'Warning!',
	  timer: 1000,
	  text: data,
	  icon: 'warning',
	  customClass: {
    	container: 'my-swal'
  	  },
	})
}
