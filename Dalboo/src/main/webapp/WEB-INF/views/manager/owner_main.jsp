<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@ taglib prefix="e" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>달보드레</title>
<style>
table {
   width: 95%;
   text-align: center;
   border-collapse: collapse;
   margin-bottom: 50px;
   margin: 0 auto;
   margin-left: 20px;
   margin-top: 50px;
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

</style>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/owner/owner_main.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body>
   <%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp" %>
   <div id="wrap">
   
   <%@ include file="/WEB-INF/views/common/ownerPageNav.jsp" %>
   <div id="section">
      
<div class="contents">
   <h2>메인</h2>
   <hr>
   
   
   
   
   
      <e:if test="${ loginUser.rank_code eq 2 }">
      <div class="sale">
      <!--//관리자가 보는 총매출 -->
      <p>모든매장 총 매출</p> 
      <fmt:formatNumber value="${ totalSales }" type="currency"/>
      <e:forEach var="d" items="${ chart }">
      <input type="hidden" value="${ d.store_name }" class="store_name">
      <input type="hidden" value="${ d.totalprice }" class="so_total_price">
      </e:forEach>
      </div>
   </e:if>   
      
<!--       관리자일경우   MD상품매출과 매장별 매출의 파이차트를 보여줌 -->
      <e:if test="${ loginUser.rank_code eq 2 }">
      
<!--       MD상품 총 매출 일단보류 -->
<!--       <div class="sale"> -->
<!--       <p>MD매출</p> -->
<%--       <fmt:formatNumber value="${ mdTotalSales }" type="currency"/> --%>
<!--       </div> -->
      
      
      <div class="container">
         <div class="row">
            <div class="col-md-12">
               <p id="donut_title">매장별 매출 현황</p>
               <canvas id="myChart1"></canvas>
            </div>
         </div>
      </div>
      
<%--       </e:if> --%>




         <script>

         var store_name = $('input[class=store_name]');
         var so_total_price = $('input[class=so_total_price]');
         var so_total_prices = new Array();
         var store_names = new Array();
         for(var i = 0; i < store_name.length; i++){
            store_names.push(document.getElementsByClassName("store_name")[i].value);
            so_total_prices.push(document.getElementsByClassName("so_total_price")[i].value)
            console.log("names : " + store_names + "\n so_total_price : " + so_total_prices);
         }
         console.log("names2 : " + store_names + "\n so_total_price2 : " + so_total_prices);
         
            // 도넛 차트
         let myChart1 = document.getElementById('myChart1').getContext('2d');

         let barChart = new Chart(myChart1, {
            type : 'doughnut',
            data: {
               labels : store_names,
               datasets: [{
                  label : '판매량',
                  data: so_total_prices,
                  backgroundColor: [
                     'rgb(184, 134, 11)', 'rgb(210, 105, 30, 0.5)', 'rgb(245, 245, 220, 0.7)', 'yellow', 'green'   
                  ],
                  borderWidth: 5,
                  borderColor: '#E0E0E0',
                  hoverBorderWidth: 10,
               }]
            }
         });
         </script>
      <br>
      
      
      </e:if>
      
      
      

      
      
      
      
       <e:if test="${ loginUser.rank_code eq 1 }">
       
      <div class="sale2">
      <h4 style="background: #FF5A5A;width: 130px;text-align: center;margin: 0 auto;border-radius: 
      5px;margin-bottom: 15px; font-size:27px">${ loginUser.store_name }</h4>커피 총 매출
      <h3>
      <fmt:formatNumber value="${ totalSales }" type="currency"/>
      </h3>
      </div>
       
       <e:forEach var="d" items="${ chart2 }">
      <input type="hidden" value="${ d.materialName }" class="materialName">
      <input type="hidden" value="${ d.materialAmount }" class="materialAmount">
      <input type="hidden" value="${d.store_num }">
      </e:forEach>
       
       
       
        <!--    재훈 차트 -->
         
         <div class="chardiv">
         <div class="container">
         <div class="row">
            <div class="col-md-12">
               <p id="donut_title"><b>${ loginUser.store_name }</b>  재고 현황</p>
               <canvas id="myChart2"></canvas>
            </div>
         </div>
      </div>  
      </div>
      
   
   
      
   <script>
        var materialName = $('input[class=materialName]');
         var materialAmount = $('input[class=materialAmount]');
         
         var materialAmounts = new Array();
         var materialNames = new Array();
         for(var i = 0; i < materialName.length; i++){
            materialNames.push(document.getElementsByClassName("materialName")[i].value);
            materialAmounts.push(document.getElementsByClassName("materialAmount")[i].value);
         }
         console.log("names : " + materialNames + "\n stocks : " + materialAmounts);
         
            // 막대 그래프
         let myChart2 = document.getElementById('myChart2').getContext('2d');

         let barChart2 = new Chart(myChart2, {
            type : 'bar',
            data: {
               labels : materialNames,
               datasets: [{
                  label : '재고량',
                  data: materialAmounts,
                  backgroundColor: [
                     'rgb(184, 134, 11)', 'rgb(210, 105, 30, 0.5)', 'rgb(245, 245, 220, 0.7)', 'yellow', 'green'   ,'rgb(150, 105, 30, 0.5)','rgb(70, 105, 30, 0.5)'
                     ,'rgb(20, 105, 30, 0.5)','rgb(210, 170, 30, 0.5)','rgb(210, 255, 30, 0.5)','rgb(210, 105, 150, 0.5)','rgb(210, 105, 250, 0.5)'
                  ],
                  borderWidth: 5,
                  borderColor: '#E0E0E0',
                  hoverBorderWidth: 10,
               }]
            },
              options: {
                  scales: {
                     yAxes: [{
                        display: true,
                        ticks: {
                           suggestedMax: 100,    // minimum will be 0, unless there is a lower value.
                           // OR //
                           beginAtZero: true   // minimum value will be 0.
                        }
                     }]
                  }
               }
            
            
         });
         </script>
      <br>  
      
      
      </e:if>
      
      
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
         
         
         
         
         
         
         
       
         
         
         
         
         
         
   </div>                  
      </div>
   </div>
</body>
</html>