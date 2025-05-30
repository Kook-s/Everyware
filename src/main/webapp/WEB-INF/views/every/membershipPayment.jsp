<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<header class="position-relative">
    <div class="page-header min-vh-50 position-relative" style="background-image: url('${pageContext.request.contextPath }/resources/assets/img/bg6.jpg');" loading="lazy">
        <span class="mask bg-gradient-info opacity-6"></span>
    </div>
</header>
<div class="card card-body blur shadow-blur mx-4 mx-md-5 mx-lg-10 mt-n9">
    <!-- <button class="btn btn-white ms-auto mt-n6 me-n3" type="button" name="button"><i class="material-icons me-2">shopping_cart</i>0 items</button> -->
    <div class="section my-4 my-lg-5">
        <div class="container">
            <div class="row flex-row">

                <div class="col-lg-12">
                    <div>
                        <h3 class="mt-lg-0 mt-4">EveryWare</h3>
                        <span class="badge badge-success">${product.pdtNm}</span>

                        <div class="accordion" id="accordionProduct">
                            <div class="accordion-item mb-1">
                                <h6 class="accordion-header" id="headingOne">
                                    <button class="accordion-button border-bottom font-weight-bold text-start" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        Description
                                        <i class="collapse-close fa fa-plus text-xs pt-1 position-absolute end-0"></i>
                                        <i class="collapse-open fa fa-minus text-xs pt-1 position-absolute end-0"></i>
                                    </button>
                                </h6>
                                <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionProduct">
                                    <div class="accordion-body text-sm opacity-8">
                                        Eres' daring 'Grigri Fortune' swimsuit has the fit and coverage of a bikini in a one-piece silhouette. This fuchsia style is crafted from the label's sculpting peau douce fabric and has flattering cutouts through the torso and back. Wear
                                        yours with mirrored sunglasses on vacation.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item mb-1">
                                <h6 class="accordion-header" id="headingTwo">
                                    <button class="accordion-button border-bottom font-weight-bold text-start" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                        Designer Information
                                        <i class="collapse-close fa fa-plus text-xs pt-1 position-absolute end-0"></i>
                                        <i class="collapse-open fa fa-minus text-xs pt-1 position-absolute end-0"></i>
                                    </button>
                                </h6>
                                <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionProduct">
                                    <div class="accordion-body text-sm opacity-8">
                                        An infusion of West Coast cool and New York attitude, Rebecca Minkoff is synonymous with It girl style. Minkoff burst on the fashion scene with her best-selling 'Morning After Bag' and later expanded her offering with the Rebecca Minkoff
                                        Collection - a range of luxe city staples with a "downtown romantic" theme.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item mb-1">
                                <h6 class="accordion-header" id="headingThree">
                                    <button class="accordion-button border-bottom font-weight-bold text-start" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                        Details and Care
                                        <i class="collapse-close fa fa-plus text-xs pt-1 position-absolute end-0"></i>
                                        <i class="collapse-open fa fa-minus text-xs pt-1 position-absolute end-0"></i>
                                    </button>
                                </h6>
                                <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionProduct">
                                    <div class="accordion-body text-sm opacity-8">
                                        <ul>
                                            <li>Storm and midnight-blue stretch cotton-blend</li>
                                            <li>Notch lapels, functioning buttoned cuffs, two front flap pockets, single vent, internal pocket</li>
                                            <li>Two button fastening</li>
                                            <li>84% cotton, 14% nylon, 2% elastane</li>
                                            <li>Dry clean</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-5">
                            <div class="col-lg-6 mt-lg-0 mt-2 d-flex">
                                <h5>첨부파일</h5><div style="text-align: right;" class="col-lg-8"><h6 id="fileSz">${product.addFileSz * product.dftPerson}</h6></div><h5>GB</h5>
                            </div>
                            <div class="col-lg-6 mt-lg-0 mt-2 d-flex">
                                <h5>클라우드</h5><div style="text-align: right;" class="col-lg-8"><h6 id="cldSz">${product.addCldSz * product.dftPerson}</h6></div><h5>GB</h5>
                            </div>
                        </div>
                        <div class="row mt-5">
                            <div class="col-lg-6 mt-lg-0 mt-2">
                                <h6 class="ms-0">사용자 수 지정</h6>
