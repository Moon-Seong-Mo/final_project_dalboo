<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 신메뉴</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/board/newmenu_detail.css">
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
		<h2>신메뉴 게시판</h2>
		<div class="outer">
			<form action="newMenuUpdateView.bo" method="post" enctype="multipart/form-data">
				<div class="detailArea">				
					<table id="tableArea">
						<tr id="first-tr"> 
							<td id="title">
								<strong>[이달의 신메뉴] ${board.title }</strong> 
								<input type="hidden" name="nNum" value="${board.nNum }"> 	
								<input type="hidden" name="page" value="${page}">							
							</td>									
							<td id="date">
								<strong align="right">${board.createDate }</strong> 
							</td>
							<td id="count">
								<strong  align="right">조회수 ${board.views }</strong> 
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<div id="content">
									<p>${board.subTitle}</p>
									<c:if test="${board.voteStatus == 'N' }">
										
									</c:if>
									<c:forEach var="f" items="${ f }">
									<div class="check-menu">
										<input type="checkbox" name="chk" value="${ f.fileNum }" onclick="chkBx(this);"/>
										<div style="display:inline-block;width: 504px;">
											<h3 align="left">${f.menuName }</h3>
											<textarea id="text-area" cols="67" rows="10"  readonly>${f.contentText }
											</textarea>
										</div>
										<div  style="display:inline-block;">											
											<img width=325 src="resources/nMUploadFiles/${f.changName }" style="margin-left:20px">
										</div>
									</div>
									</c:forEach>
									
									
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div id="btnDiv" align="right">	
				<c:if test="${ !empty loginUser && loginUser.id eq 'admin' }">									
						<input type="submit" id="sbm-btn" value="수정">
						<input type="button" id="del-Btn" value="삭제">
				</c:if>				
						<input type="button" id="res-btn" value="목록" onclick="location.href='nList.bo'">
					</div>
			</form>
			<c:if test="${ !empty loginUser}">
				<button id="vote_btn" onclick="voteChk();">투표하기</button>	
			</c:if>				
		</div>
	</div>
</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
		
		<script>
				$(function(){
					$('#sbm-btn').click(function(){
							var con = confirm("수정 페이지로 이동하시겠습니까?");
							if(con){
							var nNum = ${board.nNum}
							
							location.href='newMenuUpdateView.bo?nNum=' + nNum;
							}else{
								return false;
							}
					});
				});
				
				$(function(){
					$('#del-Btn').click(function(){
							var con = confirm("정말 삭제하시겠습니까?");
							if(con){
							var nNum = ${board.nNum}
							
							location.href='deleteNewMenu.bo?nNum=' + nNum;
							}else{
								return false;
							}
					});
				});

				
				function voteChk(){ 
					var v = ${v};
				     
					if(v == 0){
					$("input[name='chk']:checked").each(function() { 
				        var fNum = $(this).val();
				        var nNum = ${board.nNum};
				
				  
				        
				        $.ajax({
				        	url: 'voteInsert.bo',
				        	data: {fileNum:fNum, 
				        		   nNum:nNum},
				        		   success:function(data){
				        		if(data == 'ok'){
				        			alert('투표해주셔서 감사합니다.');
				        			location.reload();
				        		}else{
				        			alert('투표에 실패했습니다.');
				        			return false;
				        		}
				        	}
				        });
				           
				    });
					}else if(v > 0){
						alert('이미 투표에 참여하셨습니다.');
						return false;
					}
				}
		</script>
		<script>
			function chkBx(chk){
			    var obj = document.getElementsByName("chk");
			    for(var i=0; i<obj.length; i++){
			        if(obj[i] != chk){
			            obj[i].checked = false;
			        }
			    }
			}
		</script>
</body>
</html>