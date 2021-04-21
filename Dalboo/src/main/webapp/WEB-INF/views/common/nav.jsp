<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nav</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/nav.css">
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> 
</head>
<style>
   button{
      outline: none;
   }
   input[type="button"]{
      outline: none;
   }
   input[type="text"]{
      outline: none;
   } 
   input[type="password"]{
      outline: none;
   }
   input[type="number"]{
      outline: none;
   }
   textarea {
      outline: none;
   }
   select{
      outline: none;
   }

</style>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<nav>
      <div class="frame nav-area">
         <ul class="main_menu">
            <li>
<%--                <span><a href="<%= request.getContextPath() %>">달보드레 소개</a></span> --%>
               <span>달보드레 소개</span>
               <ul class="sub_menu">
                  <li><a href="introduce.bo">달보드레</a></li>
                  <li><a href="howtofind.bo">오시는 길</a></li>               
               </ul>
            </li>
            <li>
<%--                <span><a href="<%= request.getContextPath() %>">메뉴</a></span> --%>
               <span>메뉴</span>
               <ul class="sub_menu">
                  <li><a href="newmenu_list.cf">신 메뉴</a></li>
                  <li><a href="coffee_list.cf">커피</a></li>               
                  <li><a href="ade_list.cf">음료</a></li>               
                  <li><a href="dessert_list.cf">디저트</a></li>               
               </ul>                  
            </li>
            <li>
<%--                <span><a href="${ contextPath }/mdMain.md?mdCategory=머그컵">MD</a></span> --%>
               <span>MD</span>
               <ul class="sub_menu">
				<li><a href="${ contextPath }/mdMain.md?mdCategory=머그컵">머그컵</a></li>
				<li><a href="${ contextPath }/mdMain.md?mdCategory=텀블러">텀블러</a></li> 
				<li><a href="${ contextPath }/mdMain.md?mdCategory=원두">원두</a></li>
				<li><a href="${ contextPath }/mdMain.md?mdCategory=악세사리">악세사리</a></li>             
               </ul>             
            </li>
            <li>
<%--                <span><a href="<%= request.getContextPath() %>">매장검색</a></span> --%>
               <span>매장검색</span>
               <ul class="sub_menu">
                  <li><a href="siren.cf">사이렌 오더</a></li>
                  <li><a href="store.etc">매장 검색</a></li>               
               </ul>            
            </li>
            <li>
<%--                <span><a href="<%= request.getContextPath() %>">공지&이벤트</a></span> --%>
               <span>공지&이벤트</span>
               <ul class="sub_menu">
                  <li><a href="notice_list.bo">공지</a></li>
                  <li><a href="event_list.bo">이벤트</a></li>               
                  <li><a href="nList.bo">이달의 신메뉴</a></li>               
               </ul>            
            </li>
            <li>
<%--                <span><a href="<%= request.getContextPath() %>">문의</a></span> --%>
               <span>문의</span>
               <ul class="sub_menu">
                  <li><a href="startUpProcedureView.etc">창업 신청</a></li>
                  <li><a href="customer_service_list.bo">고객센터</a></li>                
                  <li><a href="faqList.etc">FAQ</a></li>      
               </ul>            
            </li>
         </ul>
      </div>
   </nav>

    
   
   <script>
   $(document).ready(function(){
       $(".nav-area").mouseover(function(){
           $(".sub_menu").stop().slideDown(200);
       });
       
       $(".nav-area").mouseleave(function(){
        $(".sub_menu").stop().slideUp(200);
       });
   });


   </script>
   


</body>
</html>