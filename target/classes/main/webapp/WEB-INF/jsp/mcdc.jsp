<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>测试用例和覆盖分析</title>
    <style>
        body, html {
            height: 100%;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            flex-direction: column;
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
            cursor: pointer;
        }

        .dropdown-content a:hover {
            background-color: #ddd;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .content {
            display: flex;
            flex: 1; /* Take remaining height */
        }

        .container {
            flex: 1;
            padding: 10px;
            display: flex;
            flex-direction: column;
        }

        .column {
            display: flex;
            flex-direction: column;
            height: 100%; /* Occupy full height of parent */
        }

        .textbox {
            flex: 1; /* Fill remaining space */
            margin-top: 10px;
            margin-bottom: 10px;
            resize: none;
        }

        .button {
            margin-top: 10px;
        }

        /* Adjusted styling for project code textarea */
        #projectCode {
            height: calc(100% - 20px); /* Adjusted to fit within column height */
        }

        /* Positioning for right-hand side */
        .right-side {
            display: flex;
            flex-direction: column;
        }

        .right-side .textbox {
            flex: 1; /* Fill remaining space */
            margin-top: 10px;
            margin-bottom: 10px;
            resize: none;
        }

        .right-side h2 {
            text-align: center;
        }

        .filename-list {
            margin-top: 10px;
            font-weight: bold;
        }

        .filename-list ul {
            list-style-type: none;
            padding: 0;
        }

        .filename-list li {
            margin-top: 5px;
            cursor: pointer;
            text-decoration: underline;
            color: blue;
        }

        .filename-list li:hover {
            color: darkblue;
        }
    </style>
</head>
<body>

<header>
    <div class="system-name">MC/DC覆盖及分析系统</div>
    <div class="welcome">
        欢迎 <a href="editreader?username=${sessionScope.username}">${sessionScope.username}</a>
    </div>
</header>

<nav>
    <a href="#" onclick="showContent('首页')">首页</a>
    <div class="dropdown" onmouseover="showDropdown()" onmouseout="hideDropdown()">
        <a href="#">项目操作</a>
        <div class="dropdown-content" id="dropdown-content">
            <label for="file-input" style="cursor: pointer;">导入项目</label>
            <input type="file" id="file-input" onchange="importProjects(event)" style="display: none;">
            <p></p>
            <label onclick="deleteProject()">移除项目</label>
        </div>
    </div>
    <a href="readerreturnback">退出登录</a>
</nav>

<div class="content">
    <div class="container">
        <div class="column">
            <h2>加载模块</h2>
            <input type="file" name="file" id="file" onchange="addFileNameToList(event)">
            <div class="filename-list" id="fileNameList">
                <ul id="fileNames"></ul>
            </div>

            <h2>测试用例</h2>
            <textarea id="testCases" class="textbox" rows="10" cols="50">
                <%
                    String testCases = (String) request.getAttribute("testCases");
                    if (testCases != null) {
                        out.print(testCases);
                    }
                %>
            </textarea>

            <form action="CoverageAnalysisServlet" method="post">
                <input type="hidden" name="testCases" id="hiddenTestCases">
                <input type="submit" value="覆盖分析" class="button" onclick="document.getElementById('hiddenTestCases').value = document.getElementById('testCases').value;">
            </form>
        </div>
    </div>
    <div class="container right-side">
        <h2>MCDC结果</h2>
        <textarea id="mcdcResults" class="textbox" rows="10" cols="50">
            <%
                String mcdcResults = (String) request.getAttribute("mcdcResults");
                if (mcdcResults != null) {
                    out.print(mcdcResults);
                }
            %>
        </textarea>
    </div>
    <div class="container right-side">
        <h2>项目代码</h2>
        <textarea id="projectCode" class="textbox" rows="30" cols="50">
            ${projectCode}
        </textarea>
    </div>
</div>

<script>
    var fileContents = [];
    var fileNames = [];

    function showContent(contentType) {
        var contentSection = document.getElementById('content');
        contentSection.innerHTML = '<h2>' + contentType + '内容</h2><p>这里显示' + contentType + '的内容...</p>';
    }

    function addFileNameToList(event) {
        var file = event.target.files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                fileContents.push(e.target.result);
                fileNames.push(file.name);

                var fileNameList = document.getElementById('fileNames');
                var listItem = document.createElement('li');
                listItem.textContent = file.name;
                listItem.dataset.index = fileContents.length - 1;
                listItem.onclick = function() {
                    loadTestCaseContent(this.dataset.index);
                };
                fileNameList.appendChild(listItem);
            };
            reader.readAsText(file);
        }
    }

    function loadTestCaseContent(index) {
        document.getElementById('testCases').value = fileContents[index];
    }
</script>

</body>
</html>
