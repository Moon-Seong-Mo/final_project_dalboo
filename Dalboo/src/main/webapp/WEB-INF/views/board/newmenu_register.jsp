<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 신메뉴</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/board/newmenu_register.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<style>
   .imgs{
      border: dashed;
      border-radius:5px;
   }
   .textarea-cl{
      border-radius:5px;
   }
</style>
</head>
<body>
<div class="wrap">
      <%@ include file="/WEB-INF/views/common/nav.jsp" %>
      <div id="content">
   
   
   <!-- 여기까지 -->
      <br>
      <h2>신메뉴 게시판 작성</h2>
      <div class="outer">
         <form action="newMenuinsert.bo" method="post" id=registerForm enctype="multipart/form-data" onsubmit="return validate();">
            <div class="detailArea">            
               <table id="tableArea"> 
                  
                  <thead>
                     <tr class="table-tr">
                        <td align="left"> 
                           <strong>제목 </strong>                      
                           <input type="text" id="title" name="title" value="" placeholder="제목을 입력해주세요." required> 
                        </td>
                        
                        
                        
                        
                        <td>
                           <b>투표 마감시간</b>
                           <input type="datetime-local" name="votEndDate" id="chk" required/>
                        </td>   
                              
                     </tr>
                     
            
                     
                     <tr>
                        <td align="left" colspan="2" >
                           <strong>작성자 &nbsp;</strong> <input type="text" name="mId" readonly value="${ loginUser.id }" style="background: lightgrey; display:block;">
                        </td>
                     </tr>
                     <tr>
                        <td colspan="2">
                           <textarea id="subtitle"  name="subTitle" cols="20" rows="5" id="subtitle" placeholder="부제목을 입력하세요." required></textarea>
                        </td>
                        
                     </tr>
                  
                  </thead>
                  <tbody>                     
                     <tr class="table-tr">
                        <td>
                           <div class="contentImgArea">
                           <input type="file" id="thumbnailImg1" multiple="multiple" name="uploadFile" onchange="LoadImg(this,1)" required>
                              <img id="contentImg1" class="imgs" width="250" height="240" border="0" onclick="imgSelect(this);">
                              <input type="hidden" class="fNum" id="fileNumber1" value="1">
                           </div>
                        </td>
                        <td>
                           <input type="text" id="menuName" class="menuname" name="menuName" placeholder="메뉴 이름을 입력해주세요." required>
                           <textarea class="contentArea" id="contentArea1" name="contentText" cols="60" rows="10" placeholder="내용을 입력해주세요." required></textarea>
                        </td>
                        <td>
                        </td>
                     </tr>
                  </tbody>
               </table>
            </div>
               
          <input type="button" id="addFormBtn" value="후보추가">
            <div id="btnDiv" align="right">               
                  <input type="button" id="res-btn" value="취소" onclick="history.back(-1);">
                  <input type="submit" id="sbm-btn" value="등록">
                  
            </div>   
            <!-- <script>
               // 내용 작성 부분의 공간을 클릭할 때 파일 첨부 창이 뜨도록 설정하는 함수
               
               });
               -->
                <script>
               
               // 각각의 영역에 파일을 첨부 했을 경우 미리 보기가 가능하도록 하는 함수
               function LoadImg(value, num){
                  if(value.files && value.files[0]){
                     var reader = new FileReader();
                     
                     reader.onload = function(e){
                        
                        
                           $("#contentImg"+num).attr("src", e.target.result);
                        
                     /*     switch(num){
                        case 1:
                           $("#contentImg1").attr("src", e.target.result);
                           break;
                        case 2: 
                           $("#contentImg2").attr("src", e.target.result);
                           break;
                        case 3:
                           $("#contentImg3").attr("src", e.target.result);
                           break;
                        } */
                     }                     
                     reader.readAsDataURL(value.files[0]);                        
                  }
               }                
            </script>            
         </form>
        
                        
         <script>
         
         var i = 1;
         var num =0;
            $(function(){
               $('#addFormBtn').click(function(){
                  num = Number($("#fileNumber"+i).val());                  
                  i = num + 1;
                  
                  var $tr = $('<tr class="table-tr">');
                  var $td1 = $("<td>");
                  var $td2 = $("<td>");
                  var $td3 = $("<td>");
                  var $div = $('<div class="contentImgArea">');
                  
                  var $img = $('<img id="contentImg'+ i +'"  class="imgs" width="250" height="240" border="0" onclick=imgSelect(this);>');
                  
                  var $ipt = $('<input type="text" name="menuName" class="menuname"  placeholder="메뉴 이름을 입력해주세요." required>');
                  var $textArea = $('<textarea class="contentArea" name="contentText" cols="60" rows="10" placeholder="내용을 입력해주세요." required></textarea>');
                  
                  var $deleteBtn = $('<span class="deleteFormBtn" onclick="deleteForm(this);">후보 삭제</span>');
                  var $hidden = $('<input type="hidden" class="fNum"  id="fileNumber'+ i +'" value="'+ Number(i) +'">');
                  var $file = $('<input type="file" id="thumbnailImg'+ i +'" multiple="multiple" name="uploadFile" onchange="LoadImg(this,'+ i +')" required>');
                  $fileDiv = $('#fileArea');
                  $tableBody = $('#tableArea tbody');
                  
                  
                  $div.append($file);
                  $div.append($img);
                  $div.append($hidden);
                  $td1.append($div);
                  
                  $td2.append($ipt);
                  $td2.append($textArea);
                  
                  $td2.append($deleteBtn);
                  
                  $tr.append($td1);
                  $tr.append($td2);
                  $tableBody.append($tr);
                  
                  
            
                                    
               }); 
               
               
            });
            
         
            function imgSelect(img){
               
                  var   imgNum = Number($(img).next().val());
                  console.log(imgNum);
                   $("#thumbnailImg"+imgNum).click();
               
            }
            function deleteForm(bt){
               
               var con = confirm('삭제하시겠습니까?');
               
               if(con){
                  var form = $(bt).parents('.table-tr');
                  form.remove();
                  
               }else{
                  return false;
               }
            
            }
            
            function chk(){
               var chkDate = $('#chk').val();
               console.log(chkDate);
               if(chkDate != ""){
                  return true;
               }else if(chkDate == ""){
                  return false;
               }
               
            }
            
            
            $(function(){
               $('#sbm-btn').click(function(){
                           var chkDate = $('#chk');
                           var chkTitle = $('#title');
                           var chksubTitle = $('#subtitle');
                           
                           var chkmenuName = $('#menuName');
                           var chkText = $('#contentArea1');
                           var chfile = $('#thumbnailImg1');
                         if(confirm('등록하시겠습니까?')){
                            if(!$('#chk').val()){
                                  alert('마감시간을 입력해주세요.');
                                  chkDate.focus();
                                 return false;
                              }else if(!$('#title').val()){
                                 alert('제목을 입력해주세요.');
                                 chkTitle.focus();
                                 return false;
                              }else if(!$('#subtitle').val()){
                                 alert('부제목을 입력해주세요.');
                                 chksubTitle.focus();
                                 return false;
                              }else if(!chkmenuName.val()){
                                 alert('메뉴 이름을 입력해주세요.');
                                 chkmenuName.focus();
                                 return false;
                              }else if(!chkText.val()){
                                 alert('메뉴 설명을 입력해주세요.');
                                 chkText.focus();
                                   return false;
                              }else if(!chfile.val()){
                                 alert('이미지를 선택해주세요.');
                                 chfile.focus();
                                   return false;
                              }
                                 return true;
                           }else{
                              return false;
                           }
                     });
                  });
                  
            </script>
            
            
            
            
      </div>
      
   </div>
</div>
   <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>