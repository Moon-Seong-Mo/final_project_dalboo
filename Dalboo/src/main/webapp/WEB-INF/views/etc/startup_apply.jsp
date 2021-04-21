<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 창업신청</title>
<style>
   
</style>
</head>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/etc/startup_apply.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<body>
<div class="wrap">
      <%@ include file="/WEB-INF/views/common/nav.jsp" %>
      <div id="content">
   
   <!-- 여기까지 -->
         <br>
         <h2>창업 신청</h2>
         <strong>|</strong>
         <div id="com-info">
            <h4 class="info-area">1. 달보드레 창업 상담번호 02-123-123 &nbsp;&nbsp; 달보드레 창업문의번호 02-123-1234 &nbsp;&nbsp;  상담시간 10:00 ~ 19:00[평일]</h4>
            <h4 class="info-area">2. 내용 / 창업 희망 지역작성 TIP</h4>
            <h5 class="info-area">&nbsp;&nbsp;&nbsp;&nbsp;1. 창업 희망 지역(시/구/동) 구체적으로 작성하여 주시면 정확하고 빠른 상담이 가능합니다.</h5>
            <h5 class="info-area">&nbsp;&nbsp;&nbsp;&nbsp;2. 점포 보유 시 : 주소, 점포의 층, 전욕 면적, 임대 조건 등을 기재해 주시기 바랍니다.</h5>
         </div>
         
         <form action="startupApply.etc"  id=applyForm method="post">
            <table id="Apply-table">
               <tr>
                  <td width="200px"><strong>제목</strong></td>
                  <td><input type="text" id="title" name="sTitle" placeholder="제목을 입력해주세요.(ex 강남점에 창업을 하고 싶습니다.)"></td>
               </tr>
               <tr>
                  <td><strong>이름</strong></td>
                  <td><input type="text" id="name" name="sName" placeholder="이름을 입력해주세요."></td>
               </tr>
               <tr>
                  <td><strong>휴대폰</strong></td>
                  <td><input type="tel" id="phone" name="sPhone" placeholder="휴대폰 번호를 '-'제외하고 입력해주세요 "></td>
               </tr>
               <tr>
                  <td><strong>이메일</strong></td>
                  <td><input type="email" id="email" name="sEmail" placeholder="이메일을 입력해주세요."></td>
               </tr>
               <tr>
                  <td><strong>매장명</strong></td>
                  <td><input type="text" id="store" name="storeName" placeholder="매장명을 입력해주세요.(ex 강남점)"></td>
               </tr>
               <tr>
                  <td><strong>창업 희망 지역</strong></td><!-- 주소API -->
                  <td>
                     <input type="text" id="zipcode"  name="post" placeholder="우편번호">
                     <input type="button" onclick="daumMapAPI2()" value="주소 찾기"><br>                  
                  </td>
               <tr>
                  <td><strong>도로명 주소</strong></td>
                  <td><input type="text" id="address" name="address1" placeholder="도로명주소"></td>
               </tr>
               
               <tr>
                  <td><strong>내용 / 창업 계획</strong></td>
                  <td><textarea cols="50" rows="10" id="ApplyContent" name="sContent" placeholder="내용을 입력해주세요" style="resize: none;"></textarea></td>
               </tr>
               <tr>
                  <td colspan="2" width=100%><input type="checkbox" name="sConfirm" id="chk" value="Y">개인정보 취급방침 약관에 동의</td>             
               </tr>
            </table>
            
            <input id="sbm-btn"type="submit" onclick="return validate();" value="보내기">
            <input id="res-btn" type="reset" value="취소">
         </form>
      </div>
   </div>
      <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
      <script>
      function daumMapAPI2() {
            new daum.Postcode({
               oncomplete:function(data) {
                  jQuery("#zipcode").val(data.zonecode); // 우편번호를 불러온다.
                  jQuery("#address").val(data.address); // 우편번호에 따른 주소를 불러온다.
               }
            }).open();
         }
      </script>
      <script>
      $("#chk").click(function(){
      if($("#chk:checked").length == 1){
         $("#chk").prop("checked", true);
      } else {
         $('#chk').prop("checked", false);
      }
      });
      
      
      
      function validate(){
       var title = $('#title').val();
       var name = $('#name').val();
       var email = $('#email').val();
       var phone = $('#phone').val();
       var store = $('#store').val();
       var address = $('#address').val();
       var contentArea = $('#ApplyContent').val();
         if(title ==""){
            alert('제목을 입력해주세요.');
            return false;
         }else if(name ==""){
            alert('이름을 입력해주세요.');
            return false;
         }else if(phone ==""){
            alert('전화번호를 입력해주세요.');
            return false;
         }else if(email ==""){
            alert('이메일을 입력해주세요.');
            return false;
         }else if(store ==""){
            alert('매장명을 입력해주세요.');
            return false;
         }else if(address ==""){
            alert('주소를 입력해주세요.');
            return false;
         }else if(contentArea ==""){
            alert('내용을 입력해주세요.');
            return false;
         }else if($("#chk").is(":checked") == false){
           alert("수집 동의에 체크를 해주세요");
           return false;
        }else{
           $('#applyForm').submit();
        }
      }
      
      </script>
      
      
      
   <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>