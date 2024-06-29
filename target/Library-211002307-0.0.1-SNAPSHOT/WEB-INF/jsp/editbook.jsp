<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改图书信息</title>
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
    <h2>修改图书信息</h2>
    <form action="editbook" method="post">
        <!-- Iterate over the list of books (assuming it's available as bookList) -->
        <c:forEach var="book" items="${bookList1}">
            <label for="bookid">图书序号:</label>
            <input type="text" id="bookid" name="bookid" value="${book.bookid}" readonly>

            
            <label for="bookName">图书名称:</label>
            <input type="text" id="bookname" name="bookname" value="${book.bookname}" >

            <label for="author">作者:</label>
            <input type="text" id="author" name="author" value="${book.author}">

            <label for="publisher">出版社:</label>
            <input type="text" id="publisher" name="publisher" value="${book.publisher}">
            
            <label for="publisher">出版时间:</label>
            <input type="text" id="publicationdate" name="publicationdate" value="${book.publicationdate}">
            
            <label for="publisher">图书类别:</label>
            <input type="text" id="bookcategory" name="bookcategory" value="${book.bookcategory}">
            
            <label for="publisher">图书页数:</label>
            <input type="text" id="pages" name="pages" value="${book.pages}">
            
            <label for="publisher">价格:</label>
            <input type="text" id="price" name="price" value="${book.price}">
            

            <!-- Add other fields as needed -->

            <input type="submit" value="提交修改">

            <!-- Back button -->
        </c:forEach>
    </form>
</body>

</html>
