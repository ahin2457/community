<%@page import="com.community.employees.EmployeeDao"%>
<%@page import="com.community.employees.Employee"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	요청 방식
		POST
	요청 URL
		http://localhost/community/admin/employees-register.jsp
	요청 파라미터
		name			직원이름
		deptNo			소속부서번호
		positionNo		직위번호
		email			이메일
		phone			연락처
		type			사용자 타입
	요청 처리 내요
		전달받은 신규 사용자정보를 테이블에 저장한다.		
--%>
<%
	// 요청 파라미터값을 조회한다.
	String name = request.getParameter("name");
	int deptNo = StringUtils.stringToInt(request.getParameter("deptNo"));
	int positionNo = StringUtils.stringToInt(request.getParameter("positionNo"));
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String type = request.getParameter("type");
	
	EmployeeDao employeeDao = EmployeeDao.getInstance();
	
	// 요청 파라미터값을 Employee 객체에 저장한다.
	Employee employee = new Employee();
	employee.setName(name);
	employee.setPassword("1234");
	employee.setDeptNo(deptNo);
	employee.setPositionNo(positionNo);
	employee.setEmail(email);
	employee.setPhone(phone);
	employee.setType(type);
	
	employeeDao.insertEmployee(employee);
	
	response.sendRedirect("employees.jsp");
	
%>