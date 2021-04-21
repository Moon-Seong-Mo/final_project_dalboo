<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 고객센터</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/board/customer_service_detail.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
</head>
<body>
<div class="wrap">
      <%@ include file="/WEB-INF/views/common/nav.jsp" %>
      <div id="content">
   <!-- 여기까지 -->
      <br>
      <h2>문의사항 게시판</h2>
      
      
       <c:if test="${ loginUser.id eq board.bWriter || loginUser.rank_code eq '2'  }">
      <div class="outer">
            <div class="detailArea">            
               <table id="tableArea">
                  <tr>
                     <td colspan="2" id="title">
                        ${ board.bTitle }                        
                     </td>            
                  </tr>
                  
                  
                  <tr>
                     <td id="views"><b>조회수</b> ${ board.bViews }</td>
                     
                     <td id="date">
                        <b>날짜 </b> ${ board.bCreateDate }
                     </td>
                     
                  </tr>
                  <tr>
                     <td id="writer">
                        <b>작성자 </b> ${ board.bWriter }
                     </td>
                     
                     <c:if test="${ !empty board.originalFileName }">
                        <td colspan="2" id="downloadfile">
                          <b>첨부파일  </b> <a href="${ contextPath }/resources/buploadFiles/${ board.renameFileName }" download="${ board.originalFileName }">${ board.originalFileName }</a>
                     </td>
                         </c:if>
                  </tr>
                  
                  
                  <tr>
                     <td colspan="2" align="left" id="contents">
                     <br>
                     <% pageContext.setAttribute("newLineChar", "\r\n"); %> <!-- \r\n 말고 그냥 \n도, \r도 가능하다 -->
                        ${ fn:replace(board.bContent, newLineChar, "<br>") }
                     </td>
                  </tr>
                  
               </table>
            </div>
            
            
            <div id="reply-area">
            
            
            <table class="replyTable">
               <tr>
                  <td><textarea rows="3" cols="83" id="rContent" style="resize: none;"></textarea></td>
                  <td><button id="rSubmit">등록하기</button></td>
               </tr>
            </table>
            
            
            <table class="replyTable2" id="rtb">
               <thead>
                  <tr>
                     <td colspan="2"><b id="rCount"></b></td>
                  </tr>
               </thead>
               <tbody>
               
               </tbody>
            </table>
            
            </div>
            <script>
            $('#rSubmit').on('click', function(){
                  var rContent = $('#rContent').val();
                  var refBid = ${ board.bNum };
            
                  $.ajax({
                     url: 'addReply.bo',
                     data: {rContent:rContent, refBid: refBid},
                     success: function(data){
                        console.log(data);
                        if(data == 'success'){
                           $('#rContent').val('');
                           getReplyList();
                        }
                     }
                  });
               });
            
//             function deleteReply((data[i].rId)){
//                getReplyList()
//             }

            
//             $('#deleteReply').click(function){
//                var delbt = $(this).val
//             }
            
            
            function getReplyList(){
                  var bNum = ${ board.bNum};
                  var loginUser="${loginUser.id}";
                  var loginAdmin="${loginUser.rank_code}";
                  $.ajax({
                     url: 'rList.bo',
                     data: {bNum:bNum},
                     success: function(data){
                        
                        $tableBody = $('#rtb tbody');
                        $tableBody.html('');
                        var $tr;
                        var $rWriter;
                        var $rContent;
                        var $rCreateDate;
                        var $rId;
                        
                        $('#rCount').text('댓글(' + data.length + ')');
                        
                        if(data.length > 0){
                            for(var i in data){
                               if(loginUser == data[i].rWriter || loginAdmin == 2 ){
                                  $tr = $('<tr>');
                                       $rWriter = $('<td width="100px">').text(data[i].rWriter);
                                       $rContent = $('<td width="350px">').text(data[i].rContent);
                                       $rCreateDate = $('<td width="100px">').text(data[i].rCreateDate);
                                       $rId = $('<td><button class="delbt" value="'+ data[i].rId +'" onclick="deleteReply(this);">삭제</button>');
//                                        $rId = $('<td><input type="button" value="삭제" class="delbt" onclick="deleteReply();');
                                       $tr.append($rWriter);
                                       $tr.append($rContent);
                                       $tr.append($rCreateDate);
                                       $tr.append($rId);
                                       $tableBody.append($tr);
                                       
                                       
                              }
                               else{
                                  $tr = $('<tr>');
                                       $rWriter = $('<td width="100px">').text(data[i].rWriter);
                                       $rContent = $('<td width="350px">').text(data[i].rContent);
                                       $rCreateDate = $('<td width="100px">').text(data[i].rCreateDate);
                                       $tr.append($rWriter);
                                       $tr.append($rContent);
                                       $tr.append($rCreateDate);
                                       $tableBody.append($tr);
                                       
                        }}}
                        else{
                           $tr = $('<tr>');
                           $rContent = $('<td colspan=3>').text('등록된 댓글이 없습니다.');
                           $tr.append($rContent);
                           $tableBody.append($tr);
                        }
                     }
                  });
               }
            
             function deleteReply(bt){
                 if(confirm("정말 삭제하시겠습니까?")){
                    var rNum = $(bt).val();
                           var $parent =  $(bt).parent().parent();
                          $parent.remove();
                        
                   $.ajax({
                        url: 'deleteReply.bo',
                        data: {rNum:rNum}
             
                     }); 
                   alert('댓글이 삭제되었습니다.');
                   return true;
                  }else{
                     return false;
                  }
             }
            
               $(function(){
                  getReplyList();
                  setInterval(function(){
                     getReplyList();
                  }, 100000);
               });
            
            </script>
      </div>
      
      
   <div id="btnDiv" align="center">
   
      <c:url var="customer_service_updateView" value="customer_service_updateView.bo">
         <c:param name="bNum" value="${ board.bNum }"/>
         <c:param name="page" value="${ page }"/>
      </c:url>
      <c:url var="customer_service_delete" value="customer_service_delete.bo">
         <c:param name="bNum" value="${ board.bNum }"/>
      </c:url>
      <c:url var="customer_service_list" value="customer_service_list.bo">
         <c:param name="page" value="${ page }"/>
      </c:url>
   </div>
      
      </c:if>
      
      
      <c:if test="${ loginUser.id eq board.bWriter }">            
      <input type="submit" id="sbm-btn" onclick="location.href='${customer_service_updateView}'" value="수정">
      </c:if>
      
      <c:if test="${ loginUser.id eq board.bWriter || loginUser.rank_code eq '2'  }">
      <input type="button" id="del-Btn"  value="삭제">
      </c:if>
      
      
      <script>
	$(function(){
		$('#del-Btn').click(function(){
				var con = confirm("정말 삭제하시겠습니까?");
				if(con){
				var bNum = ${board.bNum}
				
				location.href='customer_service_delete.bo?bNum=' + bNum;
				}else{
					return false;
				}
		});
	});
	</script>
      
      
      
      <c:if test="${ loginUser.id ne board.bWriter && loginUser.rank_code ne '2'  }">
      <span class="warning">
         <br><br><br>관리자와 작성자만 접근이 가능한 게시물입니다!! <br><br><br><br><br>
      </span>
      </c:if>
      
      <input type="button" id="res-btn" onclick="location.href='customer_service_list.bo'" value="목록">
   </div>
   </div>
   <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>