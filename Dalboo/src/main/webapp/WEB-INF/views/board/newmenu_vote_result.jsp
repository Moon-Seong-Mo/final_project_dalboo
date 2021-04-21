<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 신메뉴</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/board/newmenu_result.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
</head>
<body>
<div class="wrap">
      <%@ include file="/WEB-INF/views/common/nav.jsp" %>
      <div id="content">

      <br>
      <h2>신메뉴 게시판</h2>
      <div class="outer">
         <form>
            <div class="detailArea">            
               <table id="tableArea">
                  <tr id="first-tr"> 
                     <td id="title">
                        <strong>[이달의 신메뉴] ${ board.title }</strong> 
                        <input type="hidden" name="no" value="">                         
                     </td>                           
                     <td id="date">
                        <strong>${ board.createDate}</strong> 
                     </td>
                     <td id="count">
                        <strong>${ board.views }</strong> 
                     </td>
                  </tr>
               </table>
               <div id="contentArea">
                  <div style="height:100px;">
                     <img id="content-logo" src="resources/images/logo.png">   
                  </div>            
                  
                  <div id="month-label">이달의 신메뉴 투표!</div>
                  
                  <div id="result-label1">
                     <p style="text-shadow: 10px 10px 10px  #fa7e22;">최종 결과 발표</p>                  
                  </div>
                  
                  <img id="vote-box" src="resources/images/votebox.png">
                  
                  <div id="result-label2">
                     이달의 신메뉴!<br>선거를 통해 선정된 맛은?
                     
                  </div>
                  
                  
                  <div id="result-label3">
                     <p>총 득표수 ${voteResult.vCount }표를 얻은<br><u>${ f.menuName }</u>가 선정되었습니다!.</p><br>
                     <img width="250px" height="400px" src="resources/nMUploadFiles/${f.changName }">
                     <h4>새로워진 이달의 맛<br>'${ f.menuName }' 기대해주세요!</h4>
                  </div>      
               </div>
            </div>
             <c:if test="${!empty sessionScope.loginUser && loginUser.rank_code eq '2'}">
               <div id="btnDiv" align="right">               
                  <input type="button" id="del-Btn" value="삭제" onclick="deleteNotice();">
                  <input type="button" id="res-btn" value="목록" onclick="history.back(-1);">
               </div>
            </c:if>
             <c:if test="${!empty sessionScope.loginUser && loginUser.rank_code eq '1'}">
               <div id="btnDiv" align="right">               
                  <input type="button" id="res-btn" value="목록" onclick="history.back(-1);">
               </div>
            </c:if>
         </form>
      </div>
   </div>
</div>
   <%@ include file="/WEB-INF/views/common/footer.jsp" %>
   
   
 <script>
    function deleteNotice(){
       if(confirm('게시글을 삭제하시겠습니까?')){
           var nNum = ${board.nNum};
           location.href='deleteNewMenu.bo?nNum=' + nNum;
       }else{
          return false;
       }
    }
 </script>
</body>
</html>