<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | MD상품 : 상품 수정</title>
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/order/md_detail.css">
<style>
	td { padding: 10px; }
	#titleImgArea:hover, #titleImg:hover, #contentImg1:hover, #contentImg2:hover, .Btn:hover { cursor: pointer; }
	input[type="text"]{width: 200px; height: 25px; font-size:16px;}
	input[type="number"]{width: 200px; height: 25px; font-size:16px;}
	select{width:200px; height:25px; font-size:16px;}
	.imgArea{margin-bottom:20px; margin-top:20px;}
	.Btn {
		font-size: 17px;
		border: 0px;
		border-radius: 5px;
		margin-right: 30px;
		width: 110px;
		height: 30px; 
	}
	#lastBtn{
	margin-top:80px; 
	margin-bottom:50px; 
	font-size:17px; 
	background:rgb(227, 189, 152); 
	border:0px; 
	width:80px; 
	height:40px; 
	border-radius:5px;
}
</style>
</head>
<body>
	<div class="wrap">
	<%@ include file="/WEB-INF/views/common/nav.jsp"%>
		<div id="content">
			<h2 align="center">MD상품</h2>
			<form action="${ contextPath }/mdModify.md" method="post" encType="multipart/form-data">
				<div class="insertArea" align="center">
					<c:forEach var="i" begin="0" end="2">
						<input type="hidden" value="${ f[i].fileNum }" name="fileNum">
					</c:forEach>
					<c:forEach begin="0" end="2" var="i">
						<input type="hidden" value="${ f[i].filePath }" name="filePath">
					</c:forEach>
					
					<table>
						<tr>
							<th>카테고리</th>
							<td>
								<input type="hidden" value=${ md.mdCategory } id="mdCategory">
									<select name="mdCategory" id="selectList">
										<option value="머그컵">머그컵</option>
										<option value="텀블러">텀블러</option>
										<option value="원두">원두</option>
										<option value="악세사리">악세사리</option>
									</select>
									
									<script>
										$(function(){
											var mdCate = $("#mdCategory").val();
											$("select[name=mdCategory]").val(mdCate).prop("selected", true);

										});
									</script>
							</td>
						</tr>
						
						<tr>
							<th>상품 이름</th>
							<td colspan="3">
								<input type="hidden" name="mdNum" value=${ md.mdNum }>								
								<input type="text" name="mdName" value="${ md.mdName }">
							</td>
						</tr>
						<tr>
							<th>상품 가격</th>
							<td><input type="number" name="mdPrice" min="1000" step="500" value="${ md.mdPrice }">&nbsp;원</td>
						</tr>
						<tr>
							<th>재질</th>
							<td><input type="text" name="mdMaterial" value="${ md.mdMaterial }"></td>
						</tr>
						<tr>
							<th>용량</th>
							<td><input type="number" name="mdCapacity" min="100" step="50" value="${ md.mdCapacity }">&nbsp;g</td>
						</tr>
						<tr>
							<th>재고 량</th>
							<td><input type="number" name="mdStock" min="10" step="5" value="${ md.mdStock }"></td>
						</tr>
					</table>
						
						
						
					<div id="imgArea" align="center">
						<b>기존 썸네일</b><br>
						<img width="200" height="300" src="${ contextPath }/resources/mdUploadFiles/${ f[0].changeName }">
						<br><b>기존 사진</b><br>
						<img width="200" height="300" src="${ contextPath }/resources/mdUploadFiles/${ f[1].changeName }" >
						<img width="200" height="300" src="${ contextPath }/resources/mdUploadFiles/${ f[2].changeName }" >
					</div> 
					
					<div id="imgArea" align="center">
						<b>수정 썸네일</b><br>
						<div id="titleImgArea">
							<img id="titleImg" width="400" height="400">
						</div>
						<b>수정 사진</b><br>
						<div id="contentImgArea1">
							<img id="contentImg1" width="400" height="400">
						</div>
						<br>
						<div id="contentImgArea2">
							<img id="contentImg2" width="400" height="400">
						</div>
					</div> 

					<div id="fileArea">
						<input type="file" id="thumbnailImg1" multiple="multiple" name="reloadImg" onchange="LoadImg(this,1)"> 
						<input type="file" id="thumbnailImg2" multiple="multiple" name="reloadImg" onchange="LoadImg(this,2)"> 
						<input type="file" id="thumbnailImg3" multiple="multiple" name="reloadImg" onchange="LoadImg(this,3)">
					</div>
					<script>
							$(function(){
								$("#fileArea").hide();
								
								$("#titleImg").click(function(){
									$("#thumbnailImg1").click();
								});
								$("#contentImg1").click(function(){
									$("#thumbnailImg2").click();
								});
								$("#contentImg2").click(function(){
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
				<c:if test="${ loginUser.id eq 'admin' }">
					<div align="center">
						<input type="submit" id="insertBtn" value="수정완료" class="Btn" style="background: rgb(227, 189, 152);"> 
						<input type="reset" id="cancelBtn" value="취소하기" class="Btn">
						<br>
						<input type="button" id="lastBtn" value="뒤로가기" onclick="history.back(-1);">
					</div>
				</c:if>
			</form>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>