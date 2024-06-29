<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Book Details</title>
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
            background-color: #5bc0de;
            color: #fff;
        }

        a.btn {
            margin-right: 5px;
        }

        /* Style for the return button */
        .return-btn {
            margin-top: 20px;
        }
    </style>
</head>

<body>
<%@ include file="Main1.jsp" %>
    <h2>图书详情</h2>
    <table>
        <tr>
            <th>属性</th>
            <th>值</th>
        </tr>
        <!-- Iterate over the list of books (assuming it's available as bookList) -->
        <c:forEach var="book" items="${bookList1}">
            <tr>
                <td>图书名称</td>
                <td>${book.bookname}</td>
            </tr>
            <tr>
                <td>作者</td>
                <td>${book.author}</td>
            </tr>
            <tr>
                <td>出版社</td>
                <td>${book.publisher}</td>
            </tr>
            <tr>
                <td>出版时间</td>
                <td>${book.publicationdate}</td>
            </tr>
              <tr>
                <td>图书类别</td>
                <td>${book.bookcategory}</td>
            </tr>
              <tr>
                <td>图书页数</td>
                <td>${book.pages}</td>
            </tr>
              <tr>
                <td>价格</td>
                <td>${book.price}</td>
            </tr>
            <tr>
                <td>所属单位</td>
                <td>${book.unit}</td>
            </tr>
            <!-- Add more rows for other book details as needed -->
        </c:forEach>
    </table>

    <!-- Return button -->
</body>

</html>
