<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改密码</title>
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
    </style>
</head>

<body>
    <h2>修改密码</h2>
    <form action="editpassword" method="post">
        <label for="favoriteBook">最喜欢的书籍:</label>
        <input type="text" id="favoriteBook" name="favoritebook" required>

        <label for="newPassword">新密码:</label>
        <input type="password" id="newpassword" name="newpassword" required>

        <input type="submit" value="提交修改">
    </form>
</body>

</html>
