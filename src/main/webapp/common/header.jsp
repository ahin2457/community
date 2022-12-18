<%@page import="com.community.employees.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String menu = request.getParameter("menu");

	Employee loginEmployee = (Employee) session.getAttribute("LOGIN_EMPLOYEE");
%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<div class="container">
		<ul class="navbar-nav me-auto">
			<li class="nav-item"><a class="nav-link <%="home".equals(menu) ? "active" : "" %>" href="/community/home.jsp">홈</a></li>
<%
	if (loginEmployee != null) {
%>
			<li class="nav-item"><a class="nav-link <%="board".equals(menu) ? "active" : "" %>" href="/community/board/home.jsp">게시판</a></li>

<%
		if ("관리자".equals(loginEmployee.getType())) {
%>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle <%="admin".equals(menu) ? "active" : "" %>" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
					관리자
          		</a>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="/community/admin/depts.jsp">부서/직위 관리</a></li>
					<li><a class="dropdown-item" href="/community/admin/employees.jsp">직원관리</a></li>
					<li><hr class="dropdown-divider"></li>
					<li><a class="dropdown-item" href="/community/admin/boards.jsp">게시판관리</a></li>
					<li><a class="dropdown-item" href="/community/admin/posts.jsp">게시글관리</a></li>
				</ul>
			</li> 
<%
		}
	}
%>
		</ul>
		<ul class="navbar-nav">
<%
	if (loginEmployee != null) {
%>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle <%="employee".equals(menu) ? "active" : "" %>" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
					내정보 보기
          		</a>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="/community/employee/home.jsp">내정보 보기</a></li>
					<li><a class="dropdown-item" href="/community/employee/password-change-form.jsp">비밀번호 변경하기</a></li>
				</ul>
			</li> 
			<li class="nav-item"><a class="nav-link" href="/community/logout.jsp">로그아웃</a></li>
<%
	} else {
%>
			<li class="nav-item"><a class="nav-link <%="login".equals(menu) ? "active" : "" %>" href="/community/login-form.jsp">로그인</a></li>
<%	
	}
%>
		</ul>
	</div>
</nav>