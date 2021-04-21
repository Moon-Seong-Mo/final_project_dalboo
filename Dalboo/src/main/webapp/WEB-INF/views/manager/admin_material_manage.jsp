<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
   
   
</style>
<meta charset="UTF-8">
<title>달보드레 | 가맹주 관리</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/manager/admin_material_manage.css">
</head>
<body>
   <%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp" %>
   <div id="wrap">
      <%@ include file="/WEB-INF/views/common/ownerPageNav.jsp" %>
      <div id="section">
         <div id="material_order_area">
            <br>
            <h2>현재고 관리</h2>
            <hr>
         <% int i=1; %>
         
         <div id="stock-area">
            <table id="add_menu">
               <thead>
                  <tr id="table_top">
                        <td>메뉴이름</td>
                        <td>전체 재고</td>
                  </tr>
               </thead>
               <tbody>
                  <c:forEach var="coffee" items="${ list }">
                     <tr>
                        <td class="meterial_tr">
                           <input type="text" id="materialName<%=i %>" name="chkName" class="chkName" value="${ coffee.materialName }" readonly>
                        </td>
                        <td>
                           <input type="text" id="amonut<%=i %>" name="amount"  class="amount" value="${ coffee.materialAmount }" readonly>
                           <input type="hidden" name="allStockNum"  value="${ coffee.allStockNum }">
                           <input type="hidden" name="price"  value="${ coffee.materialPrice }">
                           <input type="hidden" name="type"  value="${ coffee.materialType }">
                           <input type="hidden" name="originalFileName"  value="${ coffee.originalFileName }">
                           <input type="hidden" name="renameFileName"  value="${ coffee.renameFileName }">
                        </td>
                     </tr>
                     <% ++i; %>
                  </c:forEach>
               </tbody>
               
            </table>
         </div>
         
         
         
         <div id="order-area">
            <div id="order-table">
             <form action="admin_material_order.ow" id="form_order"method="post" enctype="Multipart/form-data">
               <table id="table-right">
               
                  <tr>
                     <th id="th-head" colspan="2">추가하기</th>
                  </tr>
                  
                  <tr>
                           <td>카테고리</td>
                           <td> 
                           <select id="menu_cate" class="type" name="materialType">
                              <option>메뉴 카테고리를 선택 하세요.</option>
                              <option value="신메뉴">신 메뉴</option>
                              <option value="커피">커피</option>
                              <option value="음료">음료</option>
                              <option value="디저트">디저트</option>
                          </select>    
                     </td>
                  </tr>
                 
                  <tr>
                     <td>재료명</td>
                     <td>
                        <input type="text" class="name" name="materialName">
                     </td>
                  </tr>
                  <tr>
                     <td>수량</td>
                     <td>
                        <input type="Number" class="amount" name="materialAmount" id="upAmount"  min="0" step="50">
                     </td>
                  </tr>
                  <tr>
                     <td>가격</td>
                     <td>
                        <input type="Number" class="price" name="materialPrice" id="price" min="0" step="500">
                        <input type="hidden" class="allStockNum" name="allStockNum" value="0">
                        <input type="hidden" class="originalFileName" name="originalFileName"  value="0">
                         <input type="hidden" class="renameFileName" name="renameFileName"  value="0">
                     </td>
                  </tr>
                  <tr>
                     <th style="font-size:24px; font-weight:normal">사진</th>
                     <td>
                           <div id="titleImgArea">
                              <img id="titleImg" width="300" height="300">
                           </div>
                           <div id="fileArea">
                            <input type="file" id="reuploadFile" name="reuploadFile" class="file" multiple="multiple"  onchange="LoadImg(this,1)" accept="image/*">
                        </div>
                     </td>
                  </tr>
                  
                  <tr>
                     <td colspan="2">
                     <input type="button" id="addBtn" class="addBtn" value="추가">
                     <input type="button" id="updBtn" class="updBtn" value="수정">
                     <input type="button" id="cenBtn" class="cenBtn" value="취소">
                     </td>
                  </tr>
               </table>
               </form> 
            </div>
            
            
         </div>
         </div>
      </div>
   </div>
</body>

