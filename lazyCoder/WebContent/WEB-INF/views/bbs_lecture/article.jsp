<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/img/titlelogo.png">
<title>뺀질코딩-영상공유게시판</title>

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
	margin: 30px auto;
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
</style>


<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery.min.js"></script>
<script type="text/javascript">
function deleteBoard(num) {
	<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}"> 
	<!-- 로그인 아이디와 게시글 아이디가 동일하면. 조건 충족하지 않으면 소스보기에서 안 보임. 실무에서는 아이디가 아니라 권한(rol)으로 함. -->
	   if(confirm("게시물을 삭제 하시겠습니까 ?")) {
	      var url="${pageContext.request.contextPath}/bbs_lecture/delete.do";
	      location.href=url+"?${query}&num=${dto.num}";
	   }
	</c:if>
	<c:if test ="${sessionScope.member.userId!='admin' && sessionScope.member.userId != dto.userId}">
	   alert('게시글을 삭제할 수 있는 권한이 없습니다.');
	</c:if>
	}
</script>
</head>
<body>


    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>

<div class="section" >
<div class="container">
    <div class="body-container" style="width: 700px;">
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/know_logo.png" style="width: 50px; height: 37.5px;">강의공유 게시판 </h3>
        </div>
        
        <div>
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc; font-family: 'Jua', sans-serif;">
			    <td colspan="2" align="center">
				   ${dto.subject}
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px; font-family: 'Jua', sans-serif;">
			       이름 : ${dto.userName}
			    </td>
			    <td width="50%" align="right" style="padding-right: 5px; font-family: 'Jua', sans-serif;">
			        ${dto.register_date } | 조회 ${dto.hitCount}
			    </td>
			</tr>
			
			<tr style="border-bottom: 1px solid #cccccc; font-family: 'Jua', sans-serif;" >
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
			    <iframe width="560" height="315" src="https://www.youtube.com/embed/N82hJpl5cMM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
			   </td>
			</tr>
			<tr style="border-bottom: 1px solid #cccccc; font-family: 'Jua', sans-serif;" >
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
			      ${dto.content}
			   </td>
			</tr>
			
		
			
			<tr height="35" style="border-bottom: 1px solid #cccccc; font-family: 'Jua', sans-serif;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
					이전글 :
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/bbs_lecture/article.do?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
					</c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc; font-family: 'Jua', sans-serif;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/bbs_lecture/article.do?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
					</c:if>
			    </td>
			</tr>
			
			<tr height="45">
			    <td>
			          <c:if test="${sessionScope.member.userId==dto.userId}">
			              <button type="button" class="btn" style="font-family: 'Jua', sans-serif;" onclick="javascript:location.href='${pageContext.request.contextPath}/bbs_lecture/update.do?page=${page}&num=${dto.num}';">수정</button>
			       	  </c:if>
			          <button type="button" class="btn" onclick="deleteBoard('${dto.num}');" style="font-family: 'Jua', sans-serif;">삭제</button>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" style="font-family: 'Jua', sans-serif;" onclick="javascript:location.href='${pageContext.request.contextPath}/bbs_lecture/list.do?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
        </div>

    </div>
</div>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>