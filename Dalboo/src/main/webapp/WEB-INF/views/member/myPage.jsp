<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 내 정보</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/member/myPage.css">
<!-- JQuery Modal Plugs -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">

<style>
#memberDeleteBox td{
	padding:10px;
}

#deleteLabel{
	font-size:14px;
}

#userId, #pwd{
	width:160px; 
	height:30px;
	outline: none; 
}

#error{
	color:red;
}
#explain{
	font-size: 12px; 
} 
#deleteA{
	width:100px; 
	height:30px;
	background: rgb(227, 189, 152);
	border:0px;
	border-radius:5px;
	outline: none;
	cursor: pointer;
}	
</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp" %>
		<div id="content">
		
			<div id="mypage_area">
				<br>
				<h1>MyPage</h1>
				<hr>
				<div id="name-area">
					<h2>${ loginUser.id }님의 정보</h2>
					<div id="myBtn-area">
						<button onclick="location.href='${ contextPath }/update_infoView.me'" class="myBtn">내 정보 수정</button>
						<button onclick="location.href='${ contextPath }/addressList.me'" class="myBtn">배송지 관리</button>
					</div>
				</div>
				
				<div id="inform-area">
					<label class="inform">아이디 : ${ loginUser.id }</label>
					<label class="inform">닉네임 : ${ loginUser.nickName }</label>
					<label class="inform">전화번호 : ${ loginUser.phone }</label>
					<label class="inform">이메일 : ${ loginUser.email }</label>
					<label class="inform">보유 포인트 : <b>${ loginUser.point }</b>P<button onclick="location.href='myPointList.me'" id="pointBtn">적립 내역</button></label>
				</div>
				
				<div id="list-table">
					<div id="list-inner">
						<div id="list-content">
							<a href="coffeeOrderView.me">
								<img class="list-img" src="<%= request.getContextPath() %>/resources/images/coffeeorder.png">
								<label class="list-name">커피 주문 목록</label>
							</a>				
							<a href="${ contextPath }/mdOrderListView.md">
								<img class="list-img" src="<%= request.getContextPath() %>/resources/images/mdlist.png">
								<label class="list-name">MD 주문 목록</label>
							</a>				
							<a href="${ contextPath }/myCartList.md">
								<img class="list-img" src="<%= request.getContextPath() %>/resources/images/wishlist.png">
								<label class="list-name">장바구니</label>
							</a>				
						</div>
					</div>
				</div>
				<div id="leave-explain">
					<label id="deleteLabel">달보드레를 더 이상 이용하지 않는다면</label> 
					<a href="#memberDelete" rel="modal:open" style="border: none; background: none; font-weight: bold; cursor: pointer; font-size: 14px;">▶ 회원탈퇴</a>
					<div id="memberDelete" class="modal">
							<h2 align="left">회원 탈퇴</h2> 
 							<label id="explain">  
								탈퇴할 경우 <b>재사용 및 복구가 불가능</b>합니다.<br>
								재사용 및 복구가 불가하오니 신중하게 선택하시기 바랍니다.
							</label><br><br>
							<div align="center"> 
								<table id="memberDeleteBox"> 
									<tr>
										<td>아이디</td>
										<td><input type="text" name="id" id="userId"></td> 
									</tr> 
									<tr>
										<td>비밀번호</td>
										<td><input type="password" name="pwd" id="pwd"></td>
									</tr>
								</table>
							</div>
							<div align="center">
								<br>
								<label id="error"></label>
								<br><br> 
								<input type="button" id="deleteA" value="탈퇴"> 
							</div> 
					</div>			
					<script>
						$("#deleteA").click(function(){
							var id = $("#userId").val();
							var pwd = $("#pwd").val();
							$.ajax({
								type:"POST",
								data: {id:id, pwd:pwd},
								url:"memberDelete.me",
								success:function(data){
									if(data == 'success'){
										alert("회원탈퇴에 성공하였습니다.");
										location.href="logout.me";
									} else if(data == 'false'){ 
										$("#error").text("아이디 또는 비밀번호를 잘못 입력하셨습니다.");
										if($("#deleteA").click(function(){
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
	</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>