<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Unit Details</title>
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
    </style>
</head>

<body>
<%@ include file="Main.jsp" %>
    <h2>单位详情</h2>
    <table>
        <tr>
            <th>属性</th>
            <th>值</th>
        </tr>
        <!-- Iterate over the list of units (assuming it's available as unitList) -->
        <c:forEach var="unit" items="${unitList}">
            <tr>
                <td>单位名称</td>
                <td>${unit.unitname}</td>
            </tr>
            <tr>
                <td>单位联系人</td>
                <td>${unit.contactperson}</td>
            </tr>
            <tr>
                <td>联系电话</td>
                <td>${unit.contactphone}</td>
            </tr>
            <tr>
                <td>联系地址</td>
                <td>${unit.contactaddress}</td>
            </tr>
            <tr>
                <td>邮箱地址</td>
                <td>${unit.emailaddress}</td>
            </tr>
            <tr>
                <td>单位性质</td>
                <td>${unit.unittype}</td>
            </tr>
            <!-- Add more rows for other unit details as needed -->
        </c:forEach>
    </table>

    <!-- Return button -->
    <div class="return-btn">
        <a href="unit">返回单位列表</a>
    </div>
</body>

</html>
