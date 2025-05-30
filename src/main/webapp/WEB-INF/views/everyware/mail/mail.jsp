<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>

.tagify{    
  width: 100%;
  max-width: 700px;
  background: rgba(white, .8);
}

/* Suggestions items */
.tagify__dropdown.users-list .tagify__dropdown__item{
    padding: .5em .7em;
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 0 1em;
    grid-template-areas: "avatar name"
                         "avatar email";
}
.download_btn{
	float: right;
}

.tagify__dropdown.users-list .tagify__dropdown__item:hover .tagify__dropdown__item__avatar-wrap{
    transform: scale(1.2);
}

.tagify__dropdown.users-list .tagify__dropdown__item__avatar-wrap{
    grid-area: avatar;
    width: 36px;
    height: 36px;
    border-radius: 50%;
    overflow: hidden;
    background: #EEE;
    transition: .1s ease-out;
}

.tagify__dropdown.users-list img{
    width: 100%;
    vertical-align: top;
}

.tagify__dropdown.users-list strong{
    grid-area: name;
    width: 100%;
    align-self: center;
}

.tagify__dropdown.users-list span{
    grid-area: email;
    width: 100%;
    font-size: .9em;
    opacity: .6;
}

.tagify__dropdown.users-list .tagify__dropdown__item__addAll{
    border-bottom: 1px solid #DDD;
    gap: 0;
}

.customActive{
	background: #e6f3ff;
}

/* Tags items */
.tagify__tag{
    white-space: nowrap;
}

.tagify__tag:hover .tagify__tag__avatar-wrap{
    transform: scale(1.6) translateX(-10%);
}

.tagify__tag .tagify__tag__avatar-wrap{
    width: 16px;
    height: 16px;
    white-space: normal;
    border-radius: 50%;
    background: silver;
    margin:5px 0;
    margin-right: 5px;
    transition: .12s ease-out;
}

.tagify__tag img{
    width: 100%;
    vertical-align: top;
    pointer-events: none;
}
#mail_nav{
	display: flex;
	width: 100%;
	margin: 0;
	padding: 15px 0;
	list-style: none;
	justify-content: space-around;
}
#mail_nav li{
	display: flex;
	flex-direction: column;
	text-align: center;
	width: 100%
}
.control_menus{
	display: flex;
	width: 100%;
	margin-left: 10px;
	margin-bottom:0;
	padding: 0;
	list-style: none;
	justify-content: flex-start;
}
.control_menus li{
	margin: 0 5px;
}
.control_menus li button{
	background: none;
	padding: 5px 5px;
}
.nav_name{
	font-size: 12px
}
.nav_icon{
	font-size: 22px
}
.nav_icon ion-icon{
	width: 30px;
    font-size: 30px;
}
#mail_unread_count{
	height: 38px;
}
.mail_menu_item li{
	padding: 5px 0;
}
.mail_menu_item ion-icon{
	font-size: 28px
}
.icon_name{
	display: flex;
}
.mail_menu_item .nav-link{
	display: flex;
    justify-content: space-between;
}
#total_count{
	font-size: 12px;
	color: gray;
}
.checkAllDiv{
	margin-left:4px;
}
.mail-unread{
	color: mediumaquamarine;   
}
.mailbox-star, .mailbox-attachment,.mailbox-isread{
	font-size:25px;
}
.important-yes{
	color: mediumaquamarine;
}
.mail-write-form{
	display: none;
}
#mail-write-form{
	display: none;
}
.files{
	display: none;
}
#files{
	display: none;
}
#selected_files_list{
	width: 100%;
	font-size: 13px;
}
.selected_files_list_container{
	height: 130px;
	overflow: scroll;
	overflow-x: hidden;
	border: 1px solid gray;
}
.mail_menu_item .active{
	background: #e6f3ff
}
.mail_profile_img{
	width: 40px;
	height: 40px;
	border-radius: 100%;
	margin-right: 5px;
}
.mail_detail{
	display: none;
}
#mail_detail{
	display: none;
}
.customcard-tools{
	float: left;
}
.customcard-header{
	padding-left: 0;
}
.customcard-header h3{
	margin: 2px;
}
.control_menus button:hover{
	border: 1px solid gray;
	
}
.control_menus button{
	border: 1px solid white;
}
.mailbox-read-info .col-2{
	padding-left: 40px;
}
.mailbox-read-info{
	padding-left: 20px;
}
.title_row h2{
	margin: 15px 0;
}
.detail_title h2{
	margin: 0;
}
.detail_profile_img{
	width: 30px;
    height: 30px;
    border-radius: 100%;
    display: inline-block;
    top: -1px;
    position: relative;
        margin-right: 5px;
}
.detail_receiver,.detail_sender{
	display: inline-block;
	margin: 0 8px;
}
#mail_list_content .form-check-input{
	transform : scale(1.5);
}
#mail_list_content .form-check{
	padding-left: 25px;
}
#mail_list_content .form-check-label{
	margin-bottom: 10px
}
.detail_title{
	margin: 5px;
    margin-top: 20px;
    margin-bottom: 0;
}
.detail_sender_div,.detail_receiver_div,.attach_div{
	padding-left: 10px;
	margin: 3px 0;
}
.attach_div label{
	padding-left: 50px;
}
.detail_sender_div label{
	padding-left: 50px;
}
.detail_receiver_div label{
	padding-left: 50px;
}
.mail_detail_date{
	margin-bottom: 15px;
}
.mailbox-read-message{
	min-height: 250px;
	padding: 2rem!important;
}
.file_div_container label{
    padding-left: 67px;
}
.file_thumb{
	width: 28px;
    height: 28px;
    border-radius: 5px;
    display: inline-block;
}
.thumb_div{
	width: 28px;
	height: 28px;
	display: inline-block;
	text-align: center;
	border-radius: 5px;
	background: gainsboro;
}
.thumb_container{
	margin: 5px 0;
}
.reply_list_div{
    padding: 40px 5%;
}
.detail_file_div{
	border: 1px solid gainsboro;
    padding: 5px 20px;
}
.sender_profile_div{
	padding-top: calc(0.375rem + 1px);
    padding-bottom: calc(0.375rem + 1px);
    padding-left: 0;
}
.receiver_profile_div{
	padding-top: calc(0.375rem + 1px);
    padding-bottom: calc(0.375rem + 1px);
    padding-left: 0;
}
.curMail{
	background: #e6f3ff;
}
li:has(.trash),li:has(.trash),li:has(.default){
	display: none;
}
li:has(.default){
	display: block;
}
.mailbox-name{
	display: flex;
}
.mailbox-date{
	padding: 21px 0!important;
}
.list_profile_mail{
	color: gray;
	font-size: 12px;
	text-align: center;
}
.reply_list_div .mailbox-date{
	font-size: 13px;
}
.mail_left{
	height: 975px;
}
.tag_container{
	padding: 2px 10px!important;
}
.fileRemoveBtn{
	padding: 0 5px;
    background: none;
    border:1px solid white;
    border-radius: 4px;
}
.fileRemoveBtn:hover{
	border:1px solid rgba(0,0,0,0.1)
}
#selected_files_list_table_head{
	border-bottom: 1px solid gray;
}
#bookmarkSort{
	cursor: pointer;
}
#bookmarkSort:hover, #attachmentSort:hover,.mailbox-subject:hover,.mailbox-name:hover{
	color: #007bff;
}
.mail-important:hover{
	color: mediumaquamarine;
}
#attachmentSort{
	cursor: pointer;
}
.mail-important,.mailbox-subject,.mailbox-name{
	cursor: pointer;
}
.mail_container{
	color: gray;
    font-size: 12px;
    line-height: 1;
}
.mail_flex{
	display: flex;
}
.name_container{
	line-height: 1.1;
}
</style>
<section class="content-header">
   <div class="container-fluid">
       <div class="row mb-2">
           <div class="col-sm-6">
               <h1>메일</h1>
           </div>
           <div class="col-sm-6">
               <ol class="breadcrumb float-sm-right">
                   <li class="breadcrumb-item"><a href="#">Home</a></li>
                   <li class="breadcrumb-item active">메일</li>
               </ol>
           </div>
       </div>
   </div><!-- /.container-fluid -->
