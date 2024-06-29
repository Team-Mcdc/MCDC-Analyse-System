<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>User List</title>
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
            background-color:#5bc0de;
            color: #fff;
        }

        a.btn {
            margin-right: 5px;
        }
         /* 样式可以根据需要进行修改 */
    .btn {
        display: inline-block;
        padding: 10px 15px;
        background-color: #5bc0de;
        color: #fff;
        text-decoration: none;
        border-radius: 5px;
        margin-top: 10px;
    }

    .btn i {
        margin-right: 5px;
    }
    </style>
</head>

<body>
<%@ include file="Main.jsp" %>
    <h2>用户列表</h2>
    <table>
        <thead>
            <tr>
                <th>用户名</th>
                <th>真实姓名</th>
                <th>联系方式</th>
                <th>地址</th>
                <th>上次登录时间</th>
                <th>操作</th>
            </tr>
        </thead>
       <tbody>
    <!-- Iterate over the list of users (assuming it's available as userList) -->
    <c:forEach var="user" items="${userList1}">
        <tr>
            <td>${user.name}</td>
            <td>${user.realname}</td>
            <td>${user.phone}</td>
            <td>${user.address}</td>
            <td>${user.lastlogintime}</td>
            <td>
                <a href="userdetails?username=${user.name}" title="详细"><i class="fas fa-info-circle"></i></a>
                <a href="edituser?username=${user.name}" title="修改"><i class="fas fa-edit"></i></a>
                <a href="deleteuser?username=${user.name}" title="删除"><i class="fas fa-trash-alt"></i></a>
            </td>
        </tr>
    </c:forEach>
</tbody>

    </table>

</body>

</html>
