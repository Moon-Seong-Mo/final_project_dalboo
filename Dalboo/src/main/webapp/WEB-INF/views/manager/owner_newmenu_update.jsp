<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>달보드레 | 신메뉴 개발</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/owner/owner_newmenu_update.css">

</head>
<body>
   <%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp" %>
   <div id="wrap">
      <%@ include file="/WEB-INF/views/common/ownerPageNav.jsp" %>
      <div id="section">
         <div id="deveolop_register_area">
         <br>
         <h2>레시피 게시글 수정</h2>
         <hr>
            <form action="owner_newmenu_update.ow" method="post" enctype="multipart/form-data">
            <div id="head-div">
                <input type="text" id="title" name="onmTitle" value="${ s.onmTitle }">
                 <input type="text" id="storeName" name="storeName" value="${ s.storeName }" readonly >
                 <input type="hidden" name="onmNum" value="${ s.onmNum }">
                 <span id="board-date">작성일 : ${ s.createDate }</span>
            </div>
            <div id="table-area">
            <table id="deveolop_register">
               <tbody>
               <% int num = 1;%>
               <c:forEach var="f" items="${ f }">                     
               <tr class="table-tr">
                  <td width="800" colspan="2">
                     <div class="contentFormArea">
                        <input type="file" id="thumbnailImg<%= num %>" multiple="multiple" name="reuploadFile" onchange="LoadImg(this,<%= num %>)" >
                        <img id="contentImg<%= num %>" class="imgs" width="250" height="240" border="0" onclick="imgSelect(this)" src="resources/nMUploadFiles/${f.changeName }">                        
                        <input type="hidden" id="numStack<%= num %>" value="<%= num %>">
                        <input type="hidden" class="fNum" id="fileNumber<%= num %>" name="fileNum" value="${ f.owFileNum }">               
                        <textarea class="contentArea" name="contentText" cols="60" rows="10" spellcheck="false" required>${f.contentText }</textarea>
                        <span class="deleteFormBtn" onclick="deleteForm(this);">X</span>
                     </div>
                  </td>
                  <% num++; %>
               </tr>
            </c:forEach>
            </tbody>
            
            </table>
            </div>
            <div id="btnArea">
                  <input type="button" class="bt2" id="cancel" value="취소">
               <input type="submit" class="bt2" id="register" value="수정">
               <input type="button" class="bt2" id="addFormBtn" value="입력 폼 추가">
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
                  var con = confirm("수정하시겠습니까?");
                     if(con){
                           var chkTitle = $('#title');
                        var file = $('#thumbnailImg1');
                        var text = $('#contentArea1');
                               if(!$('#title').val()){
                                 alert('제목을 입력해주세요.');
                                 chkTitle.focus();
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
         var num =<%= num %>-1;
            $(function(){
               $('#addFormBtn').click(function(){
                  
                  num = Number($("#numStack"+num).val());   
                  console.log(num);
                  i = num + 1;
                  
                  var $tr = $('<tr class="table-tr">');
                  var $td1 = $("<td>");
                  var $div = $('<div class="contentFormArea">');
                  
                  var $img = $('<img id="contentImg'+ i +'"  class="imgs" width="250" height="240" border="0" onclick=imgSelect(this);>');
                  var $textArea = $('<textarea class="contentArea1" name="contentText" cols="60" rows="10" required placeholder="예) 물을 150ml 준비해주세요."></textarea>');
                  var $deleteBtn = $('<span class="deleteFormBtn" onclick="deleteForm(this);">X</span>');
                  var $fileNum = $('<input type="hidden" class="fNum"  id="fileNumber'+ i +'" name="fileNum" value="0">');
                  var $hidden = $('<input type="hidden" id="numStack'+ i +'" value="'+ i +'">');
                  var $file = $('<input type="file" id="thumbnailImg'+ i +'" multiple="multiple" name="reuploadFile" onchange="LoadImg(this,'+ i +')">');
                  
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
                  var fNum = $(bt).prev().prev().val();
                  form.remove();
                   $.ajax({
                          url: 'deleteNewMenuFile.ow',
                          data: {fNum:fNum}
                          
                          });
               }else{
                  return false;
               }
            
            }
            $(function(){
               $('#cancel').click(function(){
               var onmNum = ${s.onmNum };
               console.log(onmNum);
                $.ajax({
                       url: 'cancelUpdateRollback.ow',
                       data: {onmNum:onmNum }
                       
                       
                 });
                history.back();
               });
            });
            </script>
      
</body>
</html>