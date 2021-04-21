<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>달보드레 | 매장 관리</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/owner/owner_material_order.css">
</head>
<body>
   <%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp" %>
   <div id="wrap">
      <%@ include file="/WEB-INF/views/common/ownerPageNav.jsp" %>
      <div id="section">
         <div id="material_order_area">
            <br>
            <h2>생산관리 > 주문하기</h2>
            <hr>         
         <div id="stock-area">
            <table>

                     <tr id="table_top">
                        <td>메뉴이름</td>
                        <td>본사 전체 재고</td>
                        <td>주문버튼</td>
                     </tr>
                  <% int i =1; %>
                  <c:forEach var="coffee" items="${ list }">
                     <tr>
                        <td>
                        <input type="text" id="materialName<%= i %>"  class="name" value="${coffee.materialName }" readonly >
                        <input type="hidden" value="<%= i %>">
                        </td>
                        <td>
                           <input type="text"   class="amount" value="${coffee.materialAmount }" readonly>
                        </td>
                        
                        <td>
                           <input type="button" class="orderBtn"  value="V"/>
                           <input type="hidden" name="allStockNum" value="${ coffee.allStockNum }">
                        </td>
                     </tr>
                     <% ++i; %>
                  </c:forEach>
                  
                  
                  
                  
               
            </table>
         </div>
         
         
         <form action="owner_material_order.ow" method="post"  onsubmit="return order();"> 
         <div id="order-area">
            <div id="order-table">         
               <table id="addMenuList">
               <tbody>
               
               </tbody>                  
               </table>
            </div>
            

         </div>
         
         <div id="btn-area">
         	<input type="button" id="cancel" class="bt2" value="메인으로" onclick="location.href='ownerMain.ow'">
            <input type="submit" value="발주" id="order_btn" >
         </div>
         
         
         
         </form>
         
         </div>
      </div>
   </div>
</body>

<script>





   $(function(){
       $(".orderBtn").click(function(){
         var chk = $(this).parent().prev().prev().children().eq(1).val();
       var isCheck = $('#addMenuList tbody').children().children('#materialName'+chk).val();   
         var materialNum = $(this).next().val();
         var amountVal = Number($(this).parent().prev().children().val()); //왼쪽 본사재고의 수
         var $name = $(this).parent().prev().prev().children().val(); //이름
         
         
         //재고 0개 이하일시
           if(amountVal <= 0){
              alert('재고가 0개 이하입니다.');
              return false;              
           }else if(amountVal > 0 && isCheck == null){
            $tableBody = $('#addMenuList tbody');
            var $tr = $('<tr>');
            var $td = $('<td>');
            var $nameText = $('<input type="text" id="materialName'+ chk +'" name="materialName"  class="name" value="' + $name + '" readonly>');
            var $td = $('<td>');
             var $amountText = $('<input type="Number" name="materialAmount" class="amount" value="5" min="5" step="5">');
             var $deleteBtn = $('<input type="button" class="deleteBtn"  value="X"/>');
             var $hiddenNum = $('<input type="hidden" name="stock_num"  value="">');
            var $allStockNum = $('<input type="hidden" name="allStockNum" value="'+materialNum+'">');
            
            $tableBody.append($tr);
            $tr.append($nameText);
            $tr.append($td);
            $td.append($amountText);
             $td.append($deleteBtn); 
             $td.append($allStockNum);
         }else if(isCheck != null){
             alert('이미 재료가 목록에 존재합니다.');
            return false;
         }
         else{
            return false;
         }
         
         
          $(".deleteBtn").click(function(){
              var $parent =  $(this).parent().parent();
              $parent.remove();
          });
          
          
          
       $(".amount").focusout(function() {
          
          if(amountVal < $(this).val()){
             alert("전체 재고보다 많은 수량을 입력하셨습니다.다시 입력해주세요.");
             $(this).val("재입력");
          }else if($(this).val() <= 0){
             alert("0보다 작은 수량을 입력하셨습니다. 다시 입력해주세요.");
             $(this).val("재입력");
          }
           
       });
          

      
          
        });
       
       
       
       
     
   });


   

   
   function order(){
	  var isCheck = $('#addMenuList tbody').children().children().val();
	  
      if(isCheck != null){
    	  if(confirm("발주 하시겠습니까?")){
    		  return true;
    	  }else{
    		  alert('취소되었습니다.');
    		  return false;
    	  }
      } else{
    	  alert('담으실 재료를 선택해주세요.');
         return false;
      }
      
   }
</script>
</html>