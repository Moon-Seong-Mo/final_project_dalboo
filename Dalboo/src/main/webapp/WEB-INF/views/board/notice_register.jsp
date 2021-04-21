<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 공지사항</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/board/register.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
</head>
<body>
<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp" %>
		<div id="content">
	
	<!-- 여기까지 -->
		<br>
		<h2>공지사항 작성</h2>
		<div class="outer">
			<form action="notice_insert.bo" method="post" enctype="Multipart/form-data">
				<div class="detailArea">				
					<table id="tableArea">
						<tr>
							<td id="title-td">제목 : 
								<input type="hidden" name="bWriter" value="${loginUser.id}">
								<input type="text" name="bTitle" id="title" value="" placeholder="제목을 입력해주세요.">  
							</td>				
						</tr>
						<tr>
							<td id="file-td">
								<input type="file"  name="uploadFile">
							</td>
						</tr>
						<tr>
							<td>
								<br>
								<textarea id="contents" name="bContent" cols="60" rows="15" placeholder="내용을 입력해주세요."></textarea>
							</td>
						</tr>
					</table>
				</div>
					<div id="btnDiv" align="center">					
						<input type="button" onclick="history.go(-1)" id="res-btn" value="취소">
						<input type="submit" id="sbm-btn" value="등록" onclick="return validate();">
					</div>
			</form>
		</div>
	</div>
	
	<script>
		function validate() {
			var chkTitle = $('#title');
			var chkContents = $('#contents')
			
			if(!$('#title').val()){
				alert('제목을 입력해주세요.');
				chkTitle.focus();
				return false;
			}else if(!$('#contents').val()){
				alert("내용을 입력해주세요.");
				chkContents.focus();
				return false;
			}
			return true;
      	 }
				
	</script>
</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>