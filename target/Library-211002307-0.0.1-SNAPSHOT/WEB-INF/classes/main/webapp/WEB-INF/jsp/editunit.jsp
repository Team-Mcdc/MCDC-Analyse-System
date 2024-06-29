<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改单位信息</title>
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
    <h2>修改单位信息</h2>
    <form action="editunit" method="post">
        <!-- Iterate over the list of books (assuming it's available as bookList) -->
        <c:forEach var="unit" items="${unitList}">
        	 <label for="unitid">单位序号:</label>
            <input type="text" id="unitid" name="unitid" value="${unit.unitid}" readonly>
            
            <label for="bookid">单位名称:</label>          
            <input type="text" id="unitname" name="unitname" value="${unit.unitname}">

            
            <label for="contactperson">联系人:</label>
            <input type="text" id="contactperson" name="contactperson" value="${unit.contactperson}" >

            <label for="contactphone">联系电话:</label>
            <input type="text" id="contactphone" name="contactphone" value="${unit.contactphone}">

            <label for="emailaddress">邮箱:</label>
            <input type="text" id="emailaddress" name="emailaddress" value="${unit.emailaddress}">
            
            <label for="contactaddress">联系地址:</label>
            <input type="text" id="contactaddress" name="contactaddress" value="${unit.contactaddress}">
            
			<label for="unittype">单位性质:</label>
            <input type="text" id="unittype" name="unittype" value="${unit.unittype}">
            <!-- Add other fields as needed -->

            <input type="submit" value="提交修改">

            <!-- Back button -->
        </c:forEach>
    </form>
</body>

</html>
