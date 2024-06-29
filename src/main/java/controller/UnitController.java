package controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.Model;

import dao.BookDao;
import dao.UnitDao;
import dao.UserDao;
import po.Book;
import po.User;
import po.Unit;

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
public class UnitController {
	@Autowired//注解装配，默认按照名称进行属性注入
	private UnitDao unitDao;

	 //展示添加页面
	 @RequestMapping(value = "/addunit", method = RequestMethod.GET)
	    public String showaddunit(HttpServletRequest request) {
		 if (request.getSession().getAttribute("username") == null) {
		        // 用户未登录，重定向到登录页面
		        return "index";
		    }
		    System.out.println("1");
	        return ("addunit");
	 }
	 @RequestMapping(value = "/addunit", method = RequestMethod.POST)
	 public ModelAndView addunit(HttpServletRequest request, HttpServletResponse response) {
	     // 处理注册表单提交的逻辑
	     // 从request中获取表单参数
		 String unitname = request.getParameter("unitname");
	     String contactperson = request.getParameter("contactperson");
	     String contactphone = request.getParameter("contactphone");
	     String contactaddress = request.getParameter("contactaddress");
	     String emailaddress = request.getParameter("emailaddress");
	    
	     Unit unit = new Unit();
	   // 插入单位表
	     unit.setUnitname(unitname);
	     unit.setContactperson(contactperson);
	     unit.setContactphone(contactphone);
	     unit.setContactaddress(contactaddress);
	     unit.setEmailaddress(emailaddress);
	     unitDao.addunit(unit);
	    
	     System.out.println("添加了一条记录");
	     System.out.println("================");
	     // 返回注册成功页面
	     return new ModelAndView("Main");
	 }
	 //展示用户列表
	 @RequestMapping(value = "/unit", method = RequestMethod.GET)
	     public String showunittable(Model model,HttpServletRequest request) {
		 if (request.getSession().getAttribute("username") == null) {
		        // 用户未登录，重定向到登录页面
		        return "index";
		    }
		 List<Unit> unitList =  unitDao.selectunit();
		 model.addAttribute("unitList",unitList);
		 System.out.println("2");
	     return ("unit");
	 }
	 //模糊查询
	 @RequestMapping(value = "/searchUnit", method = RequestMethod.GET)
	 public String searchbook(@RequestParam(value = "search", required = false) String searchKeyword, Model model) {
	     // 在这里执行模糊查询的逻辑，使用 searchKeyword
	     // 例如，你可以调用一个 service 方法来执行数据库查询
		 System.out.println(searchKeyword);
	     List<Unit> searchResults = unitDao.selectUnitByName(searchKeyword);
	     System.out.println(searchResults);
	     // 将查询结果传递到前端页面
	     model.addAttribute("unitList", searchResults);
	     
	     // 返回你的单位列表页面
	     return "unit";// 假设你的单位列表页面的视图名称为 "unitList"
	 }
	 
	 //详情
	 @RequestMapping(value = "/unitdetails", method = RequestMethod.GET)
	 public String unitdetails (@RequestParam(value = "unitid", required = false) String unitid, Model model) {
	     Unit unit  = unitDao.selectUnitByid(unitid);
	     List<Unit> unitList = new ArrayList<>();
	     unitList.add(unit);
	     System.out.println(unit.getUnitname());
	     model.addAttribute("unitList", unitList);
	     return "unitdetails";// 假设你的单位列表页面的视图名称为 "unitList"
	 }
	 
	 //修改展示
	 @RequestMapping(value = "/editunit", method = RequestMethod.GET)
	 public String showunitedit (@RequestParam(value = "unitid", required = false) String unitid, Model model) {
	     Unit unit  = unitDao.selectUnitByid(unitid);
	     List<Unit> unitList = new ArrayList<>();
	     unitList.add(unit);
	     System.out.println(unit.getUnitname());
	     model.addAttribute("unitList", unitList);
	     return "editunit";// 假设你的单位列表页面的视图名称为 "unitList"
	 }
	 
	 //修改
	 @RequestMapping(value = "/editunit", method = RequestMethod.POST)
	    public String editunit(HttpServletRequest request, HttpServletResponse response) {
		    String unitid = request.getParameter("unitid");
	        String unitname = request.getParameter("unitname");
	        String contactperson = request.getParameter("contactperson");
	        String contactphone = request.getParameter("contactphone");
	        String emailaddress = request.getParameter("emailaddress");
	        String contactaddress = request.getParameter("contactaddress");
	        String unittype = request.getParameter("unittype");

	        System.out.println(unitname);
	        int m = unitDao.updateunit(unitname,contactperson,contactphone,emailaddress,contactaddress,unittype,unitid);

	        return "redirect:/unitdetails?unitid=" + unitid;
	    }
	 
	 //删除
	 @RequestMapping(value = "/deleteunit", method = RequestMethod.GET)
	 public String deleteunit(@RequestParam(value = "unitid")String unitid,Model model) {
		 unitDao.deleteunit(unitid);
		 System.out.println("删除成功");
	     return "redirect:/unit";
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
