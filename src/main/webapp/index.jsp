<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>SQL Gateway - Murach's Java Servlets and JSP</title>
    <link rel="stylesheet" href="styles/main.css" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sqlStatement == null}">
    <c:set var="sqlStatement" value="select * from User" />
</c:if>

<div class="container">
    <div class="header">
        <h1><i class="fas fa-database"></i> SQL Gateway</h1>
        <p>Enter an SQL statement and click the Execute button</p>
    </div>

    <div class="content">
        <div class="form-section">
            <div class="section-title">
                <i class="fas fa-code"></i> SQL Statement
            </div>
            <form class="sql-form" action="sqlGateway" method="post" id="sqlForm">
                <textarea class="sql-textarea" name="sqlStatement" cols="60" rows="8" placeholder="Enter your SQL query here...">${sqlStatement}</textarea>
                <button type="submit" class="execute-btn">
                    <i class="fas fa-play"></i> Execute Query
                </button>
            </form>
        </div>

        <div class="result-section">
            <div class="section-title">
                <i class="fas fa-table"></i> SQL Result
            </div>
            <div class="loading" id="loading">
                <i class="fas fa-spinner"></i>
                <p>Processing your query...</p>
            </div>
            <div class="sql-result" id="sqlResult">
                ${sqlResult}
            </div>
        </div>
    </div>
</div>

<script>
    // Hiển thị loading khi submit form
    document.getElementById('sqlForm').addEventListener('submit', function() {
        document.getElementById('loading').style.display = 'block';
        document.getElementById('sqlResult').innerHTML = '';
    });

    // Nếu đã có kết quả, ẩn loading
    window.addEventListener('load', function() {
        if(document.getElementById('sqlResult').innerHTML.trim() !== '') {
            document.getElementById('loading').style.display = 'none';
        }

        // Format lại kết quả SQL nếu là bảng
        formatSQLResult();
    });

    // Hàm định dạng kết quả SQL
    function formatSQLResult() {
        const resultDiv = document.getElementById('sqlResult');
        const content = resultDiv.innerHTML.trim();

        // Kiểm tra xem có phải là kết quả bảng không
        if (content.includes('<table')) {
            // Thêm lớp cho bảng để CSS có thể định dạng
            const tables = resultDiv.getElementsByTagName('table');
            for (let table of tables) {
                table.classList.add('sql-table');

                // Thêm lớp cho các hàng và ô
                const rows = table.getElementsByTagName('tr');
                for (let i = 0; i < rows.length; i++) {
                    if (i === 0) {
                        // Hàng đầu tiên là header
                        const ths = rows[i].getElementsByTagName('th');
                        if (ths.length === 0) {
                            // Nếu không có th, chuyển đổi td đầu tiên thành th
                            const tds = rows[i].getElementsByTagName('td');
                            if (tds.length > 0) {
                                for (let j = 0; j < tds.length; j++) {
                                    const td = tds[j];
                                    const th = document.createElement('th');
                                    th.innerHTML = td.innerHTML;
                                    td.parentNode.replaceChild(th, td);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
</script>
</body>
</html>