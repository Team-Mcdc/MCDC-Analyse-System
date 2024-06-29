<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Unit List</title>
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

        .search-form {
            margin-bottom: 20px;
        }

        .search-input {
            padding: 8px;
            width: 200px;
        }
    </style>
</head>

<body>
	<%@ include file="Main.jsp" %>
	 <h2>单位列表</h2>
    <!-- Search Form -->
    <form action="searchUnit" method="get" class="search-form">
        <label for="search" style="margin-right: 10px;">模糊查询:</label>
        <input type="text" id="search" name="search" class="search-input">
        <input type="submit" value="搜索" class="btn">
    </form>

    <!-- Unit Table -->
    <table>
        <thead>
            <tr>
                <th>单位名称</th>
                <th>联系人</th>
                <th>联系电话</th>
                <th>联系地址</th>
                <th>邮箱地址</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <!-- Iterate over the list of units (assuming it's available as unitList) -->
            <c:forEach var="unit" items="${unitList}">
                <tr>
                    <td>${unit.unitname}</td>
                    <td>${unit.contactperson}</td>
                    <td>${unit.contactphone}</td>
                    <td>${unit.contactaddress}</td>
                    <td>${unit.emailaddress}</td>
                    <td>
                        <a href="unitdetails?unitid=${unit.unitid}" title="详细"><i class="fas fa-info-circle"></i></a>
                        <a href="editunit?unitid=${unit.unitid}" title="修改"><i class="fas fa-edit"></i></a>
                        <a href="deleteunit?unitid=${unit.unitid}" title="删除"><i class="fas fa-trash-alt"></i></a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Return button -->
</body>

</html>
