<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加用户</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #fff; /* Set background color to white */
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        form {
            width: 100%;
            max-width: 400px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        form p {
            text-align: center;
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-top: 5px;
        }

        button {
            background-color: #007bff;
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>

<body>
    <form action="register" method="post">
        <p>用户名: <input type="text" id="username" name="username" required></p>
        <p>密码: <input type="password" id="password" name="password" required></p>
        <p>真实姓名: <input type="text" id="realname" name="realname" required></p>
        <p>联系电话: <input type="text" id="number" name="number" required></p>
        <p>邮箱: <input type="email" id="email" name="email" required></p>
        <p>住址: <input type="text" id="address" name="address" required></p>
        <p>性别: <input type="text" id="gender" name="gender" required></p>
        <p>密保问题:你最喜欢的水果 <input type="text" id="question" name="question" required></p>
        
        <p><button type="submit">注册用户</button></p>
    </form>
</body>

</html>
