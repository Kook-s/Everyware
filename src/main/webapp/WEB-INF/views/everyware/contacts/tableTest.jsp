<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.bootstrap4.min.css">
<link rel="stylesheet" href="../../../../resources/bootstrap/dist/css/adminlte.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js" defer></script>
<script src="https://cdn.datatables.net/1.13.5/js/dataTables.bootstrap4.min.js" defer></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js" defer></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap4.min.js" defer></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js" defer></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.colVis.min.js" defer></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js" defer></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js" defer></script>
    <script type="text/javascript">
        $(document).ready(function() {
            var table = $('#example').DataTable({
                "columnDefs": [
                    { "orderable": false, "targets": 0 }, // 체크박스 열 비활성화
                    { "orderable": false, "targets": -1 } // 버튼 열 비활성화
                ]
            });

            $('#example tbody').on('change', 'input[type="checkbox"]', function() {
                // 체크박스 변경 이벤트 핸들러
                if ($(this).is(':checked')) {
                    $(this).closest('tr').addClass('selected');
                } else {
                    $(this).closest('tr').removeClass('selected');
                }

                // 체크된 행의 개수에 따라 버튼 활성화/비활성화
                var selectedRows = table.rows('.selected').data().length;
                if (selectedRows > 0) {
                    $('#editBtn, #deleteBtn').prop('disabled', false);
                } else {
                    $('#editBtn, #deleteBtn').prop('disabled', true);
                }
            });

            $('#editBtn').click(function() {
            	// 수정 버튼 클릭 이벤트 핸들러
            	alert('click');
                var selectedRowsData = table.rows('.selected').data();
                console.log('selectedRowsData', selectedRowsData);
                if (selectedRowsData.length > 0) {
                	var cells = table.rows('.selected').nodes();
                  	console.log('cells', cells[1]);

                  cells.each(function() {
                    var cellData = $(this).text();
                	  console.log(cellData);
                    $(this).html('<input type="text" value="' + cellData + '">');
                  });
                }
                
                
                
            });
        });
    </script>
</head>
<body>
    <table id="example" class="display">
        <thead>
            <tr>
                <th></th>
                <th>Name</th>
                <th>Position</th>
                <th>Office</th>
                <th>Age</th>
                <th>Start date</th>
                <th>Salary</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><input type="checkbox"></td>
                <td>Tiger Nixon</td>
                <td>System Architect</td>
                <td>Edinburgh</td>
                <td>61</td>
                <td>2011/04/25</td>
                <td>$320,800</td>
            </tr>
            <tr>
                <td><input type="checkbox"></td>
                <td>Garrett Winters</td>
                <td>Accountant</td>
                <td>Tokyo</td>
                <td>63</td>
                <td>2011/07/25</td>
                <td>$170,750</td>
            </tr>
            <!-- 나머지 행들 -->
        </tbody>
    </table>

    <button id="editBtn" disabled>Edit</button>
    <button id="deleteBtn" disabled>Delete</button>
</body>
</html>