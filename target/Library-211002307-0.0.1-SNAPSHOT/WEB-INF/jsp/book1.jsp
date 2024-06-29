<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Book List</title>
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
            background-color:#5bc0de;
            color: #fff;
        }

        a.btn {
            margin-right: 5px;
        }
         .btn {
        display: inline-block;
        padding: 10px 15px;
        background-color: #5bc0de;
        color: #fff;
        text-decoration: none;
        border-radius: 5px;
        margin-top: 10px;
    }

    .btn i {
        margin-right: 5px;
    }
    </style>
</head>

<body>
	 <%@ include file="Main1.jsp" %>
    <h2>图书列表</h2>
     <form action="searchbook" method="get">
        <label for="searchKeyword">查询图书:</label>
        <input type="text" id="search" name="search" placeholder="输入书名、编号、作者或出版社">
        <button type="submit">查询</button>
    </form>
    <table>
        <thead>
            <tr>
                <th>图书序号</th>
                <th>书名</th>
                <th>出版社</th>
                <th>作者</th>
                <th>图书类型</th>
                <th>操作</th>
            </tr>
        </thead>
       <tbody>
    <!-- Iterate over the list of books (assuming it's available as bookList) -->
<c:forEach var="book" items="${bookList1}">
    <c:choose>
        <c:when test="${roleid eq 1}">
            <tr>
                <!-- 显示图书信息 -->
                <td>${book.bookid}</td>
                <td>${book.bookname}</td>
                <td>${book.publisher}</td>
                <td>${book.author}</td>
                <td>${book.bookcategory}</td>
                <td>
                    <a href="bookdetails2?bookid=${book.bookid}" title="详细"><i class="fas fa-info-circle"></i></a>
                    <a href="editbook?bookid=${book.bookid}" title="修改"><i class="fas fa-edit"></i></a>
                    <a href="deletebook?bookid=${book.bookid}" title="删除"><i class="fas fa-trash-alt"></i></a>
                </td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${book.state eq 1}">
                    <tr>
                        <td>${book.bookid}</td>
                        <td>${book.bookname}</td>
                        <td>${book.publisher}</td>
                        <td>${book.author}</td>
                        <td>${book.bookcategory}</td>
                        <td>
                            <a href="bookdetails2?bookid=${book.bookid}" title="详细"><i class="fas fa-info-circle"></i></a>
                            <a href="editbook?bookid=${book.bookid}" title="修改"><i class="fas fa-edit"></i></a>
                            <a href="deletebook?bookid=${book.bookid}" title="删除"><i class="fas fa-trash-alt"></i></a>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <!-- 处理其他情况的代码 -->
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>
</c:forEach>



</tbody>

    </table>
 </body>

</html>
