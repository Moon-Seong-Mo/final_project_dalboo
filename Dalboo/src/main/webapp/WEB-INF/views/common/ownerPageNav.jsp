<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">
<title>Insert title here</title>

</head>
<body>
		<div id="nav">
			<p id="tag-title">Menu</p>
			<ul>
			
			
				
				<c:if test="${empty sessionScope.loginUser}">
				<li style="background :#27b6af; width:95%; border-radius: 5px;"><a href="<%= request.getContextPath() %>/ownerLoginPage.ow" >메인</a></li>
				</c:if>
				
				<c:if test="${!empty sessionScope.loginUser}">
				<li style="background :#27b6af; width:95%; border-radius: 5px;"><a href="<%= request.getContextPath() %>/ownerMain.ow" >메인</a></li>
				</c:if>
				
				
				
				
				<li class="main_menu"><a href='${ contextPath }/owner_notice.ow'>가맹주 공지사항</a></li>
				<li class="main_menu"><a href="owner_newmenu_list.ow">신메뉴 개발</a></li>
				
				
				<c:if test="${!empty sessionScope.loginUser&& loginUser.rank_code eq '1'}">
				<li>
					<p>생산관리 ▼</p>
					<ul class="sub_menu">
						<li><a href="<%= request.getContextPath() %>/owner_material_orderView.ow">주문하기</a></li> <!-- 재료 주문하기 -->
<!-- 																			ㄴ onwer_material_order -->
						<li><a href="<%= request.getContextPath() %>/owner_order_status.ow">발주 현황</a></li> <!--  내가 주문 현황 어떻게 된건지 페이지(수락/거절/대기) 결제일만 넣기 -->
<!-- 																			ㄴ onwer_order_status -->
					</ul>
				</li>
				</c:if>
				
				
				<c:if test="${!empty sessionScope.loginUser&& loginUser.rank_code eq '2'}">
				<li>
					<p>생산관리 ▼</p>
					<ul class="sub_menu">
						<li><a href="<%= request.getContextPath() %>/admin_inventory.ow">본사 재고</a></li> <!--  현재 본사의 재고를 추가/삭제하고 몇개 남아있는지봄 -->
<!-- 																						ㄴ admin_material_manage -->
						<li><a href="<%= request.getContextPath() %>/admin_delivery.ow">발주 관리 </a></li> <!-- 매장별 발주 뭐했는지보고 수락 거절 함 -->
<!-- 																						ㄴ admin_delivery_manage -->
						<li><a href="<%= request.getContextPath() %>/admin_delivery_status.ow">납품 현황</a></li> <!--  내가 어디 매장을 재료 물품들을 수락/거절했는지 목록 -->
<!-- 																						ㄴ admin_delivery_status -->
					</ul>	
				</li>
<!-- 				<li class="main_menu"><a href="startUpList.ow">창업 신청서 관리</a></li> -->
				</c:if>
				
				
				
			</ul>
		</div>
		
		<script>
         $(function(){
            $('li').click(function(){
               var status = $(this).children('.sub_menu').css('display');
               if(status =='none'){
                  $(this).children('.sub_menu').css({'display':'block'});
               } else if(status =='block'){
                  $(this).children('.sub_menu').css({'display':'none'});
               }
               
            });
         });
      </script>
		
</body>
</html>