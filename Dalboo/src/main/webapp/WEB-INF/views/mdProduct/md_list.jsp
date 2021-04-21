<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | MD상품</title>
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/content.css">
<%-- <link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/order/md_list.css"> --%>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/order/md_list.css">
<style>
select {
	float: right;
	width: 80px;
	padding: .8em .5em;
	border: 1px solid #999;
	border-radius: 10px;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	text-align-last:center; 
}
</style>
</head>
<body>
	<div class="wrap">
	<%@ include file="/WEB-INF/views/common/nav.jsp"%>
		<div id="content">
			<div class="outer">
				<h3 id="top">달보드레 MD</h3>
				<hr>
				<div class="top_title">
					<label class="cate" id="cate1"><a href="${ contextPath }/mdMain.md?mdCategory=머그컵">머그컵</a></label><label style="font-size:25px; color:gray;">|</label>
					<label class="cate" id="cate2"><a href="${ contextPath }/mdMain.md?mdCategory=텀블러">텀블러</a></label> <label style="font-size:25px; color:gray;">|</label>
					<label class="cate" id="cate3"><a href="${ contextPath }/mdMain.md?mdCategory=원두">원두</a></label><label style="font-size:25px; color:gray;">|</label>
					<label class="cate" id="cate4"><a href="${ contextPath }/mdMain.md?mdCategory=악세사리">악세사리</a></label>
				</div>
				
				<!-- 카테고리 값 받아오기  -->
				<input type="hidden" value="${ mdCategory }" id="mdCategory">		
				<!-- 정렬 , list가 비어있으면 보이지 않음 -->
				<c:if test="${ !empty mdlist }">
					<div id="selectArea">
						<select id="selectList" name="selectList">
							<option value="new" selected>최신순</option>
							<option value="population">인기순</option>
						</select>
					</div>
				</c:if>
				<!-- 등록된 사진 없을 떄 -->
				<c:if test="${ empty mdlist }">
					<h1 style="margin-top:150px;">상품 준비중입니다</h1>
				</c:if>

				<c:if test="${ !empty mdlist }">
					<div id="thumbArea">
						<c:forEach var="md" items="${ mdlist }">
							<c:forEach var="f" items="${ flist }">
								<c:if test="${ md.mdNum eq f.boardNum }">
									<div id="imgArea">
										<a href="${ contextPath }/mdDetail.md?mdNum=${ md.mdNum }">
											<img src="${ contextPath }/resources/mdUploadFiles/${ f.changeName }" width="200px" height="300px">
											<p id="mdNameList">${ md.mdName }</p>
										</a> 
										
									</div>
								</c:if>
							</c:forEach>
						</c:forEach>
					</div>
				</c:if>
				
				<c:if test="${ !empty mdlist }">
					<div align="center" class="pagingArea">
						<!-- [이전 비활성화] -->
						<c:if test="${ pi.currentPage <= 1 }">
							<input type="button" class="Btn" value="&lt;" disabled="disabled" style="pointer-events:none;">
						</c:if>
						
						<!-- [이전] -->
						<c:if test="${ pi.currentPage > 1 }">
							<c:url var="before" value="mdMain.md">
								<c:param name="mdCategory" value="${ mdCategory }"/>
								<c:param name="page" value="${ pi.currentPage - 1 }" />
							</c:url>
							<input type="button" class="Btn" value="&lt;"onclick="location.href='${ before }'">
						</c:if>
	
						<!-- [페이지] -->
						<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
							<c:url var="pagination" value="${ mdMain.md }">
								<c:param name="mdCategory" value="${ mdCategory }"/>
								<c:param name="page" value="${ p }" />
							</c:url>
							<c:if test="${ p eq pi.currentPage }">
								<input type="button" id="choosen" value="${ p }" disabled="disabled">
							</c:if>
							<c:if test="${ p ne pi.currentPage }">
								<input type="button" class="numBtn" value="${ p }" onclick="location.href='${ pagination }'">
							</c:if>
						</c:forEach>
	
						<!--[다음 비활성화] -->
						<c:if test="${ pi.currentPage >= pi.maxPage }">
							<input type="button" class="Btn" value="&gt;" disabled="disabled" style="pointer-events:none;">
						</c:if>
	
						<!-- [다음] -->
						<c:if test="${ pi.currentPage < pi.maxPage }">
							<c:url var="after" value="${ mdMain.md }">
								<c:param name="mdCategory" value="${ mdCategory }"/>
								<c:param name="page" value="${ pi.currentPage + 1 }" />
							</c:url>
							<input type="button" class="Btn" value="&gt;" onclick="location.href='${ after }'">
						</c:if>
					</div>
				</c:if>

				<c:if test="${ loginUser.rank_code eq 2}">
					<div id="adminArea">
						<input type="button" class="adminBtn" onclick="location.href='mdInsertView.md'" value="추가">
					</div>
				</c:if> 
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
					
	<script>
		var mdCategory = $('#mdCategory').val();
		var cate1 = $('#cate1').text();
		var cate2 = $('#cate2').text();
		var cate3 = $('#cate3').text();
		var cate4 = $('#cate4').text();
		
		$(function(){
			if(mdCategory == cate1){
				$('#cate1').css('font-weight', 'bold');
			}
			if(mdCategory == cate2){
				$('#cate2').css('font-weight', 'bold');
			}
			if(mdCategory == cate3){
				$('#cate3').css('font-weight', 'bold');
			}
			if(mdCategory == cate4){
				$('#cate4').css('font-weight', 'bold');
			}
		});
	
		//select누르면 인기 페이지로 이동
		$(function(){
			var $select = $('select');
			var mdCategory = $('#mdCategory').val();
			
			$select.change(function(){
			var selectVal = $(this).val();
				if(selectVal == 'new'){
					location.href='mdMain.md?mdCategory='+mdCategory;
				} else{
					location.href='mdPopList.md?mdCategory='+mdCategory;
				}
			});						
			
		});
	</script>
</body>
</html>