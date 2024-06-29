<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Monthly Borrow Count Chart</title>

    <!-- 导入Chart.js库 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>
    <%@ include file="Main1.jsp" %>
    <h2>图书统计</h2>
    <p>本单位总图书数：${unitBookCount}</p>
    <p>当前在库总图书数：${inStockBookCount}</p>

    <canvas id="monthlyBorrowChart" width="400" height="200"></canvas>

    <script>
        // 获取从Spring控制器传递过来的数据
        var monthlyBorrowCountData = ${monthlyBorrowCount};

        // 转换数据为Chart.js所需的格式
        var labels = Object.keys(monthlyBorrowCountData);
        var data = Object.values(monthlyBorrowCountData);

        // 创建柱状图
        var ctx = document.getElementById('monthlyBorrowChart').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Borrow Count',
                    data: data,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>

</html>
