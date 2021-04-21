<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 메뉴추가</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/order/coffee_register.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp" %>
		<div id="content">
	
		<!-- 여기까지 -->
		<br>
		<h2>메뉴 등록</h2>
		<div class="outer">
			<form action="coffee_insert.cf" method="post" enctype="Multipart/form-data">
				<div class="detailArea">				
					<table id="tableArea">
						
						<tr>
			                     	<th>카테고리</th>
			                     	<td> 
			                     <select name="mType" id="menu_cate">
			                        <option value="">메뉴 카테고리를 선택 하세요.</option>
			                        <option value="신메뉴">신 메뉴</option>
			                        <option value="커피">커피</option>
			                        <option value="음료">음료</option>
			                        <option value="디저트">디저트</option>
			                	 </select>    
									</td>
						</tr>
						
						
						<tr>
							<th id="title-td">메뉴 이름 </th>
								<td><input type="text" name="mName" value="" id="name" placeholder="제목을 입력해주세요.">  
							</td>				
						</tr>
						
						<tr>
							<th>가격</th>
							<td>
								 <input type="number"  name="mPrice" id="price"  min="0" step="100">
							</td>
						</tr>
						
						<tr>
							<th>카페인</th>
							<td>
							<input type="number"  name="mCaffeine" id="caffeine" min="0">
							</td>
						</tr>
						<tr>
							<th>칼로리</th>
							<td>
							 <input type="number"  name="mCalorie" id="calorie" min="0">
							</td>
						</tr>
						
						
						<tr>
							<th>나트륨</th>
							<td>
							<input type="number"  name="mSodium" id="sodium" min="0">
							</td>
						</tr>
						<tr>
							<th>당분</th>
							<td>
							<input type="number"  name="mSugar" id="sugar" min="0">
							</td>
						</tr>
						<tr>
							<th>용량</th>
							<td>
							<input type="number"  name="mCapacity" id="capacity" min="0" step="10">
							</td>
						</tr>
						<tr>
							<th>설명</th>
							<td>
							<input type="text" name="mContent" id="inputcontent">
							</td>
						</tr>
						
						<tr>
							<th>사진</th>
							<td>
		                     <div id="titleImgArea">
		                        <img id="titleImg" width="525" height="300">
		                     </div>
		                  	</td>
						</tr>
						
					</table>
				</div>
				
					
				<div id="btnDiv" align="center">					
					<input type="button" onclick="history.back(-1)" id="res-btn" value="취소" style="background: lightgray; border-radius: 5px; font-size: 17px; border: none; cursor: pointer;">
					<input type="submit" id="sbm-btn" value="등록" onclick="return validate();">
				</div>
				
	             <!-- 파일 업로드 하는 부분 -->
			    <div id="fileArea">
			       <input type="file" id="uploadFile" multiple="multiple" name="uploadFile" onchange="LoadImg(this,1)" accept="image/*">
			    </div>
			    
			    <script>
               // 내용 작성 부분의 공간을 클릭할 때 파일 첨부 창이 뜨도록 설정하는 함수
               $(function(){
                  $("#fileArea").hide();
                  
                  $("#titleImgArea").click(function(){
                     $("#uploadFile").click();
                  });
               });
		               
               // 각각의 영역에 파일을 첨부 했을 경우 미리 보기가 가능하도록 하는 함수
               function LoadImg(value, num){
                  if(value.files && value.files[0]){
                     var reader = new FileReader();
                     
                     reader.onload = function(e){                        
                        switch(num){
                        case 1: 
                           $("#titleImg").attr("src", e.target.result);
                           break;
                     }
                     }
                     
                     reader.readAsDataURL(value.files[0]);
	                  }
	               }
				</script>
				
				<script>
				function validate() {
					var chkCate = $('#menu_cate');
					var chkName = $('#name');
					var chkPrice = $('#price');
					var chkCaffeine = $('#caffeine')
					var chkCalorie = $('#calorie')
					var chkSodium = $('#sodium')
					var chkSugar = $('#sugar')
					var chkCapacity = $('#capacity')
					var chkInputcontent = $('#inputcontent')
					var chkImage = $('#uploadFile');
					
					if($('#menu_cate').val() ==""){
						alert('카테고리를 선택해주세요.');
						chkCate.focus();
						return false;
					}else if(!$('#name').val()){
						alert("이름을 입력해주세요.");
						chkName.focus();
						return false;
					}else if(!$('#price').val()){
						alert("가격을 입력해주세요.");
						chkPrice.focus();
						return false;
					}else if(!$('#caffeine').val()){
						alert("카페인을 입력해주세요.");
						chkCaffeine.focus();
						return false;
					}else if(!$('#calorie').val()){
						alert("칼로리를 입력해주세요.");
						chkCalorie.focus();
						return false;
					}else if(!$('#sodium').val()){
						alert("나트륨 입력해주세요.");
						chkSodium.focus();
						return false;
					}else if(!$('#sugar').val()){
						alert("당분을 입력해주세요.");
						chkSugar.focus();
						return false;
					}else if(!$('#capacity').val()){
						alert("용량을 입력해주세요.");
						chkCapacity.focus();
						return false;
					}else if(!$('#inputcontent').val()){
						alert("설명을 입력해주세요.");
						chkInputcontent.focus();
						return false;
					}else if($('#uploadFile').val() ==''){
						alert("사진을 넣어 주세요.");
						chkImage.focus();
						return false;
					}
					return true;
					
					
		       }
				
				</script>
				
				
			</form>
		</div>
	</div>
	</div>
	
	
	
	
	
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>