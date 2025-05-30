<table class="table table-bordered doc-aprvCn" data="$aprvCn">
    <colgroup>
        <col style="width:20%">
        <col style="width:80%">
    </colgroup>
    <tr>
        <td class="doc-header">잔여휴가일</td>
        <td data="$restVacDay"></td>
    </tr>
    <tr>
        <td class="doc-header">휴가종류</td>
        <td data="$viType">
            <span>
                <select class="custom-select custom-select-sm" name="viType" id="viType">
                	<c:forEach items="${vacationList }" var="item">
                    <option value="${item.viNo}">
                        ${item.viType} (${item.viDay}일)<br/>
                        <span style="font-size: 13px; color:gray;">${item.viMemo}</span>
                    </option>
                	</c:forEach>
                </select>
            </span>
        </td>
    </tr>
    <tr>
        <td class="doc-header">휴가기간</td>
        <td>
            <span><input type="date" name="vacBgngDt" id="vacBgngDt" data="$vacBgngDt">
            &nbsp;~&nbsp;
            <span></span><input type="date" name="vacEndDt" id="vacEndDt" data="$vacEndDt"></span>
        </td>
    </tr>
    <tr>
        <td class="doc-header">휴가사유</td>
        <td>
            <textarea id="editorArea"></textarea>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            위와 같이 휴가를 신청하오니 재가하여 주시기 바랍니다.
        </td>
    </tr>
</table>