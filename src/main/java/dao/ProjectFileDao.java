package dao;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import po.Project;


@Repository("ProjectFileDao")
@Mapper
/*使用Spring自动扫描MyBatis的接口并装配
（Spring将指定包中所有被@Mapper注解标注的接口自动装配为MyBatis的映射接口*/
public interface ProjectFileDao {
	public int addProjectFile(@Param("userId") int userId, @Param("name") String name, @Param("project_path") String path);
}
