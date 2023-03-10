package com.community.departments;

import java.util.List;

import com.community.util.SqlMapper;

public class DepartmentDao {

	private static DepartmentDao instance = new DepartmentDao();
	private DepartmentDao() {}
	public static DepartmentDao getInstance() {
		return instance;
	}
	
	@SuppressWarnings("unchecked")
	public List<Department> getAllDepartments() {
		return (List<Department>) SqlMapper.selectList("departments.getAllDepartments");
	}
	
	public Department getDepartmentByNo(int departmentNo) {
		return (Department) SqlMapper.selectOne("departments.getDepartmentByNo", departmentNo);
	}
	
	public void insertDepartment(Department department) {
		SqlMapper.insert("departments.insertDepartment", department);
	}
	
	public void updateDepartment(Department department) {
		SqlMapper.update("departments.updateDepartment", department);
	}
}
