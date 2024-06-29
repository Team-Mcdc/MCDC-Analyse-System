<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>工作人员信息表单</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }

        h2 {
            color: #333;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #5bc0de;
            color: #fff;
            cursor: pointer;
        }

        hr {
            border: 0;
            height: 1px;
            background-color: #ddd;
            margin: 20px 0;
        }
    </style>
</head>
<body>

<h2>读者信息表</h2>

<form action="applyborrowbook" method="post">

<input type="hidden" name="bookid" value="${bookid}">
    <c:forEach var="user" items="${userlist}">
        <label for="name">姓名:</label>
        <input type="text" id="name" name="name" value="${user.name}">
        
        <label for="name">真实姓名:</label>
        <input type="text" id="realname" name="realname" value="${user.realname}">

        <label for="contact">联系方式:</label>
        <input type="text" id="contact" name="contact" value="${user.phone}">

        <label for="email">邮箱:</label>
        <input type="text" id="email" name="email" value="${user.email}">

        <label for="address">地址:</label>
        <input type="text" id="address" name="address" value="${user.address}">
        
         <p>预计归还日期: <input type="text" id="returntime" name="returntime" required></p>
         <p>借入理由: <input type="text" id="borrowingreason" name="borrowingreason" required></p>

        <hr>
    </c:forEach>

    <input type="submit" value="提交">
</form>

</body>
</html>
