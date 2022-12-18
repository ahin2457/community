<%@page import="com.community.boards.Board"%>
<%@page import="com.community.boards.BoardDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
	요청 방식
		GET
	요청 URL
		http://localhost/community/admin/boards-delete.jsp?boardNo=100
	요청 파라미터
		boardNo		삭제할 게시판 번호
	요청 처리 내용
		요청파라미터로 전달받은 게시판 정보를 삭제한다.
 --%>
<%
	// 요청파라미터값을 조회한다.
	int boardNo = StringUtils.stringToNumber(request.getParameter("boardNo"));
	
	BoardDao boardDao = BoardDao.getInstance();
	// 게시판 번호에 해당하는 게시판 정보를 조회한다.
	Board board = boardDao.getBoardByNo(boardNo);
	// 게시판 정보 삭제여부를 "Y"로 변경한다.
	board.setDeleted("Y");
	// 변경된 게시판 정보를 테이블에 반영한다.
	boardDao.updateBoard(board);
	
	response.sendRedirect("boards.jsp?boardNo=" + boardNo);
%>