<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- 근태 시간 -->
    <div class="row">
        <div class="col-md-4">
            <div class="card">

                <div class="card-header">
                    <h3 class="card-title">
                        <ion-icon name="alarm-outline"></ion-icon>
                        오늘의 출퇴근
                    </h3>

                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                </div>

                <div class="card-body" style="display: block;">
                    <div>
                        <!-- 시계 -->
                        <div id="date" class="date"></div>
                        <div id="time" class="time"></div>
                        <div id="today">

                        </div>

                        <div class="today">
                            <c:set value="${workList }" var="work" />
                            <c:choose>
                                <c:when test="${empty work }">
                                    <table>
                                        <tr>
                                            <td>
                                                <button type="button" class="btn btn-block bg-gradient-primary"
                                                    id="btnWorkBgngDt">출근</button>
                                            </td>
                                            <td>00:00:00</td>
                                            <td>
                                                <button type="button" class="btn btn-block bg-gradient-secondary"
                                                    id="btnWorkEndDt">퇴근</button>
                                            </td>
                                            <td>00:00:00</td>
                                        </tr>
                                    </table>
                                </c:when>

                                <c:otherwise>
                                    <c:forEach items="${work }" var="work">
                                        <c:set var="workDt" value="${work.workDt}" />
                                        <c:set var="workBgngDt" value="${work.workBgngDt}" />
                                        <c:set var="workEndDt" value="${work.workEndDt}" />
                                        <table>
                                            <tr>
                                                <td>
                                                    <button type="button" class="btn btn-block bg-gradient-primary"
                                                        id="btnWorkBgngDt">출근</button>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${workBgngDt}" pattern="HH:mm:ss"
                                                        type="date" />
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-block bg-gradient-secondary"
                                                        id="btnWorkEndDt">퇴근</button>
                                                </td>
                                                <td>
                                                    <c:if test="${workEndDt eq null}">
                                                        00:00:00
                                                    </c:if>
                                                    <c:if test="${workEndDt ne null}">
                                                        <fmt:formatDate value="${workEndDt}" pattern="HH:mm:ss"
                                                            type="date" />
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </table>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>