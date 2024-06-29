<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MC/DC覆盖及分析系统</title>
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

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .content {
            display: flex;
            height: calc(100% - 100px);
        }

        .code-editor {
            flex: 2;
            padding: 20px;
            box-sizing: border-box;
        }

        .project-list {
            flex: 1;
            padding: 20px;
            box-sizing: border-box;
            border-left: 1px solid #ddd;
            overflow-y: auto;
        }

        .project-list h3 {
            margin-top: 0;
        }

        textarea {
            width: 100%;
            height: 200px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        button {
            padding: 10px 20px;
            margin-right: 10px;
            background-color: #5bc0de;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #46a1c2;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 5px;
            padding: 10px;
            flex-direction: column;
            gap: 10px;
        }

        .dropdown-content label {
            cursor: pointer;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            border-radius: 5px;
        }

        .dropdown-content label:hover {
            background-color: #ddd;
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
            <label onclick="deleteProject()">移除项目</label>
        </div>
    </div>
    <a href="readerreturnback">退出登录</a>
</nav>
<div id="context-menu" style="display: none; position: fixed; background-color: #fff; border: 1px solid #ccc; box-shadow: 2px 2px 5px rgba(0,0,0,0.2); z-index: 100;">
    <div onclick="deleteProject()" style="padding: 10px; cursor: pointer;">删除</div>
</div>

<div class="content">
    <div class="code-editor">
        <h3>当前项目名称</h3>
        <div id="current-project">无</div>
        <h3>头文件</h3>
        <textarea id="header-file"></textarea>
        <h3>代码主体</h3>
        <textarea id="code-body"></textarea>
        <h3>运行结果</h3>
        <textarea id="run-result" readonly></textarea>
        <button onclick="saveCode()">保存</button>
        <button onclick="runCode()">运行</button>
         <button onclick="postToMcdc()">MCDC分析</button>
    </div>
    <div class="project-list">
        <h3>项目列表</h3>
        <ul id="project-list">
            <!-- 项目列表项会动态添加到这里 -->
        </ul>

<ul id="project-list2" style="display: none;">
    <c:forEach items="${projects}" var="project">
        <li>${project.name}</li>
    </c:forEach>
</ul>
<ul id="project-list3" style="display: none;">
    <c:forEach items="${projects}" var="project">
        <li>${project.content}</li>
    </c:forEach>
</ul>
    </div>
</div>
<!-- 新增的跳转按钮 -->


<script>
// 获取项目列表 UL 元素


var projectList = document.getElementById('project-list');

// 右键点击项目名称时显示右键菜单
projectList.addEventListener('contextmenu', function(event) {
    event.preventDefault(); // 阻止默认的右键菜单弹出
    var target = event.target;
    if (target.tagName === 'LI') {
        var contextMenu = document.getElementById('context-menu');
        contextMenu.style.top = event.clientY + 'px'; // 设置右键菜单的位置
        contextMenu.style.left = event.clientX + 'px';
        contextMenu.style.display = 'block'; // 显示右键菜单
		
        // 将当前项目名称存储在自定义属性中
        contextMenu.setAttribute('data-project-name', target.textContent.trim());
    }
});

// 点击页面其他地方时隐藏右键菜单
document.addEventListener('click', function() {
    var contextMenu = document.getElementById('context-menu');
    contextMenu.style.display = 'none'; // 隐藏右键菜单
});


function deleteProject() {
    var projectName = document.getElementById('context-menu').getAttribute('data-project-name');
    
    if (confirm('确定要移除项目 "' + projectName + '" 吗？')) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'DeleteProjectServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    // 从 projects 数组中移除已删除的项目
                    projects = projects.filter(function(project) {
                        return project.name !== projectName;
                    });

                    // 从 project-list2 和 project-list3 中移除已删除的项目
                    var projectList2 = document.getElementById('project-list2');
                    var projectList3 = document.getElementById('project-list3');
                    var projectItems2 = projectList2.getElementsByTagName('li');
                    var projectItems3 = projectList3.getElementsByTagName('li');
                    
                    for (var i = 0; i < projectItems2.length; i++) {
                        if (projectItems2[i].textContent.trim() === projectName) {
                            projectList2.removeChild(projectItems2[i]);
                            break;
                        }
                    }

                    for (var i = 0; i < projectItems3.length; i++) {
                        if (projectItems3[i].textContent.trim() === projectName) {
                            projectList3.removeChild(projectItems3[i]);
                            break;
                        }
                    }

                    // 成功删除时，清空编辑区域和当前项目名称显示
                    document.getElementById('header-file').value = '';
                    document.getElementById('code-body').value = '';
                    document.getElementById('run-result').value = '';
                    document.getElementById('current-project').textContent = '无';

                    // 重新加载项目列表
                    loadProjectList();
                    alert('项目已成功删除');
                } else if (xhr.status === 404) {
                    alert('删除项目失败：未找到要删除的项目。');
                } else if (xhr.status === 500) {
                    alert('删除项目失败：服务器内部错误。');
                } else {
                    alert('删除项目失败：未知错误。');
                }
            }
        };

        // 发送请求并传递要删除的项目名称
        xhr.send('name=' + encodeURIComponent(projectName));

        // 隐藏右键菜单
        document.getElementById('context-menu').style.display = 'none';
    }
}


    function showDropdown() {
        var dropdownContent = document.getElementById('dropdown-content');
        dropdownContent.style.display = 'flex';
    }

    function hideDropdown() {
        var dropdownContent = document.getElementById('dropdown-content');
        dropdownContent.style.display = 'none';
    }

    function postToMcdc() {
        var headerContent = document.getElementById('header-file').value;
        var codeBodyContent = document.getElementById('code-body').value;
        var nameContent = document.getElementById('current-project').textContent;

        var form = document.createElement('form');
        form.method = 'POST';
        form.action = 'mcdc';

        var headerInput = document.createElement('input');
        headerInput.type = 'hidden';
        headerInput.name = 'headerCode';
        headerInput.value = headerContent;
        form.appendChild(headerInput);

        var bodyInput = document.createElement('input');
        bodyInput.type = 'hidden';
        bodyInput.name = 'bodyCode';
        bodyInput.value = codeBodyContent;
        form.appendChild(bodyInput);

        var nameInput = document.createElement('input');
        nameInput.type = 'hidden';
        nameInput.name = 'name';
        nameInput.value = nameContent;
        form.appendChild(nameInput);

        document.body.appendChild(form);
        form.submit();
    }

    function showContent(contentType) {
        var contentSection = document.getElementById('content');
        contentSection.innerHTML = '<h2>' + contentType + '内容</h2><p>这里显示' + contentType + '的内容...</p>';
    }

    function saveCode() {
        var headerContent = document.getElementById('header-file').value;
        var codeBodyContent = document.getElementById('code-body').value;
        var nameContent = document.getElementById('current-project').textContent;

        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'SaveProjectFileServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    alert('代码已保存');
                    // Example: Handle response or update UI as needed
                } else {
                    alert('保存失败，请重试');
                    // Example: Handle error state
                }
            }
        };

        xhr.send('name=' + encodeURIComponent(nameContent) + '&headerCode=' + encodeURIComponent(headerContent) + '&bodyCode=' + encodeURIComponent(codeBodyContent));
    }

    function runCode() {
        var headerContent = document.getElementById('header-file').value;
        var codeBodyContent = document.getElementById('code-body').value;

        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'CodeExecutionServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                document.getElementById('run-result').value = xhr.responseText;
            }
        };
        xhr.send('headerCode=' + encodeURIComponent(headerContent) + '&bodyCode=' + encodeURIComponent(codeBodyContent));
    }


    
    var projects = []; // 初始项目列表为空数组


