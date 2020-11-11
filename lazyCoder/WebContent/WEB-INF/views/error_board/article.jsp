<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/img/titlelogo.png">
<title>뺀질코딩-에러떠요!</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery.min.js"></script>

<style type="text/css">
.container {
	width: 1080px;
	margin: 0 auto;/* 중앙정렬 */
	
}
.content{
	overflow:hidden;
	/* display: flex; */
}
.aside {
	height: 600px;
	width: 25%;
	float :left;
}
.section {
	float :right;
	height: 600px;
	width: 70%;
	border-radius: 20px;
}
.body-container{
margin-left: 30px;
}
.sidenav {
  grid-area: sidenav;
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  transition: all .6s ease-in-out;
/*   background-color: #394263; */
  
  border-radius: 20px;
  
}
.sidenav.active {
  transform: translateX(0);
}
.sidenav__close-icon {
  visibility: visible;
  top: 8px;
  right: 12px;
  cursor: pointer;
  font-size: 20px;
  color: #ddd;
  
}
.sidenav__list {
  padding: 0;
  margin-top: 85px;
  list-style-type: none;
}
.sidenav__list-item {
  padding: 20px 20px 20px 40px;
  color: black;
  font-family: 'Jua', sans-serif;
  font-size: 20px;
}
.sidenav__list-item:hover {
  background-color: rgba(255, 255, 255, 0.2);
  cursor: pointer;
}
</style>

<script type="text/javascript">
<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
function deleteBoard(boardNum) {
	if(confirm("게시물을 삭제 하시겠습니까 ?")) {
		var url="${pageContext.request.contextPath}/error_board/delete.do?boardNum="+boardNum+"&${query}";
		location.href=url;
	}
}
</c:if>
</script>
</head>
<body>

<div class="container">
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="content">
<div class="aside">
		  <aside class="sidenav" style="background-image: url('${pageContext.request.contextPath}/resource/img/aside3.png');">
		    <div class="sidenav__close-icon">
		      <i class="fas fa-times sidenav__brand-close"></i>
		    </div>
		    <ul class="sidenav__list">
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/error_board/list.do"> 에러떠요!</a></li>
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/error_board/list_404.do">└ 404/500 에러</a></li>
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/error_board/list_Null.do">└ NullPointer 에러</a></li>
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/error_board/list_Exception.do">└ Exception 에러</a></li>
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/error_board/list_Etc.do">└ 기타 에러</a></li>
		    </ul>
		  </aside>
</div>
<div class="section" style="background: url('${pageContext.request.contextPath}/resource/img/container1.png');">
<div class="container">
    <div class="body-container" style="width: 700px;">
       <c:if test ="${dto.category=='Etc.'}">
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/error_logo.png" style="width: 50px; height: 37.5px;"> 기타 에러</h3>
        </div>
       </c:if>
       <c:if test ="${dto.category!='Etc.'}">
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/error_logo.png" style="width: 50px; height: 37.5px;"> ${dto.category} 에러</h3>
        </div>
       </c:if>
        
        <div>
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;font-family:  'Jua', sans-serif;">
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
			        ${dto.created } | 조회 ${dto.hitCount}
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">
			       에러 : ${dto.category}
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
                         <a href="${pageContext.request.contextPath}/error_board/article.do?boardNum=${preReadDto.boardNum}&${query}">${preReadDto.subject}</a>
                  </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       다음글 :
                  <c:if test="${not empty nextReadDto}">
                         <a href="${pageContext.request.contextPath}/error_board/article.do?boardNum=${nextReadDto.boardNum}&${query}">${nextReadDto.subject}</a>
                  </c:if>
			    </td>
			</tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;font-family:  'Jua', sans-serif;">
			<tr height="45">
			    <td width="300" align="left">
			    
			    	  <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/error_board/reply.do?boardNum=${dto.boardNum}&page=${page}';">답변</button>
			          <c:if test="${sessionScope.member.userId == dto.userId}">
			              <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/error_board/update.do?boardNum=${dto.boardNum}&${query}';">수정</button>
			          </c:if>
			          <c:if test="${sessionScope.member.userId != dto.userId}">
			              <button type="button" class="btn" disabled="disabled">수정</button>
			          </c:if>
			          <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
			              <button type="button" class="btn" onclick="deleteBoard('${dto.boardNum}');">삭제</button>
			          </c:if>
			          <c:if test="${sessionScope.member.userId!=dto.userId && sessionScope.member.userId!='admin'}">
			              <button type="button" class="btn" disabled="disabled">삭제</button>
			          </c:if>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/error_board/list.do?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
        </div>

    </div>
</div>
</div>
</div>
</div>

<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>