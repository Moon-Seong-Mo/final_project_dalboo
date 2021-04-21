<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 비밀번호 변경</title>
<style>
@import url('https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800');

html, body {
	margin: 0;
	padding: 0;
	
}

.frame {
	width: 1200px;
	margin: auto;
}

.wrap {
	vertical-align: middle;
	text-align: center;
	width: 1400px;
	min-height: 760px;
	margin: auto;
}

#content {
	width: 100%;
	height: 100%;
	margin-bottom: 50px;
	margin-top: 70px;
}

#outer {
	width: 900px;
	margin-left: auto;
	margin-right: auto;
	margin-top: 140px;
}

h2 {
	margin-bottom: 50px;
}

table#pwd_table {
	margin: 0 auto;
	width: 500px;
}

#pwd, #newPwd1, #newPwd2 {
	width: 160px;
	height: 30px;
}

th {
	padding: 15px;
	font-size: 18px;
}

#btnArea {
	margin-top: 50px;
}

.Btn {
	color: rgb(72, 72, 72);
	font-family: 'Nanum Gothic';
	font-size: 18px;
	border: 0px;
	border-radius: 5px;
	margin-right: 30px;
	width: 95px;
	height: 40px;
	cursor: pointer;
}

#cancel {
	background: lightgray; 
	border-radius : 5px;
	border: none;
	border-radius: 5px;
}

#updateinfo {
	background: rgb(227, 189, 152);
}
</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp"%>
		<div id="content">
			<div id="outer">
				<h2 align="center">내 정보 수정</h2>

				<form action="update_pwd.me" method="post" id="update_pwdForm" name="update_pwdForm" onsubmit="return send();">
					<table id="pwd_table">
						<tr>
							<th>현재 비밀번호</th>
							<td><input type="password" name="pwd" id="pwd"></td>
						</tr>
						<tr>
							<th>새 비밀번호</th>
							<td><input type="password" name="newPwd1" id="newPwd1"></td>
						</tr>
						<tr>
							<th>새 비밀번호 확인</th>
							<td><input type="password" name="newPwd2" id="newPwd2"></td>
					</table>
					<div align="center" id="btnArea">
						<button type="button" id="cancel" class="Btn" onclick="history.go(-1)">취소하기</button>
						<input type="submit" id="updateinfo" class="Btn" value="수정하기" on>
					</div>
				</form>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>

</html>