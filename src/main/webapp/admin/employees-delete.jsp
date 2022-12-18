<%@page import="com.community.employees.Employee"%>
<%@page import="com.community.employees.EmployeeDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	요청 방식
		GET
	요청 URL
		http://localhost/community/admin/employees-delete.jsp?empNo=1000
	요청 파라미터
		empNo	삭제할 직원번호
	요청 처리 내용
		요청파라미터로 전달받은 직원번호에 해당하는 직원 정보의 emp_deleted값을 "Y"로 변경한다.
--%>
<%
	// 요청파라미터값을 조회한다.
	int empNo = StringUtils.stringToInt(request.getParameter("empNo"));
	
	EmployeeDao employeeDao = EmployeeDao.getInstance();
	// 사용자정보를 조회한다.
	Employee employee = employeeDao.getEmployeeByNo(empNo);
	employee.setDeleted("Y");
	
	employeeDao.updateEmployee(employee);
	
	response.sendRedirect("employees.jsp");
%>