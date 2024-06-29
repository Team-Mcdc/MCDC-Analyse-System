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
            display: flex;
            align-items: center;
            font-size: 20px;
            font-weight: bold;
        }

        .system-name {
            flex: 1;
        }

        nav {
            background-color: #f4f4f4;
            color: #333;
            padding: 20px;
            box-sizing: border-box;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        nav a {
            display: inline-block;
            color: #333;
            text-decoration: none;
            margin: 0 20px;
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

        .content-box {
            padding: 20px;
        }
         /* 下拉菜单样式 */
        .dropdown2 {
            position: relative;
            display: inline-block;
        }

        .dropdown2-content{
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

        .content-box {
            padding: 20px;
        }
    </style>
</head>
<body>

<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
    String username = "admin";
    Date now = Calendar.getInstance().getTime();
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String formattedDate = dateFormat.format(now);
%>

<header>
    <div class="system-name">图书管理系统</div>
    <div style="color: #fff;">
        欢迎 <a href="editowninfo?username=<%= username %>"> <%= username %> </a>
    </div>
</header>

<nav>
    <a href="#" onclick="showContent('首页')">首页</a>
    <a href="book" >图书管理</a>
    
    <!-- 添加带有下拉菜单的导航项 -->
    <div class="dropdown">
        <a href="#">用户管理</a>
        <div class="dropdown-content">
            <a href="adduser">添加用户</a>
            <a href="usertable">用户列表</a>
        </div>
    </div>
    
    <a href="#" onclick="showContent('公告管理')">公告管理</a>
    <!-- 添加带有下拉菜单的导航项 -->
    <div class="dropdown2">
        <a href="#">单位管理</a>
        <div class="dropdown-content">
            <a href="addunit">添加单位</a>
            <a href="unit">单位信息维护</a>
        </div>
    </div>
     <a href="indexback" >退出登录</a>
</nav>


<script>

    //废案，内嵌页面
   function showAddUserForm() {
    console.log('1'); 
    var contentSection = document.getElementById('content');
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            // 创建一个新的 div 元素
            var newContent = document.createElement('div');
            
            // 将 JSP 页面的内容插入到新的 div 元素中
            newContent.innerHTML = xhr.responseText;
            
            // 清空 contentSection 的内容
            contentSection.innerHTML = '';
            
            // 将新的 div 元素插入到 contentSection 中
            contentSection.appendChild(newContent);
        }
    };
    xhr.open('GET', 'adduser', true);
    xhr.send();
}

</script>

</body>
</html>
