<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>달보드레 | 로그인</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/owner/owner_login.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">
</head>
<body>
   <%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp" %>
   <div id="wrap">
      <%@ include file="/WEB-INF/views/common/ownerPageNav.jsp" %>
      <div id="section">
         <div id="owner_login">
         
         <br>
               <div>
                    <a href="<%= request.getContextPath() %>/">
                     <img id="top_logo2" src="resources/images/logo.png">
                    </a>
               </div>
               
               <p id="logintitle">L O G I N</p>
               
               
                 <div>
                    <input type="text" class="userid_input" name="userName" id="userName" size="32" maxlength="20" placeholder="매장명을 입력해주세요" required>
                 </div>
                 <div>
                     <input type="password" class="userid_input" name="userCode" id="userCode" size="32" maxlength="20" placeholder="코드를 입력해주세요" required>
<!--                      <input type="text" class="userid_input" name="userCode" id="userCode" size="32" maxlength="20" placeholder="코드를 입력해주세요" required> -->
                     <br>
                 </div>
                 

                 <p id="error"></p>
                 
                 <div>
                    <button id="login">로그인</button>
                    <br><br>
                 </div>
            
            <script>
       			 $("#login").click(function(){
                  var userName = document.getElementById('userName').value;
                  var userCode = document.getElementById('userCode').value;
                  console.log(userCode);
					
                  $.ajax({
                	  type:"POST",
                	  data:{userName:userName, userCode:userCode},
                	  url : "ownerLogin.ow",
                	  success : function(data){
	                	  if(data == 'success'){
// 		                           location.href='ownerLogin.ow?userCode=' + userCode + "&userName=" + userName;
		                           location.href='ownerMain.ow';
	                	  } else if(data == 'false'){
								$("#error").text("아이디 또는 비밀번호를 잘못 입력하셨습니다.");
								if($("#login").click(function(){
									$("#error").text("");
								}));
							} 
						}
					});						
				});
            
            </script>
         
         
      </div>
   </div>
</div>
</body>
</html>