</section>
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-2 mail_left">
          <a href="#" id="writeBtn" class="btn btn-primary btn-block mb-3">메일쓰기</a>
          
          <div class="card">
            <div class="card-header">
              <h3 class="card-title">메일함</h3>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="card-body p-0">
              <ul class="nav nav-pills flex-column">
                <li class="nav-item">
                	<ul id="mail_nav" class="small_menu_ul">
					  	<li>
					  		<span class="nav_icon" id="mail_unread_count"></span>
					  		<span class="nav_name">안읽음</span>
					  	</li>
					  	<li id="bookmarkSort">
					  		<span class="nav_icon" id="star"><ion-icon name="star-outline"></ion-icon></span>
					  		<span class="nav_name">중요</span>
					  	</li>
					  	<li id="attachmentSort">
					  		<span class="nav_icon" id="attach"><ion-icon name="attach-outline"></ion-icon></span>
					  		<span class="nav_name">첨부</span>
					  	</li>
					  </ul>
                </li>
              </ul>
            </div>
            <!-- /.card-body -->
          </div>
          <div class="card">
            <div class="card-header">
              <h3 class="card-title">메일함</h3>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="card-body p-0">
              <ul class="nav nav-pills flex-column mail_menu_item">
              	<li class="nav-item active">
                  <a href="#" class="nav-link">
                  	<div class="icon_name">
                  		 <ion-icon name="mail-outline"></ion-icon> <span>전체메일</span>
                  	</div>
                  	<div class="mail_count allTotal">
                    	<span class="badge bg-primary float-right"></span>
                    </div>
                  </a>
                </li>
                <li class="nav-item">
                  <a href="#" class="nav-link">
                    <div class="icon_name">
                      <ion-icon name="file-tray-outline"></ion-icon><span>받은메일함</span>
                    </div>
                    <div class="mail_count receiveTotal">
                    	<span class="badge bg-primary float-right"></span>
                    </div>
                  </a>
                </li>
                <li class="nav-item">
                  <a href="#" class="nav-link">
                    <div class="icon_name">
                      <ion-icon name="send-outline"></ion-icon> <span>보낸메일함</span>
                    </div>
                    <div class="mail_count sendTotal">
                    	<span class="badge bg-primary float-right"></span>
                    </div>
                  </a>
                </li>
                <li class="nav-item">
                  <a href="#" class="nav-link">
                    <div class="icon_name">
                      <ion-icon name="document-outline"></ion-icon> <span>임시보관함</span>
                  	</div>
                  	<div class="mail_count tempTotal">
                    	<span class="badge bg-primary float-right"></span>
                    </div>
                  </a>
                </li>
                <li class="nav-item">
                  <a href="#" class="nav-link">
                    <div class="icon_name">
                      <ion-icon name="trash-outline"></ion-icon> <span>휴지통</span>
                    </div>
                    <div class="mail_count trashTotal">
                    	<span class="badge bg-warning float-right">65</span>
                    </div>                  
                  </a>
                </li>
              </ul>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
          <!-- /.card -->
        </div>
        <!-- /.col -->
        <div class="col-md-10">
          <div class="card card-primary card-outline mail_box">
            <div class="card-header right_section">
              <h3 class="card-title"><span id="mailbox_title">전체메일</span> <span id="total_count">전체 35/1263</span></h3>
			 
              <div class="card-tools">
                <div class="input-group input-group-sm">
                  <input type="text" class="form-control" id="searchInput" placeholder="Search Mail">
                  <div class="input-group-append">
                    <div class="btn btn-primary" id="searchBtn">
                      <i class="fas fa-search"></i>
                    </div>
                  </div>
                </div>
              </div>
              <!-- /.card-tools -->
            </div>
            <!-- /.card-header -->
            <div class="card-body p-0">
              <div class="mailbox-controls top_controls">
                <ul class="control_menus">
                	<li>
                	  <div class="icheck-primary checkAllDiv default temp trash">
                        <input type="checkbox" value="" id="checkAll">
                        <label for="checkAll"></label>
                      </div>
                	</li>
                	<li>
                		<div class="btn-group">
                			<button class="btn default trash checked_read_btn" disabled="disabled">읽음</button>
                		</div>
                		
                	</li>
                	<li>
                		<div class="btn-group">
                			<button class="btn default checked_reply_btn" disabled="disabled">답장</button>
                		</div>
                	</li>
                	<li>
                		<div class="btn-group">
                			<button class="btn trash checked_retrieve_btn" disabled="disabled">복원</button>
                		</div>
                	</li>
                	<li>
                		<div class="btn-group">
                			<button class="btn trash checked_delete_btn" disabled="disabled">영구삭제</button>
                		</div>
                	</li>
                	<li>
                		<div class="btn-group">
                			<button class="btn default temp checked_remove_btn" disabled="disabled">삭제</button>
                		</div>
                	</li>
                	<li>
                		<div class="btn-group">
                			<button class="btn default temp checked_resend_btn" disabled="disabled">전달</button>
                		</div>
                	</li>
                	<li>
                		<div class="btn-group">
					      <button type="button"  class="btn dropdown-toggle default temp trash" data-toggle="dropdown">
					        	더보기 
					      </button>
					      <div class="dropdown-menu">
					        <a class="dropdown-item" href="#">Link 1</a>
					        <a class="dropdown-item" href="#">Link 2</a>
					        <a class="dropdown-item" href="#">Link 3</a>
					      </div>
					    </div>
                	</li>
                	<li>
                		<div class="btn-group">
					      <button type="button" class="btn dropdown-toggle default temp trash" data-toggle="dropdown">
					        	정렬
					      </button>
					      <div class="dropdown-menu orderBtn">
					        <a class="dropdown-item active" href="#">최신순</a>
					        <a class="dropdown-item" href="#">오래된순</a>
					      </div>
					    </div>
                	</li>
                </ul>
              </div>
              <div class="table-responsive mailbox-messages">
                <table class="table table-hover table-striped">
                  <tbody id="mail_list_content">
                  
                  </tbody>
                </table>
                <!-- /.table -->
              </div>
              <!-- /.mail-box-messages -->
            </div>
            <!-- /.card-body -->
            <div class="card-footer p-0">
              <div class="mailbox-controls mail_pagination">
                
                 
                <!-- /.float-right -->
              </div>
            </div>
          </div>
          <!-- /.card -->
          
          
          
          
          
          
          
          
          
          
              <div class="card card-primary card-outline mail-write-form" id="mail-write-form">
		<div class="card-header">
		<h3 class="card-title">Compose New Message</h3>
		</div>
		
		<div class="card-body">
		<div id="reply_on">
		</div>
		<div class="form-group row">
		  <label for="mail_write_title" class="col-sm-2 col-form-label">제목 </label>
		  <div class="col-sm-10">
		    <input type="text" class="form-control" id="mail_write_title" placeholder="title:">
		  </div>
		</div>
		<div class="form-group row">
		  <label for="mail_write_to" class="col-sm-2 col-form-label">받는이 </label>
		  <div class="input-group col-sm-10">
		  	<input name='users-list-tags' id="mail_write_to">
		  	<div>
		    <button class="btn btn-outline-secondary" type="button" data-toggle="modal" data-target="#tree-modal" id="address_book_btn">주소록</button>
		    </div>
		  </div>
		</div>
		<div class="form-group row">
		  <label for="mail_write_title" class="col-sm-2 col-form-label">파일첨부 </label>
		  <div class="col-sm-10 fileDiv" >
			  <div class="col-sm-10 selected_files_list_container">
			    	<table id="selected_files_list"></table>
			  </div>
			  <button class="btn btn-outline-secondary" id="attachBtn" type="button"><i class="fas fa-paperclip"></i> Attachment</button>
			  <input type="file" class="form-control files" id="files" multiple>
			</div>
		</div>
		<div class="form-group">
		
		<textarea id="mail_write_content"></textarea>
		</div>
		
		<div class="card-footer">
		<div class="float-right">
		<button type="button" class="btn btn-default" id="draft_btn"><i class="fas fa-pencil-alt"></i> Draft</button>
		<button type="button" id="mail_send_btn" class="btn btn-primary"><i class="far fa-envelope"></i> Send</button>
		</div>
		<button type="reset" class="btn btn-default" id="discard_btn"><i class="fas fa-times"></i> Discard</button>
		</div>
		
		</div>
        </div>
        <!-- /.col -->
        
        
        
        
        
        
        
        
        <div class="card card-primary card-outline mail_detail" id="mail_detail">
            <div class="card-header customcard-header">
              <div class="customcard-tools">
                <a href="#" class="btn btn-tool" title="Previous" id="pre_btn"><i class="fas fa-chevron-left"></i></a>
              </div>
              <h3 class="card-title">Read Mail</h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body p-0">
            <!-- /.mailbox-read-info -->
              <div class="mailbox-controls with-border text-center">
                 <ul class="control_menus detail_small_menu">
                	<li>
                		<div class="btn-group">
                			<button class="btn detail_reply_btn">답장</button>
                		</div>
                	</li>
                	<li>
                		<div class="btn-group">
                			<button class="btn detail_resend_btn">전달</button>
                		</div>
                	</li>
                	<li>
                		<div class="btn-group">
                			<button class="btn detail_remove_btn">삭제</button>
                		</div>
                	</li>
                </ul>
              </div>
              <div class="mailbox-read-info card">
              <div class="d-flex flex-row detail_title">
                  <h2>템플릿 건들기 쉽쥬</h2>
              </div>
              <div class="mail_detail_date">
                <div class="btn btn-tool">
                  <h8>2023년 7일 15월 (화) 오전 12시 25분</h8>
                </div>
			  </div>
			  <div class="row detail_sender_div">
				  <label for="sender_profile_div" class="col-sm-2 col-form-label">보낸사람 </label>
				  <div class="bg-gradient rounded-pill col-10 sender_profile_div" id="sender_profile_div" style="">
                   <div class="detail_sender"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
                </div>
			  </div>
              <div class="row detail_receiver_div">
				  <label for="receiver_profile_div" class="col-sm-2 col-form-label">받은사람 </label>
				  <div class="bg-gradient rounded-pill col-10 receiver_profile_div" id="receiver_profile_div" style="">
                  <div class="detail_receiver"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
			        <div class="detail_receiver"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
			        <div class="detail_receiver"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
			        <div class="detail_receiver"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
			        <div class="detail_receiver"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
			        <div class="detail_receiver"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
			        <div class="detail_receiver"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
			        <div class="detail_receiver"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
			        <div class="detail_receiver"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
			        <div class="detail_receiver"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
			        <div class="detail_receiver"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
			        <div class="detail_receiver"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
			        <div class="detail_receiver"><img src='/resources/img/메일.png' class="detail_profile_img">가나다</div>
                </div>
			  </div>
			  
              
              
              <div class="row file_div_container">
				  <label for="detail_file_div" class="col-sm-2 col-form-label">파일첨부 </label>
				  <div class="col-sm-10 detail_file_div">
					  <div class="col-sm-10">
					    	<table id="detail_file_list"></table>
					  </div>
					</div>
				</div>
			  </div>
              <!-- /.mailbox-controls -->
              <div class="mailbox-read-message">
                <p>Hello John,</p>

                <p>Keffiyeh blog actually fashion axe vegan, irony biodiesel. Cold-pressed hoodie chillwave put a bird
                  on it aesthetic, bitters brunch meggings vegan iPhone. Dreamcatcher vegan scenester mlkshk. Ethical
                  master cleanse Bushwick, occupy Thundercats banjo cliche ennui farm-to-table mlkshk fanny pack
                  gluten-free. Marfa butcher vegan quinoa, bicycle rights disrupt tofu scenester chillwave 3 wolf moon
                  asymmetrical taxidermy pour-over. Quinoa tote bag fashion axe, Godard disrupt migas church-key tofu
                  blog locavore. Thundercats cronut polaroid Neutra tousled, meh food truck selfies narwhal American
                  Apparel.</p>

                <p>Raw denim McSweeney's bicycle rights, iPhone trust fund quinoa Neutra VHS kale chips vegan PBR&amp;B
                  literally Thundercats +1. Forage tilde four dollar toast, banjo health goth paleo butcher. Four dollar
                  toast Brooklyn pour-over American Apparel sustainable, lumbersexual listicle gluten-free health goth
                  umami hoodie. Synth Echo Park bicycle rights DIY farm-to-table, retro kogi sriracha dreamcatcher PBR&amp;B
                  flannel hashtag irony Wes Anderson. Lumbersexual Williamsburg Helvetica next level. Cold-pressed
                  slow-carb pop-up normcore Thundercats Portland, cardigan literally meditation lumbersexual crucifix.
                  Wayfarers raw denim paleo Bushwick, keytar Helvetica scenester keffiyeh 8-bit irony mumblecore
                  whatever viral Truffaut.</p>

                <p>Post-ironic shabby chic VHS, Marfa keytar flannel lomo try-hard keffiyeh cray. Actually fap fanny
                  pack yr artisan trust fund. High Life dreamcatcher church-key gentrify. Tumblr stumptown four dollar
                  toast vinyl, cold-pressed try-hard blog authentic keffiyeh Helvetica lo-fi tilde Intelligentsia. Lomo
                  locavore salvia bespoke, twee fixie paleo cliche brunch Schlitz blog McSweeney's messenger bag swag
                  slow-carb. Odd Future photo booth pork belly, you probably haven't heard of them actually tofu ennui
                  keffiyeh lo-fi Truffaut health goth. Narwhal sustainable retro disrupt.</p>

                <p>Skateboard artisan letterpress before they sold out High Life messenger bag. Bitters chambray
                  leggings listicle, drinking vinegar chillwave synth. Fanny pack hoodie American Apparel twee. American
                  Apparel PBR listicle, salvia aesthetic occupy sustainable Neutra kogi. Organic synth Tumblr viral
                  plaid, shabby chic single-origin coffee Etsy 3 wolf moon slow-carb Schlitz roof party tousled squid
                  vinyl. Readymade next level literally trust fund. Distillery master cleanse migas, Vice sriracha
                  flannel chambray chia cronut.</p>

                <p>Thanks,<br>Jane</p>
              </div>
              <div class="reply_list_div">
              </div>
              <!-- /.mailbox-read-message -->
            </div>
            <!-- /.card-body -->
            <div class="card-footer bg-white">
              <ul class="mailbox-attachments d-flex align-items-stretch clearfix">
                <li>
                  <span class="mailbox-attachment-icon"><i class="far fa-file-pdf"></i></span>

                  <div class="mailbox-attachment-info">
                    <a href="#" class="mailbox-attachment-name"><i class="fas fa-paperclip"></i> Sep2014-report.pdf</a>
                        <span class="mailbox-attachment-size clearfix mt-1">
                          <span>1,245 KB</span>
                          <a href="#" class="btn btn-default btn-sm float-right"><i class="fas fa-cloud-download-alt"></i></a>
                        </span>
                  </div>
                </li>
                <li>
                  <span class="mailbox-attachment-icon"><i class="far fa-file-word"></i></span>

                  <div class="mailbox-attachment-info">
                    <a href="#" class="mailbox-attachment-name"><i class="fas fa-paperclip"></i> App Description.docx</a>
                        <span class="mailbox-attachment-size clearfix mt-1">
                          <span>1,245 KB</span>
                          <a href="#" class="btn btn-default btn-sm float-right"><i class="fas fa-cloud-download-alt"></i></a>
                        </span>
                  </div>
                </li>
                <li>
                  <span class="mailbox-attachment-icon has-img"><img src="../../dist/img/photo1.png" alt="Attachment"></span>

                  <div class="mailbox-attachment-info">
                    <a href="#" class="mailbox-attachment-name"><i class="fas fa-camera"></i> photo1.png</a>
                        <span class="mailbox-attachment-size clearfix mt-1">
                          <span>2.67 MB</span>
                          <a href="#" class="btn btn-default btn-sm float-right"><i class="fas fa-cloud-download-alt"></i></a>
                        </span>
                  </div>
                </li>
                <li>
                  <span class="mailbox-attachment-icon has-img"><img src="../../dist/img/photo2.png" alt="Attachment"></span>

                  <div class="mailbox-attachment-info">
                    <a href="#" class="mailbox-attachment-name"><i class="fas fa-camera"></i> photo2.png</a>
                        <span class="mailbox-attachment-size clearfix mt-1">
                          <span>1.9 MB</span>
                          <a href="#" class="btn btn-default btn-sm float-right"><i class="fas fa-cloud-download-alt"></i></a>
                        </span>
                  </div>
                </li>
              </ul>
            </div>
            <!-- /.card-footer -->
            <div class="card-footer">
              <div class="float-right">
                <button type="button" class="btn btn-default detail_reply_btn"><i class="fas fa-reply"></i> Reply</button>
                <button type="button" class="btn btn-default detail_resend_btn"><i class="fas fa-share"></i> Forward</button>
              </div>
              <button type="button" class="btn btn-default detail_remove_btn"><i class="far fa-trash-alt"></i> Delete</button>
            </div>
            <!-- /.card-footer -->
          </div>
        
        
        
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
    
    <%@ include file="../contacts/contactModal.jsp" %>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    <sec:authentication var="empId" property="principal.employee.empId"/>
