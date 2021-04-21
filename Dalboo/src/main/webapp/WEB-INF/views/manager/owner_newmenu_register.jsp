<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>달보드레 | 신메뉴 개발</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/owner/owner_newmenu_register.css">
</head>
<body>
   <%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp" %>
   <div id="wrap">
      <%@ include file="/WEB-INF/views/common/ownerPageNav.jsp" %>
      <div id="section">
         <div id="deveolop_register_area">
         <br>
         <h2>레시피 작성</h2>
         <hr>
            <form action="owner_newmenu_insert.ow" method="post" enctype="multipart/form-data">
            <div id="header-div">
               <h2 id="title-text">제목 :</h2><input type="text" id="title" name="onmTitle" placeholder="제목을 입력해주세요" required>
               <input type="hidden" id="storeName" name="storeName" value="${ loginUser.store_name }">
            </div>
            <div id="table-div">
            <table id="deveolop_register">
               <tbody>                     
               <tr class="table-tr">
                  <td>
                     <div class="contentFormArea">
                        <input type="file" id="thumbnailImg1" multiple="multiple" name="uploadFile" onchange="LoadImg(this,1)" required>
                        <img id="contentImg1" class="imgs" width="250" height="240" border="0" onclick="imgSelect(this);">
                        <input type="hidden" id="numStack1" value="1">
                        <input type="hidden" class="fNum" id="fileNumber1" value="">               
                        <textarea class="contentArea" id="contentArea1" name="contentText" cols="60" rows="10" required placeholder="예) 물을 150ml 준비해주세요."></textarea>
                        <span class="deleteFormBtn" onclick="deleteForm(this);">X</span>
                     </div>
                  </td>
               </tr>
            </tbody>
            
            </table>
            </div>   
            <div id="btnArea">
                  <input type="button" id="cancel" value="취소"  onclick="history.back(-1);">
               <input type="submit" id="register" value="등록">
               <input type="button" id="addFormBtn" value="입력 폼 추가">
            </div>
         </form>
         
      </div>
     </div> 
   </div>
   
             <script>
               
               // 각각의 영역에 파일을 첨부 했을 경우 미리 보기가 가능하도록 하는 함수
               function LoadImg(value, num){
                  if(value.files && value.files[0]){
                     var reader = new FileReader();
                     
                     reader.onload = function(e){
                        
                        
                           $("#contentImg"+num).attr("src", e.target.result);
                     }                     
                     reader.readAsDataURL(value.files[0]);                        
                  }
               } 
               
               $(function(){
               $('#register').click(function(){
                  var con = confirm("등록하시겠습니까?");
                     if(con){
                           var chkTitle = $('#title');
                        var file = $('#thumbnailImg1');
                        var text = $('#contentArea1');
                               if(!$('#title').val()){
                                 alert('제목을 입력해주세요.');
                                 chkTitle.focus();
                                 return false;
                              }else if(!file.val()){
                                 alert('이미지를 선택해주세요.');
                                 file.focus();
                                 return false;
                              }else if(!text.val()){
                                 alert('레시피 설명을 입력해주세요.');
                                 text.focus();
                                 return false;
                              }
                                                 
                     }else{
                        return false;
                     }
               });
            });
            </script>            
      
         
            
                        
         <script>         
         var i = 1;
         var num =0;
            $(function(){
               $('#addFormBtn').click(function(){
                  num = Number($("#numStack"+i).val());   
                  console.log(num);
                  i = num + 1;
                  
                  var $tr = $('<tr class="table-tr">');
                  var $td1 = $("<td>");
                  var $div = $('<div class="contentFormArea">');
                  
                  var $img = $('<img id="contentImg'+ i +'"  class="imgs" width="250" height="240" border="0" onclick=imgSelect(this);>');
                  var $textArea = $('<textarea class="contentArea1" name="contentText" cols="60" rows="10" placeholder="예) 물을 150ml 준비해주세요." required></textarea>');
                  var $deleteBtn = $('<span class="deleteFormBtn" onclick="deleteForm(this);">X</span>');
                  var $fileNum = $('<input type="hidden" class="fNum"  id="fileNumber'+ i +'" name="fileNum" value="">');
                  var $hidden = $('<input type="hidden" id="numStack'+ i +'" value="'+ i +'">');
                  var $file = $('<input type="file" id="thumbnailImg'+ i +'" multiple="multiple" name="uploadFile" onchange="LoadImg(this,'+ i +')" required>');
                  
                  $fileDiv = $('#fileArea');
                  $tableBody = $('#deveolop_register tbody');

                  $tableBody.append($tr);
                  $tr.append($td1);
                  $td1.append($div);
                  $div.append($file);
                  $div.append($img);
                  $div.append($hidden);
                  $div.append($fileNum);
                  $div.append($textArea);
                  $div.append($deleteBtn);                     
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
            </script>
      
</body>
</html>
