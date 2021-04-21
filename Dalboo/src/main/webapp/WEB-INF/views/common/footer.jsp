<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
</head>
<body>
	
	<div class="footer">
	
	<div class="line"></div>
         <img id="bottom_logo" src="<%= request.getContextPath() %>/resources/images/dalboofooter.png" width="250px">
         <div id="notice">
            (주) 달보드레 대표 홍길동<br>
            주소: 서울시 강남구 테헤란로 KH정보교육원 5~6층 팩스: 02-111-2222<br>
            본사 대표전화: 02-111-2222 가맹상담전화: 02-3333-4444 고객센터: 1544-1234<br><br>
            <b>COPYRIGHTⓒ 2020, ALL RIGHTS RESERVED</b>
         </div>
         <div class="link">
            <a href="<%= request.getContextPath() %>"><img id="logo1" src="<%= request.getContextPath() %>/resources/images/instargram.png"></a>               
            <a href="<%= request.getContextPath() %>"><img id="logo2" src="<%= request.getContextPath() %>/resources/images/facebook.png"></a>               
            <a href="<%= request.getContextPath() %>"><img id="logo3" src="<%= request.getContextPath() %>/resources/images/twitter.png"></a>                  
         </div>
	</div>
</body>
</html>