<%@page import="com.community.employees.EmployeeDao"%>
<%@page import="com.community.employees.Employee"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	요청 방식
		POST
	요청 URL
		http://localhost/community/admin/employees-modify.jsp
	요청 파라미터
		no				직원번호
		name			직원이름
		deptNo			부서번호
		positionNo		직원번호
		email			이메일
		phone			전화번호
		type			사용자 타입
		deleted			삭제여부
	요청 처리 내용
		요청 파라미터로 전달받은 변경된 사용자정보를 테이블에 반영한다.
--%>
<%
	// 요청파라미터값을 조회한다.
	int no = StringUtils.stringToInt(request.getParameter("no"));
	String name = request.getParameter("name");
	int deptNo = StringUtils.stringToInt(request.getParameter("deptNo"));
	int positionNo = StringUtils.stringToInt(request.getParameter("positionNo"));
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String type = request.getParameter("type");
	String deleted = request.getParameter("deleted");
	
	EmployeeDao employeeDao = EmployeeDao.getInstance();
	// 직원번호에 해당하는 직원정보를 조회한다.
	Employee employee = employeeDao.getEmployeeByNo(no);
	employee.setName(name);
	employee.setDeptNo(deptNo);
	employee.setPositionNo(positionNo);
	employee.setEmail(email);
	employee.setPhone(phone);
	employee.setType(type);
	employee.setDeleted(deleted);
	// 변경된 사용자정보를 테이블에 반영시킨다.
	employeeDao.updateEmployee(employee);
	
	response.sendRedirect("employees.jsp");
%>