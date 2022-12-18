package com.community.employees;

import java.util.List;
import java.util.Map;

import com.community.util.SqlMapper;

public class EmployeeDao {

	private static EmployeeDao instance = new EmployeeDao();
	private EmployeeDao() {}
	public static EmployeeDao getInstance() {
		return instance;
	}
	
	public int getTotalRows(Map<String, Object> param) {
		return (Integer) SqlMapper.selectOne("employees.getTotalRows", param); 
	}
	
	@SuppressWarnings("unchecked")
	public List<EmployeeListDto> getEmployees(Map<String, Object> param) {
		return (List<EmployeeListDto>) SqlMapper.selectList("employees.getEmployees", param);
	}
	
	public void insertEmployee(Employee employee) {
		SqlMapper.insert("employees.insertEmployee", employee);
	}
	
	public Employee getEmployeeByNo(int employeeNo) {
		return (Employee) SqlMapper.selectOne("employees.getEmployeeByNo", employeeNo);
	}

	public Employee getEmployeeByEmail(String employeeEmail) {
		return (Employee) SqlMapper.selectOne("employees.getEmployeeByEmail", employeeEmail);
	}
	
	public void updateEmployee(Employee employee) {
		SqlMapper.update("employees.updateEmployee", employee);
	}
}
