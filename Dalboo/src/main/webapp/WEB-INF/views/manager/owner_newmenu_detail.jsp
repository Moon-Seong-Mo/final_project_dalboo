<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>달보드레 | 신메뉴 개발</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/owner/owner_newmenu_detail.css">
</head>
<body>
   <%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp" %>
   <div id="wrap">
      <%@ include file="/WEB-INF/views/common/ownerPageNav.jsp" %>
      <div id="section">
         <br>
       <h2>신메뉴 개발</h2>
       <hr>
        <div id="newmenu_detail_area">
        <form action="ownerNewMenuUpdateView.ow" method="post" enctype="multipart/form-data">
             <div id="table-area-div1">
                <input type="text" id="title" name="onmTitle" value="${ s.onmTitle }">
              <input type="text" id="storeName" name="storeName" value="${ s.storeName }">
               <span id="board-views">조회수: ${s.onmViews }</span>
               <span id="board-date">${ s.createDate }</span>
               
            </div>
            <div  id="table-area-div2">
             <table id="deveolop_register">
               
               <tbody>
               <c:forEach var="f" items="${ f }">                     
               <tr class="table-tr" style="border:none;">
                  <td width="800" colspan="2" style="border:none;">
                     <div class="contentFormArea" style="border:none;">
                        <input type="file" id="thumbnailImg1" multiple="multiple" name="uploadFile" onchange="LoadImg(this,1)" value="${f.originalName }">
                        <div class="recipe-div">
                           <img id="contentImg1" class="imgs" width="250" height="240" border="0" onclick="imgSelect(this);" src="resources/nMUploadFiles/${f.changeName }">                        <input type="hidden" class="fNum" id="fileNumber1" value="1">               
                           <textarea class="contentArea" name="contentText" cols="60" rows="10" spellcheck="false">${f.contentText }</textarea>
                        </div>
                     </div>
                  </td>
               </tr>
            </c:forEach>
            </tbody>
            
            </table>
            
            </div>
               <div id="btnArea">
<%--             <c:if test="${!empty sessionScope.loginUser  && loginUser.rank_code eq '2'}"> --%>
            <c:if test="${loginUser.rank_code eq '2' || loginUser.store_name eq s.storeName}">
               <input type="button" id="delete" class="bt2" value="삭제">
             </c:if>
             
             <c:if test="${loginUser.store_name eq s.storeName }">
               <input type="button" id="update" class="bt2"  value="수정">
        	 </c:if>
               <input type="button" id="list" class="bt2" value="목록으로" onclick="location.href='owner_newmenu_list.ow'">
             </div>
        </form>
      </div>
     </div> 
   </div>
   
   <script>
         $(function(){
            $('#delete').click(function(){
               var con = confirm("정말 삭제하시겠습니까?");
            if(con){
            var onmNum = ${s.onmNum}
            
            location.href='deleteOwnerNewMenu.ow?onmNum=' + onmNum;
            }else{
               return false;
            }   
            });
         });
         
         $(function(){
         $('#update').click(function(){
               var con = confirm("수정 페이지로 이동하시겠습니까?");
               if(con){
               var onmNum = ${s.onmNum}
               
               location.href='ownerNewMenuUpdateView.ow?onmNum=' + onmNum;
               }else{
                  return false;
               }
         });
      });

   </script>
</body>
</html>