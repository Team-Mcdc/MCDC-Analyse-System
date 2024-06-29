<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Book Borrow</title>
    <style>
        body {
            padding: 20px;
            font-family: Arial, sans-serif;
        }

        h2 {
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #5bc0de;
            color: #fff;
        }

        a.btn {
            margin-right: 5px;
        }

        /* Style for the return button */
        .return-btn {
            margin-top: 20px;
        }

        /* Style for the status buttons */
        .status-btns {
            margin-bottom: 10px;
        }

        .status-btns a {
            display: inline-block;
            padding: 5px 10px;
            margin-right: 10px;
            text-decoration: none;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .status-btns a.active {
            background-color: #5bc0de;
            color: #fff;
            border: 1px solid #5bc0de;
        }

        /* Set the color for the "待审核" button */
        .status-btns a[href="borrowmanagement"] {
            color: blue;
        }
    </style>
</head>

<body>
    <%@ include file="Main1.jsp" %>
    <h2>流入管理</h2>

    <!-- Status buttons -->
    <div class="status-btns">
        <a href="borrowmanagement" >待审核</a>
        <a href="approved" >已审核</a>
        <a href="completed" >已结束</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>流通ID</th>
                <th>图书ID</th>
                <th>所属单位</th>
                <th>借阅单位</th>
                <th>借阅时间</th>
                <th>归还时间</th>
                <th>借阅理由</th>
                <th>借阅人</th>
                <th>联系方式</th>
                <th>借入状态</th>
                <th>操作</th> <!-- 新添加的操作列 -->
                <!-- 可根据需要添加其他字段 -->
            </tr>
        </thead>
        <tbody>
            <!-- Iterate over the list of flows (assuming it's available as flowlist) -->
            <c:forEach var="flow" items="${flowlist}">
                <tr>
                    <td>${flow.borrowingid}</td>
                    <td>${flow.bookid}</td>
                    <td>${flow.fromunit}</td>
                    <td>${flow.tounit}</td>
                    <td>${flow.borrowingtime}</td>
                    <td>${flow.returntime}</td>
                    <td>${flow.borrowingreason}</td>
                    <td>${flow.borrower}</td>
                    <td>${flow.borrowercontact}</td>
                    <td>${flow.flow}</td>
                    <td>
                        <!-- 添加拒绝流入和归还的操作链接 -->
                        <a href="rejectflow?borrowingid=${flow.borrowingid}" title="拒绝流入">拒绝流入</a>
                       
                    </td>
                    <!-- 添加其他字段的显示 -->
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Return button -->
</body>

</html>
