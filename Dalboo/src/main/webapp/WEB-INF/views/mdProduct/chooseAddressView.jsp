<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소지 선택</title>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#a-table{border-collapse:collapse; width:500px; text-align:center;}
	#btnArea{margin-top:10px; margin-bottom:10px;}
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
	<div align="center">
		<h3 align="left">배송지 선택</h3>
		<hr>
	</div>
	<div align="center" style="overflow: auto; height:250px;">
		<table id="a-table">
			<thead>
				<tr style="background:#e9e9e9; height:50px;">
					<th width="15%">배송지</th>
					<th width="15%">수령인</th>
					<th width="50%">주소</th>
					<th width="20%">연락처</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${ empty adlist }">
					<tr>
						<td colspan="6">저장된 배송지가 없습니다.</td>
					</tr>
				</c:if>
				
				<c:forEach var="ad" items="${ adlist }">
					<tr style="border-bottom:1px solid rgba(75, 75, 75, 0.33); height:60px; ">	
						<td>${ ad.adName }</td>
						<td>${ ad.adReceiver }</td>
						<td class="address">${ ad.adAddress }</td>
						<td>${ ad.adPhone }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div id="btnArea" align="center">
		<input type="button" value="배송지 추가" id="insert" class="Btn" style="background:rgb(227, 189, 152);">
		<input type="button" value="닫기" class="Btn" onclick="window.close()">
	</div>
	
	<script>
	$(function(){
		
		$(".address").mouseenter(function(){
			$(this).parent().children().css({'background':'rgba(227, 189, 152, 0.1)', 'cursor':'pointer'});
		}).mouseout(function(){
			$(this).parent().children().css('background','none');
		}).click(function(){
			var tr = $(this).parent();
			var td = tr.children();
			var name = td.eq(1).text();
			var address = td.eq(2).text();
			var phone = td.eq(3).text();
			
			$("#ad1",opener.document).css("display","none");
			$("#ad2",opener.document).css("display","block");
			$("#adcheck2",opener.document).prop("checked",true);
			
			opener.document.getElementById('name2').value = name;
			opener.document.getElementById('add2').value = address;
			opener.document.getElementById('phone2').value = phone;
			window.close();		
						
		});
	});
	
	
	//배송지 추가
	document.getElementById("insert").onclick = function() {
		openWindow(function(win) {
			location.href = "choseaddress.md";
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
	
	</script>
</body>
</html>