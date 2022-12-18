<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.boards.Board"%>
<%@page import="java.util.List"%>
<%@page import="com.community.boards.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		http://localhostcommunity/admin/boards.jsp
		http://localhostcommunity/admin/boards.jsp?boardNo=100
	요청 파라미터
		boardNo			게시판 번호
	요청 처리내용
		게시판 전체 목록을 화면에 출력한다.
		요청파라미터로 전달받은 게시판번호에 해당하는 게시판 상세정보를 출력한다.
--%>
<%	
	// 요청 파라미터 값을 조회한다.
	int boardNo = StringUtils.stringToInt(request.getParameter("boardNo"));

	BoardDao boardDao = BoardDao.getInstance();
	
	// 전체 게시판 목록을 조회한다.
	List<Board> boardList = boardDao.getAllBoards();
	
	// 선택한 게시판의 상세정보를 조회한다.
	Board selectedBoard = boardDao.getBoardByNo(boardNo);
%>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">게시판 관리</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="card">
				<div class="card-header">전체 게시판 목록</div>
				<div class="card-body">
					<div class="row p-2">
						<div class="col-3">
							<div class="list-group" id="list-boards">
								<a href="boards.jsp" class="list-group-item list-group-action disabled fw-bold fs-5 text-dark bg-light">
		  							사내 게시판
		  						</a>
<%	
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
						<div class="col-9">
							<form id="form-board-info" class="border p-3" method="post" action="boards-modify.jsp">
								<input type="hidden" name="boardNo" value="<%=selectedBoard.getNo() %>" />
								<table class="table table-sm">
									<colgroup>
										<col width="25%">
										<col width="75%">
									</colgroup>
									<tbody>
										<tr class="align-middle">
											<th>상위 게시판</th>
											<td>
												<select class="form-select form-select-sm" name="parentBoardNo">
													<option value="0"> 선택안함</option>
<%
	for (Board board : boardList) {
		if (board.getParentBoardNo() == 0) {
%>
													<option value="<%=board.getNo() %>" <%=board.getNo() == selectedBoard.getParentBoardNo() ? "selected" : ""%>> <%=board.getName() %></option>
<%
		}
	}
%>
												</select>
											</td>
										</tr>
										<tr class="align-middle">
											<th>게시판 이름</th>
											<td>
												<input type="text" class="form-control form-control-sm" name="name" value="<%=selectedBoard.getName() %>" />
											</td>
										</tr>
										<tr class="align-middle">
											<th>게시판 설명</th>
											<td>
												<textarea class="form-control" rows="3" name="description"><%=selectedBoard.getDescription() %></textarea>
											</td>
										</tr>
										<tr class="align-middle">
											<th>게시판 사용</th>
											<td>
												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio" name="deleted" value="N" <%="N".equals(selectedBoard.getDeleted()) ? "checked" :"" %>>
													<label class="form-check-label">사용</label>
												</div>
												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio" name="deleted" value="Y" <%="Y".equals(selectedBoard.getDeleted()) ? "checked" :"" %>>
													<label class="form-check-label">미사용</label>
												</div>
											</td>
										</tr>
										<tr class="align-middle">
											<th>읽기 권한</th>
											<td>
												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio" name="readOption" value="Y" <%="Y".equals(selectedBoard.getReadOption()) ? "checked" :"" %>>
													<label class="form-check-label">전체 허용</label>
												</div>
												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio" name="readOption" value="N" <%="N".equals(selectedBoard.getReadOption()) ? "checked" :"" %>>
													<label class="form-check-label">개별 설정</label>
												</div>
											</td>
										</tr>
										<tr class="align-middle">
											<th>쓰기 권한</th>
											<td>
												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio" name="writeOption" value="Y" <%="Y".equals(selectedBoard.getWriteOption()) ? "checked" :"" %>>
													<label class="form-check-label">전체 허용</label>
												</div>
												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio" name="writeOption" value="N" <%="N".equals(selectedBoard.getWriteOption()) ? "checked" :"" %>>
													<label class="form-check-label">개별 설정</label>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="text-end">
									<button type="submit" class="btn btn-warning btn-xs" id="btn-modify-board">수정</button>
									<a href="boards-delete.jsp?boardNo=<%=boardNo%>" class="btn btn-danger btn-xs me-3 <%=selectedBoard.getNo() == 0 ? "disabled" : "" %>">삭제</a>
									<button type="button" class="btn btn-primary btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-boards">신규 등록</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal" tabindex="-1" id="modal-form-boards">
	<div class="modal-dialog modal-lg">
	<form id="form-board" class="p-3" method="post" action="boards-register.jsp">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">신규 게시판 등록폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<table class="table table-sm">
						<colgroup>
							<col width="25%">
							<col width="75%">
						</colgroup>
						<tbody>
							<tr class="align-middle">
								<th>상위 게시판</th>
								<td>
									<select class="form-select form-select-sm" name="parentBoardNo">
										<option value="0"> 선택안함</option>
<%
for (Board board : boardList) {
	if (board.getParentBoardNo() == 0) {
%>
										<option value="<%=board.getNo() %>" > <%=board.getName() %></option>
<%
	}
}
%>
									</select>
								</td>
							</tr>
							<tr class="align-middle">
								<th>게시판 이름</th>
								<td>
									<input type="text" class="form-control form-control-sm" name="name"/>
								</td>
							</tr>
							<tr class="align-middle">
								<th>게시판 설명</th>
								<td>
									<textarea class="form-control" rows="3" name="description"></textarea>
								</td>
							</tr>
							<tr class="align-middle">
								<th>게시판 사용</th>
								<td>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="deleted" value="N" checked>
										<label class="form-check-label">사용</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="deleted" value="Y">
										<label class="form-check-label">미사용</label>
									</div>
								</td>
							</tr>
							<tr class="align-middle">
								<th>읽기 권한</th>
								<td>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="readOption" value="Y" checked>
										<label class="form-check-label">전체 허용</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="readOption" value="N">
										<label class="form-check-label">개별 설정</label>
									</div>
								</td>
							</tr>
							<tr class="align-middle">
								<th>쓰기 권한</th>
								<td>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="writeOption" value="Y" checked>
										<label class="form-check-label">전체 허용</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="writeOption" value="N">
										<label class="form-check-label">개별 설정</label>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-xs">등록</button>
			</div>
		</div>
	</form>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	
	let $boarInfoForm = $("#form-board-info");
	
	// 수정 버튼 클릭시 실행되는 이벤트 핸들러 함수를 등록한다.
	$("#form-board-info").submit(function() {
		if ($("#form-board-info :input[name=name]").val() === "") {
			alert("게시판 이름을 필수입력값입니다.");
			return false;
		}
		if ($("#form-board-info :input[name=description]").val() === "") {
			alert("게시판 설명은 필수입력값입니다.");
			return false;
		}
		return true;
	});
	
	// 신규등록 버튼 클릭시 실행되는 이벤트 핸들러 함수를 등록한다.
	$("#form-board").submit(function() {
		if ($("#form-board :input[name=name]").val() === "") {
			alert("게시판 이름을 필수입력값입니다.");
			return false;
		}
		if ($("#form-board :input[name=description]").val() === "") {
			alert("게시판 설명은 필수입력값입니다.");
			return false;
		}
		return true;
	});
})
</script>
</body>
</html>