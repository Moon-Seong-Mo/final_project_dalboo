<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="e" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 매장</title>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/etc/store_list.css">

<!-- JQuery Modal Plugs -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">

<!-- Daum Address API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<!-- Kakao Map API & library -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a76d669609bbdc285414a8c651ed614a&libraries=services"></script>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			<div id="content">
			
			<div id="store_list_area">
			
				<br>
				<h1>매장 검색</h1>
				<hr>
				<div id="store_search">
					
					<!-- Kakao MAP API 불러오는곳 -->
					<div id="map"></div>
					
					
					
					
					
					
					<form id="place">
               
		               <h3>검색 조건</h3>
		                 <select class="searchLocation" id="searchoption" name="searchLocation" style="width:300px;height:50px;">
		                   <option value="지역">지역</option>
		                   <option value="매장명">매장명</option>
		                   <option value="주소">주소</option>
		                 </select>
		                 
		                 <br><br>
		               </form>
		               
		               <form id="shop">
		                  <div>
		                     <h3>매장 검색</h3>
		                  </div>
		                  <input type="text" class="searchT" id="searchT" name="searchT">
		                  <input type="button" onclick="searchStore();" value='검색'>
		                  <br>
		                  <b>총 <span style="font-size: 25px;">${ pi.listCount }</span>개의 매장이 있습니다.</b>
		               </form>
		               
		               <script>
		                  function searchStore(){
		                     var option = document.getElementById('searchoption').value;
		                     var Text = document.getElementById('searchT').value;
		                     if(Text == ""){
		                        if(confirm("전체 매장을 검색하시겠습니까?")){
		                           location.href='search.etc?option=' + option + '&searchText=' + Text + '&currentPage=' + ${pi.currentPage};
		                        }else{
		                           alert('취소하셨습니다.');
		                           return false;
		                        }
		                     }else {
		                        if(confirm("'"+option+"' 조건으로 매장을 검색하시겠습니까?")){
		                           location.href='search.etc?option=' + option + '&searchText=' + Text + '&currentPage=' + ${pi.currentPage};
		                        }else{
		                           alert('취소하셨습니다.');
		                           return false;
		                        }
		                     }
		                  }
		               </script>
		               </div>
					
					
					
					
					
					
					
					
					
					<fieldset>
						<div class="store">
							<table class="storeinfo">
							<colgroup>
								<col width="10%">
								<col width="25%">
								<col width="25%">
								<col width="25%">
							</colgroup>
								<thead id="head">
									<tr>
										<th scope="col" class="name">지역</th>
										<th scope="col">매장명</th>
										<th scope="col">주소</th>
										<th scope="col">전화번호</th>
										<e:if test="${ loginUser.rank_code eq 2 }">
										<th scope="col">수정 및 삭제</th>
										</e:if>			
									</tr>
								</thead>
								<tbody align ="center">
								<e:if test="${ pi.listCount gt 0 }">
									<e:forEach var="s" items="${ list }">
										
										<script>
											var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
										    	mapOption = {
											        center: new kakao.maps.LatLng(35.555142, 126.970436), // 지도의 중심좌표
											        level: 13 // 지도의 확대 레벨
										    	};
														
											// 지도를 생성한다 
											var map = new kakao.maps.Map(mapContainer, mapOption); 
														
											// 주소 좌표 변환 객체
											var geocoder = new kakao.maps.services.Geocoder();
										
											// 주소로 좌표를 검색합니다
											geocoder.addressSearch('${ s.store_address }', function(result, status) {
													
											// 	좌표 검색이 정상일 경우
												if(status == kakao.maps.services.Status.OK){
														
													var location = new kakao.maps.LatLng(result[0].y, result[0].x);
														
													// 마커 생성
													var marker = new kakao.maps.Marker({
													    map: map,
													    position: location
													});
																				        
													// 인포 윈도우 생성
													var infowindow = new kakao.maps.InfoWindow({
														content: '<div style="width:140px;text-align:center;padding:6px 0; background">${ s.store_name }</div>'
													});
													// 인포 윈도우 표시
													infowindow.open(map, marker);
														
													// 지도의 중심을 결과값을 받은 위치로 이동
													map.setCenter(location);
												}
											});
										</script>
										<tr>
											<td>${ s.store_region }</td>
											<td>${ s.store_name }</td>
											<td>${ s.store_address }</td>
											<td>${ s.store_phone }</td>
												<e:if test="${ loginUser.rank_code eq 2 }">
												<td>
												<!-- 모달창 수정 접근-->
												<a href="#stoUpdate"  rel="modal:open"  class="updateButton">수정</a>
												<!-- 매장 삭제 -->
												<form action="deletestore.etc" method="post" onsubmit="return warn();">
													<input type="hidden" value="${ s.store_num }"  class="store_num" name="deleteNum">
													<button type="submit" style="background: orangered; border-radius: 5px; padding: 3px; 
													font-size: 14px; margin-top: 6px; color: white; border: none;">삭제</button>												</form>
												</td>
												</e:if>
										</tr>
									</e:forEach>
								</e:if>
								<e:if test="${ pi.listCount le 0 }">
										<script>
											var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
										    	mapOption = {
											        center: new kakao.maps.LatLng(36.555142, 126.970436), // 지도의 중심좌표
											        level: 13 // 지도의 확대 레벨
										    	};
											// 지도를 생성한다 
											var map = new kakao.maps.Map(mapContainer, mapOption);
									    </script>
									<tr>
										<td colspan="4">등록된 매장이 없습니다.</td>
									</tr>
								</e:if>
								</tbody>
							</table>
						</div>
					</fieldset>
					
					<!-- 모달창 매장 수정 -->
					<div id="stoUpdate" class="modal">
					<form action="updatestore.etc" method="post">
						<input type="hidden" id="storeNum" name="store_num">
						<input type="hidden" name="page" value="${ pi.currentPage }">
						<div id="modal-header">매장 수정</div>
						<div id="modal-body">
							<span>지역 : </span><input type="text" id="upregion" name="store_region"><br>
							<span>매장명 : </span><input type="text" id="upname" name="store_name" readonly><br>
							<span>우편번호 : </span><input id="zonecode" type="text" value="" style="width:130px;" readonly/>
							<input type="button" style="height: 35px; width: 95px;" onClick="daumMapAPI1();" value = "주소 찾기" /><br>
							<span>상세주소 : </span><input type="text" id="upaddress" value="" name="store_address" readonly/><br>
							<span>전화번호 : </span><input type="text" id="upphone" name="store_phone"><br>
						</div>
						<input type="submit" value="update">
						<a href="#" rel="modal:close">Close</a>
					</form>
					</div>
					

					<!-- 모달창 매장 등록 -->
					<!-- <div id="stoInsert" class="modal">
					<form action="insertstore.etc" method="post">
						<div id="modal-header">매장 등록</div>
						<div id="modal-body">
							<span>지역 : </span><input type="text" id="store_region" name="store_region"><br>
							<span>매장명 : </span><input type="text" id="store_name" name="store_name"><br>
							<span>우편번호 : </span><input id="zipcode" type="text" value="" style="width:130px;" readonly/>
							<input type="button" style="height: 35px; width: 95px;" onClick="daumMapAPI2();" value = "주소 찾기" /><br>
							<span>상세주소 : </span><input type="text" id="address" value="" name="store_address" readonly/><br>
							<span>전화번호 : </span><input type="text" id="store_phone" name="store_phone"><br>
						</div>
						<input type="submit" value="insert" class="insertButton">
						<a href="#" rel="modal:close">Close</a>
					</form>
					</div> -->
					
					<!-- 모달창 등록 접근 -->
					<!-- <p><a href="#stoInsert" rel="modal:open">매장 등록</a></p> -->

					<br><br>
					
					<!-- 페이징 넣기 -->
				<div id="pagingArea" align="center">
					<c:if test="${ pi.currentPage <= 1 }">
						<button class="Btn">&lt;</button>
					</c:if>
					<c:if test="${ pi.currentPage > 1 }">
						<c:url var="before" value="store.etc">
							<c:param name="page" value="${ pi.currentPage - 1 }"/>
						</c:url>
						<button onclick='location.href="${ before }"' class="Btn">&lt;</button> &nbsp;
					</c:if>
					
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:if test="${ p eq pi.currentPage }">
							<button id="choosen" disabled>${ p }</button>
						</c:if>
						
						<c:if test="${ p ne pi.currentPage }">
							<c:url var="pagination" value="store.etc" >
								<c:param name="page" value="${ p }" />
							</c:url>
							<button onclick='location.href="${ pagination }"' class="numBtn">${ p }</button> &nbsp;
						</c:if>
					</c:forEach>
					
					<c:if test="${ pi.currentPage >= pi.maxPage }">
						<button class="Btn">&gt;</button>
					</c:if>
					<c:if test="${ pi.currentPage < pi.maxPage }">
						<c:url var="after" value="store.etc">
							<c:param name="page" value="${ pi.currentPage + 1 }" />
						</c:url> 
						<button onclick='location.href="="${ after }"' class="Btn">&gt;</button>
					</c:if>
				</div>
				
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>

