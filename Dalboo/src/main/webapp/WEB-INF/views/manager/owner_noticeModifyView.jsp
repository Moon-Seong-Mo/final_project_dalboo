<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>달보드레 | 공지사항</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">
<style>
.outer {
	margin-left: auto;
	margin-right: auto;
	margin-bottom: 50px;
}

#notice_register {
	border-collapse: collapse;
	margin-top: 50px;
	text-align: left;
}

td {
	padding: 10px;
}

#title {
	width: 500px;
	height: 40px;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: #fff;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #5cb85c;
	cursor: pointer;
	border: 1px solid #4cae4c; border-radius : .25em;
	-webkit-transition: background-color 0.2s;
	transition: background-color 0.2s;
	border-radius: .25em;
}

.filebox label:hover {
	background-color: #6ed36e;
}

.filebox label:active {
	background-color: #367c36;
}

.filebox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

#btnArea {
	margin-top: 50px;
	margin-left: 50px;
}

#cancel {
	width: 100px;
	height: 50px;
	border: 0px;
	border-radius: 5px;
	font-size: 15px;
}

#register {
	width: 100px;
	height: 50px;
	margin-left: 50px;
	border: 0px;
	border-radius: 5px;
	background: rgb(52, 73, 94);
	color: white;
	font-size: 15px;
}

.box-file-input label {
	display: inline-block;
	background: rgb(52, 73, 94);
	border-radius: 5px;
	color: #fff;
	padding: 0px 15px;
	line-height: 35px;
	cursor: pointer;
}

.box-file-input label:after {
	content: "파일등록";
}

.box-file-input .file-input {
	display: none;
}

.box-file-input .filename {
	display: inline-block;
	padding-left: 10px;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp" %>
	<div id="wrap">
		<%@ include file="/WEB-INF/views/common/ownerPageNav.jsp" %>
		<div id="section">
			<div align="center" class="outer">
				<h2 align="center">공지 작성</h2>
				<hr>
				
				<form action="${ contextPath }/modifyNotice.ow" method="post" encType="multipart/form-data">
					<table id="notice_register">
						<tr>	
							<td>제목</td>
							<td>
								<input type="text" name="owTitle" id="title" value="${ on.owTitle }">
								<input type="hidden" name="renameFileName" value="${ on.renameFileName }">
								<input type="hidden" name="onNo" id="onNo" value="${ on.onNo }">
								<input type="hidden" name="page" value="${ page }">
							</td>
						</tr>
						<tr>
							<td>첨부파일</td>
							<td>
							<c:if test="${ !empty on.renameFileName }">
								<br>현재 업로드한 파일 : 
								<a href="${ contextPath }/resources/ownerNoticeuploadFiles/${ on.renameFileName }" download="${ on.renameFileName }"> ${ on.originFileName }</a>						
							</c:if>
							<div class="box-file-input">
								<br>
								<label><input type="file" name="reloadFile" class="file-input"></label>
								<span class="filename">수정하실 파일이 있다면 업로드 해주세요.</span> 
							</div>
							</td>
						</tr>
						<tr>	
							<td>내용</td>
							<td><textarea id="content" name="owContent" cols="70" rows="32" wrap="hard" style="resize: none;">${ on.owContent }</textarea></td>
						</tr>
					</table>
					<div id="btnArea" align="center">
						<c:url var="onlist" value="owner_notice.ow">
							<c:param name="page" value="${ page }" />
						</c:url>
						<input type="button" id="cancel" value="목록으로" onclick="location.href='${ onlist }'"> 
						<input type="submit" id="register" value="등록">
					</div>
				</form>
			</div>
		</div> 
   </div>
   <script>
		
   		/* <br>태그 띄어쓰기로 치환 */
   		var str = $("#content").text();
		str = str.replaceAll("<br>", "\r\n");
		document.getElementById("content").value = str;
		
		
		
		$(document).on("change", ".file-input", function() {

			$filename = $(this).val();

			if ($filename == "")
				$filename = "파일을 선택해주세요.";

			$(".filename").text($filename);

		});
		
	</script>
</body>
</html>


