<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/manager/member_info.css">
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp" %>
		<div id="content">
			<div id="manage-table-area">
			<br>
			<h1>회원관리</h1>
			<hr>
				<table id="manage-table">
					<thead>
						<tr>
							<th width="20px"></th>
							<th>ID</th>
							<th>닉네임</th>
							<th>이메일</th>
							<th>포인트</th>
							<th>가입일</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="radio" name="check"></td>
							<td>kim01</td>
							<td>김보드레</td>
							<td>kim01@naver.com</td>
							<td>4210P</td>
							<td>2020-12-10</td>
							<td><%-- <c:if test="${ status eq 'Y'}">활성</c:if> --%>활성</td>
						</tr>
						<tr>
							<td><input type="radio" name="check"></td>
							<td>kim01</td>
							<td>김보드레</td>
							<td>kim01@naver.com</td>
							<td>4210P</td>
							<td>2020-12-10</td>
							<td><%-- <c:if test="${ status eq 'Y'}">활성</c:if> --%>활성</td>
						</tr>
						<tr>
							<td><input type="radio" name="check"></td>
							<td>kim01</td>
							<td>김보드레</td>
							<td>kim01@naver.com</td>
							<td>4210P</td>
							<td>2020-12-10</td>
							<td><%-- <c:if test="${ status eq 'Y'}">활성</c:if> --%>활성</td>
						</tr>
						<tr>
							<td><input type="radio" name="check"></td>
							<td>kim01</td>
							<td>김보드레</td>
							<td>kim01@naver.com</td>
							<td>4210P</td>
							<td>2020-12-10</td>
							<td><%-- <c:if test="${ status eq 'Y'}">활성</c:if> --%>활성</td>
						</tr>
						
					</tbody>
				</table>

				<div id="mBtn-area">
					<button id="mBtn" onclick="deleteM();">제명 시키기</button>
				</div>
				
				<div id="basic">
					<select name="search" id="search">
						<option value="">아이디</option>
						<option value="">닉네임</option>
						<option value="">상태</option>
					</select>
					<input type="text" id="search-t">
					<input type="submit" id="serach-b" value="검색">
				</div>
				<!-- 페이징 처리 -->
				<div id="pagingArea" align="center">
					<button class="Btn">&lt;</button>
					<button id="choosen" disabled>1</button>
					<button class="numBtn">2</button>
					<button class="numBtn">3</button>
					<button class="numBtn">4</button>
					<button class="Btn">&gt;</button>
				</div>
				
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>

<script>
	function deleteM(){
		if(confirm("정말 제명시키겠습니까?")){
			return true;
		}else{
			return false;
		}
	}
</script>
</html>