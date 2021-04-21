<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 비밀번호 변경</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<style>
div#findPwdResult {
    font-size: 20px;
    margin-top: 150px;
}

button#login,#home{
	background: none;
    border: 1px solid black;
    margin-left: 50px;
    margin-top: 30px;
    width: 100px;
    height: 40px;
    font-weight: bold;
    border-radius : 5px; 
}
</style>
</head>
<body>

	<span style="color: green; font-weight: bold;">변경할 비밀번호를 입력해주세요.</span>
	<div style="text-align: center;">
		<form action="pass_change.do${e_mail}" method="post">
			<br>
			<div>
				변경할 비밀번호 입력 : <input type="number" name="member_pass" placeholder="비밀번호를 입력하세요.">
			</div>

			<br><br>
			<button type="submit" name="submit">비밀번호 변경</button>

		</form>
	</div>


</body>
</html>
