<%@page import="com.community.posts.NotificationDao"%>
<%@page import="com.community.posts.CommentDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.community.posts.PostDao"%>
<%@page import="com.community.employees.EmployeeDao"%>
<%@page import="com.community.employees.EmployeeDetailDto"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.employees.Employee"%>
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
	<jsp:param name="menu" value="employee"/>
</jsp:include>
<%--
	요청 방식
		GET
	요청 URL
		http://localhost/community/employee/home.jsp
	요청 파라미터
		없음
	요청 처리 내용
		세션에 저장된 로그인된 직원 정보를 출력한다.
		해당 직원이 작성한 글 갯수, 작성한 댓글 갯수, 받은 알림 갯수를 조회해서 출력한다.
 --%>
<%
	Employee loginEmployee = (Employee) session.getAttribute("LOGIN_EMPLOYEE");
	if (loginEmployee == null) {
		response.sendRedirect("../login-form.jsp?error=deny");
		return;
	}
	
	EmployeeDao employeeDao = EmployeeDao.getInstance();
	PostDao postDao = PostDao.getInstance();
	CommentDao commentDao = CommentDao.getInstance();
	NotificationDao notificationDao = NotificationDao.getInstance();
	
	// 직원 상세정보를 조회한다.
	EmployeeDetailDto dto = employeeDao.getEmployeeDetail(loginEmployee.getNo());
	
	Map<String, Object> param = new HashMap<>();
	param.put("empNo", loginEmployee.getNo());
	
	int postTotalRows = postDao.getAllTotalRows(param);
	int commentTotalRows = commentDao.getAllTotalRows(param);
	int notificationTotalRows = notificationDao.getAllTotalRows(param);
%>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">내 정보 보기</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-3">
			<div class="card">
				<div class="card-header">나의 메뉴</div>
				<div class="card-body">
					<div class="list-group">
						<a href="home.jsp" class="list-group-item list-group-item-action active">내 정보 보기</a>
						<a href="my-posts.jsp" class="list-group-item list-group-item-action">내가 작성한 게시글</a>
						<a href="my-comments.jsp" class="list-group-item list-group-item-action">내가 작성한 댓글</a>
						<a href="my-notifications.jsp" class="list-group-item list-group-item-action">나에게 온 알림</a>
					</div>
				</div>
				<div class="card-body">
					<div class="list-group">
						<a href="password-change-form.jsp" class="list-group-item list-group-item-action">비밀번호 변경하기</a>
					</div>
				</div>
			</div>
		</div>
		<div class="col-9">
			<div class="row mb-3">
				<div class="col-12">
					<table class="table table-bordered">
						<colgroup>
							<col width="15%">
							<col width="35%">
							<col width="15%">
							<col width="35%">
						</colgroup>
						<tbody>
							<tr>
								<th class="bg-light">직원번호</th><td><%=dto.getNo() %></td>
								<th class="bg-light">입사일</th><td><%=StringUtils.dateToText(dto.getCreatedDate()) %></td>
							</tr>
							<tr>
								<th class="bg-light">소속부서</th><td><%=dto.getDeptName() %></td>
								<th class="bg-light">직위</th><td><%=dto.getPositionName() %></td>
							</tr>
							<tr>
								<th class="bg-light">이름</th><td colspan="3"><%=dto.getName() %></td>
							</tr>
							<tr>
								<th class="bg-light">연락처</th><td><%=dto.getPhone() %></td>
								<th class="bg-light">이메일</th><td><%=dto.getEmail() %></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-12">
					<div class="card">
						<div class="card-header">내 정보</div>
						<div class="card-body">
							<div class="row p-3">
								<div class="col-4">
								<div class="card">
									<div class="card-body bg-light text-bold">
										<h5>내가 작성한 글</h5>
										<small>내가 작성한 글은 <strong><%=postTotalRows %>개</strong> 입니다.</small>
									</div>
								</div>
								</div>
								<div class="col-4">
									<div class="card">
										<div class="card-body bg-light text-bold">
											<h5>내가 작성한 댓글</h5>
											<small>내가 작성한 댓글은 <strong><%=commentTotalRows %>개</strong> 입니다.</small>
										</div>
									</div>
								</div>
								<div class="col-4">
									<div class="card">
										<div class="card-body bg-light text-bold">
											<h5>내에게 온 알림</h5>
											<small>나에게 온 알림은 <strong><%=notificationTotalRows %>개</strong> 입니다.</small>
										</div>
									</div>
								</div>
							</div>
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