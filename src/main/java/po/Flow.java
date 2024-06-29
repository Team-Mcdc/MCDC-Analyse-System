package po;

import java.sql.Date;
import java.sql.Timestamp;

public class Flow {
	private String borrowingid;
	private String bookid;
	private String borrowingaccountid;
	private Timestamp borrowingtime;
	private Timestamp returntime;
	private String borrowingreason;
	private String borrower;
	private String borrowercontact;
	private String remark;
	private String fromunit;//对方单位
	private String tounit;
	private String flow;
	private String isback;
	private String state;
	private String yujireturntime;
	
	public String getBorrowingid() {
		return borrowingid;
	}
	public void setBorrowingid(String borrowingid) {
		this.borrowingid = borrowingid;
	}
	public String getBookid() {
		return bookid;
	}
	public void setBookid(String bookid) {
		this.bookid = bookid;
	}
	public String getBorrowingaccountid() {
		return borrowingaccountid;
	}
	public void setBorrowingaccountid(String borrowingaccountid) {
		this.borrowingaccountid = borrowingaccountid;
	}
	
	public String getBorrowingreason() {
		return borrowingreason;
	}
	public void setBorrowingreason(String borrowingreason) {
		this.borrowingreason = borrowingreason;
	}
	public String getBorrower() {
		return borrower;
	}
	public void setBorrower(String borrower) {
		this.borrower = borrower;
	}
	public String getBorrowercontact() {
		return borrowercontact;
	}
	public void setBorrowercontact(String borrowcontact) {
		this.borrowercontact = borrowcontact;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getFromunit() {
		return fromunit;
	}
	public void setFromunit(String fromunit) {
		this.fromunit = fromunit;
	}
	public String getTounit() {
		return tounit;
	}
	public void setTounit(String tounit) {
		this.tounit = tounit;
	}
	public Timestamp getBorrowingtime() {
		return borrowingtime;
	}
	public void setBorrowingtime(Timestamp borrowingtime) {
		this.borrowingtime = borrowingtime;
	}
	public Timestamp getReturntime() {
		return returntime;
	}
	public void setReturntime(Timestamp returntime) {
		this.returntime = returntime;
	}
	public String getFlow() {
		return flow;
	}
	public void setFlow(String flow) {
		this.flow = flow;
	}
	public String getIsback() {
		return isback;
	}
	public void setIsback(String isback) {
		this.isback = isback;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getYujireturntime() {
		return yujireturntime;
	}
	public void setYujireturntime(String yujireturntime) {
		this.yujireturntime = yujireturntime;
	}
	
}
