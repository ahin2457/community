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
<jsp:include page="common/header.jsp">
	<jsp:param name="menu" value="login"/>
</jsp:include>
<%--
	요청 방식
		GET
	요청 URL
		http://localhost/community/loginform.jsp
		http://localhost/community/loginform.jsp?error=fail
		http://localhost/community/loginform.jsp?error=deny
	요청 파라미터
		error		에러 상황
	요청 처리 내용
		로그인 폼을 출력한다.
		요청 파라미터로 전달받은 에러 상황에 맞는 경고창을 출력한다.
 --%>
<%
	// 요청 파라미터 값을 조회한다.
	String error = request.getParameter("error");
%>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">로그인</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-sm-6">
<%
	if ("fail".equals(error)) {
%>
			<div class="alert alert-danger">
				<strong>로그인 실패</strong> 아이디 혹은 비밀번호가 올바르지 않습니다.
			</div>
<%
	}
%>
<%
	if ("deny".equals(error)) {
%>
			<div class="alert alert-danger">
				<strong>요청처리 거부</strong> 해당 요청은 로그인 후 이용가능 합니다.
			</div>
<%
	}
%>
			<form id="form-login" class="border bg-light p-3" method="post" action="login.jsp">
				<div class="mb-3">
					<label class="form-label">직원번호</label>
					<input type="text" class="form-control" name="empNo" value="1000"/>
				</div>
				<div class="mb-3">
					<label class="form-label">비밀번호</label>
					<input type="password" class="form-control" name="empPassword" value="1111"/>
				</div>
				<div class="text-end">
					<a href="../home.jsp" class="btn btn-secondary">취소</a>
					<button type="submit" class="btn btn-primary">로그인</button>
				</div>
			</form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#form-login").submit(function() {
		let empNo = $("#form-login :input[name=empNo]").val();
		let empPassword = $("#form-login :input[name=empPassword]").val();
		
		if (empNo === "") {
			alert("직원번호는 필수 입력값입니다.");
			return false;
		}
		if (empPassword === "") {
			alert("비밀번호는 필수 입력값입니다.");
			return false;
		}
		return true;
	});
})
</script>
</body>
</html>