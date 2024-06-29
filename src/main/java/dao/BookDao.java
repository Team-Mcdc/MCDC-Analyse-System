package dao;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import po.Book;
import po.Unit;
import po.User;

@Repository("bookDao")
@Mapper
/*使用Spring自动扫描MyBatis的接口并装配
（Spring将指定包中所有被@Mapper注解标注的接口自动装配为MyBatis的映射接口*/
public interface BookDao {
	public  List<Book> selectbook();
	public  List<Book> selectbookbystate(String flow);
	public  List<Book> selectbookbyunit(String unit);
	public  Book selectbookbyid(String bookid);
	public List<Book> selectothorbook(String bookid);
	public  List<Book> selectownbook(String unit);
	public int updatebookinfo(
	            @Param("bookname") String bookname,
	            @Param("publicationdate") Date publicationDate,
	            @Param("pages") int pages,
	            @Param("author") String author,
	            @Param("publisher") String publisher,
	            @Param("bookcategory") String bookCategory,
	            @Param("price") float price,
	            @Param("bookid") String bookId
	    );
	public  int deletebook(String bookid);
	public int addbook(Book book);
	public List<Book> selectbookbykeyword(String searchName);
	public int updatebookstate(@Param("state") String state,@Param("bookid") String bookid);
	public int updatebookflow(@Param("flow") String flow,@Param("bookid") String bookid);
}


