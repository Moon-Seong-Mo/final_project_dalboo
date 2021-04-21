<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>달보드레</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/owner/owner_newmenu_list.css">
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> 
</head>
<body>
   <%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp" %>
   <div id="wrap">
      <%@ include file="/WEB-INF/views/common/ownerPageNav.jsp" %>
      <div id="section">
         
         <div id="develop_notice">
         <br>
         <h2>신메뉴 개발</h2>
         <hr>
         
         <table id="tb">
            <thead>
               <tr>
                  <th>No.</th>
                  <th>제목</th>
                  <th>작성자</th>
                  <th>등록일</th>
               </tr>
            </thead>
            
            <tbody>
               <c:forEach var="b" items="${ list }">
                  <tr class="tr-content">
                     <td align="center">${ b.onmNum }</td>
                     <td align="center">
                        <c:if test="${ !empty loginUser }">
                           <c:url var="onmdetail" value="onmdetail.ow">
                              <c:param name="onmNum" value="${ b.onmNum }"/>
                              <c:param name="page" value="${ pi.currentPage }"/>
                           </c:url>
                           <a href="${ onmdetail }">${ b.onmTitle }</a>
                        </c:if>
                        <c:if test="${ empty loginUser }">
                           ${ b.onmTitle }      
                        </c:if>
                     </td>
                     
                     <td align="center">${ b.storeName }</td>
                     <td align="center">${ b.createDate }</td>
                  </tr>
               </c:forEach>
            </tbody>   
         </table>
         
         <!-- 페이징  -->
            <div class="pagingArea" align="center">
               <!-- [이전 비활성화] -->
               <c:if test="${ pi.currentPage <= 1 }">
                  <input type="button" class="Btn" value="&lt;" disabled="disabled" style="pointer-events:none;">
               </c:if>
               
               <!-- [이전] -->
               <c:if test="${ pi.currentPage > 1 }">
                  <c:url var="before" value="owner_newmenu_list.ow">
                     <c:param name="page" value="${ pi.currentPage - 1 }" />
                  </c:url>
                  <input type="button" class="Btn" value="&lt;"onclick="location.href='${ before }'">
               </c:if>

               <!-- [페이지] -->
               <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                  <c:url var="pagination" value="owner_newmenu_list.ow">
                     <c:param name="page" value="${ p }" />
                  </c:url>
                  <c:if test="${ p eq pi.currentPage }">
                     <input type="button" id="choosen" value="${ p }" disabled="disabled">
                  </c:if>
                  <c:if test="${ p ne pi.currentPage }">
                     <input type="button" class="numBtn" value="${ p }" onclick="location.href='${ pagination }'">
                  </c:if>
               </c:forEach>

               <!--[다음 비활성화] -->
               <c:if test="${ pi.currentPage >= pi.maxPage }">
                  <input type="button" class="Btn" value="&gt;" disabled="disabled" style="pointer-events:none;">
               </c:if>

               <!-- [다음] -->
               <c:if test="${ pi.currentPage < pi.maxPage }">
                  <c:url var="after" value="owner_newmenu_list.ow">
                     <c:param name="page" value="${ pi.currentPage + 1 }" />
                  </c:url>
                  <input type="button" class="Btn" value="&gt;" onclick="location.href='${ after }'">
               </c:if>
            <c:if test="${!empty loginUser}">               
               <input type="button" id="register" value="등록">
            </c:if>
            </div>
            
            
            <div id="searchArea">
            <select name="search" id="searchCate">
                <option>제목</option>
                <option>작성자</option>
            </select>
            <input type="text" id="searchText" placeholder="제목을 입력해주세요.">
            <button type="button" id="search" onclick="searchBtn();">검색</button>
            
            </div>
         </div>
      </div>
   </div>
         
         <script>
            function searchBtn(){

               var option = document.getElementById('searchCate').value;
               var title = document.getElementById('searchText').value;
               
               
               $.ajax({
                  url: 'searchNewMenu.ow',
                  data: {title:title,
                        option:option},
                  success:function(data){
                     $tableBody = $('#tb tbody');
                        $tableBody.html('');
                        
                        if(data.length == 0){
                           alert('검색결과가 존재하지 않습니다.');
                        }
                        for(var i in data){
                           var $tr = $('<tr>');
                           var $sNum = $('<td>').text(data[i].onmNum);
                           var $sTitle = $('<td>').text(data[i].onmTitle);
                           var $sWriter = $('<td>').text(data[i].storeName);
                           var $sCreateDate = $('<td>').text(data[i].createDate);
                           
                           $tr.append($sNum);
                           $tr.append($sTitle);
                           $tr.append($sWriter);
                           $tr.append($sCreateDate);
                           
                           $tableBody.append($tr);
                           
                           $(document).ready(function(){
                               $('tr').attr({
                                   "class" : "trContent"
                               });   
                           });
                           
                           $(function(){
                              $('.trContent').mouseenter(function(){
                                 $(this).css({'font-weight':'bold','cursor':'pointer'});
                              }).mouseout(function(){
                                 $(this).css({'font-weight':'normal'});
                              }).click(function(){
                                var chkLog = ${loginUser.rank_code};
                                 var bId = $(this).children('td').eq(0).text();
                                 
                                 if(chkLog != null){
                                    location.href='onmdetail.ow?onmNum=' + bId + '&page=' + ${pi.currentPage};
                                 }
                              });
                           });
                        } 
                  }
                  
               });
            }
         </script>
            
            
            
   
   <script>
      $(function(){
         $('#register').click(function(){
            location.href='ownerRegisterView.ow';   
         });
      });
   </script>
</body>
</html>