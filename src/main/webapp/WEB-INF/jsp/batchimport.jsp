<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Batch Import</title>
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
    <h2>批量导入</h2>
    <form action="import" method="post" enctype="multipart/form-data">
    <label for="file">选择文件路径:</label>
    <input type="file" id="inputfile" name="uplowdfile" accept=".xlsx">
    <input type="submit" value="导入">
</form>
</body>

</html>
