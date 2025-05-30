<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<section class="py-lg-0 pb-5">
  <div class="bg-gradient-dark position-relative m-0  shadow-lg overflow-hidden" style="background-image: url('https://images.unsplash.com/photo-1467541473380-93479a5a3ffa?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2246&q=80'); background-size: cover;" loading="lazy">
    <span class="mask bg-gradient-dark opacity-6"></span>
    <div class="container pb-lg-9 pb-7 pt-7 position-relative z-index-1">
      <div class="row">
        <div class="col-md-8 mx-auto text-center">
<%--          <span class="badge bg-gradient-dark mb-2">Pricing</span>--%>
          <h3 class="text-white">Every Membership</h3>
          <p class="text-white">저희는 회원님의 능력을 발휘할 수 있게 도울 것 입니다.</p>
        </div>
      </div>
    </div>
  </div>
  <div class="mt-sm-n10 mt-n7">
    <div class="container">
      <div class="row mb-5">
        <div class="col-lg-4 col-md-6 col-7 mx-auto text-center">
          <div class="nav-wrapper mt-5 position-relative z-index-2">
            <ul class="nav nav-pills nav-fill flex-row p-1" id="tabs-pricing" role="tablist">
              <li class="nav-item">
                <a class="nav-link mb-0 active" id="tabs-iconpricing-tab-1" data-bs-toggle="tab" href="#monthly" role="tab" aria-controls="monthly" aria-selected="true">
                  Basic
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link mb-0" id="tabs-iconpricing-tab-2" data-bs-toggle="tab" href="#annual" role="tab" aria-controls="annual" aria-selected="false">
                  Premium
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="tab-content tab-space">
        <div class="tab-pane active" id="monthly">
          <div class="row">
            <div class="col-lg-4 mb-lg-0 mb-4">
              <div class="card shadow-lg">
                <span class="badge rounded-pill bg-light text-dark w-30 mt-n2 mx-auto">FILE</span>
                <div class="card-header text-center pt-4 pb-3">
                  <h1 class="font-weight-bold mt-2">
                    <small class="text-lg align-top me-1"></small>60<small class="text-lg">.GB</small>
                  </h1>
                </div>
                <div class="card-body text-lg-start text-center pt-0">
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">60GB 기본 제공</span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">1이당 3GB 추가</span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">자유로운 형식</span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">remove</i>
                    <span class="ps-3">매월 초기화되는 공간</span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">remove</i>
                    <span class="ps-3">API Access </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">remove</i>
                    <span class="ps-3">Complete documentation </span>
                  </div>
<%--                  <a href="javascript:;" class="btn btn-icon bg-gradient-dark d-lg-block mt-3 mb-0">--%>
<%--                    Join--%>
<%--                    <i class="fas fa-arrow-right ms-1"></i>--%>
<%--                  </a>--%>
                </div>
              </div>
            </div>
            <div class="col-lg-4 mb-lg-0 mb-4">
              <div class="card bg-gradient-dark shadow-lg">
                <span class="badge rounded-pill bg-info w-30 mt-n2 mx-auto">Basic</span>
                <div class="card-header text-center pt-4 pb-3 bg-transparent">
                  <h1 class="font-weight-bold mt-2 text-white">
                    <small class="text-lg align-top me-1"></small>200,000<small class="text-lg">원</small>
                  </h1>
                </div>
                <div class="card-body text-lg-start text-center pt-0">
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto text-white">done</i>
                    <span class="ps-3 text-white">인원 제한 20명 제공</span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto text-white">done</i>
                    <span class="ps-3 text-white">자유로운 관리 권한</span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto text-white">done</i>
                    <span class="ps-3 text-white">지문인식</span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto text-white">done</i>
                    <span class="ps-3 text-white">Sketch Files </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto text-white">remove</i>
                    <span class="ps-3 text-white">API Access </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto text-white">remove</i>
                    <span class="ps-3 text-white">Complete documentation </span>
                  </div>
                  <a href="/everysolution/payment?pdtNm=basic" class="btn btn-icon bg-gradient-info d-lg-block mt-3 mb-0">
                    Try Basic
                    <i class="fas fa-arrow-right ms-1"></i>
                  </a>
                </div>
              </div>
            </div>
            <div class="col-lg-4 mb-lg-0 mb-4">
              <div class="card shadow-lg">
                <span class="badge rounded-pill bg-light text-dark w-30 mt-n2 mx-auto">Enterprise</span>
                <div class="card-header text-center pt-4 pb-3">
                  <h1 class="font-weight-bold mt-2">
                    <small class="text-lg align-top me-1">$</small>99<small class="text-lg">/mo</small>
                  </h1>
                </div>
                <div class="card-body text-lg-start text-center pt-0">
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">Unlimited team members</span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">100GB Cloud storage </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">Integration help </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">Sketch Files </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">API Access </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">Complete documentation </span>
                  </div>