var projectListElement = document.getElementById('project-list2');
var projectss = projectListElement.getElementsByTagName('li');
var projectListElement2 = document.getElementById('project-list3');
var projectss_content = projectListElement2.getElementsByTagName('li');

console.log(projectss.length)

for (var i = 0; i < projectss.length; i++) {
    var projectName = projectss[i].textContent; // 获取每个项目的文本内容
    var fileContent = projectss_content[i].textContent;
    projects.push({ name: projectName, content: fileContent });
}

console.log("zheshi"+projects.length); // 使用 projects.length 来获取数组的大小
    
    

    function importProjects(event) {
        var file = event.target.files[0];
        var reader = new FileReader();

        reader.onload = function(e) {
            var fileName = file.name;
            var fileContent = e.target.result;
            projects.push({ name: fileName, content: fileContent });

            loadProjectList(); // 加载项目列表
        };

        reader.readAsText(file);
    }

    function loadProjectList() {
        var projectListElement = document.getElementById('project-list');
        projectListElement.innerHTML = '';
        projects.forEach(function(project) {
            var li = document.createElement('li');
            li.textContent = project.name;
            li.onclick = function() {
                loadProjectContent(project);
            };
            projectListElement.appendChild(li);
        });
    }
	
    function loadProjectContent(project) {
        var lines = project.content.split('\n');
        var header = [];
        var codeBody = [];

        lines.forEach(function(line) {
            if (line.trim().startsWith('#')) {
                header.push(line);
            } else {
                codeBody.push(line);
            }
        });

        document.getElementById('header-file').value = header.join('\n');
        document.getElementById('code-body').value = codeBody.join('\n');
        document.getElementById('run-result').value = '// ' + project.name + '的运行结果';

        document.getElementById('current-project').textContent = project.name; // 更新当前项目名称
    }

    // 页面加载完成后加载项目列表
    document.addEventListener('DOMContentLoaded', function() {
        loadProjectList();
    });
</script>

</body>
</html>
        
