<%@page import="com.community.boards.Board"%>
<%@page import="java.util.List"%>
<%@page import="com.community.boards.BoardDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<link href="/web-community/resources/css/style.css" rel="stylesheet">
<title>사내 커뮤니티</title>
</head>
<body>
<jsp:include page="../common/header.jsp">
	<jsp:param name="menu" value="board"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">최신 게시글</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-3">
			<div class="card">
				<div class="card-header">전체 게시판 목록</div>
				<div class="card-body">
					<div class="d-grid gap-2">
						<button class="btn btn-primary btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#modal-form-posts">게시글 등록</button>
					</div>
					<div class="list-group">
		  				<a href="boards.jsp" 
		  					class="list-group-item list-group-action disabled fw-bold fs-5 text-dark bg-light">
		  					사내 게시판
		  				</a>
<%	
	int boardNo = StringUtils.stringToNumber(request.getParameter("boardNo"));

	BoardDao boardDao = BoardDao.getInstance();
	
	// 전체 게시판 목록을 조회한다.
	List<Board> boardList = boardDao.getAllBoards();
	
	// 선택한 게시판의 상세정보를 조회한다.
	Board selectedBoard = boardDao.getBoardByNo(boardNo);
	
	for (Board board : boardList) {
		if (board.getNo() == 0) {
			continue;
		}
%>
		  				<a href="boards.jsp?boardNo=<%=board.getNo() %>" 
		  					class="list-group-item list-group-action <%=board.getNo() == boardNo ? "active" : "" %>"
		  					data-board-no="<%=board.getNo() %>">
		  					<span class="<%=board.getParentBoardNo() > 0 ? "ps-4" : "" %>"> <%=board.getName() %></span>
		  				</a>
<%
	}
%>
					</div>
				</div>
			</div>
		</div>
		<div class="col-9">
			<div class="card">
				<div class="card-header">최신 게시글</div>
				<div class="card-body">
					<form class="mb-3" method="get" action="">
						<div class="mb-2 d-flex justify-content-between">
							<div>
								<select class="form-select form-select-xs">
									<option value="10"> 10</option>
									<option value="10"> 15</option>
									<option value="10"> 20</option>
								</select>
							</div>
							<div>
								<small><input type="checkbox"> 안읽은 게시글</small>
								<select class="form-select form-select-xs">
									<option value="10"> 제목</option>
									<option value="10"> 작성자</option>
									<option value="10"> </option>
								</select>
								<input type="text" class="form-control form-control-xs w-150">
								<button type="button" class="btn btn-outline-secondary btn-xs">검색</button>
							</div>
						</div>
						<table class="table table-sm border-top">
							<colgroup>
								<col width="3%">
								<col width="9%">
								<col width="15%">
								<col width="*">
								<col width="10%">
								<col width="12%">
								<col width="7%">
								<col width="7%">
							</colgroup>
							<thead>
								<tr class="bg-light">
									<th><input type="checkbox"></th>
									<th>번호</th>
									<th>게시판명</th>
									<th>제목</th>
									<th>작성자</th>
									<th>등록일</th>
									<th>조회</th>
									<th>추천</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="checkbox" name="" value=""/></td>
									<td>100000</td>
									<td>공지사항</td>
									<td><a href="" class="text-decoration-none text-dark">[중요] 공지사항 등록</a></td>
									<td>홍길동</td>
									<td>2022-12-01</td>
									<td>12</td>
									<td>10</td>
								</tr>
							</tbody>
						</table>
					</form>
					<nav>
						<ul class="pagination pagination-sm justify-content-center">
							<li class="page-item disabled">
								<a class="page-link">이전</a>
							</li>
							<li class="page-item"><a class="page-link active" href="#">1</a></li>
							<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
							<li class="page-item">
								<a class="page-link" href="#">다음</a>
							</li>
						</ul>
					</nav>
					<div class="text-end">
						<button class="btn btn-primary btn-xs"  data-bs-toggle="modal" data-bs-target="#modal-form-posts">등록</button>
						<button class="btn btn-danger btn-xs">삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../common/modal-form-posts.jsp">
	<jsp:param name="boardNo" value="100"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>