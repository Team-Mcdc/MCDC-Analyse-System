<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>图书管理系统</title>
    <style>
        body, html {
            height: 100%;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        header {
            background-color: #5bc0de;
            color: #fff;
            padding: 10px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
        }

        .system-name {
            margin-bottom: 10px;
        }

        .welcome {
            color: #fff;
            margin-right: 15px;
        }

        nav {
            display: flex;
            justify-content: center;
            background-color: #f4f4f4;
            color: #333;
            padding: 20px;
            box-sizing: border-box;
        }

        nav a {
            display: block;
            color: #333;
            text-decoration: none;
            margin: 0 15px;
            padding: 8px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        nav a:hover {
            background-color: #ddd;
        }

        /* 下拉菜单样式 */
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 5px;
        }

        .dropdown-content a {
            color: #333;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            border-radius: 5px;
        }

        .dropdown-content a:hover {
            background-color: #ddd;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }
        /* 下拉菜单样式 */
        .dropdown2 {
            position: relative;
            display: inline-block;
        }

        .dropdown2-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 5px;
        }

        .dropdown2-content a {
            color: #333;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            border-radius: 5px;
        }

        .dropdown2-content a:hover {
            background-color: #ddd;
        }

        .dropdown2:hover .dropdown-content {
            display: block;
        }
    </style>
</head>
<body>

<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
    
    Date now = Calendar.getInstance().getTime();
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String formattedDate = dateFormat.format(now);
%>

<header>
    <div class="system-name">图书管理系统</div>
    <div class="welcome">
        欢迎 <a href="editstaff?username=${sessionScope.username}">${sessionScope.username}</a>
    </div>
</header>


<nav>
    <a href="#" onclick="showContent('首页')">首页</a>
    <div class="dropdown2">
        <a href="#">图书管理</a>
        <div class="dropdown-content">
            <a href="addbook">图书入库</a>
            <a href="book1">图书维护</a>
            <a href="ownbook">图书权限</a>
        </div>
    </div>
    <a href="bookflow" >图书流通</a>
    <div class="dropdown">
        <a href="#">流入流出管理</a>
        <div class="dropdown-content">
            <a href="borrowmanagement">流入管理</a>
            <a href="lendmanagement">流出管理</a>
        </div>
    </div>
   
    <a href="lendreadermanagement">借出归还管理</a>
        
    <a href="count">统计分析管理</a>
    <a href="indexback" >退出登录</a>
</nav>


<script>
    function showContent(contentType) {
        var contentSection = document.getElementById('content');
        contentSection.innerHTML = '<h2>' + contentType + '内容</h2><p>这里显示' + contentType + '的内容...</p>';
    }

    function showAddUserForm() {
        console.log('1');
        var contentSection = document.getElementById('content');
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var newContent = document.createElement('div');
                newContent.innerHTML = xhr.responseText;
                contentSection.innerHTML = '';
                contentSection.appendChild(newContent);
            }
        };
        xhr.open('GET', 'adduser', true);
        xhr.send();
    }
</script>

</body>
</html>
