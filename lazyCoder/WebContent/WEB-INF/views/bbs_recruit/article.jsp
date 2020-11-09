﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/img/titlelogo.png">
<title>뺀질코딩-채용공고</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery.min.js"></script>
<script type="text/javascript">
function deleteBoard(num) {
	<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
	if(confirm("게시물을 삭제 하시겠습니까 ?")) {
		var url="${pageContext.request.contextPath}/bbs_recruit/delete.do?num="+num+"&page=${page}";
		location.href=url;
	}
	</c:if>
	<c:if test="${sessionScope.member.userId==dto.userId && sessionScope.member.userId!='admin'}">
		alert("게시물을 삭제 하실수 없습니다.");
	</c:if>
}
	
	

</script>
</head>
<body>

    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
<div class="container">
    <div class="body-container" style="width: 700px;">
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/recruit_logo.png" style="width: 50px; height: 37.5px;"> 채용 공고</h3>
        </div>
        
        <div>
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;font-family: 'Jua', sans-serif;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="center">
				${dto.subject}
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">
			       이름 : ${dto.userName}
			    </td>
			    <td width="50%" align="right" style="padding-right: 5px;">
			        ${dto.created}
			    </td>
			</tr>
			
			<tr>
				<td colspan="2" style="padding: 10px 5px;"align="center">
					<img src="${pageContext.request.contextPath}/uploads/bbs_recruit/${dto.imageFilename}" style="width: 700px; height: auto; resize: both;">
				</td>
			</tr>
			
			
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="30">
			  ${dto.content} 
			   </td>
			</tr>
		
			
			<tr height="45">
			    <td>
			    <c:if test="${sessionScope.member.userId==dto.userId}">
			          <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/bbs_recruit/update.do?num=${dto.num}&page=${page}';">수정</button>
			          <button type="button" class="btn" onclick="deleteBoard('${dto.num}');">삭제</button>
			    </c:if>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/bbs_recruit/list.do?page=${page}';">리스트</button>
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