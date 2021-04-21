<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 아이디 찾기</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<style>
div#findIdResult {
    margin-top: 150px;
    font-size: 20px;
}

#idResultDiv{
	margin-top:50px; 
	margin-bottom:50px;
}
#p1{display:inline; font-size:25px;}
#p2{display:inline; font-size:13px; margin-left:30px;}

h4{margin-top:50px; margin-bottom:50px;}

#btnArea{margin-top:50px;}
button#login,#findPwd{
    border: none;
    width: 130px;
    height: 35px;
    color: black;
    font-size: 17px;
    border-radius : 5px; 
}
</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp"%>
		<div id="content">
			<div id="findIdResult" align="center">
				<h3>아이디 찾기</h3>			
				<c:if test="${ !empty member && empty msg }">
					<div id="idResultDiv">
						<p id="p1"> ${ member.id }</p><p id="p2">가입 : ${ member.enrollDate }</p>
						<div id="btnArea">
							<button type="button" id="login" onclick="location.href='login.me'">로그인</button>
							<button type="button" id="findPwd"onclick="location.href='findpwdView.me'">비밀번호 찾기</button>
						</div>
					</div>
				</c:if>
				<c:if test="${ !empty msg }">
					<h4>${ msg }</h4>
					<div id="btnArea">
						<button type="button" id="login" onclick="location.href='findIdView.me'">뒤로가기</button>
						<button type="button" id="findPwd"onclick="location.href='findpwdView.me'">비밀번호 찾기</button>
					</div>
				</c:if>
				
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>