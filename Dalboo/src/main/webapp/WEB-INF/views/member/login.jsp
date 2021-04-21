<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 로그인</title>
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/content.css">
<link rel = "shortcut icon" href = "${ contextPath }/favicon.ico">
<style>
@import
	url('https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800')
	;

body {
	font-family: 'Nanum Gothic';
}

div#login {
	margin-top: 150px;
}

input#userId {
	width: 300px;
	height: 50px;
}

input#userPwd {
	width: 300px;
	height: 50px;
}

p {
	font-size: 50px;
	font-weight: bold;
}

#subBtn {
	background: rgb(227, 189, 152);
	border-radius: 5px;
	border: none;
	width: 300px;
	height: 35px;
	color: black;
	font-size: 20px;
	cursor: pointer;
}

#findid, #findpwd, #join {
	background: none;
	border: none;
}

#btnArea {
	margin-top: 50px;
}

input[type="button"] {
	cursor: pointer;
}

#error {
	font-size: 13px;
	color: rgb(255, 117, 117);
}
</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp"%>
		<div id="content">
			<div id="login">
					<div align="center">
						<p>LOGIN</p>
						<table>
							<tr>
								<td><input type="text" class="userid_input" name="id" id="userId" size="32" maxlength="20" placeholder="아이디를 입력해주세요" required></td>
							</tr>
							<tr>
								<td><input type="password" class="userpwd_input" name="pwd" id="userPwd" size="32" maxlength="20" placeholder="비밀번호를 입력해주세요" required></td>
							</tr>
						</table>
						<p id="error"></p>
						<br>
					</div>
					<div>
						<button type="button" id="subBtn">로그인</button>
					</div>
				<script>
					
					$("#subBtn").click(function(){
						var id = $("#userId").val();
						var pwd = $("#userPwd").val();
						
						$.ajax({
							type:"POST",
							data:{id:id, pwd:pwd},
							url : "logingo.me",
							success : function(data){
								if(data == 'success'){
									location.href='home.do';
								} else if(data == 'false'){
									$("#error").text("아이디 또는 비밀번호를 잘못 입력하셨습니다.");
									if($("#subBtn").click(function(){
										$("#error").text("");
									}));
								} 
							}
						});						
					});
				
				</script>

				<div id="btnArea">
					<input type="button" id="join" onclick="location.href='joinView.me'" value="회원가입"> |
					<input type="button" id="findid" onclick="location.href='findIdView.me'"value="아이디 찾기"> | 
					<input type="button" id="findpwd" onclick="location.href='findpwdView.me'" value="비밀번호 찾기">
					<br>
				</div>
			</div>
		</div>
	</div>



	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>