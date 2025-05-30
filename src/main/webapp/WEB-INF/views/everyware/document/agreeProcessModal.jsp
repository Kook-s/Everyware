<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>합의</title>
<style type="text/css">
.agree-type{
	height: 20px !important;
    width: 40px !important;
}
label{
	margin: 0px !important;
}
.oppn-label{
	font-weight: 300 !important;
    /* color: #999999 !important; */
    font-size: 17px !important;
}
.detail{
	font-size: 15px;
    color: #979797;
}
.dcrb-label{
	font-weight: 300 !important;
}
.radio-label{
	font-size: 20px;
}
</style>
</head>
<body>
    <!-- 모달 시작 -->
    <div class="modal fade" id="agree-process-modal">
        <div class="modal-dialog modal-md modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">합의</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>

            <div class="modal-body">
				<div class="pt-3 pl-3 pr-3">
					<div class="row agree-checkbox-wrap mb-4">
						<div class="col form-check form-check-inline">
							<input type="radio" class="form-control form-check-input agree-type" name="agree-type" id="agree" value="3" checked>
							<label class="radio-label" for="confirm">합의</label>
						</div>
						<div class="col form-check form-check-inline">
							<input type="radio" class="form-control form-check-input agree-type" name="agree-type" id="disagree" value="4">
							<label class="radio-label" for="reject">반대</label>
						</div>
					</div>
					<div class="form-group">
						<label class="oppn-label" for="oppn">합의의견</label>
						<textarea class="form-control" name="agree-oppn" id="agree-oppn"rows="5"></textarea>
					</div>
					<input type="hidden" id="agree-aprvLineSn">
				</div>
            </div>

            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
              <button type="button" class="btn btn-primary agree-process-btn" data-dismiss="modal">확인</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
      <!-- /.modal-dialog -->
    </div>
    <!-- 모달 끝 -->
<script type="text/javascript">
$(function(){
	
});
</script>
</body>
</html>