<%@page import="com.community.boards.BoardDao"%>
<%@page import="com.community.boards.Board"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	요청 방식
		POST
	요청 URL
		http://localhost/community/admin/board-register.jsp
	요청 파라미터
		parentBoardNo	상위 게시판 번호
		name			게시판 이름
		description		게시판 설명
		readOption		읽기 옵션
		writeOpton		쓰기 옵션
	요청 처리 내용
		신규 게시판 정보(상위 게시판 번호, 게시판 이름, 게시판 설명, 읽기 옵션, 쓰기 옵션)를 전달받아서 테이블에 저장한다.
--%>
<%
	// 요청파라미터값을 조회한다.
	int parentBoardNo = StringUtils.stringToInt(request.getParameter("parentBoardNo"));
	String name = request.getParameter("name");
	String description = request.getParameter("description");
	String readOption = request.getParameter("readOption");
	String writeOption = request.getParameter("writeOption");
	
	BoardDao boardDao = BoardDao.getInstance();
	// 상위 게시판 정보를 조회한다.
	Board parentBoard = boardDao.getBoardByNo(parentBoardNo);
	// 상위 게시판보다 출력순서가 늦은 게시판의 출력순서를 변경한다.
	boardDao.updateBoardSeq(parentBoardNo);
	
	// 조회된 게시판 정보를 Board객체에 저장한다.
	Board board = new Board();
	board.setName(name);
	board.setDescription(description);
	board.setSeq(parentBoard.getSeq() + 1);
	board.setReadOption(readOption);
	board.setWriteOption(writeOption);
	board.setParentBoardNo(parentBoardNo);
	
	// 게시판정보를 테이블에 저장시킨다.
	boardDao.insertBoard(board);
	
	// 게시판 관리 페이지를 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("boards.jsp");
%>