<script src="/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@yaireo/tagify"></script>
<script src="https://cdn.jsdelivr.net/npm/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />
<script src="/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
window.toInput = document.querySelector('#mail_write_to');
$(()=>{
	var totalPage=1;
	var page=1;
	var searchKeyword=""
	var menuName = "전체메일"
	var isLately="최신순"
	var bookMark=false
	var attachment=false
	const writeBtn = $("#writeBtn")
	
	const addressBookBtn=$("#address_book_btn")
	
	const mail_send_btn = $("#mail_send_btn")
	const draftBtn = $("#draft_btn")
	const discardBtn = $("#discard_btn")
	
	const attachBtn = $("#attachBtn")
	const detailReplyBtn = $(".detail_reply_btn");
	const detailRemoveBtn = $(".detail_remove_btn");
	const detailResendBtn = $(".detail_resend_btn");
	
	const checkedReadBtn = $(".checked_read_btn");
	const checkedReplyBtn = $(".checked_reply_btn");
	const checkedRemoveBtn = $(".checked_remove_btn");
	const checkedResendBtn = $(".checked_resend_btn");
	const checkedRetrieveBtn = $(".checked_retrieve_btn")
	const checkedDeleteBtn = $(".checked_delete_btn")
    
	const fileRemoveBtn = $(".fileRemoveBtn")
	
	const fileInput = $(".files")
	const selectedFileListEl = $("#selected_files_list")
	var selectedFileList=[];
	var fileInfoList=[];
	var menuFlag=true;
	var writeFlag=false;
	var detailFlag=false;
	var replyEmpObj=null;
	var replyFlag=false
	var replyEmlId=null;
	
	getMailList("전체메일",page,searchKeyword,isLately,bookMark,attachment,mailboxFill)
	
	
	
	
	
	
	
	
	
	
	
	
	$('.tree-return-btn').on("click",function(){
		modalReturn(function(data){
			console.log(data)
			var fList=[]
			$.each(data,function(i,v){
				if(v.empId=="${empId}"){
					return true;
				}
				var profile ="/resources/img/basicProfile.png"
				if(v.empProfile!=null){
					profile = "/everyware/mypage/thumbnail?empId="+v.empId
				}
					var obj = {
							"value": v.empId,
							"name" : v.empName,
							"jbgdNm":v.jbgdNm,
							"deptNm":v.deptNm,
							"avatar":profile,
							"email":v.empMail
					}
					fList.push(obj)
			})
			console.log(fList)
			tagify.addTags(fList)
			
		});
	})
	
	
	
	
	
	detailResendBtn.on("click",function(){
		var emlId=$(".mailbox-read-info").attr("id")
		
		
		mailWriteForm();
		getDetail(emlId,function(response){
			
			var receiveList=""
			
			$.each(response.receiver,function(i,v){
				if((i+1)%5==0){
					receiveList+="\n"
				}
				if(i>0){
					receiveList+=", "
				}
				receiveList+=v.empName+`<\${v.empMail}>`
			})
			
			var date = dateFormat2(response.emlSndngDt)
			
			var originMessage=""
			var title=""
			if(menuName=="임시보관함"){
				originMessage += response.emlCn
				title=response.emlTtl
			}else{
				originMessage  = `-----Original Message-----<br>`
				originMessage += `From: \${response.sender.empName}&lt;\${response.sender.empMail}&gt;<br>`
				originMessage += `To: \${receiveList}<br>`
				originMessage += `Sent: \${date}<br>`
				originMessage += `Subject: \${response.emlTtl}<br>`
				originMessage += response.emlCn+"<br>"
				originMessage += `------------------------------<br>`
				title="FW: "+response.emlTtl
			}
			
			CKEDITOR.instances.mail_write_content.setData(originMessage)
			  $("#mail_write_title").val(title)
			
			  
			if(response.fileList!=null && response.fileList.length>0){
				var header=$(`<tr id="selected_files_list_table_head">
					    			<th>파일명</th>
					    			<th>타입</th>
					    			<th>용량</th>
					    			<th>X</th>
					    		</tr>`)
				selectedFileListEl.append(header)
				$.each(response.fileList,function(i,v){
					fileInfoList.push(v)
					var newType=v.fileType
					if(v.fileType==null||v.fileType==""||v.fileType=="blank"){
						newType=getExtensionFromFileName(v.fileNm)
					}
					console.log(v)
					var tr=$(`<tr class='fileTr fileInfo'>
						    			<td>\${v.fileNm}</td>
						    			<td>\${newType}</td>
						    			<td>\${v.fileSz}</td>
						    			<td><button class='fileRemoveBtn'>X</button></td>
						    		</tr>`)
					selectedFileListEl.append(tr)
				})
				
			}

		
		})
	})
	
	
	
	
	
	
	detailRemoveBtn.on("click",function(){
		if(confirm("삭제 하시겠습니까?")){
			
			var senderEl=$(".mailbox-read-info .detail_sender")
			var emlId = $(".mailbox-read-info").attr("id")
			var typeList=[]
			var emlIdList=[emlId]
			if(senderEl.attr("id")=="${empId}"){
				typeList.push("send")
			}else{
				typeList.push("receive")
			}
			
			$.ajax({
				  url: '/everyware/mail/trash', // 요청을 보낼 URL
				  method: 'post', // HTTP 메서드 (GET, POST 등)
				  data: JSON.stringify({emlIdList:emlIdList,typeList:typeList}),
				  beforeSend : function(xhr){
					  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			  	  },
			  	 contentType: 'application/json; charset=utf-8',
				  success: function(response) {
					  if(response.res=="OK"){
						  getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,mailboxFill)
						  $(".mail_detail").hide(100)
							setTimeout(() => {
								$(".mail_box").show(100)
							}, 100);
							menuFlag=true;
							detailFlag=false;
					  }
				  },
				  error: function(xhr, status, error) {
					alertError("실패")
				  }
				}); 
		}
	})
	
	
	$(".mail-write-form").on("click",".fileRemoveBtn",function(){
		var tr=$(this).parents(".fileTr")
		var fileNm = tr.find("td:eq(0)").text()
		var fileType = tr.find("td:eq(1)").text()
		var fileSz = tr.find("td:eq(2)").text()
		var successFlag=false
		console.log(this)
		console.log(tr)
		console.log(fileNm)
		console.log(fileType)
		console.log(fileSz)
		if(tr.hasClass("fileInfo")){
			for(var i=0; i<fileInfoList.length; i++){
				if(fileInfoList[i].fileNm==fileNm && fileInfoList[i].fileType==fileType &&fileInfoList[i].fileSz==fileSz ){
					fileInfoList.splice(i,1);
					successFlag=true;
					break;
				}
				if(fileInfoList[i].fileNm==fileNm && (fileInfoList[i].fileType=="blank"||fileInfoList[i].fileType=="") &&fileInfoList[i].fileSz==fileSz ){
					fileInfoList.splice(i,1);
					successFlag=true;
					break;
				}
			}
		}else if(tr.hasClass("file")){
			for(var i=0; i<selectedFileList.length; i++){
				if(selectedFileList[i].name==fileNm && selectedFileList[i].type==fileType &&selectedFileList[i].size==fileSz ){
					selectedFileList.splice(i,1);
					successFlag=true;
					break;
				}
				if(selectedFileList[i].name==fileNm && selectedFileList[i].type=="" &&selectedFileList[i].size==fileSz ){
					selectedFileList.splice(i,1);
					successFlag=true;
					break;
				}
			}
		}
		
		if(!successFlag){
			alertError("알수없는 에러")
		}else{
			if($("#selected_files_list tr").length==2){
				$("#selected_files_list").empty()
			}else{
				tr.remove()
			}
			
		}
	})
	
	
	
	
	
	discardBtn.on("click",function(){
		getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,mailboxFill,function(){
			writeFormReset()
			$(".mail-write-form").hide(100)
			setTimeout(() => {
				$(".mail_box").show(100)
			}, 100);
			menuFlag=true;
			writeFlag=false
			$("#checkAll").prop('checked', false)
		})
	})
	
	draftBtn.on("click",function(){
		
		var tags = $(".tagify__tag")
		var idList=[]
		$.each(tags,function(i,v){
			idList.push(v.__tagifyTagData.value)
		})
		
		
		console.log($("#mail_write_title").val())
		console.log(CKEDITOR.instances.mail_write_content.getData())
		console.log(idList)
		console.log(selectedFileList)
		var formData = new FormData();
		$.each(selectedFileList,function(i,v){
			formData.append("cFiles",v)
			if(v.type==null||v.type==""){
				formData.append("fileType","blank")
			}else{
				formData.append("fileType",v.type)
			}
		})
		$.each(idList,function(i,v){
			formData.append("cReceiver",v)
		})
		$.each(fileInfoList,function(i,v){
			formData.append("fileInfoList["+i+"].atchFileNo",v.atchFileNo);
			formData.append("fileInfoList["+i+"].atchFileSeq",v.atchFileSeq);
			formData.append("fileInfoList["+i+"].bizType",v.bizType);
			formData.append("fileInfoList["+i+"].filePath",v.filePath);
			formData.append("fileInfoList["+i+"].fileNm",v.fileNm);
			formData.append("fileInfoList["+i+"].fileSz",v.fileSz);
			formData.append("fileInfoList["+i+"].custId",v.custId);
			formData.append("fileInfoList["+i+"].fileCrtDt",new Date(v.fileCrtDt));
			formData.append("fileInfoList["+i+"].fileSavedNm",v.fileSavedNm);
			if(v.fileType==null||v.fileType==""){
				formData.append("fileInfoList["+i+"].fileType","blank");
			}else{
				formData.append("fileInfoList["+i+"].fileType",v.fileType);
			}
		})
		formData.append("emlTtl",$("#mail_write_title").val())
		formData.append("emlCn",CKEDITOR.instances.mail_write_content.getData())
		formData.append("emlTmprStrgYn","Y")
		if(replyFlag){
			formData.append("upEmlId",replyEmlId)
		}else{
			formData.append("upEmlId",0)
		}
		
		
		$.ajax({
			  url: '/everyware/mail/send', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: formData,
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	  processData : false,
			  contentType : false,
			  success: function(response) {
				if(response=="OK"){
					alertSuccess("임시저장 되었습니다.")
					getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,mailboxFill,function(){
						writeFormReset()
						$(".mail-write-form").hide(100)
						setTimeout(() => {
							$(".mail_box").show(100)
						}, 100);
						menuFlag=true;
						$("#checkAll").prop('checked', false)
					})
					
					writeFlag=false;
				}else if(response=="NOTEXIST"){
					alertError("파일 사용량이 초과하였습니다.")
				}else{
					alertError("서버에러 다시시도해주세요.")
				}
			  },
			  error: function(xhr, status, error) {
				  alertError("메일전송 실패")
			  }
			});
	})
	
	
	$(document).on('change', '#mail_list_content input[type="checkbox"]', function() {
	  var checkedCount = $('#mail_list_content input[type="checkbox"]:checked').length;
	  console.log('체크된 체크박스 개수:', checkedCount);
	  

	  if(checkedCount==0){
		  checkedReadBtn.prop("disabled", true);
		  checkedReplyBtn.prop("disabled", true);
		  checkedRemoveBtn.prop("disabled", true);
		  checkedResendBtn.prop("disabled", true);
		  checkedDeleteBtn.prop("disabled", true);
		  checkedRetrieveBtn.prop("disabled",true);
	  }else if(checkedCount==1){
		  if(menuName=="받은메일함"){
			  checkedReadBtn.prop("disabled", false);
			  checkedReplyBtn.prop("disabled", false);
			  checkedRemoveBtn.prop("disabled", false);
			  checkedResendBtn.prop("disabled", false);
		  }else if(menuName=="전체메일"||menuName=="보낸메일함"){
			  var emlId = $(this).attr("id")
			  checkedReadBtn.prop("disabled", false);
			  checkedRemoveBtn.prop("disabled", false);
			  checkedResendBtn.prop("disabled", false);
			  if($(this).parent(emlId).hasClass("receive")){
				  checkedReplyBtn.prop("disabled", false);
			  }else{
				  checkedReplyBtn.prop("disabled", true);
			  }
		  }else if(menuName=="휴지통"){
			  checkedRetrieveBtn.prop("disabled", false);
			  checkedDeleteBtn.prop("disabled", false);
			  checkedReadBtn.prop("disabled", false);
			  checkedDeleteBtn.prop("disabled", false);
		  }else if(menuName=="임시보관함"){
			  checkedRemoveBtn.prop("disabled", false);
			  checkedResendBtn.prop("disabled", false);
		  }
	  }else{
		  checkedRemoveBtn.prop("disabled", false);
		  checkedReadBtn.prop("disabled", false);
		  checkedReplyBtn.prop("disabled", true);
		  checkedResendBtn.prop("disabled", true);
		  checkedDeleteBtn.prop("disabled", false);
		  checkedReadBtn.prop("disabled", false);
		  checkedRetrieveBtn.prop("disabled",false);
	  } 
	});
	
	checkedReadBtn.on("click",function(){
		var checkedInputs = $('#mail_list_content input[type="checkbox"]:checked')
		$.each(checkedInputs,function(i,v){
			var tr = $(v).parents("#"+v.id)
			if(tr.hasClass("send")){
				
			}else if(tr.hasClass("receive")){
				readMail(v.id,function(response){
					$(".mailbox-isread",tr).html(`<ion-icon class="mail-isread" name="mail-open-outline"></ion-icon>`)
					$("#mail_unread_count").text(response.unreadCnt)
				})
			}
		})
	})
	checkedReplyBtn.on("click",function(){
		console.log("어 왔어")
		var checkedInputs = $('#mail_list_content input[type="checkbox"]:checked')
		var tr = checkedInputs.parents("#"+checkedInputs.attr("id"))
		var imgEl = $(".mail_profile_img",tr)
		
		replyEmlId=checkedInputs.attr("id")
		var senderId = imgEl.data("empid")
		var senderName = imgEl.data("empname")
		var jbgdNm = imgEl.data("jbgdnm")
		var deptNm = imgEl.data("deptnm")
		var senderMail = imgEl.data("empmail")
		var senderProfile = imgEl.attr("src")
		
		 replyEmpObj={
				"value":senderId,
				"name" :senderName,
				"jbgdNm":jbgdNm,
				"deptNm":deptNm,
				"avatar":senderProfile,
				"email":senderMail
			}
		
		console.log(replyEmpObj)
		
		mailWriteForm(function(){
			tagify.addTags([replyEmpObj])
				
			replyFlag=true;
		})  
			
	})
	
	checkedResendBtn.on("click",function(){
		var checkedInputs = $('#mail_list_content input[type="checkbox"]:checked')
		var emlId=checkedInputs.attr("id")
		
		
		mailWriteForm();
		getDetail(emlId,function(response){
			
			var receiveList=""
			
			$.each(response.receiver,function(i,v){
				if((i+1)%5==0){
					receiveList+="\n"
				}
				if(i>0){
					receiveList+=", "
				}
				receiveList+=v.empName+`<\${v.empMail}>`
			})
			
			var date = dateFormat2(response.emlSndngDt)
			
			var originMessage=""
			var title=""
			if(menuName=="임시보관함"){
				originMessage += response.emlCn
				title=response.emlTtl
			}else{
				originMessage  = `-----Original Message-----<br>`
				originMessage += `From: \${response.sender.empName}&lt;\${response.sender.empMail}&gt;<br>`
				originMessage += `To: \${receiveList}<br>`
				originMessage += `Sent: \${date}<br>`
				originMessage += `Subject: \${response.emlTtl}<br>`
				originMessage += response.emlCn+"<br>"
				originMessage += `------------------------------<br>`
				title="FW: "+response.emlTtl
			}
			
			CKEDITOR.instances.mail_write_content.setData(originMessage)
			  $("#mail_write_title").val(title)
			
			  
			  if(response.fileList!=null && response.fileList.length>0){
					var header=$(`<tr id="selected_files_list_table_head">
						    			<th>파일명</th>
						    			<th>타입</th>
						    			<th>용량</th>
						    			<th>X</th>
						    		</tr>`)
					selectedFileListEl.append(header)
					$.each(response.fileList,function(i,v){
						fileInfoList.push(v)
						var newType=v.fileType
						if(v.fileType==null||v.fileType==""||v.fileType=="blank"){
							newType=getExtensionFromFileName(v.fileNm)
						}
						console.log(v)
						var tr=$(`<tr class='fileTr fileInfo'>
							    			<td>\${v.fileNm}</td>
							    			<td>\${newType}</td>
							    			<td>\${v.fileSz}</td>
							    			<td><button class='fileRemoveBtn'>X</button></td>
							    		</tr>`)
						selectedFileListEl.append(tr)
					})
					
				}

		
		})
	})
	
	checkedRemoveBtn.on("click",function(){
		var checkedInputs = $('#mail_list_content input[type="checkbox"]:checked')
		var emlIdList = []
		var typeList=[]
		
		$.each(checkedInputs,function(i,v){
			var tr = $("#mail_list_content tr#"+$(v).attr("id"))
			emlIdList.push(v.id)
			console.log(tr)
			 var type = ""
			if(tr.hasClass("send")){
				type="send"
			}else if(tr.hasClass("receive")){
				type="receive"
			}
			typeList.push(type) 
		})
		if(confirm(checkedInputs.length+'개의 항목을 삭제 하시겠습니까?')){
			$.ajax({
				  url: '/everyware/mail/trash', // 요청을 보낼 URL
				  method: 'post', // HTTP 메서드 (GET, POST 등)
				  data: JSON.stringify({emlIdList:emlIdList,typeList:typeList}),
				  beforeSend : function(xhr){
					  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			  	  },
			  	 contentType: 'application/json; charset=utf-8',
				  success: function(response) {
					  if(response.res=="OK"){
						  var tr = $(".table-striped tr")
						  if(tr.length<=checkedInputs.length){
							  if(page==1||page<totalPage){
								  
							  }else{
								  page=page-1
							  }
						  }
						  $("#checkAll").prop('checked', false)
						  getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,mailboxFill)
					  }
				  },
				  error: function(xhr, status, error) {
					alertError("실패")
				  }
				}); 
		}
	})
	
	
	checkedRetrieveBtn.on("click",function(){
		var checkedInputs = $('#mail_list_content input[type="checkbox"]:checked')
		var emlIdList = []
		var typeList=[]
		
		$.each(checkedInputs,function(i,v){
			var tr = $("#mail_list_content tr#"+$(v).attr("id"))
			emlIdList.push(v.id)
			console.log(tr)
			 var type = ""
			if(tr.hasClass("send")){
				type="send"
			}else if(tr.hasClass("receive")){
				type="receive"
			}
			typeList.push(type) 
		})
		if(confirm(checkedInputs.length+'개의 항목을 복원 하시겠습니까?')){
			$.ajax({
				  url: '/everyware/mail/retrieve', // 요청을 보낼 URL
				  method: 'post', // HTTP 메서드 (GET, POST 등)
				  data: JSON.stringify({emlIdList:emlIdList,typeList:typeList}),
				  beforeSend : function(xhr){
					  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			  	  },
			  	 contentType: 'application/json; charset=utf-8',
				  success: function(response) {
					  if(response.res=="OK"){
						  var tr = $(".table-striped tr")
						  if(tr.length<=checkedInputs.length){
							  if(page==1||page<totalPage){
								  
							  }else{
								  page=page-1
							  }
						  }
						  $("#checkAll").prop('checked', false)
						  getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,mailboxFill)
					  }
				  },
				  error: function(xhr, status, error) {
					alertError("실패")
				  }
				});
		}
	})
	
	
	checkedDeleteBtn.on("click",function(){
		var checkedInputs = $('#mail_list_content input[type="checkbox"]:checked')
		var emlIdList = []
		var typeList=[]
		
		$.each(checkedInputs,function(i,v){
			var tr = $("#mail_list_content tr#"+$(v).attr("id"))
			emlIdList.push(v.id)
			console.log(tr)
			 var type = ""
			if(tr.hasClass("send")){
				type="send"
			}else if(tr.hasClass("receive")){
				type="receive"
			}
			typeList.push(type) 
		})
		
		if(confirm(checkedInputs.length+'개의 항목을 영구삭제합니다.(복구할 수 없음)')){
			$.ajax({
				  url: '/everyware/mail/erase', // 요청을 보낼 URL
				  method: 'post', // HTTP 메서드 (GET, POST 등)
				  data: JSON.stringify({emlIdList:emlIdList,typeList:typeList}),
				  beforeSend : function(xhr){
					  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			  	  },
			  	 contentType: 'application/json; charset=utf-8',
				  success: function(response) {
					  if(response.res=="OK"){
						  var tr = $(".table-striped tr")
						  if(tr.length<=checkedInputs.length){
							  if(page==1||page<totalPage){
								  
							  }else{
								  page=page-1
							  }
						  }
						  $("#checkAll").prop('checked', false)
						  getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,mailboxFill)
					  }
				  },
				  error: function(xhr, status, error) {
					alertError("실패")
				  }
				});
		}
	})
	
	
	
	
	
	
	$("#searchBtn").on("click",function(){
		var searchWord=$("#searchInput").val()
		searchKeyword=searchWord
		page=1
		getMailList("전체메일",page,searchKeyword,isLately,bookMark,attachment,mailboxFill)
		$("#checkAll").prop('checked', false)
	})
	
	detailReplyBtn.on("click",function(){
		replyEmlId=$(".mailbox-read-info").attr("id")
		var senderEl=$(".mailbox-read-info .detail_sender")
		var senderId = senderEl.attr("id")
		var senderName = senderEl.data("empname")
		var jbgdNm = senderEl.data("jbgdnm")
		var deptNm = senderEl.data("deptnm")
		var senderMail = senderEl.data("empmail")
		var senderProfile = $(".detail_profile_img",senderEl).attr("src")
		
		replyEmpObj={
			"value":senderId,
			"name" :senderName,
			"jbgdNm":jbgdNm,
			"deptNm":deptNm,
			"avatar":senderProfile,
			"email":senderMail
		}
		
		mailWriteForm(function(){
			tagify.addTags([replyEmpObj])
			
			replyFlag=true;
		}) 
	})
	
	
	$("#mail_write_to").on("change",function(){
		console.log("바꼈음")
		var value = $("#mail_write_to").val()
		var curval=""
		if(value!=""){
			curval=JSON.parse($("#mail_write_to").val())
		}
		if(replyFlag){
			if(curval!="" && curval.length==1 && replyEmpObj.value==curval[0].value){
				$("#reply_on").append($(`<span>reply to: \${replyEmpObj.name} \${replyEmpObj.jbgdNm} &lt;\${replyEmpObj.email}&gt;</span>`))
			}else{
				$("#reply_on").html("")
			}
		}
	})
	
	
	$(".mail_box,.reply_list_div").on("click",".receive .mailbox-name,.receive .mailbox-subject",function(){
		if(menuFlag){
			$(".mail_box").hide(100)
			setTimeout(() => {
				$(".mail_detail").show(100)
			}, 100);
			menuFlag=false;
		}else if(writeFlag){
			$(".mail-write-form").hide(100)
			setTimeout(() => {
				$(".mail_detail").show(100)
			}, 100);
			writeFlag=false;
		}else if(detailFlag){
			$(".mail_detail").fadeOut(100)
			setTimeout(() => {
				$(".mail_detail").fadeIn(100)
			}, 100);
		}
		detailFlag=true
		
		var tr=$(this).parents(".receive")
		//읽음 처리
		if($(".mail-isread",tr).hasClass("mail-unread")){
			readMail(tr.attr("id"),function(response){
				$("#mail_unread_count").text(response.unreadCnt)
			})
		}
		
		
		detailReplyBtn.show()
		
		
		var emlId = $(this).parents(".receive").attr("id")
		getDetail(emlId, function(response){
			
			$(".detail_title h2").text("")
			$(".mail_detail_date h8").text("")
			$(".sender_profile_div").html("")
			$(".receiver_profile_div").html("")
			$(".mailbox-read-message").html("")
			$(".mailbox-attachments").html("")
			$(".file_div_container").html("")
			$(".mailbox-read-info").attr("id",response.emlId)
			
			
			$(".detail_title h2").text(response.emlTtl)
			$(".mail_detail_date h8").text(dateFormat2(response.emlSndngDt))
			
			
			//메일 내용 넣기
			var profile ="/resources/img/basicProfile.png"
			if(response.sender.empProfile!=null){
				profile = "/everyware/mypage/thumbnail?empId="+response.sender.empId
			}
			var senderProfile=$(`<div class="detail_sender col-5" id="\${response.sender.empId}" data-empname="\${response.sender.empName}" data-jbgdnm="\${response.sender.jbgdNm}" data-empmail="\${response.sender.empMail}" data-deptnm="\${response.sender.deptNm}">
								<img src="\${profile}" class="detail_profile_img">
								\${response.sender.empName} \${response.sender.jbgdNm} &lt;\${response.sender.empMail}&gt;
								</div>`)
			$(".sender_profile_div").append(senderProfile)
			$.each(response.receiver,function(i,v){
				var profile ="/resources/img/basicProfile.png"
				if(v.empProfile!=null){
					profile = "/everyware/mypage/thumbnail?empId="+v.empId
				}
				
				var receiverProfile=$(`<div class="detail_receiver col-5" id="\${v.empId}" data-empname="\${v.empName}" data-jbgdnm="\${v.jbgdNm}" data-empmail="\${v.empMail}" data-deptnm="\${v.deptNm}">
										<img src="\${profile}" class="detail_profile_img">
										\${v.empName} \${v.jbgdNm} &lt;\${v.empMail}&gt;
										</div>`)
				$(".receiver_profile_div").append(receiverProfile)						
			})
			
			$(".mailbox-read-message").html(response.emlCn)
			
			//첨부파일 넣기
			
			if(response.fileList!=null){
				var temp = $(`<label for="detail_file_div" class="col-sm-2 col-form-label">파일첨부 <a id="file_list_toggle_btn" class="file_down"><ion-icon name="chevron-down-outline"></ion-icon></a></label>
						  <div class="col-sm-10">
						  <div class="col-sm-10 detail_file_div">
						  </div>
						</div>`)
				$(".file_div_container").append(temp)
				$.each(response.fileList,function(i,v){
					
					var type = getFileType(v.fileNm)
					var iconMatch = getMatchedIcon(type)
					var imgOpt=""
					if(iconMatch=='img'){
						iconMatch=`<img class="file_thumb" src="/everyware/mail/thumbnail/?atchFileNo=\${v.atchFileNo}&atchFileSeq=\${v.atchFileSeq}" alt="Attachment">`
						imgOpt=" has-img"
					}
					
					var fileSize=convertFileSize(v.fileSz)
					
					var attach=$(`<div class="thumb_container" data-atchfileno="\${v.atchFileNo}" data-atchfileseq="\${v.atchFileSeq}" data-filenm="\${v.fileNm}" data-filesz="\${v.fileSz}" data-filetype="\${v.fileType}">
			                  	<div class="thumb_div">\${iconMatch}</div>
			                    <a href="/everyware/mail/filedownload/?atchFileNo=\${v.atchFileNo}&atchFileSeq=\${v.atchFileSeq}" class="mailbox-attachment-name"><i class="fas fa-paperclip"></i> \${v.fileNm}</a>
			                          <span>\${fileSize}</span>
			                          <a  href="/everyware/mail/filedownload/?atchFileNo=\${v.atchFileNo}&atchFileSeq=\${v.atchFileSeq}" class="btn btn-default btn-sm float-right download_btn"><i class="fas fa-cloud-download-alt"></i></a>
			                	</div>`)
			                
			        $(".detail_file_div").append(attach)
				})
			}
			
			
			$(".reply_list_div").empty()
			
			var table = $("<table class='table table-hover'></table>")
			var thead= $(`<thead>
						  <tr>
						  	<th colspan="7">주고받은 메일</th>
			              </tr>
		                </thead>
						  `)
			var tbody = $("<tbody></tbody>")
			$.each(response.replyList,function(i,v){
				 var isreadCheck=""
				 if(v.senderId!="${empId}"){
				  	if(v.emlReadDt==null){
				  			  isreadCheck=`<ion-icon name="mail" class="mail-isread mail-unread"></ion-icon>`	
				  	}else{
				  			  isreadCheck=`<ion-icon class="mail-isread" name="mail-open-outline"></ion-icon>`
				  	}
				  }else{
					  isreadCheck=`<ion-icon class="mail-isread" name="mail-open-outline"></ion-icon>`
				  }
					  
					  
					  var bookmarkCheck=""
					  if(v.emlBookMark=='N'){
						  bookmarkCheck=`<ion-icon class="mail-important" name="star-outline"></ion-icon>`
					  }else{
						  bookmarkCheck=`<ion-icon class="mail-important important-yes" name="star"></ion-icon>`
					  }
					  
					  var sendDate = dateFormat(v.emlSndngDt)
					  
					  var existFile = ""
					  if(v.atchFileNo!=0){
						  existFile=`<ion-icon name="attach-outline"></ion-icon>`
					  }
					  
					  var mailType=""
					  if("${empId}"==v.senderId){
						  mailType="class='send'"
					  }else{
						  mailType="class='receive'"
					  }
				
				var emlId = $(".mailbox-read-info").attr("id")
				var isCurMail = ""
				if(emlId == v.emlId){
					isCurMail="curMail"
				}
				var profile ="/resources/img/basicProfile.png"
				if(v.senderProfile!=null){
					profile = "/everyware/mypage/thumbnail?empId="+v.senderId
				}
				var row = $(`
						  <tr id="\${v.emlId}" \${mailType}>
						  <td>\${i+1}</td>
		                  <td class="mailbox-star">\${bookmarkCheck}</td>
		                  <td class="mailbox-isread">\${isreadCheck}</td>
		                  <td class="mailbox-subject"><b> \${v.emlTtl}</td>
		                  <td class="mailbox-attachment">\${existFile}</td>
		                  <td class="mailbox-name"><img class="mail_profile_img" src="\${profile}"><div class="list_profile"><div class="list_profile_name">\${v.senderName} \${v.senderJbgdNm}</div><div class="list_profile_mail">\${v.senderMail}</div></div></td>		                  
		                  <td class="mailbox-date"><div>\${sendDate}</div></td>
		                </tr>
						  `)
				row.addClass(isCurMail)		  
				tbody.append(row)
				
			})
			table.append(thead)
			table.append(tbody)
			$(".reply_list_div").append(table)
			
		})
		
		
		
		
		
		
		
	})
	 $(".mail_box,.reply_list_div").on("click",".send .mailbox-name,.send .mailbox-subject",function(){
		console.log(detailFlag)
		console.log(menuFlag)
		console.log(writeFlag)
		
		
		if(menuFlag){
			$(".mail_box").hide(100)
			setTimeout(() => {
				$(".mail_detail").show(100)
			}, 100);
			menuFlag=false;
		}else if(writeFlag){
			$(".mail-write-form").hide(100)
			setTimeout(() => {
				$(".mail_detail").show(100)
			}, 100);
			writeFlag=false;
		}else if(detailFlag){
			$(".mail_detail").fadeOut(100)
			setTimeout(() => {
				$(".mail_detail").fadeIn(100)
			}, 100);
		}
		detailFlag=true
		
		
		detailReplyBtn.hide()
		
		
		var emlId = $(this).parents(".send").attr("id")
		getDetail(emlId, function(response){
			
			$(".detail_title h2").text("")
			$(".mail_detail_date h8").text("")
			$(".sender_profile_div").html("")
			$(".receiver_profile_div").html("")
			$(".mailbox-read-message").html("")
			$(".mailbox-attachments").html("")
			$(".file_div_container").html("")
			$(".mailbox-read-info").attr("id",response.emlId)
			
			
			$(".detail_title h2").text(response.emlTtl)
			$(".mail_detail_date h8").text(dateFormat2(response.emlSndngDt))
			
			
			//메일 내용 넣기
			var profile ="/resources/img/basicProfile.png"
			if(response.sender.empProfile!=null){
				profile = "/everyware/mypage/thumbnail?empId="+response.sender.empId
			}
			var senderProfile=$(`<div class="detail_sender col-5" id="\${response.sender.empId}" data-empname="\${response.sender.empName}" data-jbgdnm="\${response.sender.jbgdNm}" data-empmail="\${response.sender.empMail}" data-deptnm="\${response.sender.deptNm}">
								<div class="mail_flex">
								<img src="\${profile}" class="detail_profile_img my-auto">
								<div class="name_mail_container"><div class="name_container">\${response.sender.empName} \${response.sender.jbgdNm}</div> <div class="mail_container">&lt;\${response.sender.empMail}&gt;</div></div>
								</div></div>`)
			$(".sender_profile_div").append(senderProfile)
			$.each(response.receiver,function(i,v){
				var profile ="/resources/img/basicProfile.png"
				if(v.empProfile!=null){
					profile = "/everyware/mypage/thumbnail?empId="+v.empId
				}
				var receiverProfile=$(`<div class="detail_receiver col-5" id="\${v.empId}" data-empname="\${v.empName}" data-jbgdnm="\${v.jbgdNm}" data-empmail="\${v.empMail}" data-deptnm="\${v.deptNm}">
										<div class="mail_flex">
										<img src="\${profile}" class="detail_profile_img my-auto">
										<div class="name_mail_container"><div class="name_container">\${v.empName} \${v.jbgdNm}</div> <div class="mail_container">&lt;\${v.empMail}&gt;</div></div>
										</div></div>`)
				$(".receiver_profile_div").append(receiverProfile)	
			})
			
			$(".mailbox-read-message").html(response.emlCn)
			
			//첨부파일 넣기
			
			if(response.fileList!=null){
				var temp = $(`<label for="detail_file_div" class="col-sm-2 col-form-label">파일첨부 <a id="file_list_toggle_btn" class="file_down"><ion-icon name="chevron-down-outline"></ion-icon></a></label>
						  <div class="col-sm-10">
						  <div class="col-sm-10 detail_file_div">
						  </div>
						</div>`)
				$(".file_div_container").append(temp)
				$.each(response.fileList,function(i,v){
					
					var type = getFileType(v.fileNm)
					var iconMatch = getMatchedIcon(type)
					var imgOpt=""
					if(iconMatch=='img'){
						iconMatch=`<img class="file_thumb" src="/everyware/mail/thumbnail/?atchFileNo=\${v.atchFileNo}&atchFileSeq=\${v.atchFileSeq}" alt="Attachment">`
						imgOpt=" has-img"
					}
					
					var fileSize=convertFileSize(v.fileSz)
					
					var attach=$(`<div class="thumb_container" data-atchfileno="\${v.atchFileNo}" data-atchfileseq="\${v.atchFileSeq}"data-filenm="\${v.fileNm}" data-filesz="\${v.fileSz}" data-filetype="\${v.fileType}">
			                  	<div class="thumb_div">\${iconMatch}</div>
			                    <a href="/everyware/mail/filedownload/?atchFileNo=\${v.atchFileNo}&atchFileSeq=\${v.atchFileSeq}" class="mailbox-attachment-name"><i class="fas fa-paperclip"></i> \${v.fileNm}</a>
			                          <span>\${fileSize}</span>
			                          <a  href="/everyware/mail/filedownload/?atchFileNo=\${v.atchFileNo}&atchFileSeq=\${v.atchFileSeq}" class="btn btn-default btn-sm float-right download_btn"><i class="fas fa-cloud-download-alt"></i></a>
			                	</div>`)
			                
			        $(".detail_file_div").append(attach)
				})
			}
			
			
			$(".reply_list_div").empty()
			
			var table = $("<table class='table table-hover'></table>")
			var thead= $(`<thead>
						  <tr>
						  	  <th colspan="7">주고받은 메일</th>
			                </tr>
		                </thead>
						  `)
			var tbody = $("<tbody></tbody>")
			$.each(response.replyList,function(i,v){
				 var isreadCheck=""
				 if(v.senderId!="${empId}"){
				  	if(v.emlReadDt==null){
				  			  isreadCheck=`<ion-icon name="mail" class="mail-isread mail-unread"></ion-icon>`	
				  	}else{
				  			  isreadCheck=`<ion-icon class="mail-isread" name="mail-open-outline"></ion-icon>`
				  	}
				  }else{
					   isreadCheck=`<ion-icon class="mail-isread" name="mail-open-outline"></ion-icon>`
				  }
					  
					  
					  var bookmarkCheck=""
					  if(v.emlBookMark=='N'){
						  bookmarkCheck=`<ion-icon class="mail-important" name="star-outline"></ion-icon>`
					  }else{
						  bookmarkCheck=`<ion-icon class="mail-important important-yes" name="star"></ion-icon>`
					  }
					  
					  var sendDate = dateFormat(v.emlSndngDt)
					  
					  var existFile = ""
					  if(v.atchFileNo!=0){
						  existFile=`<ion-icon name="attach-outline"></ion-icon>`
					  }
					  
					  var mailType=""
					  if("${empId}"==v.senderId){
						  mailType="class='send'"
					  }else{
						  mailType="class='receive'"
					  }
				
				var emlId = $(".mailbox-read-info").attr("id")
				var isCurMail = ""
				if(emlId == v.emlId){
					isCurMail="curMail"
				}
				//메일 내용 넣기
				var profile ="/resources/img/basicProfile.png"
				if(v.senderProfile!=null){
					profile = "/everyware/mypage/thumbnail?empId="+v.senderId
				}
				var row = $(`
						  <tr id="\${v.emlId}" \${mailType}>
						  <td>\${i+1}</td>
		                  <td class="mailbox-star">\${bookmarkCheck}</td>
		                  <td class="mailbox-isread">\${isreadCheck}</td>
		                  <td class="mailbox-subject"><b> \${v.emlTtl}</td>
		                  <td class="mailbox-attachment">\${existFile}</td>
		                  <td class="mailbox-name"><img class="mail_profile_img" src="\${profile}"><div class="list_profile"><div class="list_profile_name">\${v.senderName} \${v.senderJbgdNm}</div><div class="list_profile_mail">\${v.senderMail}</div></div></td>
		                  <td class="mailbox-date"><div>\${sendDate}</div></td>
		                </tr>
						  `)
				row.addClass(isCurMail)		  
				tbody.append(row)
				
			})
			table.append(tbody)
			table.append(thead)
			$(".reply_list_div").append(table)
			
		})
	})
	
	$(".mail_detail").on("click","#file_list_toggle_btn",function(){
		if($(this).hasClass("file_down")){
			//올리고
			$('.detail_file_div').stop(true,true).slideUp(100)
			$(this).html(`<ion-icon name="chevron-up-outline"></ion-icon>`)
		   $(this).removeClass("file_down")
		   $(this).addClass("file_up")
		}else if($(this).hasClass("file_up")){
			//내리고
		   $('.detail_file_div').stop(true,true).slideUp(100)
           $('.detail_file_div').stop(true,true).slideDown(100)
           $(this).html(`<ion-icon name="chevron-down-outline"></ion-icon>`)
		   $(this).removeClass("file_up")
		   $(this).addClass("file_down")
		}
	})
	
	$("#bookmarkSort").on("click",function(){
		console.log("누름")
		bookMark=!bookMark;
		page=1
		getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,mailboxFill,function(){
			if($("#bookmarkSort").hasClass("customActive")){
				$("#bookmarkSort").removeClass("customActive");
				
			}else{
				$("#bookmarkSort").addClass("customActive");
				
			}
			$("#checkAll").prop('checked', false)
		})
		
	})
	$("#attachmentSort").on("click",function(){
		attachment=!attachment;
		page=1
		getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,mailboxFill,function(){
			if($("#attachmentSort").hasClass("customActive")){
				$("#attachmentSort").removeClass("customActive");
				
			}else{
				$("#attachmentSort").addClass("customActive");
				
			}
			$("#checkAll").prop('checked', false)
		})
	})
	
	$(document).on("click",".mail-important",function(){
		var parent = $(this).parent()
		var emlBookMark=""
		if($(this).hasClass("important-yes")){
			emlBookMark="N"
		}else{
			emlBookMark="Y"
		}
		var emlId=$(this).parents("tr").attr("id")
		var type = $(this).parents("tr").attr("class").split(" ")[0]
		var obj = {
			emlBookMark:emlBookMark, 
			emlId:emlId,
			type:type
		}
		$.ajax({
			  url: '/everyware/mail/bookMark', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: JSON.stringify(obj),
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	 contentType: 'application/json; charset=utf-8',
			  success: function(response) {
				if(response.res==1){
					parent.empty()
					
					if(emlBookMark=='Y'){
						parent.append($(`<ion-icon class="mail-important important-yes" name="star"></ion-icon>`))
					}else{
						parent.append($(`<ion-icon class="mail-important" name="star-outline"></ion-icon>`))
					}
				}
			  },
			  error: function(xhr, status, error) {
				alertError("실패")
			  }
			});
	})
	
	$(".mail_pagination").on("click","a",function(e){
		e.preventDefault()
		page=$(this).data("page")
		getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,mailboxFill)
		$("#checkAll").prop('checked', false)
	})
	
	
	$(document).on("change","#checkAll",function(){
		if($("#checkAll").prop('checked')){
			$("#mail_list_content input[type=checkbox]").prop('checked', true).trigger('change'); 
		}else{
			$("#mail_list_content input[type=checkbox]").prop('checked', false).trigger('change'); 
		}
		
	})
	
	$(".orderBtn").on("click","a",function(e){
		e.preventDefault()
		$(".orderBtn a").removeClass("active")
		$(this).addClass("active")
		if(isLately=="최신순"){
			isLately='오래된순'
		}else{
			isLately='최신순'
		}
		page=1
		getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,mailboxFill)
		$("#checkAll").prop('checked', false)
	})
	
	writeBtn.on("click", function(){
		mailWriteForm();
	})
	
	$("#pre_btn").on("click",function(){

		writeFormReset()
		
		$("#checkAll").prop('checked', false)
		
		
		checkedReadBtn.prop("disabled",true)
		checkedReplyBtn.prop("disabled",true)
		checkedRemoveBtn.prop("disabled",true)
		checkedResendBtn.prop("disabled",true)
		
		
		
		
		$(".mail_menu_item li").removeClass("active")
		$(this).addClass("active")
		
		getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,mailboxFill)
		
		menuFlag=true;
		if(writeFlag){
			console.log("위")
			$(".mail-write-form").hide(100)
			setTimeout(() => {
				$(".mail_box").show(100)
			}, 100);
			writeFlag=false;
		}else if(detailFlag){
			$(".mail_detail").hide(100)
			setTimeout(() => {
				$(".mail_box").show(100)
			}, 100);
			detailFlag=false;
		}else{
			console.log("아래")
			$(".mail_box").hide(100)
			setTimeout(() => {
				$(".mail_box").show(100)
			}, 100);
		} 
		
	})
    
	$(".mail_menu_item li").on("click",function(){
		
		writeFormReset()
		searchKeyword=""
		$("#searchInput").val("")
		page=1
		
		$("#checkAll").prop('checked', false)
		
		
		$(".top_controls li").hide()
		
		
		checkedReadBtn.prop("disabled",true)
		checkedReplyBtn.prop("disabled",true)
		checkedRemoveBtn.prop("disabled",true)
		checkedResendBtn.prop("disabled",true)
		
		
		menuName = $(".icon_name span",this).text()


		var btnClass=""
		switch (menuName) {
		    case '전체메일':
		    	btnClass='.default';
		    	break;
		    case '받은메일함':
		    	btnClass= '.default';
		    	break;
		    case '보낸메일함':
		    	btnClass= '.default';
		    	break;
		    case '임시보관함':
		    	btnClass= '.temp';
		    	break;
		    case '휴지통':
		    	btnClass= '.trash';
		    	break;
		    default:
		    	btnClass= '';
		  }
		console.log(btnClass)
		$(btnClass).parents("li").show();
		
		
		$(".mail_menu_item li").removeClass("active")
		$(this).addClass("active")
		
		
		
		getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,mailboxFill)
		var a = window.scrollY
		setTimeout(() => {
			window.scrollTo(0, a );
		}, 50);
		menuFlag=true;
		if(writeFlag){
			console.log("위")
			$(".mail-write-form").hide(100)
			setTimeout(() => {
				$(".mail_box").show(100)
			}, 100);
			writeFlag=false;
		}else if(detailFlag){
			$(".mail_detail").hide(100)
			setTimeout(() => {
				$(".mail_box").show(100)
			}, 100);
			detailFlag=false;
		}else{
			console.log("아래")
			$(".mail_box").hide(100)
			setTimeout(() => {
				$(".mail_box").show(100)
			}, 100);
		} 
		
		
	})
	attachBtn.on("click",function(){
		fileInput.click();
	})
	
	$(document).on("change",".files",function(e){
		var files = e.target.files;
		if(files.length>0 && selectedFileListEl.html()==""){
			var header=$(`<tr id="selected_files_list_table_head">
				    			<th>파일명</th>
				    			<th>타입</th>
				    			<th>용량</th>
				    			<th>삭제</th>
				    		</tr>`)
			selectedFileListEl.append(header)
		}
		$.each(files,function(i,v){
			
			selectedFileList.push(v)
			console.log(v)
			var newType=v.type
			if(v.type==null||v.type==""){
				newType=getExtensionFromFileName(v.name)
			}
			var tr=$(`<tr class='fileTr file'>
				    			<td>\${v.name}</td>
				    			<td>\${newType}</td>
				    			<td>\${v.size}</td>
				    			<td><button class='fileRemoveBtn'>X</button></td>
				    		</tr>`)
			selectedFileListEl.append(tr)
		})
		
		console.log(selectedFileList)
	})
	CKEDITOR.replace("mail_write_content",{
		footnotePrefix: "a",
		filebrowserUploadUrl: '/imageUpload.do?${_csrf.parameterName }=${_csrf.token}'
	})
	
	mail_send_btn.on("click", function(){
		
		var tags = $(".tagify__tag")
		if(tags.length==0){
			alertWarning("받는사람을 입력해 주세요.")
			return false;
		}
		var idList=[]
		$.each(tags,function(i,v){
			idList.push(v.__tagifyTagData.value)
		})
		
		
		console.log($("#mail_write_title").val())
		console.log(CKEDITOR.instances.mail_write_content.getData())
		console.log(idList)
		console.log(selectedFileList)
		var formData = new FormData();
		$.each(selectedFileList,function(i,v){
			formData.append("cFiles",v)
			if(v.type==null||v.type==""){
				formData.append("fileType","blank")
			}else{
				formData.append("fileType",v.type)
			}
			
		})
		$.each(idList,function(i,v){
			formData.append("cReceiver",v)
		})
		$.each(fileInfoList,function(i,v){
			formData.append("fileInfoList["+i+"].atchFileNo",v.atchFileNo);
			formData.append("fileInfoList["+i+"].atchFileSeq",v.atchFileSeq);
			formData.append("fileInfoList["+i+"].bizType",v.bizType);
			formData.append("fileInfoList["+i+"].filePath",v.filePath);
			formData.append("fileInfoList["+i+"].fileNm",v.fileNm);
			formData.append("fileInfoList["+i+"].fileSz",v.fileSz);
			formData.append("fileInfoList["+i+"].custId",v.custId);
			formData.append("fileInfoList["+i+"].fileCrtDt",new Date(v.fileCrtDt));
			formData.append("fileInfoList["+i+"].fileSavedNm",v.fileSavedNm);
			if(v.fileType==null||v.fileType==""){
				formData.append("fileInfoList["+i+"].fileType","blank");
			}else{
				formData.append("fileInfoList["+i+"].fileType",v.fileType);
			}
		})
		formData.append("emlTtl",$("#mail_write_title").val())
		formData.append("emlCn",CKEDITOR.instances.mail_write_content.getData())
		formData.append("emlTmprStrgYn","N")
		if(replyFlag){
			formData.append("upEmlId",replyEmlId)
		}else{
			formData.append("upEmlId",0)
		}
		
		$.ajax({
			  url: '/everyware/mail/send', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: formData,
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	  processData : false,
			  contentType : false,
			  success: function(response) {
				if(response=="OK"){
					alertSuccess("전송되었습니다.")
					if(idList.length>0){
						var obj={			//알람을 웹소켓으로		
								type:"al",
								alarm:{
									sndrNm:"${empId}",
									empIdList:idList,
									alarmType:1,
									urlAddr:"/everyware/mail"
								}
						}
						ws.send(JSON.stringify(obj));
					}
					getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,mailboxFill,function(){
						writeFormReset()
						$(".mail-write-form").hide(100)
						setTimeout(() => {
							$(".mail_box").show(100)
						}, 100);
						menuFlag=true;
						$("#checkAll").prop('checked', false)
					})
					
					writeFlag=false;
				}else if(response=="NOTEXIST"){
					alertError("파일 사용량이 초과하였습니다.")
				}else{
					alertError("서버에러 다시시도해주세요.")
				}
			  },
			  error: function(xhr, status, error) {
				alertError("메일전송 실패")
			  }
			});
	})
	
	
	
	
	function writeFormReset(){
		tagify.removeAllTags();
		$("#mail_write_title").val("")
		CKEDITOR.instances.mail_write_content.setData("")
		CKEDITOR.instances.mail_write_content.updateElement()
		selectedFileList=[]
		selectedFileListEl.empty()
		fileInfoList=[]
		$(".fileDiv input").val("")
		$("#reply_on").html("")
		replyEmpObj=null;
		replyFlag=false
		replyEmlId=null;
	}

	
	function getMailList(menuName,page,searchKeyword,isLately,bookMark,attachment,callback,callback2){
		var obj = {
				menuName : menuName,
				page : page,
				searchKeyword : searchKeyword,
				isLately : isLately,
				bookMark:bookMark,
				attachment:attachment
			}
			console.log(obj)
			$.ajax({
				  url: '/everyware/mail/mailList', // 요청을 보낼 URL
				  method: 'post', // HTTP 메서드 (GET, POST 등)
				  data: JSON.stringify(obj),
				  beforeSend : function(xhr){
					  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			  	  },
			  	  contentType: 'application/json; charset=utf-8',
				  success: function(response) {
						totalPage=response.totalPage
					  if(typeof callback!='undefined'){
						  callback(response)
					   }
					  if(typeof callback2!='undefined'){
					  	callback2()
					  }
					  
				  },
				  error: function(xhr, status, error) {
					alertError("메일전송 실패")
				  }
				});
	}
	
	function mailboxFill(response){
		$(".mail_box #mailbox_title").text(menuName)
		  $("#total_count").text("전체 "+response.totalRecord+"건")
		  $("#mail_list_content").empty();
		  
		
		$(".mail_count span").empty()
		
		if(response.allTotal>0){
			$(".allTotal span").text(response.allTotal)
			$(".allTotal").fadeIn(500)
		}else{
			$(".allTotal").fadeOut(500)
		}
		
		if(response.receiveTotal>0){
			$(".receiveTotal span").text(response.receiveTotal)
			$(".receiveTotal").fadeIn(500)
		}else{
			$(".receiveTotal").fadeOut(500)
		}
		
		if(response.sendTotal>0){
			$(".sendTotal span").text(response.sendTotal)
			$(".sendTotal").fadeIn(500)
		}else{
			$(".sendTotal").fadeOut(500)
		}
		
		if(response.tempTotal>0){
			$(".tempTotal span").text(response.tempTotal)
			$(".tempTotal").fadeIn(500)
		}else{
			$(".tempTotal").fadeOut(500)
		}
		
		if(response.trashTotal>0){
			$(".trashTotal span").text(response.trashTotal)
			$(".trashTotal").fadeIn(500)
		}else{
			$(".trashTotal").fadeOut(500)
		}
		
		
		  var unreadCount = ""
		  if(response.mailUnreadCount>999){
			  unreadCount="999+"
		  }else{
			  unreadCount=response.mailUnreadCount
		  }
		  $("#mail_unread_count").text(unreadCount)
		  $.each(response.dataList,function(i,v){
			  var isreadCheck=""
		  	  if(menuName=="받은메일함"){
		  		if(v.emlReadDt==null){
		  			  isreadCheck=`<ion-icon name="mail" class="mail-isread mail-unread"></ion-icon>`	
		  		  }else{
		  			  isreadCheck=`<ion-icon class="mail-isread" name="mail-open-outline"></ion-icon>`
		  		  }
		  	  }else if(menuName=="임시보관함"){
		  		isreadCheck=""
		  	  }else if(menuName=="보낸메일함"){
		  		isreadCheck=`<ion-icon class="mail-isread" name="mail-open-outline"></ion-icon>`
		  	  }else if(menuName=="전체메일"){
		  		if("${empId}"==v.senderId){
		  			 isreadCheck=`<ion-icon class="mail-isread" name="mail-open-outline"></ion-icon>`
		  		}else{
		  			if(v.emlReadDt==null){
			  			  isreadCheck=`<ion-icon name="mail" class="mail-isread mail-unread"></ion-icon>`	
			  		  }else{
			  			  isreadCheck=`<ion-icon class="mail-isread" name="mail-open-outline"></ion-icon>`
			  		  }
		  		}
		  	  }else if(menuName=="휴지통"){
			  		if("${empId}"==v.senderId){
			  			 isreadCheck=`<ion-icon class="mail-isread" name="mail-open-outline"></ion-icon>`
			  		}else{
			  			if(v.emlReadDt==null){
				  			  isreadCheck=`<ion-icon name="mail" class="mail-isread mail-unread"></ion-icon>`	
				  		  }else{
				  			  isreadCheck=`<ion-icon class="mail-isread" name="mail-open-outline"></ion-icon>`
				  		  }
			  		}
			  	  }
			  
			  
			  var bookmarkCheck=""
			  if(v.emlBookMark=='N'){
				  bookmarkCheck=`<ion-icon class="mail-important" name="star-outline"></ion-icon>`
			  }else{
				  bookmarkCheck=`<ion-icon class="mail-important important-yes" name="star"></ion-icon>`
			  }
			  
			  var sendDate = dateFormat(v.emlSndngDt)
			  
			  var existFile = ""
			  if(v.atchFileNo!=0){
				  existFile=`<ion-icon name="attach-outline"></ion-icon>`
			  }
			  
			  var mailType=""
			  if("${empId}"==v.senderId){
				  mailType="class='send'"
			  }else{
				  mailType="class='receive'"
			  }
			  console.log("zz")
			  console.log(v)
			  var profile ="/resources/img/basicProfile.png"
			  if(v.senderProfile!=null){
				  profile = "/everyware/mypage/thumbnail?empId="+v.senderId
			  }
			  var row = $(`
				  <tr id="\${v.emlId}" \${mailType}>
                  <td>
                    <div class="form-check">
	                    <label class="form-check-label" for="\${v.emlId}">
	                      <input type="checkbox" class="form-check-input" id="\${v.emlId}" name="mailCheck" value="\${v.emlId}">
	                    </label>
	                  </div>
                  </td>
                  <td class="mailbox-star">\${bookmarkCheck}</td>
                  <td class="mailbox-isread">\${isreadCheck}</td>
                  <td class="mailbox-subject"><b> \${v.emlTtl}</td>
                  <td class="mailbox-attachment">\${existFile}</td>
                  <td class="mailbox-name"><img class="mail_profile_img" data-empid="\${v.senderId}" data-empname="\${v.senderName}" data-jbgdnm="\${v.senderJbgdNm}" data-deptnm="\${v.senderDeptNm}" data-empmail="\${v.senderMail}" src="\${profile}"><div class="list_profile"><div class="list_profile_name">\${v.senderName} \${v.senderJbgdNm}</div><div class="list_profile_mail">\${v.senderMail}</div></div></td>
                  <td class="mailbox-date"><div>\${sendDate}</div></td>
                </tr>
				  `)
			  
			/* 	  $("#mail_list_content").append(row) */
				  row.hide().appendTo("#mail_list_content").fadeIn(700)
		  })
		  $(".mail_pagination").html(response.pagingHTML)
	}
	
	
	
	
	
	
	
	
	function getDetail(emlId, callback){
		$.ajax({
			  url: '/everyware/mail/detail', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: JSON.stringify({emlId:emlId}),
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	 contentType: 'application/json; charset=utf-8',
			  success: function(response) {
				callback(response)
			  },
			  error: function(xhr, status, error) {
				alertError("실패")
			  }
			});
	}
	
	
	
	
	
	function readMail(emlId,callback){
		$.ajax({
			  url: '/everyware/mail/readmail', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  data: JSON.stringify({emlId:emlId}),
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
		  	 contentType: 'application/json; charset=utf-8',
			  success: function(response) {
				 if(typeof callback !="undefined"){
					 callback(response)
				 }
				 
			  },
			  error: function(xhr, status, error) {
				alertError("실패")
			  }
			});
		
	}
	
	
	function mailWriteForm(callback){
		if(writeFlag){
			$(".mail-write-form").hide(100)
			setTimeout(() => {
				$(".mail_box").show(100)
			}, 100);
			writeFlag=false;
			menuFlag=true;
			writeFormReset()
		}else{

			getProfileList(function(profileList){
				console.log(profileList)
				console.log("얘는 전")
				var list=[]
				$.each(profileList,function(i,v){
					var profile ="/resources/img/basicProfile.png"
					if(v.empProfile!=null){
						profile = "/everyware/mypage/thumbnail?empId="+v.empId
					}
					var obj = {
							"value": v.empId,
							"name" : v.empName,
							"jbgdNm":v.jbgdNm,
							"deptNm":v.deptNm,
							"avatar":profile,
							"email":v.empMail
					}
					list.push(obj)
				})
				console.log(list)
				tagify.settings.whitelist=list
				
				if(typeof callback !='undefined'){
					callback();
				}
			})
				
			if(detailFlag){
				$(".mail_detail").hide(100)
				setTimeout(() => {
					$(".mail-write-form").show(100)
				}, 100);
				detailFlag=false
				writeFlag=true
			}else{
				$(".mail_box").hide(100)
				setTimeout(() => {
					$(".mail-write-form").show(100)
				}, 100);
				writeFlag=true
				menuFlag=false
			}
		}
		
		
	}
})
	
	
function getProfileList(callback){
		$.ajax({
			  url: '/everyware/mail/profileList', // 요청을 보낼 URL
			  method: 'post', // HTTP 메서드 (GET, POST 등)
			  beforeSend : function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  	  },
			  success: function(response) {
				callback(response)
			  },
			  error: function(xhr, status, error) {
				alertError("프로필 리스트 가져오기 실패")
			  }
			});
}
function dateFormat(data){
	var currentDate = new Date(data);

	// 연도, 월, 일, 시간, 분을 가져옵니다.
	var year = currentDate.getFullYear();
	var month = String(currentDate.getMonth() + 1).padStart(2, '0');
	var day = String(currentDate.getDate()).padStart(2, '0');
	var hours = String(currentDate.getHours()).padStart(2, '0');
	var minutes = String(currentDate.getMinutes()).padStart(2, '0');

	// "yyyy-mm-dd HH:MM" 형태의 문자열을 생성합니다.
	var formattedDate = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;

	return formattedDate;
	
}

