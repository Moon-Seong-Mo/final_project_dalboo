<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레</title>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> 
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">

</head>
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
<body>
		<header>
		
			<c:if test="${ empty sessionScope.loginUser }">
			<a href="<%= request.getContextPath() %>/ownerLoginPage.ow">
               <img src="resources/images/logo.png" id="logoImg">
            </a>
            </c:if>
            
			<c:if test="${ !empty sessionScope.loginUser }">
               <img src="resources/images/logo.png" id="logoImg">
            </c:if>
            
            
            
            
            
            
            
			    <div id="headerBtnArea">			    
			    	<c:if test="${ !empty sessionScope.loginUser}">
	             	  <button id="logoutBtnOwner"><img width=40 height=40 src="resources/images/logouticon.png"></button>
		     		</c:if>
		     		
			    </div>      	
              
		     		 
		     		  <button class="owner-Btn" id="defaultPage">기본페이지</button>
		     	<c:if test="${ empty sessionScope.loginUser }">		     	
		     		  <button class="owner-Btn" id="loginBtn">로그인</button>
		     	</c:if>
			
		</header>
		
		<script>
			$(function(){
				$('#loginBtn').click(function(){
					location.href='ownerLoginPage.ow';
				});
			});
			$(function(){
				$('#logoutBtnOwner').click(function(){
					var con = confirm('로그아웃 하시겠습니까?');
					if(con){
						location.href='logout.ow';
					}else{
						return false;
					}
				});
			});
			
			$(function(){
				$('#defaultPage').click(function(){
					location.href='defaultPage.ow';
				});
			});
		</script>
</body>
</html>