<%--                                <c:if test="${product.addDftPerson eq 100}" var="addDftPerson">--%>
<%--                                  <c:set value="${addDftPerson}"  var="addDftPerson"/>--%>
<%--                                </c:if>--%>
<%--                                <c:if test="${product.addDftPerson ne 100}" var="addDftPerson">--%>
<%--                                    <c:set value="${addDftPerson}"  var="addDftPerson"/>--%>
<%--                                </c:if>--%>
                                <input type="number" class="form-control ps-1" id="ordrPerson" min="${product.dftPerson}" max="${product.addDftPerson}" step="10" value="${product.dftPerson}" style="border: 1px solid gray;">
                            </div>
                            <div class="col-lg-6 mt-lg-0 mt-2 d-flex flex-column">
                                <h6 style="text-align: right;" class="mb-0 mt-2 ">가격</h6>
                                <h5 style="text-align: right;"  class="d-flex justify-content-end"><div id="prise">${product.dftPrice }</div><div> 원</div></h5>
                            </div>
                        </div>
                        <div class="row mt-4">

                            <div class="col-lg-4 ms-auto">
                                <button class="btn bg-gradient-info mb-0 mt-lg-auto w-100" type="button" name="button" onclick="requestPay()">구입</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<section class="py-md-7 pb-5">
    <div class="container">
        <div class="row text-center">
            <div class="col-lg-4 col-md-6">
                <div class="info">
                    <div class="icon icon-lg icon-shape bg-gradient-info shadow-info text-center border-radius-xl mt-n4">
                        <i class="material-icons opacity-10">local_shipping</i>
                    </div>
                    <h5 class="mt-4">24h Delivery</h5>
                    <p>Divide details about your product or agency work into parts. Write a few lines about each one. A paragraph describing a feature will be enough.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="info">
                    <div class="icon icon-lg icon-shape bg-gradient-info shadow-info text-center border-radius-xl mt-n4">
                        <i class="material-icons opacity-10">verified_user</i>
                    </div>
                    <h5 class="mt-4">Refundable Policy</h5>
                    <p>It really matters and then like it really doesn’t matter. What matters is the people who are sparked by it. And the people who are like offended by it.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="info">
                    <div class="icon icon-lg icon-shape bg-gradient-info shadow-info text-center border-radius-xl mt-n4">
                        <i class="material-icons opacity-10">favorite</i>
                    </div>
                    <h5 class="mt-4">Popular Item</h5>
                    <p>That’s what I’m here for. Don’t be afraid to be wrong because you can’t learn anything from a compliment. Why would anyone pick blue over pink? </p>
                </div>
            </div>
        </div>
    </div>
</section>

<script type="text/javascript">

$(function(){
    $("#ordrPerson").on("click" , function(){

        $("#fileSz").text($("#ordrPerson").val()*${product.addFileSz})
        $("#cldSz").text($("#ordrPerson").val()*${product.addCldSz})
        $("#prise").text($("#ordrPerson").val()*${product.addPrice})
    })
})

    function requestPay() {
        var price = document.querySelector("#prise").innerText;
        alert("${client.picNm}")
        const userCode = 'imp75664656';
        IMP.init(userCode); // 가맹점 식별 코드를 넣어 모듈을 초기화해주세요.

        IMP.request_pay({ // param
            pg: "kakaopay",
            pay_method: "card",
            merchant_uid: "merchant"+ new Date().getTime(),
            name: "EveryWare${product.pdtNm}",
            amount: parseInt(price),
            customer_uid: "kooks"+ new Date().getTime(),
            buyer_email: "${client.custId}@naver.com",
            buyer_name: "${client.picNm}",
            buyer_tel: "${client.brno}",
            buyer_addr: "${client.bplcAddr}",
            buyer_postcode: "${client.bplcZip}"
        }, function(rsp){ // callback

            if (rsp.success) {
                console.log("rsp",rsp);
                // 결제 성공 시 로직
                alert("결제성공")

                $.ajax({
                    url: '/everysolution/payment',
                    method: 'post',
                    data: {custId: "${client.custId}",
                            ordrPerson: $("#ordrPerson").val()},
                    beforeSend : function(xhr){
                        xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                    },
                    success: function(res){
                        if(res == "OK"){
                            alert("성공")
                            location.href="/everysolution/successPayment?pdtNm=${product.pdtNm}";}
                        else{
                            console.log("실패임",res.status)
                        }
                    },
                    error: function(xhr){
                        console.log("실패",xhr.status);
                    }
                })
                // location.href="/everysolution/successPayment";
            } else {
                // 결제 실패 시 로직
                alert("결제실패")
                // location.href="/everysolution/successPayment";
            }
        });
    }

</script>

