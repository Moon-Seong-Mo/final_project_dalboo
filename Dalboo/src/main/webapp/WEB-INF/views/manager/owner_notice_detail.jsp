<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 공지사항</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">
<style>
.outer {
   margin-left: auto;
   margin-right: auto;
}

#detail {
   width: 800px;
   min-height: 400px;  
   border: 1px solid #E0E0E0;
}

h1 {
   margin-top: 100px;
}

#noSee {
   display: none;
   border: 1px solid rgb(190, 190, 190);
   width: 400px;
   height: 50px;
   margin-top: 20px;
   text-align: left;
   font-size: 16px;
   border-radius: 10px;
}

#btnArea {
   margin-top: 30px;
}

a {
   text-decoration: none;
   color: black;
   font-weight: bold;
}

#list {
   width: 100px;
   height: 40px;
   background: rgb(44, 62, 80);
   color: white;
   border: 0px;
   border-radius: 5px;
   font-size: 15px;
   cursor: pointer;
}

.Btn {
   width: 80px;
   height: 40px;
   color: white;
   border: 1px solid lightgray;
   border-radius: 5px;
   cursor: pointer;
}

#fileBtn {
   float: left;
   margin-top: 20px;
   width: 80px;
   height: 40px;
   color: rgb(44, 62, 80);
   border: 1px solid lightgray;
   border-radius: 5px;
   cursor: pointer;
}
</style>
</head>
<body>
   <%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp"%>
   <div id="wrap">
      <%@ include file="/WEB-INF/views/common/ownerPageNav.jsp"%>
      <div id="section">
      
         <div class="outer" align="center">
         
            <div id="detail">
               <h1>${ on.owTitle }</h1>
               <p style="display: inline; float:left; width:100px; font-size:15px;">관리자</p>
               <p style="display: inline; float:right; width:100px; font-size:15px;">조회수 : ${ on.onCount }</p>
               <p style="display: inline; float:right; width:100px; font-size: 15px;">${ on.owDate }</p>
               
               <c:if test="${ img == 1 }">
                  <div align="center" style="margin-top: 100px;">
                     <img src="${ contextPath }/resources/ownerNoticeuploadFiles/${ on.renameFileName }" style="max-width: 800px;"> 
                  </div>
               </c:if>
               
               <div align="center" style="margin-top:80px; font-size: 18px;">
                  <div style="width: 800px; min-height:40px; background: white; text-align: left; border-radius: 10px;">
                     <br>
                        <div style="margin-left:20px;">${ on.owContent }</div> 
                     <br>
                  </div>
               </div>               
               
               <c:if test="${ img == 2 }">
                  <div style="display:inline;">
                     <button id="fileBtn">첨부파일</button>
                     <div align="left" id="noSee">
                        <br>
                        &nbsp;&nbsp;다운로드 [ <a href="${ contextPath }/resources/ownerNoticeuploadFiles/${ on.renameFileName }" download="${ on.renameFileName }"> ${ on.originFileName }</a> ]
                     </div>
                  </div>
               </c:if>
            </div>
            
            <div id="btnArea" align="center">
               <c:url var="onlist" value="owner_notice.ow">
                  <c:param name="page" value="${ page }" />
               </c:url>
               <input type="button" id="list" value="목록으로" onclick="location.href='${ onlist }'"> 
               
               <!-- 관리자만 보이도록 -->
               <c:if test="${ loginUser.rank_code eq 2 }">
                  <div align="center" style="margin-left:400px; margin-top:100px;">
                     <c:url value="ownerNoticeModifyView.ow" var="modify">
                        <c:param name="onNo" value="${ on.onNo }"/>
                        <c:param name="page" value="${ page }"/>
                     </c:url>
                  
                     <input type="button" id="delete" class="Btn" value="삭제" style="background: rgb(211, 84, 0)"> 
                     <input type="button" id="update" class="Btn" value="수정" style="background: rgb(44, 62, 80)" onclick="location.href='${ modify }'">
                  </div>
               </c:if>
            </div> 
            
         </div>
      
      
      </div>
   </div>
   <script>
   
      
   
      $(document).ready(function(){
         $("#fileBtn").click(function(){
            $("#noSee").toggle();
         });
      });
   
   
   
      $("#delete").click(function(){
         
         var onNo = ${ on.onNo }; 
         
         var bool = confirm( onNo + "번 게시글을 삭제하시겠습니까?");
         
         if(bool){
            location.href='ownerNoticeDelete.ow?onNo='+onNo;
         }
      });
         
      
   </script>
</body>
</html>

