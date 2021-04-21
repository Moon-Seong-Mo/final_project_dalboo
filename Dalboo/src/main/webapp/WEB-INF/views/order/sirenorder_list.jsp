<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="e" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 사이렌오더</title>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/order/sirenorder_list.css">
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			<div id="content">
			
			
			<div id="sirenorder_list_area">
			
			<div id="bell">
			<img src="<%= request.getContextPath() %>/resources/images/orderbell.PNG" align="left">
			<h2 align="left">주문하기</h2>
			</div>
			
				<div id="sirenorder_list">
					<div>
					<ul class="order-nav-list">
						<li><a href="#" class="newMenu">신메뉴</a></li> <b>|</b>
						<li><a href="#" class="coffee">커피</a></li> <b>|</b>
						<li><a href="#" class="beverage">에이드</a></li> <b>|</b>
						<li><a href="#" class="dessert">디저트</a></li>
					</ul>
					</div>
			
				<div id="hotcold">
				<img src="<%= request.getContextPath() %>/resources/images/thumb.PNG" align="left">
				<h2 align="left" class="menu">추천메뉴</h2>
				</div>
				<div id="">
				<e:forEach var="m" items="${ list }">
				<e:if test="${ m.materialAmount gt '0' }">
				<ul class="coffeelist">
					<li class="coffeelist2">
						<img src="resources/materialuploadFiles/${ m.rename_filename }">
						<div>
							<label>${ m.materialName }</label>
							<p>${ m.materialprice } won</p>
						</div>
					</li>
				</ul>
				</e:if>
				</e:forEach>
				</div>
	
				<div id="hotcold">
				<img src="<%= request.getContextPath() %>/resources/images/thumb.PNG" align="left">
				<h2 align="left" class="menu">카테고리별 메뉴</h2>
				</div>
				<input type="hidden" name="mNum" class="mNum">
				<input type="hidden" name="m_id" class="m_id" value="${ loginUser.id }">
				<input type="hidden" name="store_num" class="store_num" value="${ store_num }">
				
			<form action="" method="post">
				<div id="hot"></div>
				
			<div id="btn">
				<e:if test="${ !empty loginUser }">
				<br>
				<input type="button" id="add" value='담기' onclick="btnclick();">
				<input type="button" id="ordercf" value='주문하기' onclick="soOrder();">
				</e:if>
			</div>
			</form>
				
			</div>
	
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
	$('.coffee').on('click', function(){
		var stockNum = $(this).parent().find(".mNum").val();
		var store_num = $('.store_num').val();
		$.ajax({
			url: "choiceCoffee.cf",
			data: {store_num: store_num},
			success : function(data){
				console.log(data);

				if(data.length > 0){
					var $hot = $('#hot');
					$hot.html('');
					$.each(data, function(index, i){
						
						if(i.materialAmount > 0){
							
						var $ul = $('<ul class="coffeelist">')
						var $li = $('<li class="coffeelist2">')
						var $menuImg = "<li class='coffeelist2'><img src='resources/materialuploadFiles/" + i.rename_filename + "'>";
						var $input = $('<input type="checkbox" name="mCheck" id="mCheck" value="'+i.stock_num + '">');
						var $mName = $('<label></label>').text(i.materialName);
						var $price = $('<p></p></div></li>').text(i.materialprice + " won");
							
						$li.append($menuImg);
						$li.append($input);
						$li.append($mName);
						$li.append($price);
						$ul.append($li);
						$hot.append($ul);
						}
					});
				}else{
					var $hot = $('#hot');
					$hot.html('');
					var $ul = $('<ul class="coffeelist">');
					var $li = $('<li class="coffeelist2">');
					var $msg = $('<span>').text("준비된 메뉴가 없습니다!");
					$li.append($msg);
					$ul.append($li);
					$hot.append($ul);
				}
			}
		});
	});

	$('.beverage').on('click', function(){
		var store_num = $('.store_num').val();
		$.ajax({
			url: "choiceAde.cf",
			data: {store_num: store_num},
			success : function(data){
				console.log(data);

				if(data.length > 0){
					var $hot = $('#hot');
					$hot.html('');
					$.each(data, function(index, i){

						if(i.materialAmount > 0){
						var $ul = $('<ul class="coffeelist">')
						var $li = $('<li class="coffeelist2">')
						var $menuImg = "<li class='coffeelist2'><img src='resources/materialuploadFiles/" + i.rename_filename + "'>";
						var $input = $('<input type="checkbox" name="mCheck" id="mCheck" value="'+i.stock_num + '">');
						var $mName = $('<label></label>').text(i.materialName);
						var $price = $('<p></p></div></li>').text(i.materialprice + " won");
							
						$li.append($menuImg);
						$li.append($input);
						$li.append($mName);
						$li.append($price);
						$ul.append($li);
						$hot.append($ul);
						}
					});
				}else{
					var $hot = $('#hot');
					$hot.html('');
					var $ul = $('<ul class="coffeelist">');
					var $li = $('<li class="coffeelist2">');
					var $msg = $('<span>').text("준비된 메뉴가 없습니다!");
					$li.append($msg);
					$ul.append($li);
					$hot.append($ul);
				}
			}
		});
	})
	
	$('.dessert').on('click', function(){
		var store_num = $('.store_num').val();
		$.ajax({
			url: "choiceDessert.cf",
			data: {store_num: store_num},
			success : function(data){
				console.log(data);

				if(data.length > 0){
					var $hot = $('#hot');
					$hot.html('');
					$.each(data, function(index, i){

						if(i.materialAmount > 0){
						var $ul = $('<ul class="coffeelist">')
						var $li = $('<li class="coffeelist2">')
						var $menuImg = "<li class='coffeelist2'><img src='resources/materialuploadFiles/" + i.rename_filename + "'>";
						var $input = $('<input type="checkbox" name="mCheck" id="mCheck" value="'+i.stock_num + '">');
						var $mName = $('<label></label>').text(i.materialName);
						var $price = $('<p></p></div></li>').text(i.materialprice + " won");
							
						$li.append($menuImg);
						$li.append($input);
						$li.append($mName);
						$li.append($price);
						$ul.append($li);
						$hot.append($ul);

						}
					});
				}else{
					var $hot = $('#hot');
					$hot.html('');
					var $ul = $('<ul class="coffeelist">');
					var $li = $('<li class="coffeelist2">');
					var $msg = $('<span>').text("준비된 메뉴가 없습니다!");
					$li.append($msg);
					$ul.append($li);
					$hot.append($ul);
				}
			}
		});
	})
	
	$('.newMenu').on('click', function(){
		var store_num = $('.store_num').val();
		$.ajax({
			url: "choiceNewMenu.cf",
			data: {store_num: store_num},
			success : function(data){
				console.log(data);

				if(data.length > 0){
					var $hot = $('#hot');
					$hot.html('');
					$.each(data, function(index, i){

						if(i.materialAmount > 0){
						var $ul = $('<ul class="coffeelist">')
						var $li = $('<li class="coffeelist2">')
						var $menuImg = "<li class='coffeelist2'><img src='resources/materialuploadFiles/" + i.rename_filename + "'>";
						var $input = $('<input type="checkbox" name="mCheck" id="mCheck" value="'+i.stock_num + '">');
						var $mName = $('<label></label>').text(i.materialName);
						var $price = $('<p></p></div></li>').text(i.materialprice + " won");
							
						$li.append($menuImg);
						$li.append($input);
						$li.append($mName);
						$li.append($price);
						$ul.append($li);
						$hot.append($ul);

						}
					});
				}else{
					var $hot = $('#hot');
					$hot.html('');
					var $ul = $('<ul class="coffeelist">');
					var $li = $('<li class="coffeelist2">');
					var $msg = $('<span>').text("준비된 메뉴가 없습니다!");
					$li.append($msg);
					$ul.append($li);
					$hot.append($ul);
				}
			}
		});
	})
	
	function btnclick() {
		var store_num = ${ store_num };
		var select_stockNum = new Array();
		var m_id = $('.m_id').val();
		$('input:checkbox[name="mCheck"]:checked').each(function (index) {
			select_stockNum.push($(this).val());
			
			$('.mNum').val(select_stockNum);
		});
		
		if(select_stockNum.length != 0){
			if(confirm("메뉴를 담았습니다. 바로 주문하시겠습니까?")){
				location.href="soCartInsertGo.cf?select_stockNum="+select_stockNum+"&m_id="+m_id + "&store_num=" + store_num;
			} else{
				alert("메뉴를 담았습니다.");
				location.href="soCartInsertBack.cf?select_stockNum="+select_stockNum+"&m_id="+m_id + "&store_num=" + store_num;
			}
		} else{
			alert("메뉴를 선택해주세요.");
		}
	}
	
	function soOrder() {
		var store_num = ${ store_num };
		var select_stockNum = new Array();
		var m_id = $('.m_id').val();
		var store_num = $('.store_num').val();
		$('input:checkbox[name="mCheck"]:checked').each(function (index) {
			select_stockNum.push($(this).val());
			
			$('.mNum').val(select_stockNum);
		});

		if(select_stockNum.length != 0){
			if(confirm("주문 하시겠습니까?")){
				location.href="soCartInsertGo.cf?select_stockNum="+select_stockNum+"&m_id="+m_id + "&store_num=" + store_num;
			} else{
				return false;
			}
		} else {
			alert("메뉴를 선택해주세요.");
		}
	}
</script>
</body>
</html>