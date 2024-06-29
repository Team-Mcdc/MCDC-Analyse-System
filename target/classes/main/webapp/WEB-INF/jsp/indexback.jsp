<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>图书管理系统登录</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBTOZxM5i8fvBQDtUch6UahjPvY1M3F9BbAv9DjBZq4eFXo3R4J/itfLEHieCA2zMTXRUVa2MK6efT8tT5aGQ==" crossorigin="anonymous" />
    <style>
        body, html {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        form {
            width: 100%;
            max-width: 400px;
            background-color: #f2f2f2;
            padding: 20px;
            border-radius: 8px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h2 {
            text-align: center;
            font-size: 28px;
            margin-top: -10px;
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 12px;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 16px;
            box-sizing: border-box;
            border: 1px solid #5bc0de;
            border-radius: 4px;
        }

        button {
            width: 100%;
            padding: 14px;
            background-color: #5bc0de;
            color: #fff;
            border: 1px solid #5bc0de;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out;
        }

        button:hover {
            background-color: #3498db;
        }

        .options {
            margin-top: 20px;
            text-align: center;
        }

        .options a {
            text-decoration: none;
            color: #5bc0de;
            margin: 0 16px;
            font-weight: bold;
            transition: color 0.3s ease-in-out;
        }

        .options a:hover {
            color: #3498db;
        }

        /* 添加图标样式 */
        .icon {
            margin-right: 8px;
        }
    </style>
</head>
<body>

<form action="login" method="post" onsubmit="return validateForm()">
    <h2><i class="fas fa-book-open icon"></i>图书管理系统登录</h2>
    <label for="username"><i class="fas fa-user icon"></i>用户名:</label>
    <input type="text" id="username" name="username" required>

    <label for="password"><i class="fas fa-lock icon"></i>密码:</label>
    <input type="password" id="password" name="password" required>

    <button type="submit"><i class="fas fa-sign-in-alt icon"></i>登录</button>

    <div class="options">
        <a href="#"><i class="fas fa-user-plus icon"></i>注册账号</a> | <a href="forgetpassword"><i class="fas fa-question-circle icon"></i>忘记密码</a>
    </div>
</form>



</body>
</html>
