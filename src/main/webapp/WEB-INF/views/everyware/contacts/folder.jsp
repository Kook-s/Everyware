<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>폴더관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/themes/default/style.min.css" />
<script src="/resources/jstree/dist/jstree.min.js"></script>
<style>
	* {
		box-sizing: border-box;
	}
/* 
	.tree-folder {
		width: 350px;
		height: 500px;
		border: 1px solid red;
	}

	.folder-form {
		width: 500px;
		height: 500px;
		border: 1px solid red;
	} */
	.folder-list-card{
		height: 400px;
	}
	.submenu-body {
        margin-bottom: 1px;
    }
</style>
</head>

<body>
	<div class="content-container">
		<section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>주소록</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">주소록</li>
                            <li class="breadcrumb-item active">폴더설정</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>
		<section class="content">
            <div class="container-fluid">
				<div class="row">
					<!-- subMenu -->
                    <div class="col-md-2">
                        <a href="/everyware/contacts/new" class="btn btn-primary btn-block mb-2 write-btn">주소록 추가</a>
                        <div class="card">
                            <div class="card card-light submenu-body">
                                <div class="card-header">
                                    <h3 class="card-title">주소록</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body p-0" style="display: block;">
                                    <ul class="nav nav-pills flex-column">
                                        <li class="nav-item active">
                                            <a href="#" class="nav-link">
                                                사내주소록
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">
                                                사외주소록
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="card card-light submenu-body">
                                <div class="card-header">
                                    <h3 class="card-title">설정(임시)</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body p-0" style="display: block;">
                                    <ul class="nav nav-pills flex-column">
                                        <li class="nav-item active">
                                            <a href="/everyware/folderTest" class="nav-link">
                                                폴더설정
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
					<!-- /.subMenu -->
					<div class="col-md-10">
						<!-- <div class="card card-light"> -->
							<!-- <div class="card-header">
								<h3 class="card-title">폴더 설정</h3>
							</div> -->
							<!-- <div class="card-body px-5 py-5"> -->
								<div class="row">
									<div class="col-md-5">
										<div class="card card-primary card-outline folder-list-card">
											<div class="card-header">
												<h3 class="card-title">내 폴더</h3>
											</div>
											<div class="card-body">
												<div class="tree-folder"></div>
											</div>
										</div>
									</div>
		
									<div class="col-md-7 ml-auto folder-form">
										<div class="card card-primary">
											<div class="card-header">
												<h3 class="card-title">상세조회</h3>
											</div>
											<div class="card-body">
												<form>
													<div class="form-group">
														<label for="type">폴더 종류</label><br/>
														<div class="row">
															<div class="col-md-4">
																<div class="icheck-primary d-inline">
																	<input type="radio" id="radioPrimary1" name="type" disabled checked>
																	<label for="radioPrimary1">
																		사내주소록
																	</label>
																</div>
															</div>
															<div class="col-md-4">
																<div class="icheck-primary d-inline">
																	<input type="radio" id="radioPrimary1" name="type" disabled>
																	<label for="radioPrimary1">
																		사외주소록
																	</label>
																</div>
															</div>
														</div>
													</div>
													<div class="form-group">
														<label for="exampleInputEmail1">폴더명</label>
														<input type="email" class="form-control" id="exampleInputEmail1"
															placeholder="폴더명을 입력해주세요.">
													</div>
													<div class="form-group">
														<label for="folder-select-box">상위 폴더</label>
														<select class="custom-select custom-select-sm folder-select-box">
															<option value="/"></option>
														</select>
													</div>
													
													<div class="card-footer justify-content-between">
														<button type="button" class="btn btn-warning">추가</button>
														<button type="submit" class="btn btn-primary">저장</button>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							<!-- </div> -->
						<!-- </div> -->
					</div>
				</div>
			</div>
		</section>
	</div>
<script>
	var tree = $('.tree-folder');

	$(function () {
		$.ajax({
			url: "/everyware/contacts/folders",
			type: "GET",
			dataType: "json",
			success: function (rslt) {
				showFolderTree(rslt);
				tree.jstree("open_all");
			}
		});
	})

	// $(tree).jstree().on('select_node.jstree', function (e, data) {

	// 	alert('e: ', e, ' data: ', data);

	// });

	showFolderTree = function (data) {
		tree.jstree({
			// 트리 설정
			'core': {
				"themes": {
					"responsive": true
				},
				'data': data
			},
			'types': {
				'default': {
					'icon': 'fa fa-folder text-warning'
				}
			},
			'plugins': [
				'types',
				'search'
			]
		});
	}

	tree.on('select_node.jstree', function (e, data) {
		var node = data.node;
		console.log(node.original); // 원시 정보 출력
	});
</script>
</body>

</html>