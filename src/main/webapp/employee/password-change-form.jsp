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
	<jsp:param name="menu" value="employee"/>
</jsp:include>
<%--
	요청 방식
		GET
	요청 URL
		http://localhost/community/employee/password-change-form.jsp
		http://localhost/community/employee/password-change-form.jsp?error=fail
	요청 파라미터
		error	에러 상황
	요청 처리 내용
		비밀번호 변경화면을 출력한다.
		요청 파라미터로 전달받은 에러 상황에 맞는 경고창을 출력한다.
 --%>
<%
	// 요청 파라미터값을 조회한다.
	String error = request.getParameter("error");
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
						<a href="" class="list-group-item list-group-item-action">내 정보 보기</a>
						<a href="" class="list-group-item list-group-item-action">내가 작성한 게시글</a>
						<a href="" class="list-group-item list-group-item-action">내가 작성한 댓글</a>
						<a href="" class="list-group-item list-group-item-action">나에게 온 알림</a>
						<a href="" class="list-group-item list-group-item-action">나에게 온 알림</a>
					</div>
				</div>
				<div class="card-body">
					<div class="list-group">
						<a href="" class="list-group-item list-group-item-action active">비밀번호 변경하기</a>
					</div>
				</div>
			</div>
		</div>
		<div class="col-9">
			<div class="row mb-3">
				<div class="col-12">
					<p>비밀번호를 변경하세요.</p>
<%
	if ("fail".equals(error)) {
%>
					<div class="alert alert-danger">
						<strong>비밀번호 변경 실패</strong>비밀번호가 일치하지 않거나 유효한 비밀번호가 아닙니다.
					</div>
<%
	}
%>
					<form id="form-password" class="border p-3 bg-light" method="post" action="password-change.jsp">
						<div class="mb-3">
							<label class="form-label">이전 비밀번호</label>
							<input type="password" class="form-control" name="prevPassword" />
						</div>
						<div class="mb-3">
							<label class="form-label">새 비밀번호</label>
							<input type="password" class="form-control" name="password" />
						</div>
						<div class="mb-3">
							<label class="form-label">새 비밀번호 확인</label>
							<input type="password" class="form-control" name="confirmPassword" />
						</div>
						<div class="text-end">
							<button type="submit" class="btn btn-primary btn-sm">비밀번호 변경</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#form-password").submit(function() {
		let prevPassword = $("#form-password :input[name=prevPassword]").val();
		let password = $("#form-password :input[name=password]").val();
		let confirmPassword = $("#form-password :input[name=confirmPassword]").val();
		
		if (prevPassword === "") {
			alert("이전 비밀번호는 필수 입력값입니다.");
			return false;
		}
		if (password === "") {
			alert("새 비밀번호는 필수 입력값입니다.");
			return false;
		}
		if (confirmPassword === "") {
			alert("새 비밀번호 확인은 필수 입력값입니다.");
			return false;
		}
		if (password != confirmPassword) {
			alert("비밀번호가 서로 일치하지 않습니다.");
			return false;
		}
		return true;
	});
})
</script>
</body>
</html>