<%--                  <a href="javascript:;" class="btn btn-icon bg-gradient-dark d-lg-block mt-3 mb-0">--%>
<%--                    Join--%>
<%--                    <i class="fas fa-arrow-right ms-1"></i>--%>
<%--                  </a>--%>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="tab-pane" id="annual">
          <div class="row">
            <div class="col-lg-4 mb-lg-0 mb-4">
              <div class="card shadow-lg">
                <span class="badge rounded-pill bg-light text-dark w-30 mx-auto">Starter</span>
                <div class="card-header text-center pt-4 pb-3">
                  <h1 class="font-weight-bold mt-2">
                    <small class="text-lg align-top me-1">$</small>119<small class="text-lg">/mo</small>
                  </h1>
                </div>
                <div class="card-body text-lg-start text-center pt-0">
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">2 team members</span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">20GB Cloud storage </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">remove</i>
                    <span class="ps-3">Integration help </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">remove</i>
                    <span class="ps-3">Sketch Files </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">remove</i>
                    <span class="ps-3">API Access </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">remove</i>
                    <span class="ps-3">Complete documentation </span>
                  </div>
<%--                  <a href="javascript:;" class="btn btn-icon bg-gradient-dark d-lg-block mt-3 mb-0">--%>
<%--                    Join--%>
<%--                    <i class="fas fa-arrow-right ms-1"></i>--%>
<%--                  </a>--%>
                </div>
              </div>
            </div>
            <div class="col-lg-4 mb-lg-0 mb-4">
              <div class="card bg-gradient-dark shadow-lg">
                <span class="badge rounded-pill bg-primary w-30 mx-auto">Premium</span>
                <div class="card-header text-center pt-4 pb-3 bg-transparent">
                  <h1 class="font-weight-bold mt-2 text-white">
                    <small class="text-lg align-top me-1">$</small>159<small class="text-lg">/mo</small>
                  </h1>
                </div>
                <div class="card-body text-lg-start text-center pt-0">
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto text-white">done</i>
                    <span class="ps-3 text-white">10 team members</span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto text-white">done</i>
                    <span class="ps-3 text-white">40GB Cloud storage </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto text-white">done</i>
                    <span class="ps-3 text-white">Integration help </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto text-white">done</i>
                    <span class="ps-3 text-white">Sketch Files </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto text-white">remove</i>
                    <span class="ps-3 text-white">API Access </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto text-white">remove</i>
                    <span class="ps-3 text-white">Complete documentation </span>
                  </div>
                  <a href="/everysolution/payment?pdtNm=premium" class="btn btn-icon bg-gradient-primary d-lg-block mt-3 mb-0">
                    Try Premium
                    <i class="fas fa-arrow-right ms-1"></i>
                  </a>
                </div>
              </div>
            </div>
            <div class="col-lg-4 mb-lg-0 mb-4">
              <div class="card shadow-lg">
                <span class="badge rounded-pill bg-light text-dark w-30 mx-auto">Enterprise</span>
                <div class="card-header text-center pt-4 pb-3">
                  <h1 class="font-weight-bold mt-2">
                    <small class="text-lg align-top me-1">$</small>399<small class="text-lg">/mo</small>
                  </h1>
                </div>
                <div class="card-body text-lg-start text-center pt-0">
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">Unlimited team members</span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">100GB Cloud storage </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">Integration help </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">Sketch Files </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">API Access </span>
                  </div>
                  <div class="d-flex justify-content-lg-start justify-content-center p-2">
                    <i class="material-icons my-auto">done</i>
                    <span class="ps-3">Complete documentation </span>
                  </div>
