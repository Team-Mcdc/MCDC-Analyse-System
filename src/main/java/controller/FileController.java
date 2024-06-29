package controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@Controller
public class FileController {

	@RequestMapping(value = "/mcdc", method = RequestMethod.GET)
    public String showmcdc(HttpServletRequest request) {
        return ("mcdc");
 }
    @RequestMapping(value = "/mcdc", method = RequestMethod.POST)
    public ModelAndView showMcdcPage(HttpServletRequest request, HttpServletResponse response)throws IOException {
    	String headerCode = request.getParameter("headerCode");
        String bodyCode = request.getParameter("bodyCode");
        String fileName = request.getParameter("name");
    	ModelAndView mav = new ModelAndView("mcdc");
        mav.addObject("projectCode", bodyCode);
        System.out.print(bodyCode);
        return mav;
    }

    @RequestMapping(value = "/SaveProjectFileServlet", method = RequestMethod.POST)
    public void saveProjectFile(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String headerCode = request.getParameter("headerCode");
        String bodyCode = request.getParameter("bodyCode");
        String fileName = request.getParameter("name");

        // 文件保存的目录
        String saveDirectory = System.getProperty("user.home") + "\\Desktop\\file\\";

        // 确保文件夹存在，如果不存在则创建
        File directory = new File(saveDirectory);
        if (!directory.exists()) {
            directory.mkdirs();
        }

        // 构造文件路径
        String filePath = saveDirectory + fileName;

        // 将头文件和代码写入文件
        try (FileWriter writer = new FileWriter(filePath)) {
            writer.write(headerCode);
            writer.write("\n\n");
            writer.write(bodyCode);
        } catch (IOException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("文件保存失败：" + e.getMessage());
            return;
        }

        // 将文件路径存入数据库
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            // 连接数据库
            conn = getConnection();

            // 插入数据的 SQL 语句
            String sql = "INSERT INTO project_files (name, project_file, userid) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, fileName);
            stmt.setString(2, filePath);
            stmt.setInt(3, 2); // 假设这里硬编码用户ID

            // 执行插入操作
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.setContentType("text/plain");
                response.getWriter().write("文件已成功保存到桌面的file文件夹，并将文件路径保存到数据库。");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("文件路径保存到数据库时出错。");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("数据库操作出错：" + e.getMessage());
        } finally {
            // 关闭数据库连接和 statement
            closeResources(conn, stmt, null);
        }
    }

    
    @RequestMapping(value = "/DeleteProjectServlet", method = RequestMethod.POST)
    public void deleteProjectFile(@RequestParam("name") String fileName, HttpServletResponse response) throws IOException {
        String saveDirectory = System.getProperty("user.home") + "\\Desktop\\file\\";
        String filePath = saveDirectory + fileName;

        // 删除本地文件
        try {
            Files.deleteIfExists(Paths.get(filePath));
        } catch (IOException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("删除文件失败：" + e.getMessage());
            return;
        }

        // 删除数据库中的记录
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            // 连接数据库
            conn = getConnection(); // 假设实现了获取数据库连接的方法
            // 删除数据的 SQL 语句
            String sql = "DELETE FROM project_files WHERE name = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, fileName);

            // 执行删除操作
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("文件已成功从桌面的file文件夹和数据库中删除。");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("数据库中未找到要删除的文件记录。");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("数据库操作出错：" + e.getMessage());
        } finally {
            // 关闭数据库连接和 statement
            closeResources(conn, stmt, null); // 假设实现了关闭数据库资源的方法
        }
    }

    @RequestMapping(value = "/CodeExecutionServlet", method = RequestMethod.POST)
    public void executeCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 获取前端页面发送的头文件和代码主体
        String headerCode = request.getParameter("headerCode");
        String bodyCode = request.getParameter("bodyCode");

        // 合并头文件和代码主体
        String fullCode = headerCode + "\n" + bodyCode;

        // 写入代码到临时文件 temp_code.c
        File codeFile = new File("temp_code.c");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(codeFile))) {
            writer.write(fullCode);
        } catch (IOException e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("写入临时文件失败：" + e.getMessage());
            return;
        }

        // 编译代码
        String gccPath = "C:\\MinGW\\bin\\gcc.exe";  // 修改为您的gcc路径
        String compileCommand = "\"" + gccPath + "\" -o temp_code temp_code.c";
        Process compileProcess = null;
        try {
            compileProcess = Runtime.getRuntime().exec(compileCommand);
            compileProcess.waitFor(); // 等待编译完成
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("编译过程中出现错误：" + e.getMessage());
            return;
        }

        // 读取编译输出信息
        StringBuilder compileOutput = new StringBuilder();
        try (BufferedReader compileReader = new BufferedReader(new InputStreamReader(compileProcess.getInputStream()))) {
            String line;
            while ((line = compileReader.readLine()) != null) {
                compileOutput.append(line).append("\n");
            }
        }

        // 检查编译结果
        try {
            int compileExitCode = compileProcess.exitValue();
            if (compileExitCode != 0) {
                response.setContentType("text/plain");
                response.getWriter().write("编译失败:\n" + compileOutput.toString());
                return;
            }
        } catch (IllegalThreadStateException e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("编译失败:\n" + e.getMessage());
            return;
        }

        // 运行编译后的可执行文件
        String runCommand = "./temp_code";  // 根据需要修改运行命令
        Process runProcess = null;
        try {
            runProcess = Runtime.getRuntime().exec(runCommand);
            runProcess.waitFor(); // 等待程序运行完成
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("运行过程中出现错误：" + e.getMessage());
            return;
        }

        // 读取运行输出信息
        StringBuilder runOutput = new StringBuilder();
        try (BufferedReader runReader = new BufferedReader(new InputStreamReader(runProcess.getInputStream()))) {
            String line;
            while ((line = runReader.readLine()) != null) {
                runOutput.append(line).append("\n");
            }
        }

        // 返回运行结果给前端页面
        response.setContentType("text/plain");
        response.getWriter().write(runOutput.toString());
    }

    // 获取数据库连接
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/mcdc", "root", "123456");
    }

    // 关闭数据库连接和 statement
    private void closeResources(Connection conn, PreparedStatement stmt, File file) {
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (file != null && file.exists()) {
            file.delete(); // 删除临时文件
        }
    }
}
