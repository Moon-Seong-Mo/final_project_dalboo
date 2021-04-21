<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/header.css">
<link rel = "shortcut icon" href = "<%= request.getContextPath() %>/favicon.ico" >
<link rel="icon" href="<%= request.getContextPath() %>/favicon.ico">
</head>
<body>
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>	
   <header>
      <div class="top_banner"></div>
      <div class="frame top_area">
         <div class="top_logo_area">
            <a href="<%= request.getContextPath() %>/home.do">
               <img id="top_logo" src="<%= request.getContextPath() %>/resources/images/logo.png">
            </a>
         </div>
         <div class="top_menu">
         		
         	 	<c:if test="${!empty sessionScope.loginUser && loginUser.rank_code eq '2'}">
<!--          	 		관리자가 로그인 하였을 때 가맹주관리를 누르면 메인페이지뜸 -->
		    		<button class="top_menu_btn" id="MypageBtn" onclick="ownerStartManage();">창업 신청 관리</button>
		   	 		<button class="top_menu_btn" id="MypageBtn" onclick="location.href='mdShipManagement.md'">배송 관리</button>
		   	 		<br>
		    		<button class="top_menu_btn" id="MypageBtn" onclick="ownerMainpage();">가맹주 관리</button>
		   		</c:if>
         	 	<c:if test="${ empty sessionScope.loginUser }">
               <input type="button" class="top_menu_btn" id="loginBtn" value="로그인" onclick="login();">
               <input type="button" class="top_menu_btn" id="signBtn" value="회원가입" onclick="location.href='joinView.me'">
               
               
               
<!--                	로그인 아예 안했을 때 점주전용 누름 -->
               <input type="button" class="top_menu_btn" id="signBtn" value="점주전용" onclick="owner();">
               
               
               
              	</c:if>
              	
               <c:if test="${!empty sessionScope.loginUser}">
		      	<c:url var="logout" value="logout.me"/>
               <button class="top_menu_btn" id="logoutBtn" onclick="location.href='${logout}'">로그아웃</button><br><br>
		      </c:if>
		      <c:if test="${!empty sessionScope.loginUser && loginUser.rank_code eq '1'}">	
               <button class="top_menu_btn" id="MypageBtn" onclick="myPage()">마이페이지</button>
		      	
		      	<b><c:out value="${loginUser.nickName}님 환영합니다!"/></b>
	      	</c:if>
	      	
		      
		      
		      
          </div>
      </div>
      
      
   </header>
   
   <script>
	function login(){
		location.href='<%= request.getContextPath() %>/login.me';
	}
	
	function join(){
		location.href='<%= request.getContextPath() %>/join.me';
	}
	
	function owner(){
		location.href='<%= request.getContextPath() %>/ownerLoginPage.ow';
	}
	
	function myPage(){
		location.href='<%= request.getContextPath() %>/myPage.me';
	}
	
	
	function ownerStartManage(){
		location.href='<%= request.getContextPath() %>/startUpList.ow';
	}
	
	function ownerMainpage(){
		location.href='<%= request.getContextPath() %>/ownerLoginPage.ow';
	}
	
	</script>
   
   
   
</body>
</html>