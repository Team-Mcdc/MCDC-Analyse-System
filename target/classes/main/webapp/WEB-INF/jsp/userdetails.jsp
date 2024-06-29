<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>User Details</title>
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
    <h2>用户详情</h2>
    <table>
        <tr>
            <th>属性</th>
            <th>值</th>
        </tr>
        <!-- Iterate over the list of users (assuming it's available as list1) -->
        <c:forEach var="user" items="${userList}">
            <tr>
                <td>用户名</td>
                <td>${user.name}</td>
            </tr>
            <tr>
                <td>真实姓名</td>
                <td>${user.realname}</td>
            </tr>
            <tr>
                <td>性别</td>
                <td>${user.gender}</td>
            </tr>
            <tr>
                <td>联系方式</td>
                <td>${user.phone}</td>
            </tr>
            <tr>
                <td>地址</td>
                <td>${user.address}</td>
            </tr>
            <tr>
                <td>上次登录时间</td>
                <td>${user.lastlogintime}</td>
            </tr>
            <tr>
                <td>角色</td>
                <td>${user.rolename}</td>
            </tr>
            <tr>
                <td>单位</td>
                <td>${user.workplace}</td>
            </tr>
        </c:forEach>
    </table>

    <!-- Return button -->
    <div class="return-btn">
        <a href="usertable">返回用户列表</a>
    </div>
</body>

</html>
