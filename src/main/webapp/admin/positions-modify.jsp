<%@page import="com.community.positions.Position"%>
<%@page import="com.community.positions.PositionDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	요청 방식
		POST
	요청 URL
		http://localhost/community/admin/positions-modify.jsp
	요청 파라미터
		positionNo		직위번호
		positionName	변경된 직위명
	요청 처리 내용
		직위번호, 변경된 직위명을 전달받아서 테이블에 반영시킨다.
--%>
<%
	// 요청 파라미터 값을 조회한다.
	int positionNo = StringUtils.stringToInt(request.getParameter("positionNo"));
	String positionName = request.getParameter("positionName");
	
	PositionDao positionDao = PositionDao.getInstance();
	// 직위번호로 직위정보를 조회한다.
	Position position = positionDao.getPositionByNo(positionNo);
	position.setName(positionName);
	
	// 변경된 직위정보를 테이블에 반영시킨다.
	positionDao.updatePosition(position);
	
	response.sendRedirect("depts.jsp");
%>