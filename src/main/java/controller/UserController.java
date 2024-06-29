package controller;


import org.springframework.beans.factory.annotation.Autowired;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.Model;

import dao.UnitDao;
import dao.UserDao;
import po.Project;
import po.Unit;
import po.User;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class UserController {
	@Autowired//注解装配，默认按照名称进行属性注入
	private UserDao userDao;
	@Autowired
	private UnitDao unitDao;
    // 获取数据库连接
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/mcdc", "root", "123456");
    }

 // 关闭数据库连接和 statement，以及可选的 ResultSet
    private void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
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
    }
	 @RequestMapping(value = "/index", method = RequestMethod.GET)
	        public String index(HttpServletRequest request) {
		    System.out.println("1");
		    HttpSession session = request.getSession(false);

		    // 如果会话不为null，表示用户已登录
		    if (session != null) {
		        // 使会话失效
		        session.invalidate();
		    }
	        return ("index");
	 }
	 
	 @RequestMapping(value = "/indexback", method = RequestMethod.GET)
     public String indexback(HttpServletRequest request) {
	    System.out.println("1");
	    HttpSession session = request.getSession(false);

	    // 如果会话不为null，表示用户已登录
	    if (session != null) {
	        // 使会话失效
	        session.invalidate();
	    }
     return ("indexback");
}		
	 @RequestMapping("/Mainselect")
	 public ModelAndView mainPage(@RequestParam("roleid") String roleid) {
	     ModelAndView modelAndView;

	     // 根据roleid判断返回的是Main1还是Main2
	     if ("1".equals(roleid)) {
	         modelAndView = new ModelAndView("Main");
	     } else if ("2".equals(roleid)) {
	         modelAndView = new ModelAndView("Main1");
	     } else {
	         
	         modelAndView = new ModelAndView("Main3");
	     }


	     return modelAndView;
	 }
	 //管理员界面
	 @RequestMapping(value = "/Main", method = RequestMethod.GET)
	    public String showMain(HttpServletRequest request) {
		 if (request.getSession().getAttribute("username") == null) {
		        // 用户未登录，重定向到登录页面
		        return "index";
		    }
		    System.out.println("1");
	        return ("Main");
	 }
	 
	 //工作人员界面
	 @RequestMapping(value = "/Main1", method = RequestMethod.GET)
	    public String showMain1(HttpServletRequest request,Model model) {
		 if (request.getSession().getAttribute("username") == null) {
		        // 用户未登录，重定向到登录页面
		        return "index";
		    }
		  String name = (String) request.getSession().getAttribute("username");
		  model.addAttribute("name", name);

		   System.out.println("name");
	       return ("Main1");
	 }
	 
	 //读者界面
	 //工作人员界面
	 @RequestMapping(value = "/Main2", method = RequestMethod.GET)
	    public String showMain2(HttpServletRequest request,Model model) {
		 if (request.getSession().getAttribute("username") == null) {
		        // 用户未登录，重定向到登录页面
		        return "index";
		    }
		  String name = (String) request.getSession().getAttribute("username");
		  model.addAttribute("name", name);

		   System.out.println("name");
	       return ("Main2");
	 }
	 
	 @RequestMapping(value = "/adduser", method = RequestMethod.GET)
	    public String showRegistrationForm(Model model,HttpServletRequest request) {
		 if (request.getSession().getAttribute("username") == null) {
		        // 用户未登录，重定向到登录页面
		        return "index";
		    }
		    List<Unit> unitList =  unitDao.selectunit();
		    model.addAttribute("unitList", unitList);
		    System.out.println("1");
	        return ("adduser");
	 }


	 @RequestMapping(value = "/login", method = RequestMethod.POST)
	 public ModelAndView login(HttpServletRequest request, HttpServletResponse response,Model model) {
	     String username = request.getParameter("username");
	     String password = request.getParameter("password");
	     System.out.println(username);
	     if(userDao.selectUserByname(username)==null) {
	    	 ModelAndView modelAndView = new ModelAndView("index");
	    	 modelAndView.addObject("error", "用户名或密码错误，请重试。");
	    	 return modelAndView;
	     }
	     User auser = userDao.selectUserByname(username);

	     if(auser.getPassword().equals(password)) {
	    	 //System.out.println(auser);
	         
		   
	    	 HttpSession session = request.getSession();
	         session.setAttribute("username", username);
	    
	       
	        	  String name = (String) request.getSession().getAttribute("username");
	    		  model.addAttribute("name", name);
	    		  
	    		  List<Project> projects = new ArrayList<>();
	              Connection conn = null;
	              PreparedStatement stmt = null;
	              ResultSet rs = null;
	              try {
	                  conn = getConnection();
	                  String sql = "SELECT name, project_file FROM project_files";
	                  stmt = conn.prepareStatement(sql);
	                  rs = stmt.executeQuery();

	                  while (rs.next()) {
	                      Project project = new Project();
	                      project.setName(rs.getString("name"));
	                      project.setProject_path(rs.getString("project_file"));
	                      String content = readFileContent(project.getProject_path());
	                      project.setContent(content);
	                      System.out.print(project.getContent());
	                      projects.add(project);
	                  }
	              } catch (SQLException e) {
	                  e.printStackTrace();
	              } finally {
	                  closeResources(conn, stmt, rs);
	              }
	              System.out.print(projects.size());
	          	ModelAndView mav = new ModelAndView("Main2");
	            mav.addObject("projects", projects);
	        	  return mav;
	         
	     }
	     else {
	    	 ModelAndView modelAndView = new ModelAndView("index");
	    	 modelAndView.addObject("error", "用户名或密码错误，请重试。");
	    	 return modelAndView;
	    	
	     }
	 }
	 
	 private String readFileContent(String filePath) {
		    StringBuilder contentBuilder = new StringBuilder();
		    try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
		        String currentLine;
		        while ((currentLine = br.readLine()) != null) {
		            // Replace < and > with &lt; and &gt;
		            currentLine = currentLine.replace("<", "&lt;").replace(">", "&gt;");
		            contentBuilder.append(currentLine).append("\n");
		        }
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
		    return contentBuilder.toString();
		}

	 
	 @RequestMapping(value = "/add", method = RequestMethod.POST)
	 public ModelAndView adduser(HttpServletRequest request, HttpServletResponse response) {
	     // 处理注册表单提交的逻辑
	     // 从request中获取表单参数
	     String username = request.getParameter("username");
	     //String password = request.getParameter("password");
	     String address= request.getParameter("address");
	     String realname= request.getParameter("realname");
	     String workid= request.getParameter("workid");
	     String number= request.getParameter("number");
	     String email= request.getParameter("email");

	     String gender= request.getParameter("gender");
	     String workplace= request.getParameter("workplace");
	     
	     System.out.println(username);
	     // 执行相应的业务逻辑，比如保存用户信息到数据库
	    
	     String isregister="y";
	     String path="D://";
	     User addmu = new User();
	     //插入用户表
	     addmu.setUsername(username);
	     String password = username.substring(username.length() - 4); // 获取用户名的后四位
	     addmu.setPassword(password); // 设置密码为后四位
	     addmu.setAddress(address);
	     addmu.setRealname(realname);
	     addmu.setEmail(email);
	     addmu.setGender(gender);

	     addmu.setContactphone(number);


	     /*//插入角色表
	     addmu.setRolename(identity);
	     System.out.println(identity);
	     userDao.addrole(addmu);
	     System.out.println("添加了一条记录");
	     System.out.println("================");*/
	     
	     //插入用户角色表
	     User auser= userDao.selectUserByname(username);
	     String uid=auser.getUserid();
	     System.out.println(uid);
	     addmu.setUserid(uid);
	     userDao.adduserrole(addmu);
	     System.out.println("添加了一条记录");
	     System.out.println("================");
	     
	     /*//插入单位表
	     addmu.setUnitname(workplace);
	     addmu.setContactperson(username);
	     addmu.setContactaddress(address);
	     addmu.setEmailaddress(email);
	     
	     userDao.addunit(addmu);*/
	     System.out.println("添加了一条记录");
	     System.out.println("================");
	     // 返回注册成功页面
	     return new ModelAndView("Main");
	 }
	 //展示用户列表
	 @RequestMapping(value = "/usertable", method = RequestMethod.GET)
	     public String showusertable(Model model,HttpServletRequest request) {
		 if (request.getSession().getAttribute("username") == null) {
		        // 用户未登录，重定向到登录页面
		        return "index";
		    }
		 List<User> userList1 =  userDao.selectUser();
		 model.addAttribute("userList1", userList1);
		 System.out.println("2");
	     return ("usertable");
	 }
	 //展示详细信息
	 @RequestMapping(value = "/userdetails", method = RequestMethod.GET)
	 public String showuserdetails(@RequestParam(value = "username") String username, Model model) {
		 //List<User> list1= userDao.selectUserBynametolist(username);//ueser表所有内容
		 List<User> userList = new ArrayList<>();  // 创建一个存储用户的列表
		 User user1 = userDao.selectUserByname(username);  // 获取第一个用户对象
		 String userid = user1.getUserid();
		 String roleid = userDao.selectroleidByid(userid);
		 System.out.println(roleid);
		 User user2= userDao.selectroleByid(roleid);
		 //User user3= userDao.selectunitByname(user1.getRealname());
		 user1.setRolename(user2.getRolename()); 
		 //user1.setUnitname(user3.getUnitname());
		 userList.add(user1);
	     System.out.println(user1.getUserid());

	     // 将用户详细信息传递给视图
	     System.out.println(userList);
	     model.addAttribute("userList", userList);

	     return "userdetails"; // 假设你有一个名为 "userdetails" 的视图
	 }
	 
	 //修改页面
	 @RequestMapping(value = "/edituser", method = RequestMethod.GET)
	 public String showedituser(@RequestParam(value = "username") String username, Model model) {
		 List<User> userList = new ArrayList<>();  // 创建一个存储用户的列表
		 User user1 = userDao.selectUserByname(username);  // 获取第一个用户对象
		 String userid = user1.getUserid();
		 String roleid = userDao.selectroleidByid(userid);
		 System.out.println(roleid);
		 User user2= userDao.selectroleByid(roleid);
		 //User user3= userDao.selectunitByname(user1.getRealname());
		 user1.setRolename(user2.getRolename()); 
		 //user1.setUnitname(user3.getUnitname());
		 userList.add(user1);
	     System.out.println(user1.getUserid());
	     // 将用户详细信息传递给视图
	     System.out.println(userList);
	     model.addAttribute("userList", userList);
	     return "edituser"; 
	 }
	 
	//修改页面
		 @RequestMapping(value = "/editowninfo", method = RequestMethod.GET)
		 public String showeditown(@RequestParam(value = "username") String username, Model model) {
			 List<User> userList = new ArrayList<>();  // 创建一个存储用户的列表
			 User user1 = userDao.selectUserByname(username);  // 获取第一个用户对象
			 String userid = user1.getUserid();
			 String roleid = userDao.selectroleidByid(userid);
			 System.out.println(roleid);
			 User user2= userDao.selectroleByid(roleid);
			 //User user3= userDao.selectunitByname(user1.getRealname());
			 user1.setRolename(user2.getRolename()); 
			 //user1.setUnitname(user3.getUnitname());
			 userList.add(user1);
		     System.out.println(user1.getUserid());
		     // 将用户详细信息传递给视图
		     System.out.println(userList);
		     model.addAttribute("userList", userList);
		     return "editowninfo"; 
		 }
		//修改页面
		 @RequestMapping(value = "/editstaff", method = RequestMethod.GET)
		 public String showeditstaff(@RequestParam(value = "username") String username, Model model) {
			 List<User> userList = new ArrayList<>();  // 创建一个存储用户的列表
			 User user1 = userDao.selectUserByname(username);  // 获取第一个用户对象
			 String userid = user1.getUserid();
			 String roleid = userDao.selectroleidByid(userid);
			 System.out.println(roleid);
			 User user2= userDao.selectroleByid(roleid);
			 //User user3= userDao.selectunitByname(user1.getRealname());
			 user1.setRolename(user2.getRolename()); 
			 //user1.setUnitname(user3.getUnitname());
			 userList.add(user1);
		     System.out.println(user1.getUserid());
		     // 将用户详细信息传递给视图
		     System.out.println(userList);
		     model.addAttribute("userList", userList);
		     return "editstaff"; 
		 }
		 
		 
		//修改页面
		 @RequestMapping(value = "/editreader", method = RequestMethod.GET)
		 public String showeditreader(Model model,HttpServletRequest request) {
			 List<User> userList = new ArrayList<>();  // 创建一个存储用户的列表
			 String username = (String) request.getSession().getAttribute("username");
			 User user1 = userDao.selectUserByname(username);  // 获取第一个用户对象
			 String userid = user1.getUserid();
			 String roleid = userDao.selectroleidByid(userid);
			 System.out.println(roleid);
			 User user2= userDao.selectroleByid(roleid);
			 //User user3= userDao.selectunitByname(user1.getRealname());
			 user1.setRolename(user2.getRolename()); 
			 //user1.setUnitname(user3.getUnitname());
			 userList.add(user1);
		     System.out.println(user1.getUserid());
		     // 将用户详细信息传递给视图
		     System.out.println(userList);
		     model.addAttribute("userList", userList);
		     return "editreader"; 
		 }
	 //修改
	 @RequestMapping(value = "/edit", method = RequestMethod.POST)
	 public String edituser(HttpServletRequest request, HttpServletResponse response) {
		 String name = request.getParameter("name");
	     String address= request.getParameter("address");
	     String realname= request.getParameter("realname");
	     String phone= request.getParameter("phone");
	     String rolename= request.getParameter("rolename");
	     String gender= request.getParameter("gender");
	     String workplace= request.getParameter("workplace");
	     System.out.println(name);
	     // 执行相应的业务逻辑，比如保存用户信息到数据库
	     User addmu = new User();
	     //插入用户表
	     addmu.setUsername(name);
	     addmu.setAddress(address);
	     addmu.setGender(gender);
	     addmu.setContactphone(phone);
	  
	     addmu.setRealname(realname);
	     addmu.setRolename(rolename);
	     
	     //开始修改
	     User user1 = userDao.selectUserByname(name);  // 获取第一个用户对象
		 String userid = user1.getUserid();
		 String roleid = userDao.selectroleidByid(userid);
		 //int i = userDao.updaterole(rolename,roleid);//更新角色表的角色名
		 int m = userDao.updateUser(workplace,name,gender,realname,address,phone,userid);
		 //int n = userDao.updateunit(unitname,phone,address,realname);
		 //System.out.println(i);
		 System.out.println(m);
		 //System.out.println(n);
		 System.out.println(roleid);
	     return "redirect:/userdetails?username="+name; 
	 }
	 
	 @RequestMapping(value = "/editowninfo", method = RequestMethod.POST)
	 public String editown(HttpServletRequest request, HttpServletResponse response) {
		 String name = request.getParameter("name");
	     String address= request.getParameter("address");
	     String realname= request.getParameter("realname");
	     String phone= request.getParameter("phone");
	     String rolename= request.getParameter("rolename");
	     String gender= request.getParameter("gender");
	     String workplace= request.getParameter("workplace");
	     System.out.println(name);
	     // 执行相应的业务逻辑，比如保存用户信息到数据库
	     User addmu = new User();
	     //插入用户表
	     addmu.setUsername(name);
	     addmu.setAddress(address);
	     addmu.setGender(gender);
	     addmu.setContactphone(phone);

	     addmu.setRealname(realname);
	     addmu.setRolename(rolename);
	     
	     //开始修改
	     User user1 = userDao.selectUserByname(name);  // 获取第一个用户对象
		 String userid = user1.getUserid();
		 String roleid = userDao.selectroleidByid(userid);
		 //int i = userDao.updaterole(rolename,roleid);//更新角色表的角色名
		 int m = userDao.updateUser(workplace,name,gender,realname,address,phone,userid);
		 //int n = userDao.updateunit(unitname,phone,address,realname);
		 //System.out.println(i);
		 System.out.println(m);
		 //System.out.println(n);
		 System.out.println(roleid);
	     return "redirect:/Main";
	 }
	 
	 //修改工作人员个人信息
	 @RequestMapping(value = "/editstaff", method = RequestMethod.POST)
	 public String editstaff(HttpServletRequest request, HttpServletResponse response) {
		 String name = request.getParameter("name");
	     String address= request.getParameter("address");
	     String realname= request.getParameter("realname");
	     String phone= request.getParameter("phone");
	     String rolename= request.getParameter("rolename");
	     String gender= request.getParameter("gender");
	     String workplace= request.getParameter("workplace");
	     System.out.println(name);
	     // 执行相应的业务逻辑，比如保存用户信息到数据库
	     User addmu = new User();
	     //插入用户表
	     addmu.setUsername(name);
	     addmu.setAddress(address);
	     addmu.setGender(gender);
	     addmu.setContactphone(phone);

	     addmu.setRealname(realname);
	     addmu.setRolename(rolename);
	     
	     //开始修改
	     User user1 = userDao.selectUserByname(name);  // 获取第一个用户对象
		 String userid = user1.getUserid();
		 String roleid = userDao.selectroleidByid(userid);
		 //int i = userDao.updaterole(rolename,roleid);//更新角色表的角色名
		 int m = userDao.updateUser(workplace,name,gender,realname,address,phone,userid);
		 //int n = userDao.updateunit(unitname,phone,address,realname);
		 //System.out.println(i);
		 System.out.println(m);
		 //System.out.println(n);
		 System.out.println(roleid);
	     return "redirect:/Main1";
	 }
	 //修改用户个人信息
	 @RequestMapping(value = "/editreader", method = RequestMethod.POST)
	 public String reader(HttpServletRequest request, HttpServletResponse response) {
		 String name = request.getParameter("name");
	     String address= request.getParameter("address");
	     String realname= request.getParameter("realname");
	     String phone= request.getParameter("phone");
	     String rolename= request.getParameter("rolename");
	     String gender= request.getParameter("gender");
	     //String workplace= request.getParameter("workplace");
	     System.out.println(name);
	     // 执行相应的业务逻辑，比如保存用户信息到数据库
	     User addmu = new User();
	     //插入用户表
	     addmu.setUsername(name);
	     addmu.setAddress(address);
	     addmu.setGender(gender);
	     addmu.setContactphone(phone);
	     //addmu.setWorkplace(workplace);
	     addmu.setRealname(realname);
	     addmu.setRolename(rolename);
	     
	     //开始修改
	     User user1 = userDao.selectUserByname(name);  // 获取第一个用户对象
		 String userid = user1.getUserid();
		 String roleid = userDao.selectroleidByid(userid);
		 //int i = userDao.updaterole(rolename,roleid);//更新角色表的角色名
		 int m = userDao.updatereader(name,gender,realname,address,phone,userid);
		 //int n = userDao.updateunit(unitname,phone,address,realname);
		 //System.out.println(i);
		 System.out.println(m);
		 //System.out.println(n);
		 System.out.println(roleid);
	     return "redirect:/Main2";
	 }
	 //删除
	 @RequestMapping(value = "/deleteuser", method = RequestMethod.GET)
	 public String deleteuser(@RequestParam(value = "username") String username, Model model) {
		 //List<User> userList = new ArrayList<>();  // 创建一个存储用户的列表
		 User user1 = userDao.selectUserByname(username);  // 获取第一个用户对象
		 String userid = user1.getUserid();
		 String roleid = userDao.selectroleidByid(userid);
		 System.out.println(roleid);//2
		 userDao.deleteuserrole(userid);
		 userDao.deleteuser(username);
		 //userDao.deleteuserrole(userid);
	 
	     return "redirect:/usertable"; 
	 }
	 
	 //用户注册
	 @RequestMapping(value = "/register", method = RequestMethod.GET)
	    public String register(Model model,HttpServletRequest request) {
		
	        return ("register");
	 }
	 
	 //处理用户注册
	 @RequestMapping(value = "/register", method = RequestMethod.POST)
	 public ModelAndView register(HttpServletRequest request, HttpServletResponse response,Model model) {
	     // 处理注册表单提交的逻辑
	     // 从request中获取表单参数
		 //判断重复注册
	     String username = request.getParameter("username");
	     String password = request.getParameter("password");
	     String address= request.getParameter("address");
	     String realname= request.getParameter("realname");
	     String number= request.getParameter("number");
	     String email= request.getParameter("email");
	     String gender= request.getParameter("gender");
	     String question = request.getParameter("question");
	     User user = userDao.selectUserByname(username);
	     if(user!=null) {
	    	 String name = user.getUsername();
		     if(name.equals(username)) {
		    	 ModelAndView modelAndView = new ModelAndView("index");
		    	 modelAndView.addObject("error", "请勿重复注册。");
		    	 return modelAndView;
		     }
	     }
	    
	     System.out.println(username);
	     // 执行相应的业务逻辑，比如保存用户信息到数据库
	    
	     String isregister="y";
	     String path="D://";
	     User addmu = new User();
	     //插入用户表
	     addmu.setUsername(username);
	     addmu.setPassword(password); // 设置密码为后四位
	     addmu.setAddress(address);
	     addmu.setRealname(realname);
	     addmu.setEmail(email);
	     addmu.setGender(gender);
	     addmu.setContactphone(number);
	     addmu.setRealname(realname);
	     addmu.setQuestion(question);
	     userDao.adduser(addmu);

	     
	    
	     ModelAndView modelAndView = new ModelAndView("index");
    	 modelAndView.addObject("error", "注册成功");
    	 return modelAndView;
	 }
	 
	 
	 //修改密码
	 @RequestMapping(value = "/editpassword", method = RequestMethod.GET)
	    public String editpassord(Model model,HttpServletRequest request) {
		
	        return ("editpassword");
	 }
	 
	//处理修改密码
		 @RequestMapping(value = "/editpassword", method = RequestMethod.POST)
		 public String editpassword(HttpServletRequest request, HttpServletResponse response,Model model) {
		     // 处理注册表单提交的逻辑
			 String name=(String) request.getSession().getAttribute("username") ;
			 User user = userDao.selectUserByname(name);
			 String userid = user.getUserid();
		     String answer= request.getParameter("favoritebook");
		     
		     String password = request.getParameter("newpassword");
		     String question = user.getQuestion();
		     System.out.println(question);
		     if(question.equals(answer)) {
		    	 userDao.updatepassword(password,userid);
		    	 return "redirect:/editreader";
		     }
		    
		     else
	    	 return "editpassword";
		 }
		 
		//忘记密码
		 @RequestMapping(value = "/forgetpassword", method = RequestMethod.GET)
		    public String forgetpassord(Model model,HttpServletRequest request) {
			
		        return ("forgetpassword");
		 }
		 
		//处理忘记密码
		 @RequestMapping(value = "/forgetpassword", method = RequestMethod.POST)
		 public ModelAndView forgetpassword(HttpServletRequest request, HttpServletResponse response,Model model) {
		     // 处理注册表单提交的逻辑
			 String name=request.getParameter("username");
			 User user = userDao.selectUserByname(name);
			 String userid = user.getUserid();
		     String answer= request.getParameter("favoritebook");
		     String password = request.getParameter("newpassword");
		     String question = user.getQuestion();
		     System.out.println(question);
		     if(question.equals(answer)) {
		    	 userDao.updatepassword(password,userid);
		    	 ModelAndView modelAndView = new ModelAndView("index");
		    	 modelAndView.addObject("error", "重置密码成功");
		    	 return modelAndView;
		     }
		    
		     else {
		    	   ModelAndView modelAndView = new ModelAndView("index");
			       modelAndView.addObject("error", "重置密码失败");
			       return modelAndView;
		     }
		  
		 }
	
}

//@Controller
//@RequestMapping("/register")
//public class RegisterController {
//	@RequestMapping("/infor")
//	public String register() {
//		return "register";
//	}
//}
