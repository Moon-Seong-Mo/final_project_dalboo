<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 나의 배송지</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<style>
	.outer{	
	width: 1000px; 
	margin-left: auto; 
	margin-right: auto; 
	margin-top: 10%;  
	}
	hr{margin-bottom:40px;}
	#a-table{border-collapse:collapse; width:1000px;}
	tr{height:50px;}
	th, td {border: 1px solid rgb(198, 199, 194);}
	#aTag{float:right; cursor:pointer;}
	#btnArea{margin-top:50px; float:right;}
	.Btn{
		font-size: 17px; 
		border: 0px; 
		border-radius:5px; 
	 	width:110px; 
	 	height:30px;	
	 	cursor:pointer;
	 }
</style>
</head> 
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp" %>
		<div id="content">
			<div class="outer">
				<h2 align="left">배송지 관리</h2>
				<hr>
				<table id="a-table">
					<thead>
						<tr style="background:#e9e9e9;">
							<th width="6%"><input type="checkbox" name="all" id="all"></th>
							<th width="13%">배송지</th>
							<th width="13%">수령인</th>
							<th width="45%">주소</th>
							<th width="15%">연락처</th>
							<th width="8%"></th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${ empty adlist }">
							<tr>
								<td colspan="6">저장된 배송지가 없습니다.</td>
							</tr>
						</c:if>
						
						<c:forEach var="ad" items="${ adlist }">
							<tr>	
								<td><input type="checkbox" name="chk" value="${ ad.adNum }" class="chk"></td>
								<td>${ ad.adName }</td>
								<td>${ ad.adReceiver }</td>
								<td class="address">${ ad.adAddress }<input type="hidden" value="${ ad.adNum }" id="adNum"></td>
								<td>${ ad.adPhone }</td>
								<td>
									<c:if test="${ ad.adBaseAddress eq '0' }"></c:if>
									<c:if test="${ ad.adBaseAddress eq '1' }"><img src="${ contextPath }/resources/images/check.png" width="30px;"></c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div style="height:30px; margin-top:30px;">
					<a id="aTag">기본 배송지 설정</a><br>
					<div style="display: none;" id="aExplain">
						<p align="right" style="color:gray;">[ 주소를 클릭하여 기본 배송지로 선택할 수 있습니다. ]</p>
					</div>
					<br>
				</div>
				
				
				<div id="btnArea">
					<input type="button" value="배송지 추가" id="insert" class="Btn">
					<input type="submit" value="배송지 삭제" onclick="delete_Address();" class="Btn">
				</div>
				<div style="height:100px;"></div>
			</div> 
		</div>
	</div>
	<script>
		
		$(document).ready(function(){
			$("#aTag").click(function(){
				$("#aExplain").toggle();
			});
		});
			
		//기본 배송지 선택하기
		//기본 배송지 선택안되몀ㄴ rowsapn으로 합치고 선택되면 나누기
		
		$(function(){
			$(".address").mouseenter(function(){
				$(this).parent().children().eq(3).css({'background':'rgba(237, 237, 237, 0.41)', 'cursor':'pointer'});
			}).mouseout(function(){
				$(this).parent().children().eq(3).css('background','none');
			}).click(function(){
				
				var address = $(this).text();
				var adNum = $(this).children().val();
				
				var bool = window.confirm("기본 배송지로 선택하겠습니까?" + "\n" + address);
				
				if(bool){
					location.href='updateBaseAdd.me?adNum='+adNum;
				} else{
				}
			});
		});
		
		
		//삭제
		function delete_Address(){
			var chkArr = [];
			
			$('input[name="chk"]:checked').each(function(i){
				chkArr.push($(this).val());
			});
			
			if(chkArr.length == 0){
				alert('삭제하실 배송지를 골라주세요');
				return false;
			}
			
			var bool = confirm("배송지를 삭제하시겠습니까?");
			if(bool){
				location.href="deleteAddress.me?chkArr="+chkArr;
			} else{
				alert("배송지 삭제를 취소하였습니다.");
			}
		}
		
		//배송지 추가
		document.getElementById("insert").onclick = function() {
			//함수를 실행시킨 후 돌아올 곳
			openWindow(function(win) {
				location.href = "addressList.me";
			});
		};
	
		var openWindow = function(closeCallback) {
		    var win = window.open('insertAddressView.me', 'insertAddress', 'width=500, height=450 , left=800 , top = 300');
		    var interval = window.setInterval(function() {
		        try {
		            if (win == null || win.closed) {
		                window.clearInterval(interval);
		                closeCallback(win);
		            }
		        }
		        catch (e) {
		        }
		    }, 100);
		    return win;
		};
		
		//배송지 전체 체크
		var leng = ${ adlist.size() };
		
			$("#all").click(function(){
				if($('#all').is(":checked")){
					$(".chk").prop("checked", true);
				} else{
					$(".chk").prop("checked", false);
				}
			});
	
			$(".chk").click(function(){
				if($("input[name='chk']:checked").length == leng){
					$("#all").prop("checked", true);
				} else {
					$('#all').prop("checked", false);
				}
			});
	</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>

</html>