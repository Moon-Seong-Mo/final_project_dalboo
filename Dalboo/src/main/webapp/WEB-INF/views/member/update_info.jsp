<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 내 정보 수정</title>
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/member/update_info.css">
<style>
@import url('https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800');
div#update_info {
	margin-top: 100px;
}

#updatepwd, #cancel, #updateinfo {
	background: rgb(224, 224, 224);
	color: rgb(64, 64, 64);
	font-size: 15px;
	font-family: 'Nanum Gothic';
	border: 0px;
	border-radius: 5px;
	margin-right: 30px;
	width: 110px;
	height: 35px;
	cursor: pointer;
}

#updatepwd {
	width: 200px;
	background: rgb(227, 189, 152);
}

#updateinfo {
	background: rgb(227, 189, 152);
	width: 92px;
	height: 40px;
	font-size: 17px;
	
}

#cancel {
	width: 92px;
	height: 40px;
	font-size: 17px;
}

table {
	margin-left: 450px;
	width: 800px;
	font-size: 20px;
	text-align: left;
	border-spacing: 30px;
	font-family: 'Nanum Gothic';
}

#id, #nickName, #email, #name, #phone {
	width: 200px;
	height: 30px;
	text-align: center;
	border: 1px solid gray;
	border-radius: 5px;
	font-size: 15px;
}

#id {
	border: 0px;
}
</style> 
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			<div id="content">
				<div id="update_info">
				<h2>내 정보 수정</h2>
                  <form action="update_info.me" method="post" id="update_infoForm">
					<table>

						<tr>
							<th>아 이 디*</th>
							<td>
								<input type="text" name="id" id="id" value="${ loginUser.id}" readonly="readonly">
								<input type="hidden" name="rank_code" value="${ loginUser.rank_code }">
							<td>
						</tr>

						<tr>
							<th>비밀번호 변경</th>
							<td>
								<button type="button" class="updatepwd" id="updatepwd" onclick="location.href='update_pwdView.me'">비밀번호 변경</button>
							<td>
						</tr>
						<tr>
							<th>닉네임*</th>
							<td><input size="32" maxlength="20" name="nickName" id="nickName" value="${ loginUser.nickName}" placeholder="닉네임을 입력해주세요" required>
							<td>
						</tr>
						<tr>
							<th>이메일*</th>
							<td><input size="32" name="email" id="email" value="${ loginUser.email}" placeholder="이메일을 입력해주세요" required>
							<td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input size="32" name="name" id="name" value="${ loginUser.name}" placeholder="이름을 입력해주세요" required>
							<td>
						</tr>
						<tr>
							<th>휴대폰 번호</th>
							<td>
								<input type="text" name="phone" id="phone" value="${ loginUser.phone}" maxlength="11" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
								<input type="hidden" name="point" value="${ loginUser.point }">
							</td>
						</tr>
					</table>

					<br><br>
                
                  <div>
                  	<button type="button" id="cancel" onclick="location.href='myPage.me'">취소</button>
                    <button type="submit" id="updateinfo">수정 완료</button>
                  </div>
				</form>           
            </div>
         </div>
	</div>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>

</html>