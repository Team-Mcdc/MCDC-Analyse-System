package po;

public class Project {
	private int UserId;
	private String name;
	private String project_path;
	private String content;
	
	public int getUserId() {
		return UserId;
	}
	public void setUserId(int userId) {
		UserId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProject_path() {
		return project_path;
	}
	public void setProject_path(String project_path) {
		this.project_path = project_path;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
}
