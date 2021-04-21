<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>달보드레 | 공지사항</title>
<style>
h2 {
   margin-left: 20px;
}

table {
   width: 95%;
   text-align: center;
   border-collapse: collapse;
   margin-bottom: 50px;
   margin: 0 auto;
   margin-left: 20px;
}

th {
   height: 50px;
   background: rgb(52, 73, 94);
   color:white;
}

td {
   height: 40px;
   border-bottom: 1px solid gray;
   text-align: center;
}

/* 페이징 */
button:hover {
   cursor: pointer;
}

.numBtn {
   border: 0px;
   background-color: rgb(190, 190, 190);
   width: 30px;
   height: 30px;
   border-radius: 5px;
}

.Btn {
   border: 0px;
   background-color: rgb(190, 190, 190);
   width: 30px;
   height: 30px;
   border-radius: 5px;
}

#choosen {
   border: 0px;
   background-color: rgb(52, 73, 94);
   color: white;
   width: 30px;
   height: 30px;
   border-radius: 5px;
}

div#pagingArea {
   margin-top: 30px;
   margin-left:80px;
}

#register {
    border-radius: 5px;
    color: white;
    border: 0px;
    outline: 0px;
    background: rgb(44, 62, 80);
    font-size: 15px;
    font-weight: bold;
    color: white;
    cursor: pointer;
    width: 80px;
    height: 30px;
    float: right;
    margin-top: 50px;
    margin-right: 50px;
} 

#search {
   border: 0px;
   border-radius : 5px;
   background: rgb(44, 62, 80);
   font-size: 15px;
   color: white;
   cursor: pointer;
   width: 80px;
   height: 30px;
}

select#searchCate {
   text-align-last:center;
   width:70px;
   height: 35px;
}

input[type="text"] {
   height: 25px;
}

div#searchArea {
   margin-left: 50px;
   margin-top: 50px;
}

#owner_notice {
   width: 95%;
}

#wrap {
   background-color: #E0E0E0;
   position: relative;
   width: 100%;
   min-height: 500px;
}
</style>
</head>
<body>
   <%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp"%>
   <div id="wrap">
      <%@ include file="/WEB-INF/views/common/ownerPageNav.jsp"%>
      <div id="section">
         <br>
         <div id="owner_notice">
            <h2>가맹주 공지사항</h2>
            <hr>

            <table>
               <tr>
                  <th>No.</th>
                  <th>제목</th>
                  <th>등록일</th>
                  <th>조회수</th>
               </tr>
               <c:forEach items="${ onlist }" var="on">
                  <tr class="contentTR" >
                     <td>${ on.onNo }</td>
                     <td>${ on.owTitle }</td>
                     <td>${ on.owDate }</td>
                     <td>${ on.onCount }</td>
                  </tr>
               </c:forEach>
               <c:if test="${ searchResult == 1 }">
                  <tr>
                     <td colspan="4">검색하신 게시글이 존재하지 않습니다.</td>
                  </tr>
               </c:if>
            </table>
               

            <c:if test="${ !empty onlist }">
               <div align="center" id="pagingArea">
               
                  <c:if test="${ sVal eq null }">
                     <c:set var="loc" value="/owner_notice.ow"/>
                  </c:if>
                  <c:if test="${ sVal ne null }">
                     <c:set var="loc" value="/noticeSearch.ow"/>
                  </c:if>
                  
                  <!-- [이전 비활성화] -->
                  <c:if test="${ pi.currentPage <= 1 }">
                     <input type="button" class="Btn" value="&lt;" disabled="disabled" style="pointer-events: none;">
                  </c:if>

                  <!-- [이전] -->
                  <c:if test="${ pi.currentPage > 1 }">
                     <c:url var="before" value="${ loc }">
                        <c:if test="${ sCate ne null }">
                           <c:param name="sCate" value="${ sCate }"/>
                           <c:param name="sVal" value="${ sVal }"/>
                        </c:if>                     
                        <c:param name="page" value="${ pi.currentPage - 1 }" />
                     </c:url>
                     <input type="button" class="Btn" value="&lt;" onclick="location.href='${ before }'">
                  </c:if>

                  <!-- [페이지] -->
                  <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                     <c:url var="pagination" value="${ loc }">
                        <c:if test="${ sCate ne null }">
                           <c:param name="sCate" value="${ sCate }"/>
                           <c:param name="sVal" value="${ sVal }"/>
                        </c:if>
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
                     <input type="button" class="Btn" value="&gt;" disabled="disabled" style="pointer-events: none;">
                  </c:if>

                  <!-- [다음] -->
                  <c:if test="${ pi.currentPage < pi.maxPage }">
                     <c:url var="after" value="${ loc }">
                        <c:if test="${ sCate ne null }">
                           <c:param name="sCate" value="${ sCate }"/>
                           <c:param name="sVal" value="${ sVal }"/>
                        </c:if>                     
                        <c:param name="page" value="${ pi.currentPage + 1 }" />
                     </c:url>
                     <input type="button" class="Btn" value="&gt;" onclick="location.href='${ after }'">
                  </c:if>
               </div>
            </c:if>


         <c:if test="${!empty loginUser && loginUser.rank_code eq 2 }"> 
               <input type="button" id="register" value="등록" onclick="location.href='owner_notice_registerView.ow'">
            </c:if>

            <div id="searchArea">
               <select name="search" id="searchCate">
                  <option value="title">제목</option>
                  <option value="content">내용</option>
               </select> 
               <input type="text" placeholder="검색어를 입력해주세요." id="searchValue"> 
               <button id="search" onclick="searchNotice();">검색하기</button>
            </div>
         </div>
         
         <script>
         
            function searchNotice(){
               var sCate = $("#searchCate").val();
               var sVal = $("#searchValue").val();
               
               if(sVal != ''){
                  location.href='noticeSearch.ow?sCate='+sCate+"&sVal="+sVal;
               } else{
                  alert("검색어를 입력해주세요");
               }
               
            }               
         
         
         
         
            $(function(){
               $('.contentTR').mouseenter(function(){
                  $(this).css({'color':'rgb(52, 73, 94)', 'cursor':'pointer'});
               }).mouseout(function(){
                  $(this).css({'color':'black', 'font-weight':'normal'});
               }).click(function(){
                 var chkLog = ${loginUser.rank_code};
                  var onNo = $(this).children('td').eq(0).text();
                  if(chkLog != null){
                      location.href='ownerNoticeDetail.ow?onNo=' + onNo + '&page=' + ${pi.currentPage};
                  }
               });
            });
         </script>
         
         
      </div>
   </div>
</body>
</html>