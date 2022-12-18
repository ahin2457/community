<%@page import="com.community.employees.Employee"%>
<%@page import="com.community.employees.EmployeeDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	요청 방식
		POST
	요청 URL
		http://localhost/community/loginform.jsp
	요청 파라미터
		empNo			직원번호
		empPassword		비밀번호
	요청 처리 내용
		요청파라미터로 전달받은 직원번호와 비밀번호로 로그인 처리를 수행한다.
		로그인 인증이 완료되면 직원정보를 세션에 저장한다.
 --%>
<%
	// 요청파라미터를 조회한다.
	int empNo = StringUtils.stringToInt(request.getParameter("empNo"));
	String empPassword = request.getParameter("empPassword");
	
	EmployeeDao employeeDao = EmployeeDao.getInstance();
	// 직원정보를 조회한다.
	Employee employee = employeeDao.getEmployeeByNo(empNo);
	// 로그인 인증절차를 수행한다.
	if (employee == null) {
		response.sendRedirect("login-form.jsp?error=fail");
		return;
	}
	if (!employee.getPassword().equals(empPassword)) {
		response.sendRedirect("login-form.jsp?error=fail");
		return;
	}
	
	// 로그인 인증절차가 완료된 직원정보를 HttpSession 객체에 저장한다.
	session.setAttribute("LOGIN_EMPLOYEE", employee);
	
	response.sendRedirect("home.jsp");
%>