function dateFormat2(data){
//입력된 날짜 문자열을 Date 객체로 변환합니다.
	var date = new Date(data);
	
	//연도, 월, 일, 시간, 분을 추출합니다.
	var year = date.getFullYear();
	var month = date.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
	var day = date.getDate();
	var hours = date.getHours();
	var minutes = date.getMinutes();
	
	//월과 일이 한 자리 수일 경우 앞에 0을 붙입니다.
	var formattedMonth = (month < 10 ? "0" : "") + month;
	var formattedDay = (day < 10 ? "0" : "") + day;
	
	// 2023년 7월 15일 (화) 오전 12시 25분와 같은 형태
	var formattedDateString = `\${year}년 \${formattedMonth}월 \${formattedDay}일 (\${getDayOfWeekString(date)}) \${getAMPMString(hours)} \${getFormattedHours(hours)}시 \${getFormattedMinutes(minutes)}분`;
	
	return formattedDateString
}
//요일을 문자열로 반환하는 함수
function getDayOfWeekString(date) {
const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
return daysOfWeek[date.getDay()];
}

//오전/오후를 문자열로 반환하는 함수
function getAMPMString(hours) {
return hours < 12 ? "오전" : "오후";
}

//시간을 12시간 형식으로 변환하는 함수
function getFormattedHours(hours) {
const formattedHours = hours % 12;
return formattedHours === 0 ? 12 : formattedHours;
}

