package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import po.Unit;
import po.User;

@Repository("unitDao")
@Mapper
/*使用Spring自动扫描MyBatis的接口并装配
（Spring将指定包中所有被@Mapper注解标注的接口自动装配为MyBatis的映射接口*/
public interface UnitDao {
	public int addunit(Unit unit);
	public List<Unit> selectunit();
	public Unit selectUnitByid(String unitid);
	public List<Unit> selectUnitByName(String searchName);
	public  int updateunit(@Param("unitname") String unitname,
            @Param("contactperson") String contactperson,
            @Param("contactphone") String contactphone,
            @Param("emailaddress") String emailaddress,
            @Param("contactaddress") String contactaddress,
            @Param("unittype") String unittype,
            @Param("unitid") String unitid);
	public  int deleteunit(String unitid);
}
