<%@page import="com.community.departemtns.Department"%>
<%@page import="java.util.List"%>
<%@page import="com.community.departemtns.DepartmentDao"%>
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
		http://localhostcommunity/admin/depts.jsp
	요청 파라미터
		없음
	요청 처리 내용
		전체 부서 정보를 조회해서 출력한다.
		전체 직위 정보를 조회해서 출력한다.
--%>
<%
	DepartmentDao departmentDao = DepartmentDao.getInstance();

	// 전체 부서목록을 조회한다.
	List<Department> departmentList = departmentDao.getAllDepartments();
%>		
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">부서/직위 관리</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="card">
				<div class="card-header">전체 부서 목록</div>
				<div class="card-body">
					<p>전체 부서목록을 확인하세요.</p>
					<table class="table table-sm" id="table-departments">
						<colgroup>
							<col width="15%">
							<col width="*">
							<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>이름</th>
								<td></td>
							</tr>
						</thead>
						<tbody>
<%
	for (Department department : departmentList) {
%>
							<tr id="row-<%=department.getNo() %>">
								<td><%=department.getNo() %></td>
								<td><%=department.getName() %></td>
								<td><button class="btn btn-outline-primary btn-xs" data-target-row="#row-<%=department.getNo() %>">수정</button></td>
							</tr>
<%
	}
%>
						</tbody>
					</table>
				</div>
				<div class="card-footer text-end">
					<button class="btn btn-primary btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-depts">신규 등록</button>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card">
				<div class="card-header">전체 직위 목록</div>
				<div class="card-body">
					<p>전체 직위목록을 확인하세요.</p>
					<table class="table table-sm" id="table-positions">
						<colgroup>
							<col width="10%">
							<col width="15%">
							<col width="15%">
							<col width="*">
							<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<th></th>
								<th>번호</th>
								<th>순서</th>
								<th>직위이름</th>
								<td></td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="checkbox" /></td>
								<td>100</td>
								<td>1</td>
								<td>대표이사</td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
							<tr>
								<td><input type="checkbox" /></td>
								<td>100</td>
								<td>2</td>
								<td>임원</td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
							<tr>
								<td><input type="checkbox" /></td>
								<td>100</td>
								<td>3</td>
								<td>부장</td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
							<tr>
								<td><input type="checkbox" /></td>
								<td>100</td>
								<td>4</td>
								<td>차장</td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
							<tr>
								<td><input type="checkbox" /></td>
								<td>100</td>
								<td>4</td>
								<td>과장</td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
						</tbody>
					</table>
					<div>
						<button class="btn btn-outline-secondary btn-xs">맨 위로</button>
						<button class="btn btn-outline-secondary btn-xs">위로</button>
						<button class="btn btn-outline-secondary btn-xs">아래로</button>
						<button class="btn btn-outline-secondary btn-xs">맨 아래로</button>
					</div>
				</div>
				<div class="card-footer text-end">
					<button class="btn btn-primary btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-positions">신규 등록</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 부서정보 등록폼 -->
<div class="modal" tabindex="-1" id="modal-form-depts">
	<div class="modal-dialog">
		<form id="form-add-depts" class="border p-3 bg-light" method="post" action="depts-register.jsp">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">부서정보 등록폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm" >부서명</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" name="deptName" placeholder="부서명을 입력하세요">
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
<!-- 부서정보 수정 폼 -->
<div class="modal" tabindex="-1" id="modal-modifyform-depts">
	<div class="modal-dialog">
		<form  id="form-modify-depts" class="border p-3 bg-light" method="post" action="depts-modify.jsp">
		<input type="hidden" name="deptNo" />
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">부서정보 등록폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">부서명</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" name="deptName" placeholder="부서명을 입력하세요">
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
<!-- 직위정보 등록폼 -->
<div class="modal" tabindex="-1" id="modal-form-positions">
	<div class="modal-dialog">
		<form id="form-add-positions" class="border p-3 bg-light" method="post" action="positions-register.jsp">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">직위정보 등록폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row mb-2">
					<label class="col-sm-2 col-form-label col-form-label-sm" >노출순위</label>
					<div class="col-sm-10">
						<input type="text" class="form-control form-control-sm" name="seq" placeholder="노출순위를 입력하세요">
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-2 col-form-label col-form-label-sm" >직위명</label>
					<div class="col-sm-10">
						<input type="text" class="form-control form-control-sm" name="name" placeholder="직위명을 입력하세요">
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
<!-- 직위정보 수정 폼 -->
<div class="modal" tabindex="-1" id="modal-modifyform-positions">
	<div class="modal-dialog">
		<form id="form-modify-positions" class="border p-3 bg-light" method="post" action="positions-modify.jsp">
		<input type="hidden" name="positionNo"  />
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">직위정보 수정폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row mb-2">
					<label class="col-sm-2 col-form-label col-form-label-sm" >직위명</label>
					<div class="col-sm-10">
						<input type="text" class="form-control form-control-sm" name="name" placeholder="직위명을 입력하세요">
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
	let deptModifyFormModal = new bootstrap.Modal("#modal-modifyform-depts");
	let positionModifyFormModal = new bootstrap.Modal("#modal-modifyform-positions");
	
	$("#table-departments .btn").click(function() {
		let targetRowId = $(this).attr("data-target-row");
		let $targetRow = $(targetRowId);
		
		let departmentNo = $targetRow.find("td:eq(0)").text();
		let departmentName = $targetRow.find("td:eq(1)").text();
		$("#form-modify-depts :hidden[name=deptNo]").val(departmentNo);
		$("#form-modify-depts :hidden[name=deptName]").val(departmentName);
		
		deptModifyFormModal.show();
	})
})
</script>
</body>
</html>