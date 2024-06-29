package dao;
import java.sql.Timestamp;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import po.User;

@Repository("userDao")
@Mapper
/*使用Spring自动扫描MyBatis的接口并装配
（Spring将指定包中所有被@Mapper注解标注的接口自动装配为MyBatis的映射接口*/
public interface UserDao {
	/**
	 * 接口方法对应SQL映射文件UserMapper.xml中的id
	 */
	public User selectUserByname(String username);
	public  List<User> selectUserBynametolist(String username);
	public  List<User> selectUser();
	public  List<User> selectuserrole();
	public  List<User> selectrole();
	public  List<User> selectAllUser();
	public  User selectroleByid(String userid);
	public  User selectunitByname(String contactperson);
	public  String selectroleidByid(String userid);
	public int adduser(User user);
	public int addrole(User user);
	public int adduserrole(User user);
	public int addunit(User user);//添加单位
	public int updatelogintime(String name);
	public int updaterole(@Param("rolename")String rolename,@Param("roleid")String roleid);
	public int updatepassword(@Param("password")String password,@Param("userid")String userid);
	public int updateUser(@Param("workplace")String workplace,@Param("username")String username,@Param("gender")String gender,@Param("realname")String realname,
			@Param("address")String address, @Param("contactphone")String contactphone,@Param("userid")String userid);
	//public int updateunit(@Param("unitname")String unitname,@Param("contactphone")String phone, @Param("address")String address,@Param("realname")String realname);
	public int updatelastlogintime(@Param("username")String name,@Param("lastlogintime")Timestamp lastlogintime);
	public int addcomment(User user);
	public int updateUser(User user);
	public int deleteuser(String username);
	public int deleteuserrole(String userid);
	public int updatereader(@Param("username")String username,@Param("gender")String gender,@Param("realname")String realname,
			@Param("address")String address, @Param("contactphone")String contactphone,@Param("userid")String userid);
}


