<%@page import="com.community.boards.BoardDao"%>
<%@page import="com.community.boards.Board"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	요청 방식
		POST
	요청 URL
		http://localhost/community/admin/board-modify.jsp
	요청 파라미터
		boardNo			게시판 번호
		parentBoardNo	상위 게시판 번호
		name			게시판 이름
		description		게시판 설명
		seq				게시판 출력순서
		deleted			게시판 삭제여부
		readOption		읽기 옵션
		writeOpton		쓰기 옵션
	요청 처리 내용
		신규 게시판 정보(상위 게시판 번호, 게시판 이름, 게시판 설명, 읽기 옵션, 쓰기 옵션)를 전달받아서 테이블에 저장한다.
--%>
<%
	// 요청파라미터값을 조회한다.
	int boardNo = StringUtils.stringToInt(request.getParameter("boardNo"));
	int parentBoardNo = StringUtils.stringToInt(request.getParameter("parentBoardNo"));
	String name = request.getParameter("name");
	String description = request.getParameter("description");
	String deleted = request.getParameter("deleted");
	String readOption = request.getParameter("readOption");
	String writeOption = request.getParameter("writeOption");

	BoardDao boardDao = BoardDao.getInstance();
	// 게시판 번호에 해당하는 게시판정보를 조회한다.
	Board board = boardDao.getBoardByNo(boardNo);
	// 변경전의 상위게시판 번호와 변경할 상위게시판 번호가 서로 다르면 상위 게시판 정보를 조회하고, 상위 게시판 보다 출력순서가 늦은 게시판들의 출력순서를 변경한다.
	if (board.getParentBoardNo() != parentBoardNo) {
		Board parentBoard = boardDao.getBoardByNo(parentBoardNo);
		boardDao.updateBoardSeq(parentBoardNo);
		
		board.setSeq(parentBoard.getSeq() + 1);
	}

	// 조회된 게시판 정보로 Board객체의 값을 변경한다. 
	board.setNo(boardNo);
	board.setName(name);
	board.setDescription(description);
	board.setDeleted(deleted);
	board.setReadOption(readOption);
	board.setWriteOption(writeOption);
	board.setParentBoardNo(parentBoardNo);
	
	// 게시판정보를 테이블에 저장시킨다.
	boardDao.updateBoard(board);
	
	// 게시판 관리 페이지를 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("boards.jsp?boardNo=" + boardNo);
%>