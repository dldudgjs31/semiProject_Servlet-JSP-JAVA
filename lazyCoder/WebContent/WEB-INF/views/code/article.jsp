<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/img/titlelogo.png">
<title>뺀질코딩-비밀의 소스코드</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery.min.js"></script>
<style type="text/css">

.container1{
	width:1200px;
	display: flex;
	margin: 0 auto;

}



</style>



<script type="text/javascript">
function deleteBoard(num) {
	
	<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}"> //조건에 만족하지 않으면 소스가 보이지 않는다
	if(confirm("게시물을 삭제하시겠습니까 ?")) {
		var url="${pageContext.request.contextPath}/code/delete.do";
		location.href=url+"?${query}&num="+num;
	}
	</c:if>
	
	<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!=dto.userId}"> //서버가 해석해서 스크립트에서도 가능
		alert('게시글을 삭제할 수 있는 권한이 없습니다');
	</c:if>
	
	
}
</script>
</head>
<body>

    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
<div class="container1">
    <div class="body-container" style="width: 1080px;">
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/source_logo.png" style="width: 50px; height: 37.5px;">${category} 게시판 </h3>
        </div>
        
        <div>
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse; font-family: 'Jua', sans-serif;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="center">
				   ${dto.subject}
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">
			       이름 : ${dto.userId}
			    </td>
			    <td width="50%" align="right" style="padding-right: 5px;">
			        ${dto.category }  |  ${dto.register_date }  |  조회 ${dto.hitCount}
			    </td>
			</tr>
			
			
			
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
			      <c:out value="<div style='width:1000px; overflow:auto;'>${dto.url}</div>" escapeXml="false"/>
			   </td>
			</tr>
			
			
			
			
			
			
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
			      ${dto.content}
			   </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
					이전글 :
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/code/article.do?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
					</c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/code/article.do?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
					</c:if>
			    </td>
			</tr>
			<tr height="45">
			    <td>
			    	<c:if test="${sessionScope.member.userId==dto.userId }">
			          <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/code/update.do?page=${page}&num=${dto.num}';" style="font-family: 'Jua', sans-serif;">수정</button>
			    	</c:if>
			          <button type="button" class="btn" onclick="deleteBoard('${dto.num}');" style="font-family: 'Jua', sans-serif;">삭제</button>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/code/${category }list.do?${query}';" style="font-family: 'Jua', sans-serif;">리스트</button>
			    </td>
			</tr>
			</table>
        </div>

    </div>
</div>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>