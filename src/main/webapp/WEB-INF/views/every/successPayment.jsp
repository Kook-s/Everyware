<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="position-relative">
  <div class="page-header min-vh-50 position-relative" style="background-image: url('../assets/img/bg6.jpg');" loading="lazy">
    <span class="mask bg-gradient-info opacity-6"></span>
  </div>
</header>
<div class="card card-body blur shadow-blur mx-4 mx-md-5 mx-lg-12 mt-n12">
  <div class="section my-4 my-lg-5">
    <div class="container">
      <div class="row flex-row">

        <div class="col-lg-12">
          <div>
            <h3 class="mt-lg-0 mt-4">EveryWare</h3>
            <span class="badge badge-success">basic</span>

            <table class="table table-pricing" style="width: 100%;">
              <thead class="text-light">
              <tr>
                <th class="ps-0">
                  <h6 class="mb-0">첨부파일</h6>
                  <h6 class="mb-0">클라우드</h6>
                  <h6 class="mb-0">사용자</h6>
                  <h6 class="mb-0">가격</h6>
                </th>
                <th class="" style="text-align: right;">
                  <h5 class="font-weight-bolder text-darker mb-0">${order.ordrPerson * product.addFileSz}  GB</h5>
                  <h5 class="font-weight-bolder text-darker mb-0">${order.ordrPerson * product.addCldSz} GB</h5>
                  <h5 class="font-weight-bolder text-darker mb-0">${order.ordrPerson} 명</h5>
                  <h5 class="font-weight-bolder text-darker mb-0">${order.ordrAmt}원</h5>
                </th>
              </tr>
              </thead>
            </table>

            <div class="row mt-4">

              <div class="col-lg-0 ms-auto">
                <button class="btn bg-gradient-info mb-0 mt-lg-auto w-100" type="button" name="button" onclick="location.href='/everysolution/home' ">확인</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
  function goHome(){
    location.herf = "/everysolution/home";
  }
</script>