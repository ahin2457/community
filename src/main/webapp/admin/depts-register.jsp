<%@page import="com.community.departments.Department"%>
<%@page import="com.community.departments.DepartmentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	요청 방식
		POST
	요청 URL
		http://localhost/community/admin/depts-register.jsp
	요청 파라미터
		deptName		신규 부서이름
	요청 처리 내용
		신규 부서정보를 테이블에 등록한다.
 --%>
<%
	// 요청 파라미터값을 조회한다.
	String deptName = request.getParameter("deptName");

	// Department객체를 생성해서 요청파라미터값을 저장한다.
	Department department = new Department();
	department.setName(deptName);
	
	DepartmentDao departmentDao = DepartmentDao.getInstance();
	// 신규 부서정보를 전달해서 테이블에 저장시킨다.
	departmentDao.insertDepartment(department);
	
	response.sendRedirect("depts.jsp");
%>