<script>
// Daum Address API(수정)
function daumMapAPI1() {
	new daum.Postcode({
		oncomplete:function(data) {
			jQuery("#zonecode").val(data.zonecode); // 우편번호를 불러온다.
			jQuery("#upaddress").val(data.address); // 우편번호에 따른 주소를 불러온다.
		}
	}).open();
}
// Daum Address API(등록)
function daumMapAPI2() {
	new daum.Postcode({
		oncomplete:function(data) {
			jQuery("#zipcode").val(data.zonecode); // 우편번호를 불러온다.
			jQuery("#address").val(data.address); // 우편번호에 따른 주소를 불러온다.
		}
	}).open();
}

function warn(){
	if(confirm("매장을 폐점처리 하시겠습니까?")){
		return true;
	} else{
		return false;
	}
}

	function coffeeorder(){
		alert("준비중 입니다.");
		// 사이렌 오더로 연결할 예정(store_num을 넘기고 store_num을 통해 매장명 or 매장주소를 받아 결제에 사용)
	}

$(".updateButton").on("click", function() {
	var storeNum = $(this).parent().find(".store_num").val();
	$.ajax({
		url: "selectstore.etc",
		data: {store_num : storeNum},
		success : function(data){
			console.log(data);
			
			$('#storeNum').val(data.store_num);
			$('#zonecode').val("");
			$('#upregion').val(data.store_region);
			$('#upname').val(data.store_name);
			$('#upaddress').val(data.store_address);
			$('#upphone').val(data.store_phone);
			
		}
	});

	return;
});
</script>
</html>