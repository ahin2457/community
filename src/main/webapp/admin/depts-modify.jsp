<%@page import="com.community.departemtns.Department"%>
<%@page import="com.community.departemtns.DepartmentDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
	요청 방식
		POST
	요청 URL
		http://localhost/community/admin/post-register.jsp
	요청 파라미터
		deptNo		부서번호
		deptName	부서이름
	요청 처리 내용
		변경된 부서정보를 전달받아서 테이블에 반영한다.
--%>
<%
	// 요청 파라미터값을 조회한다.
	int deptNo = StringUtils.stringToNumber(request.getParameter("deptNo"));
	String deptName = request.getParameter("deptName");
	
	DepartmentDao departmentDao = DepartmentDao.getInstance();
	
	// 부서번호로 부서정보를 조회한다.
	Department department = departmentDao.getDepartmentByNo(deptNo);
	// 조회된 부서이름을 Department객체에 반영한다.
	department.setName(deptName);
	departmentDao.updateDepartment(department);
	
	response.sendRedirect("depts.jsp");
%>