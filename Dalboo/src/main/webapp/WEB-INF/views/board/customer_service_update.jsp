<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 고객센터</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/board/update.css">
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
		<h2>문의사항 수정</h2>
		<div class="outer">
			<form action="customer_service_update.bo" method="post" enctype="Multipart/form-data">
				<input type="hidden" name="page" value="${ page }">
		<input type="hidden" name="bNum" value="${ board.bNum }">
		<input type="hidden" name="renameFileName" value="${ board.renameFileName }">
				<div class="detailArea">				
					<table id="tableArea">
						<tr>
							<td id="title-td">제목 : 
								<input type="hidden" name="bWriter" value="${loginUser.id}">
								<input type="text" name="bTitle" id="title" value="${ board.bTitle }" placeholder="제목을 입력해주세요.">  
							</td>				
						</tr>
						<tr>
							<td id="file-td">
								<input type="file" name="reloadFile">
								<c:if test="${ !empty board.originalFileName }">
									<br>현재 업로드된 파일 : 
									<a href="${ contextPath }/resources/buploadFiles/${ board.renameFileName }" download="${ board.originalFileName }">
										${ board.originalFileName }
									</a>
								</c:if>
							</td>
						</tr>
						<tr>
							<td>
								<br>
								<textarea id="contents" name="bContent" cols="60" rows="15" placeholder="내용을 입력해주세요.">${ board.bContent }</textarea>
							</td>
						</tr>
					</table>
				</div>
					<div id="btnDiv" align="center">					
						<input type="button" id="res-btn" onclick="history.go(-1)" value="취소">
						<input type="submit" id="sbm-btn" value="수정" onclick="return validate();">
						
		
						
						<c:url var="customer_service_list" value="customer_service_list.bo">
							<c:param name="page" value="${ page }"/>
						</c:url>
					</div>
			</form>
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
</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>