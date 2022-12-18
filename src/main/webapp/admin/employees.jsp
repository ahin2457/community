<%@page import="com.community.positions.Position"%>
<%@page import="com.community.departments.Department"%>
<%@page import="com.community.positions.PositionDao"%>
<%@page import="com.community.departments.DepartmentDao"%>
<%@page import="com.community.employees.EmployeeListDto"%>
<%@page import="java.util.List"%>
<%@page import="com.community.util.Pagination"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.community.employees.EmployeeDao"%>
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
		http://localhost/community/admin/employees.jsp
		http://localhost/community/admin/employees.jsp?page=2
	요청 파라미터
		page	조회할 페이지번호
	요청 처리 내용
		페이지 번호에 해당하는 직원 목록을 조회해서 출력한다.
 --%>
<%
	// 요청파라미터를 조회한다.
	int currentPage = StringUtils.stringToInt(request.getParameter("page"), 1);

	Map<String, Object> param = new HashMap<>();

	DepartmentDao departmentDao = DepartmentDao.getInstance();
	EmployeeDao employeeDao = EmployeeDao.getInstance();
	PositionDao positionDao = PositionDao.getInstance();
	
	int totalRows = employeeDao.getTotalRows(param);
	
	Pagination pagination = new Pagination(currentPage, totalRows);
	param.put("begin", pagination.getBegin());
	param.put("end", pagination.getEnd());
	
	List<EmployeeListDto> employees = employeeDao.getEmployees(param);
	List<Department> departments = departmentDao.getAllDepartments();
	List<Position> positions = positionDao.getAllPositions();
	
%>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">직원 관리</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="card">
				<div class="card-header">직원 리스트</div>
				<div class="card-body">
					<p>직원 목록을 확인하세요.</p>
					<table class="table table-sm" id="table-employees">
						<colgroup>
							<col width="10%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>이름</th>
								<td>부서명</td>
								<td>직위</td>
								<td>연락처</td>
								<td>삭제여부</td>								
								<td></td>
							</tr>
						</thead>
						<tbody>
<%
	for (EmployeeListDto dto : employees) {
%>
							<tr>
								<td><%=dto.getNo() %></td>
								<td><%=dto.getName() %></td>
								<td><%=dto.getDeptName() %></td>
								<td><%=dto.getPositionName() %></td>
								<td><%=dto.getPhone() %></td>
								<td><%=dto.getDeleted() %></td>
								<td>
									<button class="btn btn-outline-primary btn-xs" data-emp-no="<%=dto.getNo() %>">상세정보</button>
									<a href="employees-delete.jsp?empNo=<%=dto.getNo() %>" class="btn btn-danger btn-xs">삭제</a>
								</td>
							</tr>
<%
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
								<a class="page-link" href="employees.jsp?page=<%=prevPage %>" data-page-no="<%=prevPage %>">이전</a>
							</li>
<%
	for (int number = beginPage; number <= endPage; number++) {
%>
							<li class="page-item">
								<a class="page-link <%=number == currentPage ? "active" : ""%>" href="employees.jsp?page=<%=number %>" data-page-no="<%=number %>">1</a>
							</li>
<%
	}
%>
							<li class="page-item <%=isLast ? "disabled" : ""%>">
								<a class="page-link" href="employees.jsp?page=<%=nextPage %>" data-page-no="<%=nextPage %>">다음</a>
							</li>
						</ul>
					</nav>
				</div>
				<div class="card-footer text-end">
					<button class="btn btn-primary btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-employees">신규 등록</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal" tabindex="-1" id="modal-form-employees">
	<div class="modal-dialog">
	<form class="border p-3 bg-light" method="post" action="employees-register.jsp">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">직원 정보 등록폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">이름</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm" name="name" placeholder="직원이름">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">소속부사</label>
						<div class="col-sm-6">
							<select class="form-select form-select-sm" name="deptNo">
<%
	for (Department dept : departments) {
%>
								<option value="<%=dept.getNo() %>"> <%=dept.getName() %></option>
<%
	}
%>
							</select>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">직위</label>
						<div class="col-sm-6">
							<select class="form-select form-select-sm" name="positionNo">
<%
	for (Position position : positions) {
%>
								<option value="<%=position.getNo() %>"> <%=position.getName() %></option>
<%
	}
%>
							</select>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">이메일</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm" name="email" placeholder="이메일">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">전화번호</label>
						<div class="col-sm-6">
							<input type="text" class="form-control form-control-sm" name="phone" placeholder="전화번호">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-3 col-form-label col-form-label-sm">직원타입</label>
						<div class="col-sm-6">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="type" value="사용자" checked>
								<label class="form-check-label">사용자</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="type" value="관리자" >
								<label class="form-check-label">관리자</label>
							</div>
						</div>
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-xs">등록</button>
			</div>
		</div>
	</form>
	</div>
</div>
<div class="modal" tabindex="-1" id="modal-detailform-employees">
	<div class="modal-dialog">
	<form class="border p-3 bg-light" method="post" action="employees-modify.jsp">
		<input type="hidden" name="no" />
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">직원 상세 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">이름</label>
					<div class="col-sm-9">
						<input type="text" class="form-control form-control-sm" name="name" placeholder="직원이름" />
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">소속부사</label>
					<div class="col-sm-6">
						<select class="form-select form-select-sm" name="deptNo">
<%
	for (Department dept : departments) {
%>
							<option value="<%=dept.getNo() %>"> <%=dept.getName() %></option>
<%
	}
%>
						</select>
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">직위</label>
					<div class="col-sm-6">
						<select class="form-select form-select-sm" name="positionNo">
<%
	for (Position position : positions) {
%>
							<option value="<%=position.getNo() %>"> <%=position.getName() %></option>
<%
	}
%>
						</select>
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">이메일</label>
					<div class="col-sm-9">
						<input type="text" class="form-control form-control-sm" name="email" placeholder="이메일" />
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">전화번호</label>
					<div class="col-sm-6">
						<input type="text" class="form-control form-control-sm" name="phone" placeholder="전화번호" />
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">직원타입</label>
					<div class="col-sm-6">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="type" value="사용자" />
							<label class="form-check-label">사용자</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="type" value="관리자" />
							<label class="form-check-label">관리자</label>
						</div>
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-3 col-form-label col-form-label-sm">삭제여부</label>
					<div class="col-sm-6">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="deleted" value="N" />
							<label class="form-check-label">삭제되지 않음</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="deleted" value="Y" />
							<label class="form-check-label">삭제됨</label>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-xs">수정</button>
			</div>
		</div>
	</form>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	let employeeDetailModal = new bootstrap.Modal("#modal-detailform-employees");
	
	$("#table-employees tbody .btn").click(function() {
		let empNo = $(this).attr("data-emp-no");
		
		$.getJSON("employees-detail-json.jsp", {empNo: empNo}, function(employee) {
			$("#modal-detailform-employees [name=no]").val(employee.no);
			$("#modal-detailform-employees [name=name]").val(employee.name);
			$("#modal-detailform-employees [name=deptNo]").val(employee.deptNo);
			$("#modal-detailform-employees [name=positionNo]").val(employee.positionNo);
			$("#modal-detailform-employees [name=phone]").val(employee.phone);
			$("#modal-detailform-employees [name=email]").val(employee.email);
			$("#modal-detailform-employees [name=type][value="+employee.type+"]").prop("checked", true);
			$("#modal-detailform-employees [name=deleted][value="+employee.deleted+"]").prop("checked", true);
			
			employeeDetailModal.show();
		})
	});
})
</script>
</body>
</html>