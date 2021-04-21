<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 오시는 길</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<style>


div#howtofind {
    width: 1200px;
    margin-top:150px;
    margin-left:auto;
    margin-right:auto;
}
h1{ margin-bottom:50px;}

table {
    border-collapse: collapse;
    font-size: 17px;
}

th{padding:10px;}

.trafficTable{float:left; margin-left:60px; color:#555;}
.imgTraffic{width:60px;  margin-right:20px;}
.trafficP{color:gray; font-size:13px;}
.noP{display:inline; font-size: 13px;}





</style>
</head>
<body>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp"%>

		<div id="content">

			<div id="howtofind" align="center">
				<h1>달보드레 본점</h1>
				<p><label style="color:rgb(227, 189, 152);">▶</label> 주소 : 서울특별시 강남구 테헤란로 14길 6 남도빌딩 2F, 3F, 4F, 5F, 6F</p>
				<p><label style="color:rgb(227, 189, 152);">▶</label> 대표번호 : 02-111-2222 가맹상담전화: 02-3333-4444 고객센터: 1544-1234</p>
				
				<div id="map" style="width: 1000px; height: 500px;"></div>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	ab873c361e31b13e2932f925a58bd487"></script>
				<script>
				var mapContainer = document.getElementById('map'), 
				    mapOption = { 
				        center: new kakao.maps.LatLng(37.49902124688196, 127.03280121608532), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };
				
				var map = new kakao.maps.Map(mapContainer, mapOption); 
				
				// 마커 위치
				var markerPosition  = new kakao.maps.LatLng(37.49902124688196, 127.03280121608532); 
				
				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    position: markerPosition
				});
				
				marker.setMap(map);
				
				// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
				// marker.setMap(null);    
				</script>
				
				
				<div align="center" style="min-height:200px; margin-top:50px; margin-bottom:50px;">
					<table class="trafficTable">
						<tr>
							<td rowspan="4"><img src="${ contextPath }/resources/images/bus.png" class="imgTraffic"></td>
						</tr>
						<tr>
							<td>
								<b>버스를 이용하실 경우</b>
								<p class="trafficP">역삼역.포스코P&S타워 정류장 하차</p>
							</td>
						</tr>
						<tr>
							<td>
								<img src="${ contextPath }/resources/images/green.png" style="border-radius: 5px; height:20px;" align="middle">
								<p class="noP">146 / 740 / 341 / 360 </p>
							</td>
						</tr>
						<tr>
							<td>
								<img src="${ contextPath }/resources/images/blue.png" style="border-radius: 5px; height:20px;" align="middle">
								<p class="noP">1100 / 1700 / 2000 / 7007 / 8001 </p>
							</td>
						</tr>
					</table>
					<br>
					<table class="trafficTable" style="margin-top:20px;">
						<tr>
							<td rowspan="2"><img src="${ contextPath }/resources/images/train.png" class="imgTraffic"> </td>
							<td><b>지하철을 이용하실 경우</b></td>
						</tr>
						<tr>
							<td><p class="trafficP">지하철 2호선 역삼역 3번출구 100m</p></td>
						</tr>
					</table>
					
					<table class="trafficTable" style="margin-top:20px;">
						<tr>
							<td rowspan="2"><img src="${ contextPath }/resources/images/car.png" class="imgTraffic"> </td>
							<td><b>승용차를 이용하실 경우</b></td>
						</tr>
						<tr>
							<td><p class="trafficP">서울특별시 강남구 테헤란로 14길 6 남도빌딩</p></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>