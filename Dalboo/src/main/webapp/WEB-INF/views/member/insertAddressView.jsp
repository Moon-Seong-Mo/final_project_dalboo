<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 배송지 추가</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	hr{margin-bottom:30px;}
	table{padding:10px;}
	input[type="text"]{width:280px; height:30px;}
	.Btn {
		border: 0px;
		background-color: rgb(244, 244, 244);
		width: 50px;
		height: 30px;
		border-radius: 5px;
	}
	.orangeBtn {
		border: 0px;
		background-color: rgb(227, 189, 152);	
		width: 50px;
		height: 30px;
		border-radius: 5px;
	}
	#btnArea{float:right; margin-right:30px; margin-top:20px;}

	
</style>
</head>
<body>

	<h2 align="left">배송지 추가</h2>
	<hr>
	<form action="insertAddress.me" method="post" name="insertAdd" onsubmit="return send(this)">
		<div align="left">
			<table>
				<tr>
					<td width="100px;">배송지</td>
					<td><input type="text" name="adName" style="width:150px;" required></td>
				</tr>		
				<tr>
					<td>수령인</td>
					<td><input type="text" name="adReceiver" style="width:150px;" required></td>
				</tr>		
				<tr>
					<td>우편번호</td>
					<td>
						<input type="text" id="postal" name="postal" readonly>
						<input type="button" id="findPostal" class="Btn" onclick="ifindPostal();" value="검색">
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" id="address1" name="address1" required></td>
				</tr>
				<tr>
					<td>상세주소</td>
					<td><input type="text" id="address2" name="address2" required></td>
				</tr>	
				<tr>
					<td>연락처</td>
	               	<td>
	               		<div>
		                  	<select name="phone1" id="phone1" style="width:80px; height:30px">
		                       <option>010</option>
		                       <option>011</option>
		                       <option>016</option>
		                       <option value="direct">직접입력</option>
		                   </select>
							-
	                  		<input type="text" maxlength="4" size="4" name="phone2" id="phone2" required style="width:70px; height:25px">
							-
	                	   <input type="text" maxlength="4" size="4" name="phone3" id="phone3" required style="width:70px; height:25px">
	               		</div>
	               </td>
				</tr>		
			</table>
		</div>
		<div id="btnArea">
			<input type="button" value="취소" class="Btn" onclick="window.close()">
			<input type="submit" value="등록" class="orangeBtn">
		</div>
	</form>
	
	<script>
		function ifindPostal() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if (data.buildingName !== '' && data.apartment === 'Y') {
	                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if (extraRoadAddr !== '') {
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postal').value = data.zonecode;
	                document.getElementById("address1").value = roadAddr;
					document.getElementById("address2").value = "";
	
	                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	                if (roadAddr !== '') {
	                    document.getElementById("address1").value += extraRoadAddr;
	                } else {
	                    document.getElementById("address1").value += '';
	                }
	            }
	        }).open();
	    }
		
		
		function send(form){
			var postal = document.getElementById("postal").value;
			
			if(postal == "" || postal.length == 0){
				alert("검색 버튼을 눌러 우편번호를 찾아주세요");
				return false;
			}
		}
		
	</script>
</body>
</html>