//분을 두 자리 수로 변환하는 함수
function getFormattedMinutes(minutes) {
return minutes < 10 ? "0" + minutes : minutes;
}

function getFileType(fileName){
	var fileName = fileName;
	var dotIndex = fileName.lastIndexOf('.');
	var extension=""
	if (dotIndex !== -1) {
		extension = fileName.substr(dotIndex + 1);
	} else {
		extension=null
	}
	return extension;
}
function getMatchedIcon(type){
	switch (type) {
    case 'jpg':
      return 'img';
    case 'png':
    	return 'img';
    case 'docx':
    	return '<i class="far fa-file-word"></i>';
    case 'doc':
    	return '<i class="far fa-file-word"></i>';
    case 'ppt':
    	return '<i class="far fa-file-powerpoint"></i>';
    case 'pptx':
    	return '<i class="far fa-file-powerpoint"></i>';
    case 'pdf':
    	return '<i class="far fa-file-pdf"></i>';
    case 'zip':
    	return '<i class="far fa-file-archive"></i>';
    default:
    	return '<i class="far fa-file-alt"></i>';
  }
}

function convertFileSize(sizeInBite) {
	  const sizeInKB = sizeInBite / 1024;
	  if (sizeInKB < 1) {
	    return sizeInBite + ' b';
	  } else if (sizeInKB < 1024) {
	    return sizeInKB.toFixed(2) + ' KB';
	  } else if (sizeInKB < 1024 * 1024) {
	    const sizeInMB = (sizeInKB / 1024).toFixed(2);
	    return sizeInMB + ' MB';
	  } else {
	    const sizeInGB = (sizeInKB / (1024 * 1024)).toFixed(2);
	    return sizeInGB + ' GB';
	  }
	}
	
function getExtensionFromFileName(fileName) {
	  // 파일 이름에 '.'이 있는지 확인
	  const lastDotIndex = fileName.lastIndexOf('.');
	  
	  if (lastDotIndex !== -1) {
	    // 마지막 '.' 이후의 문자열을 확장자로 반환
	    return fileName.slice(lastDotIndex + 1);
	  } else {
	    // '.'이 없으면 확장자가 없는 경우이므로 빈 문자열 반환
	    return '';
	  }
	}
</script>
<script src="/resources/js/mail_tagify.js"></script> 