<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<button onclick="requestPay()">결제하기</button>
</head>
<body>

</body>
<script type="text/javascript">
 // 예: imp00000000

function requestPay() {
	const userCode = 'imp75664656';
	IMP.init(userCode); // 가맹점 식별 코드를 넣어 모듈을 초기화해주세요.

	IMP.request_pay({ // param
        pg: "tosspayments",
        pay_method: "card",
        merchant_uid: "ORD20180131-54322311",
        name: "노르웨이 회전 의자",
        amount: 100,
        buyer_email: "bjmonly1@naver.com",
        buyer_name: "신국현",
        buyer_tel: "010-7389-3274",
        buyer_addr: "대전 중구 오류동",
        buyer_postcode: "01181"
    }, function (rsp) { // callback
        if (rsp.success) {
            // 결제 성공 시 로직
        } else {
            // 결제 실패 시 로직
        }
    });
	}
</script>
</html>