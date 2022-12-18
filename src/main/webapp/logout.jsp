<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	요청 방식
		GET
	요청 URL
		http://localhost/community/logout.jsp
	요청 파라미터
		없음
	요청 처리 내용
		HttpSession 객체를 무효화시켜서 HttpSession 객체에 저장된 인증된 사용자정보를 삭제시켜서 로그아웃 처리를 수행한다.
 --%>
<%
	session.invalidate();
	response.sendRedirect("home.jsp");
%>