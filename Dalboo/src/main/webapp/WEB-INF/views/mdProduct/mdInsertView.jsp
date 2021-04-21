<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | MD 상품 추가</title>
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/order/md_detail.css">
<style>
	td { padding: 10px; }
	#titleImgArea:hover, #contentImgArea1:hover, #contentImgArea2:hover, #contentImgArea3:hover, .Btn:hover { cursor: pointer; }
	input[type="text"]{width: 200px; height: 25px; font-size:16px;}
	input[type="number"]{width: 200px; height: 25px; font-size:16px;}
	select{width:200px; height:25px; font-size:16px;}
	.Btn {
		font-size: 17px;
		border: 0px;
		border-radius: 5px;
		margin-right: 30px;
		width: 110px;
		height: 30px; 
	}
	
</style>
</head>
<body>
	<div class="wrap">
	<%@ include file="/WEB-INF/views/common/nav.jsp"%>
		<div id="content">
			<h2 align="center">MD상품</h2>
			<form action="${ contextPath }/insert.md" method="post" encType="multipart/form-data">
				<div class="insertArea" align="center">
					<table>
						<tr>
							<th>카테고리</th>
							<td>
								<select name="mdCategory">
									<option value="머그컵">머그컵</option>
									<option value="텀블러">텀블러</option>
									<option value="원두">원두</option>
									<option value="악세사리">악세사리</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>상품 이름</th>
							<td colspan="3"><input type="text" name="mdName" id="Name"></td>
						</tr>
						<tr>
							<th>상품 가격</th>
							<td><input type="number" name="mdPrice" min="1000" id="mdPrice" step="500" >&nbsp;원</td>
						</tr>
						<tr>
							<th>재질</th>
							<td><input type="text" name="mdMaterial" id="mdMaterial"></td>
						</tr>
						<tr>
							<th>용량</th>
							<td><input type="number" name="mdCapacity" min="100"  step="50" id="mdCapacity">&nbsp;g</td>
						</tr>
						<tr>
							<th>재고 량</th>
							<td><input type="number" name="mdStock" min="10"id="mdStock" step="5"></td>
						</tr>
					</table>
					<div id="imgArea" align="center">
						<b>썸네일</b><br>
						<div id="titleImgArea">
							<img id="titleImg" width="400" height="400">
						</div>
						<b>사진</b><br>
						<div id="contentImgArea1">
							<img id="contentImg1" width="400" height="400">
						</div>
						<br>
						<div id="contentImgArea2">
							<img id="contentImg2" width="400" height="400">
						</div>
					</div> 

					<div id="fileArea">
						<input type="file" id="thumbnailImg1" multiple="multiple" name="thumbnailImg" onchange="LoadImg(this,1)"> 
						<input type="file" id="thumbnailImg2" multiple="multiple" name="thumbnailImg" onchange="LoadImg(this,2)"> 
						<input type="file" id="thumbnailImg3" multiple="multiple" name="thumbnailImg" onchange="LoadImg(this,3)">
					</div>
					<script>
							$(function(){
								$("#fileArea").hide();
								
								$("#titleImgArea").click(function(){
									$("#thumbnailImg1").click();
								});
								$("#contentImgArea1").click(function(){
									$("#thumbnailImg2").click();
								});
								$("#contentImgArea2").click(function(){
									$("#thumbnailImg3").click();
								});
							});
							
							function LoadImg(value, num){
								if(value.files && value.files[0]){
									var reader = new FileReader();
									
									reader.onload = function(e){								
										switch(num){
										case 1: 
											$("#titleImg").attr("src", e.target.result);
											break;
										case 2:
											$("#contentImg1").attr("src", e.target.result);
											break;
										case 3: 
											$("#contentImg2").attr("src", e.target.result);
											break;
										}
									}
									reader.readAsDataURL(value.files[0]);
								}
							}
						</script>
						
						
						
						
						
						
						
						
						

				</div>
				<br>
				<div align="center">
					<input type="button" id="cancelBtn" value="목록" class="Btn" onclick="location.href='mdMain.md?mdCategory=머그컵'">
					<input type="submit" id="insertBtn" value="작성완료" class="Btn" style="background: rgb(227, 189, 152);"> 
				</div>
				
				
				<script>
						$("#insertBtn").click(function(){
							if($("#Name").val() == ''){
								alert("상품 이름을 입력해주세요.");
								$("#Name").focus();
								return false;
							} else if($("#mdPrice").val() == ''){
								alert("상품 가격을 입력해주세요.");
								$("#mdPrice").focus();
								return false;						
							} else if($("#mdMaterial").val() == ''){
								alert("상품 재질을 입력해주세요.");
								$("#mdMaterial").focus();
								return false;						
							} else if($("#mdCapacity").val() == ''){
								alert("상품 용량을 입력해주세요.");
								$("#mdCapacity").focus();
								return false;						
							} else if($("#mdStock").val() == ''){
								alert("상품 재고를 입력해주세요.");
								$("#mdStock").focus(); 
								return false;						
							} else if($("#thumbnailImg1").val() == ''){
								alert("썸네일 사진을 등록해주세요.");
								return false;			 			
							} else if($("#thumbnailImg2").val() == '' || $("#thumbnailImg3").val() == ''){
								alert("사진을 등록해주세요.");
								return false;			 			
							} 
							return true;
						});
			</script>
			</form>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>