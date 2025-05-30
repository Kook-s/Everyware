<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재</title>
<style type="text/css">
.apprval-type{
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
    <div class="modal fade" id="approval-process-modal">
        <div class="modal-dialog modal-md modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">결재</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>

            <div class="modal-body">
				<div class="pt-3 pl-3 pr-3">
					<div class="row approval-checkbox-wrap mb-4">
						<div class="col form-check form-check-inline">
							<input type="radio" class="form-control form-check-input apprval-type" name="approval-type" id="confirm" value="3" checked>
							<label class="radio-label" for="confirm">승인</label>
						</div>
						<div class="col form-check form-check-inline">
							<input type="radio" class="form-control form-check-input apprval-type" name="approval-type" id="reject" value="4">
							<label class="radio-label" for="reject">반려</label>
						</div>
					</div>
					<div class="form-group">
						<label class="oppn-label" for="oppn">결재의견</label>
						<textarea class="form-control" name="approval-oppn" id="approval-oppn"rows="5"></textarea>
					</div>
					<div class="form-group dcrb-box">
						<input type="checkbox" name="dcrbYn" id="dcrbYn">
						<label class="dcrb-label" for="dcrbYn">전결 처리</label>
						<span class="detail">(체크 시 결재가 종료됩니다.)</span>
					</div>
					<input type="hidden" id="approval-aprvLineSn">
					<input type="hidden" id="approval-order">
					<input type="hidden" id="approval-subYn">
				</div>
            </div>

            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
              <button type="button" class="btn btn-primary approval-process-btn" data-dismiss="modal">확인</button>
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