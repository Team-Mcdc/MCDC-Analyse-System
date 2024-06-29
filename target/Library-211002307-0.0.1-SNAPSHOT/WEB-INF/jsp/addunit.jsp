<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加单位</title>
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
    <form action="addunit" method="post">
        <p>单位名称: <input type="text" id="unitname" name="unitname" required></p>
        <p>单位联系人: <input type="text" id="contactperson" name="contactperson" required></p>
        <p>联系电话: <input type="text" id="contactphone" name="contactphone" required></p>
        <p>联系地址: <input type="text" id="contactaddress" name="contactaddress" required></p>
        <p>邮箱地址: <input type="text" id="emailaddress" name="emailaddress" required></p>

        <p><button type="submit">添加单位</button></p>
    </form>
</body>

</html>
