<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 비밀번호 찾기</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="shortcut icon" href="<%= request.getContextPath() %>/favicon.ico">
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<style>
@charset "UTF-8";

div#findPwd {
	margin-top: 150px;
}

button#findpwd {
	background: rgb(227, 189, 152);
	border: none;
	width: 150px;
	height: 35px;
	color: black;
	font-size: 20px;
	margin-left: 100px;
	border-radius: 5px;
}

button#email-authentication-btn {
	margin-top: 20px;
	margin-bottom: 20px; 
	background : rgb(237, 237, 237);
	border-radius: 5px;
	border: none;
	width: 120px;
	height: 35px;
	cursor: pointer;
}

button.btn.main-btn.btn-block {
	margin-top: 20px;
	border-radius: 5px;
	border: none;
	width: 120px;
	height: 35px;
	cursor: pointer;
	background: rgb(227, 189, 152);
}
 
input#id, #email {
	width: 270px;
	height: 30px;
	margin-top: 15px;
}

input#certifyCode {
	width: 320px;
	height: 30px;
	font-size: 20px;
	margin-top: 15px;
}

table {
	width: 800px;
	text-align: center;
	margin-left: 200px;
}
#p1{
	font-size:13px;
	color:gray;
}





#my-spinner {
   width: 100%; height: 100%;
   top: 0; left: 0;
   display: none;
   opacity: .6;
   background: silver;
   position: fixed;
}
#my-spinner div {
   width: 100%; height: 100%;
   display: table;
}
#my-spinner span {
   display: table-cell;
   text-align: center;
   vertical-align: middle;
}
#my-spinner img {
   background: white;
   padding: 1em;
   border-radius: .7em;
}








</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp"%>
		<div id="content">
			<div id="findPwd">
				<form action="findPwd.me" method="POST"
					onsubmit="return validate();" id="findPwd-form">
					<h2 style="text-align: center;">비밀번호 찾기</h2>
					<div align="center">
						<table>
							<tr>
								<td width="150px;">아이디</td>
								<td><input type="text" id="id" name="id"></td>
								<td rowspan="2" width="260px;"><span id="checkEmail"></span></td>
							</tr>
							<tr>
								<td>이메일</td>
								<td><input type="text" id="email" name="email"></td>
							</tr>
						</table>
					</div>
					<div class="col-md-3">
						<button class="btn main-btn btn-block" id="email-authentication-btn" type="button">이메일 확인</button>
					</div>

					<div>
						<p id="p1">본인의 아이디와 이메일이 일치한 후에 [비밀번호 찾기] 버튼을 눌러야 본인 이메일에 임시 비밀번호가 전송됩니다.</p>
					</div>

					<div class="row mt-5 mb-3">
						<div class="col-sm-6">
							<button class="btn main-btn btn-block">비밀번호 찾기</button>
						</div>
					</div>
				</form>
			</div>
			
			
			
			<script>
				var email = false;
				var certifyCode;
				$(function() {
					$email = $("#email");

					// 이메일 확인 및 전송
					$("#email-authentication-btn").on("click",function() {
						email = false;
						if ($(this).text() == "다시 입력하기") {
							$email.prop("readonly", false).val("").focus();
							$("#email-authentication-btn").text("이메일 확인").removeClass("del-btn").addClass("main-btn");
							$("#checkEmail").html("이메일을 다시 입력해주세요.");
						} else {
							var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
							if (!regExp.test($email.val())) {
								$("#checkEmail").html("이메일 형식이<br> 유효하지 않습니다.").css("color", "rgb(255, 117, 117)");
							} else {
								$("#checkEmail").html("<span class='spinner-border spinner-border-sm'></span> 이메일을 확인하고 있습니다.").css("color", "gray");

								$.ajax({
									url : 'signUpedEmail',
									type : "POST",
									data : {email : $email.val()},
									success : function(result) {
										console.log(result);
										if (result == "0") {
												$("#checkEmail").html("가입되지 않은 이메일입니다.").css("color","rgb(255, 117, 117)");
											}  else {
												$("#checkEmail").html("존재하는 이메일 입니다.<br> 비밀번호 찾기 버튼을 눌러주세요.").css("color","rgb(41, 128, 185)");
								 				$email.prop("readonly",true);
												$("#email-authentication-btn").text("다시 입력하기").removeClass("main-btn").addClass("del-btn");
												email = true;
												certifyCode = result; 
												console.log("인증번호"+ result);
											} 
										},
									error : function(e) {
										console.log("email 인증 ajax 실패");
										console.log(e);
									}
								});
							}
						}
					});
				});
				
				
		</script>	



		<script>
           $(document).ready(function(){
             $('#my-spinner').hide(); //첫 시작시 로딩바를 숨겨준다.
         })
         .ajaxStart(function(){
            $('#my-spinner').show(); //ajax실행시 로딩바를 보여준다.
         })
         .ajaxStop(function(){
            $('#my-spinner').hide(); //ajax종료시 로딩바를 숨겨준다.
         });
        </script>
        <div id='my-spinner'>
          <div><span>
             <img src='//cdnjs.cloudflare.com/ajax/libs/galleriffic/2.0.1/css/loader.gif'>
          </span></div>
         </div>




		





		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>