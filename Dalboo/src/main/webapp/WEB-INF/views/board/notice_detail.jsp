<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 공지사항</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/board/detail.css">
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
		<h2>공지 게시판</h2>
		<div class="outer">
				<div class="detailArea">				
					<table id="tableArea">
						<tr>
							<td colspan="2" id="title">
								${ board.bTitle }								
							</td>				
						</tr>
						
						
						<tr>
							<td id="views"><b>조회수</b> ${ board.bViews }</td>
							
							<td id="date">
								<b>날짜 </b> ${ board.bCreateDate }
							</td>
							
						</tr>
						<tr>
							<td id="writer">
								<b>작성자 </b> ${ board.bWriter }
							</td>
							
							<c:if test="${ !empty board.originalFileName }">
				            <td colspan="2" id="downloadfile">
				              <b>첨부파일  </b> <a href="${ contextPath }/resources/buploadFiles/${ board.renameFileName }" download="${ board.originalFileName }">${ board.originalFileName }</a>
							</td>
				       		</c:if>
						</tr>
						
						
						<tr>
							<td colspan="2" align="left" id="contents">
							<br>
							<% pageContext.setAttribute("newLineChar", "\r\n"); %> <!-- \r\n 말고 그냥 \n도, \r도 가능하다 -->
         					${ fn:replace(board.bContent, newLineChar, "<br>") }
							</td>
						</tr>
						
					</table>
				</div>
		</div>
	<div id="btnDiv" align="center">
	
		<c:url var="notice_updateView" value="notice_updateView.bo">
			<c:param name="bNum" value="${ board.bNum }"/>
			<c:param name="page" value="${ page }"/>
		</c:url>
		<c:url var="notice_delete" value="notice_delete.bo">
			<c:param name="bNum" value="${ board.bNum }"/>
		</c:url>
		<c:url var="notice_list" value="notice_list.bo">
			<c:param name="page" value="${ page }"/>
		</c:url>
		
		
<%-- 		<c:if test="${ !empty loginUser.id}">				 --%>
		<c:if test="${ loginUser.id eq board.bWriter }">				
		<input type="submit" id="sbm-btn" onclick="location.href='${notice_updateView}'" value="수정">
		<input type="button" id="del-Btn"  value="삭제">
		</c:if>
		<input type="button" id="res-btn" onclick="location.href='${notice_list}'"  value="목록">
	</div>
	</div>
	
	<script>
	$(function(){
		$('#del-Btn').click(function(){
				var con = confirm("정말 삭제하시겠습니까?");
				if(con){
				var bNum = ${board.bNum}
				
				location.href='notice_delete.bo?bNum=' + bNum;
				}else{
					return false;
				}
		});
	});
	</script>
</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>