<script>
   
   //메뉴랑 수량 추가
   $(function(){
      $(".addBtn").click(function(){
         
         var $name = $(this).closest("table").find(".name").val();
         var $amount = $(this).closest("table").find(".amount").val();
         var $price = $(this).closest("table").find(".price").val();
         var $type = $(this).closest("table").find(".type").val();
         var form = $('#form_order')[0];
         var uploadFile = new FormData(form);
        
          var $upAmount = $("input:text[name ='chkName']:input[value='"+ $name +"']").parent().next().children().eq(0);
          var $eqStatus = $("input:text[name ='chkName']:input[value='"+ $name +"']").val();
          var $chkAmount  = $("input:text[name ='chkName']:input[value='"+ $name +"']").parent().next().children().eq(0).val();
          var $chkAllstock = $("input:text[name ='chkName']:input[value='"+ $name +"']").parent().next().children().eq(1).val();
          var $chkType = $("input:text[name ='chkName']:input[value='"+ $name +"']").parent().next().children().eq(3).val();
          var $chkPrice = Number($("input:text[name ='chkName']:input[value='"+ $name +"']").parent().next().children().eq(2).val());
          var $totalAmount = Number($chkAmount) + Number($amount); //수량 변경시킴
          
         
          
          if($type == "메뉴 카테고리를 선택 하세요."){
              alert(' 카테고리가 입력되어있지 않습니다.');
              return false;
              }else if(!$amount){
              alert('수량이 입력되어있지 않습니다.');
              return false;
              }else if(!$price){
              alert('가격이 입력되어있지 않습니다.');
              return false;
            }else if(!$name){
              alert('재료명이 입력되어있지 않습니다.');
              return false;
             }else if($eqStatus== null){
            $.ajax({
               url:'admin_material_order.ow',
               data:uploadFile,
               processData:false,
               contentType:false,
               type:'POST',
               success:function(data){
                  location.reload();
               }
            });
         } else if($eqStatus != null){
           alert('존재하는 재료입니다.');
           return false;
         }
         
         
       
         
         $(".deleteBtn").click(function(){
              var $parent =  $(this).parent().parent();
              $parent.remove();
          });
         
      });
         $('.meterial_tr').click(function(){
            var $nameform = $('#table-right').find(".name");
             var $amountform = $('#table-right').find(".amount");
             var $priceform = $('#table-right').find(".price");
             var $typeform = $('#table-right').find(".type");
             var $allstockNumform = $('#table-right').find(".allStockNum");
             var $originalFileNameform = $('#table-right').find(".originalFileName");
             var $renameFileNameform = $('#table-right').find(".renameFileName");
             var $imgform = $('#table-right').find("#titleImg");
           /*-------------------------------------------------------  */
             var $name = $(this).children().val();
             var $amount = $(this).next().children().eq(0).val();
             var $allstockNum = Number($(this).next().children().eq(1).val());
             var $price = Number($(this).next().children().eq(2).val());
             var $type = $(this).next().children().eq(3).val();
             var $original = $(this).next().children().eq(4).val();
             var $rename = $(this).next().children().eq(5).val();
             
             var $addbtn = $('.addBtn').css('display','none');
             var $updBtn = $('.updBtn').css('display','inline-block');
             var $cenBtn = $('.cenBtn').css('display','inline-block');
             /* ------------------------------------------------------- */
             $nameform.val($name);
             $amountform.val($amount);
             $priceform.val($price);
             $typeform.val($type);
             $allstockNumform.val($allstockNum); 
             $originalFileNameform.val($original);
             $renameFileNameform.val($rename);
             $imgform.attr("src", 'resources/materialuploadFiles/'+ $renameFileNameform.val());
             
             var $headerText = $('#table-right').children().find('#th-head');
                 $headerText.text('수정하기').css({'font-size':'35px', 'font-weight':'bold','width':'250px' } );
             $('.cenBtn').click(function(){
                $addbtn = $('.addBtn').css('display','block');
                 $updBtn = $('.updBtn').css('display','none');
                 $cenBtn = $('.cenBtn').css('display','none');
                 $nameform.val('');
                 $amountform.val('');
                 $priceform.val('');
                 $typeform.val('');
                 $allstockNumform.val(''); 
                 $originalFileNameform.val('');
                 $renameFileNameform.val('');
                 $imgform.removeAttr('src');
                 $headerText.text('추가하기').css({'font-size':'35px', 'font-weight':'bold','width':'250px' } );
             });
             
             $('.updBtn').click(function(){
                var form = $('#form_order')[0];
                 var uploadFile = new FormData(form);
                 
                 $.ajax({
                    url:'admin_material_order.ow',
                    data:uploadFile,
                    processData:false,
                    contentType:false,
                    type:'POST',
                    success:function(data){
                      location.reload();
                   }
                 });
             });
             
         });
      
   });
   
</script>


         <!-- 파일 업로드 하는 부분 -->
             <script>
               // 내용 작성 부분의 공간을 클릭할 때 파일 첨부 창이 뜨도록 설정하는 함수
               $(function(){
                  $("#fileArea").hide();
                  
                  $("#titleImgArea").click(function(){
                     $("#reuploadFile").click();
                  });
               });
                     
               // 각각의 영역에 파일을 첨부 했을 경우 미리 보기가 가능하도록 하는 함수
               function LoadImg(value, num){
                  if(value.files && value.files[0]){
                     var reader = new FileReader();
                     
                     reader.onload = function(e){                        
                        switch(num){
                        case 1: 
                           $("#titleImg").attr("src", e.target.result);
                           break;
                       }
                     }
                     
                     reader.readAsDataURL(value.files[0]);
                  }
              }
            </script>
</html>