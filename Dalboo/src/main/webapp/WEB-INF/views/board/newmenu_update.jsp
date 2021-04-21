<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 신메뉴</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/board/newmenu_update.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
</head>
<style>
   .imgs{
      border: dashed;
      border-radius:5px;
   }
   .textarea-cl{
      border-radius:5px;
   }
</style>
<body>
<div class="wrap">
      <%@ include file="/WEB-INF/views/common/nav.jsp" %>
      <div id="content">
   
   <!-- 여기까지 -->
      <br>
      <h2>신메뉴 게시판 수정폼</h2>
      <div class="outer">
         <form action="newMenuUpdate.bo" method="post" enctype="multipart/form-data">
            <div class="detailArea">            
               <table id="tableArea">
               <thead>
                  <tr id="first-tr"> 
                     <td id="title">
                        <strong>제목: </strong><input type="text" id="Boardtitle" name="title" value="${board.title }"required>
                        <input type="hidden" name="nNum" value="${ board.nNum }">
                                                
                     </td>                           
                     <td id="date">
                        <strong align="right">${board.createDate }</strong> 
                     </td>
                     <td id="count">
                        <strong  align="right">조회수 ${board.views }</strong> 
                     </td>
                  </tr>
                  <tr>
                     <td colspan="3">
                           <textarea class="textarea-cl2" id="subtitle" name="subTitle" cols="50" rows="10" required>${board.subTitle}</textarea>

                     </td>
                  </tr>
                  </thead>
                  <tbody>
                  <% int num = 1;%>
                  <c:forEach var="f" items="${ f }">
                     <tr class="table-tr">
                        <td colspan="3">
                              <div class="check-menu">
                                 <div class="contentImgArea">
                                    <input type="file" id="thumbnailImg<%= num %>" multiple="multiple" class="reuploadFile"  name="reuploadFile" onchange="LoadImg(this,<%= num %>)">
                                    <div style="display:inline-block;">
                                       <h2 id="menuText">메뉴 이름  </h2> <input type="text" id="menuName" name="menuName" placeholder="메뉴 이름을 입력해주세요." required value="${f.menuName }" style="display:block;">
                                       <textarea class="textarea-cl" name="contentText" cols="50" rows="10" required >${f.contentText }</textarea>
                                    </div>
                                    
                                    <input type="hidden" class="fNum" id="fileNumber<%= num %>"  name="fileNum" value="${ f.fileNum }">
                                    <input type="hidden" id="numStack<%= num %>" value="<%= num %>">
                                    <img id="contentImg<%= num %>" class="imgs" width="250" height="240" border="0" src="resources/nMUploadFiles/${f.changName }" onclick="imgSelect(this);">
                                    <span class="deleteFormBtn" onclick="deleteForm(this);">후보 삭제</span>
                                 </div>
<!--                                  <span class="deleteFormBtn" onclick="deleteForm(this);">X</span> -->
                              </div>
                              <% ++num; %>
                        </td>
                     </tr>   
                  </c:forEach>
                  
                  
                           
                  </tbody>
               </table>
               <input type="button" class="btn-cl" id="addFormBtn" value="후보 추가">
            </div>
               <div id="btnDiv" align="right">               
                  <input type="button" class="btn-cl" id="res-btn" value="취소" onclick="cancel();">
                  <input type="submit" class="btn-cl"  id="sbm-btn" value="수정">
<!--                   <input type="button" class="btn-cl" id="addFormBtn" value="입력 폼 추가"> -->
               </div>
         </form>
      </div>
   </div>
</div>
   <%@ include file="/WEB-INF/views/common/footer.jsp" %>
   
               <script>
               $(function(){
                  $('#sbm-btn').click(function(){
                     var con = confirm("수정하시겠습니까?");
                        if(con){
                              var chkTitle = $('#Boardtitle');
                              var chksubTitle = $('#subtitle');
                                  if(!chkTitle.val()){
                                    alert('제목을 입력해주세요.');
                                    chkTitle.focus();
                                    return false;
                                 }else if(!chksubTitle.val()){
                                    alert('부제목을 입력해주세요.');
                                    chksubTitle.focus();
                                    return false;
                                 }
                                                    
                        }else{
                           return false;
                        }
                  });
                  
               });
            
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
            </script>   
               
         <script>   /* 폼 추가 삭제 */   
         
         
         function imgSelect(img){
            
            var   imgNum = $(img).prev().val();
            console.log(imgNum);
             $("#thumbnailImg"+imgNum).click();
         
         }
         
         var i = ${f.size()};
         var num =0;

               $(function(){
                  $('#addFormBtn').off().on('click', function() {
                  num = Number($("#numStack"+i).val());
                  console.log(i);
                  i = num + 1;
                  $tableBody = $('#tableArea tbody');
                  var $tr = $('<tr class="table-tr">');
                  var $td1 = $("<td colspan='3'>");
                  var $div1 = $('<div class="check-menu">');
                  var $div2 = $('<div class="contentImgArea">');
                  var $div3 = $('<div style="display:inline-block;">');
                  
               
               
                  var $img = $('<img id="contentImg'+ i +'" class="imgs" width="250" height="240" border="0" onclick="imgSelect(this);">');
                  var $ipt = $('<h2  id="menuText">메뉴 이름: </h2><input type="text" name="menuName" placeholder="메뉴 이름을 입력해주세요." required style="display:block;">');
                  var $textArea = $('<textarea class="textarea-cl" name="contentText" cols="50" rows="10" placeholder="내용을 입력해주세요." required></textarea>');
                  var $deleteBtn = $('<span class="deleteFormBtn" onclick="deleteForm(this);">후보 삭제</span>');                  
                  var $fileNum = $('<input type="hidden" class="fNum"  id="fileNumber'+ i +'" name="fileNum" value="0">');
                  var $hidden = $('<input type="hidden" id="numStack'+ i +'" value="'+ i +'">');
                  var $file = $('<input type="file" id="thumbnailImg'+ i +'" multiple="multiple" class="reuploadFile" name="reuploadFile" onchange="LoadImg(this,'+ i +')">');
                  

                  $tableBody.append($tr);
                  $td1.append($div1);
                  $tr.append($td1);
                  $div2.append($file);
                  $div2.append($div3);
                  $div3.append($ipt);
                  $div3.append($textArea);
                  $div2.append($fileNum);
                  $div2.append($hidden);                  
                  $div2.append($img);
                  $div2.append($deleteBtn);
                  $div1.append($div2);
                  
                  }); 
                  
                  
               });
            
         
            
               function deleteForm(bt){
                        
                        var con = confirm('삭제하시겠습니까?');
                        
                        if(con){
                           var form = $(bt).parents('.table-tr');
                           var fNum = $(bt).prev().prev().prev().val();
                           form.remove();
                            $.ajax({
                                   url: 'deleteVoteMenu.bo',
                                   data: {fNum:fNum}
                                   
                                });
                        }else{
                           return false;
                        }
                     
                     }
            
            function cancel(){
               
               var nNum = ${board.nNum};
                $.ajax({
                       url: 'cancelUpdateRollback.bo',
                       data: {nNum:nNum}
                       
                       
                 });
                history.back();
            }
            </script>
               
</body>
</html>