<%--                  <a href="javascript:;" class="btn btn-icon bg-gradient-dark d-lg-block mt-3 mb-0">--%>
<%--                    Join--%>
<%--                    <i class="fas fa-arrow-right ms-1"></i>--%>
<%--                  </a>--%>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<section class="pt-5">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-12 text-center">
        <h2 class="text-gradient text-info text-center">Compare Features</h2>
        <p class="lead mb-5">Join the world&#39;s largest developer community</p>
      </div>
      <div class="col-lg-10">
        <div class="table-responsive">
          <table class="table table-pricing">
            <thead class="text-light">
            <tr>
              <th class="ps-2">
                <h6 class="mb-0">Space individual</h6>
              </th>
              <th class="text-center">
                <h6 class="font-weight-bold">Team</h6>
                <h5 class="font-weight-bolder text-darker mb-0">$39</h5>
              </th>
              <th class="text-center">
                <h6 class="font-weight-bold">Growth</h6>
                <h5 class="font-weight-bolder text-darker mb-0">$79</h5>
              </th>
              <th class="text-center">
                <h6 class="font-weight-bold">Enterprise</h6>
                <h5 class="font-weight-bolder text-darker mb-0">$99</h5>
              </th>
            </tr>
            </thead>
            <tbody>
            <tr>
              <td class="py-3">
                <span class="text-xs">Community support</span>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-check text-success text-xs"></i>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-check text-success text-xs"></i>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-check text-success text-xs"></i>
              </td>
            </tr>
            <tr>
              <td class="py-3">
                <span class="text-xs">100+ Example Pages</span>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-check text-success text-xs"></i>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-check text-success text-xs"></i>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-check text-success text-xs"></i>
              </td>
            </tr>
            <tr>
              <td class="py-3">
                <span class="text-xs">50+ Section Examples</span>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-check text-success text-xs"></i>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-check text-success text-xs"></i>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-check text-success text-xs"></i>
              </td>
            </tr>
            <tr>
              <td class="py-3">
                <span class="text-xs">Multiple use</span>
              </td>
              <td class="text-center py-3">

              </td>
              <td class="text-center py-3">
                    <span class="text-xs">
                      upon request
                    </span>
              </td>
              <td class="text-center py-3">
                    <span class="text-xs">
                      upon request
                    </span>
              </td>
            </tr>
            <tr>
              <th class="pt-4 pb-2 ps-2">
                <h6 class="mb-0">Developer tools</h6>
              </th>
              <th></th>
              <th></th>
              <th></th>
            </tr>
            <tr>
              <td class="py-3">
                <span class="text-xs">Custom messages</span>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-minus text-secondary text-xs"></i>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-check text-success text-xs"></i>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-check text-success text-xs"></i>
              </td>
            </tr>
            <tr>
              <td class="py-3">
                <span class="text-xs">Multiple requests</span>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-minus text-secondary text-xs"></i>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-minus text-secondary text-xs"></i>
              </td>
              <td class="text-center py-3">
                <i class="fas fa-check text-success text-xs"></i>
              </td>
            </tr>
            <tr>
              <!-- <th class="border-bottom-0"></th>
              <th class="text-center align-items-center border-bottom-0">
                <a href="javascript:;" class="btn btn-dark mt-3">Choose Plan</a>
              </th>
              <th class="text-center align-items-center border-bottom-0">
                <a href="javascript:;" class="btn btn-dark mt-3">Choose Plan</a>
              </th>
              <th class="text-center align-items-center border-bottom-0">
                <a href="javascript:;" class="btn bg-gradient-info mt-3">Choose Plan</a>
              </th> -->
            </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</section>