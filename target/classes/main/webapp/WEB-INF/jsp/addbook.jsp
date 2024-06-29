<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加图书</title>
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

        select {
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
<%@ include file="Main1.jsp" %>
    <h2>添加图书</h2>
     <div style="float: right; margin-top: -40px;">
        <a href="batchimport">批量导入</a>
    </div>
    <form action="addbook" method="post">
        <label for="bookname">图书名称:</label>
        <input type="text" id="bookname" name="bookname" required>

        <label for="author">作者:</label>
        <input type="text" id="author" name="author" required>

        <label for="publisher">出版社:</label>
        <input type="text" id="publisher" name="publisher" required>

        <label for="publicationdate">出版日期:</label>
        <input type="date" id="publicationdate" name="publicationdate" required>

        <label for="pages">页数:</label>
        <input type="number" id="pages" name="pages" required>

        <label for="price">价格:</label>
        <input type="text" id="price" name="price" required>

         <label for="bookcategory">图书分类:</label>
         <input type="text" id="bookcategory" name="bookcategory" required>
		
		 <label for="bookcategory">图片路径:</label>
         <input type="text" id="imagepath" name="imagepath" required>

         <!-- 
        <label for="unit">单位:</label>
         <select id="unit" name="unit" required>
    <!-- 在这里添加单位的选项，可以从数据库中动态获取 -->
    <!-- <option value="单位1">单位1</option>
    <option value="单位2">单位2</option> -->
    <!-- 添加其他选项 -->
          <!-- </select> -->


        <!-- Add other fields as needed -->

        <input type="submit" value="添加图书">
    </form>
</body>

</html>
