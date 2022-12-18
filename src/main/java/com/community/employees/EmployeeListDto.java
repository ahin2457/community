package com.community.employees;

public class EmployeeListDto {

	private int no;
	private String name;
	private int deptNo;
	private String deptName;
	private int positionNo;
	private String positionName;
	private String phone;
	private String deleted;

	public EmployeeListDto() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getDeptNo() {
		return deptNo;
	}

	public void setDeptNo(int deptNo) {
		this.deptNo = deptNo;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public int getPositionNo() {
		return positionNo;
	}

	public void setPositionNo(int positionNo) {
		this.positionNo = positionNo;
	}

	public String getPositionName() {
		return positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDeleted() {
		return deleted;
	}
	
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
}
