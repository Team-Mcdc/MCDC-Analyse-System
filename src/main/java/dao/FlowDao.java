package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import po.Flow;
import po.Unit;
import po.User;

@Repository("FlowDao")
@Mapper
/*使用Spring自动扫描MyBatis的接口并装配
（Spring将指定包中所有被@Mapper注解标注的接口自动装配为MyBatis的映射接口*/
public interface FlowDao {
	public int addflow(Flow flow);
	public int addborrow(Flow flow);
	public List<Flow> selectflowdsh(@Param("flow")String flow,@Param("tounit")String tounit);
	public List<Flow> selectflowdsh2(@Param("flow")String flow,@Param("fromunit")String fromunit);
	public List<Flow> selectownborrow(@Param("state")String state,@Param("borrowingaccountid")String borrowingaccountid);
	public List<Flow> selectborrow(@Param("state")String state,@Param("fromunit")String fromunit);
	public List<Flow> selectflowbyunit(String fromunit);
	
	public int updateflowbyid(@Param("flow")String flow,@Param("borrowingid")String borrowingid);
	public int updatebackbyid(@Param("isback")String isback,@Param("borrowingid")String borrowingid);
	public int updatereaderbackbyid(@Param("isback")String isback,@Param("borrowingid")String borrowingid);
	//public int updatereaderstatebyid(@Param("state")String state,@Param("borrowingid")String borrowingid);
	public  String selectbookbyborrowid(String borrowingidS);
	public  String selectbookbyborrowid2(String borrowingid);
	public int updatebookreturntime(@Param("borrowingid")  String borrowingid);
	public int updatestatebyid(@Param("state")String state,@Param("borrowingid")String borrowingid);
	
}
