<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="e" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 자주묻는질문</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/etc/faq.css">
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp" %>
		<div id="content">		
			<div id="example">
			<h2 id="page-title">FAQ(자주묻는 질문)</h2>	
				<table id="table-area">
				<e:if test="${ list ne null }">
					<e:forEach var="f" items="${ list }">
						<tr>
							<td><div class="icon">Q</div>${ f.faq_title }</td>
							<td class="open">▼</td>
						</tr>
						
						<tr class="click-content">
							<td colspan="2"><div class="icon-1">A</div>${ f.faq_content }</td>
						</tr>
						<e:url var="faqup" value="faqup.etc">
							<e:param name="faq_num" value="${ f.faq_num }"/>
						</e:url>
					</e:forEach>
				</e:if>
				</table>
			</div>
		</div>
	</div>
	<script>
	 $('.open').click(function(){
		 var is_display =  $(this).parent().next('.click-content').css('display');
     		 console.log(is_display);
       	if(is_display == 'none'){
       		 $(this).parent().next('.click-content').css('display','block');
       	}else if(is_display == 'block'){
       		 $(this).parent().next('.click-content').css('display','none');
       	}
  	 });
	 
	 $('.close').click(function(){
		 var is_display =  $(this).parent().css('display');
     		 console.log(is_display);
       	if(is_display == 'block'){
       		 $(this).parent().css('display','none');
       	}
   });
	</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>