
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改用户信息</title>
    <style>
        body {
            padding: 20px;
            font-family: Arial, sans-serif;
        }

        h2 {
            margin-bottom: 20px;
        }

        form {
            width: 50%;
            margin: auto;
        }

        label {
            display: block;
            margin-bottom: 10px;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 20px;
        }

        input[type="submit"] {
            background-color: #5bc0de;
            color: #fff;
            cursor: pointer;
        }

        /* Add style for the "Back" button */
        .back-button {
            background-color: #ccc;
            color: #000;
            cursor: pointer;
        }
    </style>
</head>

<body>
    <h2>修改用户信息</h2>
    <form action="editowninfo" method="post">
        <!-- Iterate over the list of users (assuming it's available as userList) -->
        <c:forEach var="user" items="${userList}">
            <label for="name">用户名:</label>
            <input type="text" id="name" name="name" value="${user.name}" >

            <label for="realname">真实姓名:</label>
            <input type="text" id="realname" name="realname" value="${user.realname}" readonly>

            <label for="realname">性别:</label>
            <input type="text" id="gender" name="gender" value="${user.gender}">

            <label for="phone">联系方式:</label>
            <input type="text" id="phone" name="phone" value="${user.phone}">

            <label for="phone">地址:</label>
            <input type="text" id="address" name="address" value="${user.address}">

            <label for="phone">角色:</label>
            <input type="text" id="rolename" name="rolename" value="${user.rolename}">

            <label for="phone">单位:</label>
            <input type="text" id="workplace" name="workplace" value="${user.workplace}">

            <!-- Add other fields as needed -->

            <input type="submit" value="提交修改">

        </c:forEach>
    </form>
</body>

</html>
