<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/img/titlelogo.png">
<title>뺀질코딩-사진게시판</title>
<meta charset="UTF-8">
<link
	href="https://fonts.googleapis.com/css2?family=Jua&family=Pathway+Gothic+One&family=Roboto+Condensed&display=swap"
	rel="stylesheet">
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery.min.js"></script>
<title>Insert title here</title>
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

.list-photo{
	width:100%;
	display: flex;
	margin: 0 auto;
	text-align: center;
	margin-bottom: 20px;
}
.list-items{
	width: 180px;
	height: 150px;
	margin-left:36px;
	background: yellow;
	border-radius: 20px;
}
.title-style{
	width:200px;
	padding:0 5px;
	overflow:hidden; 
	text-overflow:ellipsis;
	white-space:nowrap;

}
</style>
<script type="text/javascript">
function article(num){
	var url="${articleUrl}&num="+num;
	location.href=url;
}

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
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/bbs_free/list_free.do"> 자유게시판</a></li>
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/bbs_best/list.do">HOT게시판</a></li>
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/bbs_photo/list.do">사진 게시판</a></li>
		    </ul>
		  </aside>
</div>
<div class="section" style="background: url('${pageContext.request.contextPath}/resource/img/container1.png');">
<div class="container">
    <div class="body-container" style="width: 700px;">
      <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/recruit_logo.png" style="width: 50px; height: 37.5px;"> 사진 게시판 </h3>
        </div>
        
        <div>

			<table style="width: 700px; margin: 20px auto 0px; border-spacing: 0px;font-family: 'Jua', sans-serif; ">
			 <c:forEach var="dto" items="${list}" varStatus="status">
			 	<c:if test="${status.index==0 }">
			 	<tr>
			 	</c:if>
			 	<c:if test="${status.index!=0 && status.index%3==0}">
			 		<c:out value="</tr><tr>" escapeXml="false"/>
			 	</c:if>
			 	
			 	<td width="230" align="center" >
			 		<div class="imgLayout" onclick="article('${dto.num}');"style="margin: 10px;">
			 		<div class="img_box"style="background: url('${pageContext.request.contextPath}/uploads/photo/${dto.fileName}');
				background-position: center;background-size:cover;background-position:center;height: 110px; border-radius: 15px; border:2px solid silver;">
				</div><Br>
				<p class="title-style" style="font-family: 'Jua', sans-serif; font-size: 15px;">
				 ${dto.subject} <p>
		 	
			 		</div>
			 	</td>
			 </c:forEach>
			<c:set var="n" value="${list.size()}"/> <!-- n은 리스트 개수 -->
			<c:if test="${n>0 && n%3!=0}">
				<c:forEach var="i" begin="${n%3+1}" end="3">
					<td width="210">
					<div class="imgLayout" style="cursor: default;">&nbsp;</div>
					</td>
				</c:forEach>
			</c:if>
			<c:if test="${n!=0}">
				<c:out value="</tr>" escapeXml="false"/>
			</c:if>
			</table>

			<table style="width: 100%; border-spacing: 0;">  
			   <tr height="35">
				<td align="center">
			        ${dataCount==0?"등록된 게시물이 없습니다.":paging}
				</td>
			   </tr>
			</table>
			
			<table style="width: 100%; margin-top: 10px; border-spacing: 0;">
			   <tr height="40">
			      <td align="left" width="100">
			     &nbsp;
			       </td>
			      <td align="center">
			           &nbsp;
			      </td>
			      <td align="right" width="100">
			          <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/bbs_photo/created.do';">사진올리기</button>
			      </td>
			   </tr>
			</table>

        </div>
    </div>
</div>
</div>
</div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

</body>
</html>