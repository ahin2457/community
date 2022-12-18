<%@page import="com.community.positions.PositionDao"%>
<%@page import="com.community.positions.Position"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	요청 방식
		POST
	요청 URL
		http://localhost/community/admin/positions-register.jsp
	요청 파라미터
		positionSeq		노출순서
		positionName	직위명
	요청 처리 내용
		신규 직위 정보를 테이블에 저장한다.
		지정된 노출 순서보다 노출 순서가 늦은 직위정보의 노출 순서를 1증가 시킨다.
--%>
<%
	// 요청 파라미터 값을 조회한다.
	int positionSeq = StringUtils.stringToInt(request.getParameter("positionSeq"));
	String positionName = request.getParameter("positionName");
	
	// Position객체를 생성해서 요청 파라미터 값을 저장한다.
	Position position = new Position();
	position.setSeq(positionSeq);
	position.setName(positionName);
	
	PositionDao positionDao = PositionDao.getInstance();
	positionDao.updatePositionSeq(positionSeq);
	positionDao.insertPosition(position);
	
	response.sendRedirect("depts.jsp");	
%>