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
<link rel="shortcut icon" href="<%= request.getContextPath() %>/favicon.ico">
<style>
div#findid {
    margin-top: 150px;
}

#tableDiv{
	margin-top:50px;
	font-size:18px;
}
table{
	width:500px;
	height:200px;
	text-align: center;
}
input[type="text"],input[type="email"]{
	width:250px;
	height:30px;
}
#phone1,#phone2,#phone3{
	width:65px;
	text-align: center;
}

#btnDiv{
	margin-top:50px;
}

button#findid{
    background: rgb(227, 189, 152);
    border: none;
    width: 110px;
    height: 35px;
    color: black;
    font-size: 17px;
    border-radius : 5px; 
    margin-left:50px;
}
button#cancel{
    border: none;
    width: 110px;
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
			<div id="findid">
				<h2>아이디 찾기</h2>

				<form action="findId.me" method="POST" id="findIdView">
					<div id="tableDiv" align="center">
						<table>
							<tr>
								<th>이름</th>
								<td><input type="text" class="username_input" name="name" id="username" placeholder="이름 입력해주세요" required></td>
							</tr>
							<tr>
								<th>휴대폰 번호</th>
								<td>
									<div>
										<input type="text" maxlength="4" size="5" name="phone1" id="phone1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="010" required>
										 - 
										<input type="text" maxlength="4" size="5" name="phone2" id="phone2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required>
										  - 
										<input type="text" maxlength="4" size="5" name="phone3" id="phone3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required>
									</div>
								</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="email" class="useremail_input"
									name="email" id="useremail" placeholder="이메일을 입력해주세요" required></td>
							</tr>
						</table>
					</div>

					<div id="btnDiv">
						<button id="cancel" type="button" onclick="history.go(-1)">취소하기</button>
						<button type="submit" id="findid">아이디 찾기</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>