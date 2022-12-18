<%@page import="com.community.posts.PostListDto"%>
<%@page import="com.community.util.Pagination"%>
<%@page import="com.community.posts.PostDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
<link href="/community/resources/css/style.css" rel="stylesheet">
<title>사내 커뮤니티</title>
</head>
<body>
<jsp:include page="../common/header.jsp">
	<jsp:param name="menu" value="admin"/>
</jsp:include>
<%--
	요청 방식
		GET
	요청 URL
		http://localhost/community/admin/posts.jsp
		http://localhost/community/admin/posts.jsp?page=2
		http://localhost/community/admin/posts.jsp?boardNo=100
		http://localhost/community/admin/posts.jsp?boardNo=100&page=2
	요청 파라미터
		page		요청 페이지 번호
		boardNo 	조회할 게시판 번호
	요청 처리 내용
		요청 페이지번호 혹은 게시판번호에 해당하는 게시글 목록을 조회해서 출력한다.
 --%>
<%
	// 요청 파라미터값을 조회한다.
	int boardNo = StringUtils.stringToInt(request.getParameter("boardNo"));
	int currentPage = StringUtils.stringToInt(request.getParameter("page"));

	BoardDao boardDao = BoardDao.getInstance();
	PostDao postDao = PostDao.getInstance();
	
	Map<String, Object> param = new HashMap<>();
	if (boardNo != 0) {
		param.put("boardNo", boardNo);
	}
	
	int totalRows = postDao.getAllTotalRows(param);
	
	Pagination pagination = new Pagination(currentPage, totalRows);
	
	// 게시판 목록을 조회한다.
	List<Board> boardList = boardDao.getBoards(param);

	// 게시글 목록을 조회한다.
	param.put("begin", pagination.getBegin());
	param.put("end", pagination.getEnd());
	List<PostListDto> posts = postDao.getAllPosts(param);	
%>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">게시물 관리</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="card">
				<div class="card-header">전체 게시판 목록</div>
				<div class="card-body">
					<div class="row p-3">
						<div class="col-3 border p-3">
							<p>전체 게시판목록을 확인하세요.</p>
							<div class="list-group">
								<a href="boards.jsp" class="list-group-item list-group-action disabled fw-bold fs-5 text-dark bg-light">
									사내 게시판
								</a>
<%	
	for (Board board : boardList) {
		if (board.getNo() == 0) {
			continue;
		}
%>
								<a href="posts.jsp?boardNo=<%=board.getNo() %>" 
									class="list-group-item list-group-action <%=board.getNo() == boardNo ? "active" : "" %> <%="Y".equals(board.getDeleted()) ? "disabled text-decoration-line-through" : "" %>"
									data-board-no="<%=board.getNo() %>">
									<span class="<%=board.getParentBoardNo() > 0 ? "ps-4" : "" %>"> <%=board.getName() %></span>
								</a>
<%
	}
%>
							</div>
						</div>
						<div class="col-9">
							<form class="border p-3" method="get" action="posts-delete.jsp">
								<input type="hidden" name="page" value="<%=currentPage %>" />
								<input type="hidden" name="boardNo" value="<%=boardNo %>" />
								<table class="table table-sm">
									<colgroup>
										<col width="5%">
										<col width="10%">
										<col width="*">
										<col width="10%">
										<col width="15%">
									</colgroup>
									<thead>
										<tr>
											<th><input type="checkbox"></th>
											<th>번호</th>
											<th>제목</th>
											<th>작성자</th>
											<th>등록일</th>
										</tr>
									</thead>
									<tbody>
<%
	if (posts.isEmpty()) {
%>
										<tr>
											<td colspan="5" class="text-center">게시글이 없습니다.</td>
										</tr>
<%
	} else {
		for (PostListDto dto : posts) {
%>
										<tr>
											<td><input type="checkbox" name="postNo" value="<%=dto.getNo() %>"/></td>
											<td><%=dto.getNo() %></td>
											<td class="<%="D".equals(dto.getDeleted()) ? "text-decoration-line-through" : ""%>">
												<%="Y".equals(dto.getImportant()) ? "[중요] " : "" %>
												<%=dto.getTitle() %>
											</td>
											<td><%=dto.getEmpName() %></td>
											<td><%=StringUtils.dateToText(dto.getCreatedDate()) %></td>
										</tr>
<%
		}
	}
%>
									</tbody>
								</table>
								<nav>
<%
	int beginPage = pagination.getBeginPage();
	int endPage = pagination.getEndPage();
	int prevPage = pagination.getPrevPage();
	int nextPage = pagination.getNextPage();
	boolean isFirst = pagination.isFirst();
	boolean isLast = pagination.isLast();
%>
									<ul class="pagination pagination-sm justify-content-center">
										<li class="page-item <%=isFirst ? "disabled" : ""%>">
											<a class="page-link" href="posts.jsp?page=<%=prevPage %>" data-page-no="<%=prevPage %>">이전</a>
										</li>
<%
	for (int number = beginPage; number <= endPage; number++) {
%>
										<li class="page-item">
											<a class="page-link <%=number == currentPage ? "active" : ""%>" href="employees.jsp?posts=<%=number %>" data-page-no="<%=number %>">1</a>
										</li>
<%
	}
%>
										<li class="page-item <%=isLast ? "disabled" : ""%>">
											<a class="page-link" href="posts.jsp?page=<%=nextPage %>" data-page-no="<%=nextPage %>">다음</a>
										</li>
									</ul>
								</nav>
								<div class="text-end">
									<button type="button" class="btn btn-outline-dark btn-sm">복구</button>
									<button type="button" class="btn btn-outline-dark btn-sm">이동</button>
									<button type="button" class="btn btn-outline-dark btn-sm">삭제</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>