<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/img/titlelogo.png">
<title>뺀질코딩-에러떠요!</title>
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
.title-style{
	width:350px;
	padding:0 5px;
	overflow:hidden; 
	text-overflow:ellipsis;
	white-space:nowrap;

}
</style>

<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
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
    	<c:if test ="${category=='all'}">
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/error_logo.png" style="width: 50px; height: 37.5px;"> 에러떠요!</h3>
        </div>
       </c:if>
       <c:if test ="${category=='Etc.'}">
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/error_logo.png" style="width: 50px; height: 37.5px;"> 기타 에러</h3>
        </div>
       </c:if>
       <c:if test ="${category!='all' && category!='Etc.'}">
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/error_logo.png" style="width: 50px; height: 37.5px;"> ${category} 에러</h3>
        </div>
       </c:if>
       
        <div>
        	<form name="errorForm" method="post">
			<table style="width: 100%; margin-top: 20px; border-spacing: 0; font-family:  'Jua', sans-serif;">
			   <tr height="35">
			      <td align="left" width="50%">
			          ${dataCount}개(${page}/${total_page} 페이지)
			      </td>
			      <td align="right">
			          &nbsp;
			      </td>
			   </tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;font-family:  'Jua', sans-serif;">
			  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <th width="60" style="color: #787878;">번호</th>
			      <th style="color: #787878;">제목</th>
			      <th width="100" style="color: #787878;">작성자</th>
			      <th width="80" style="color: #787878;">작성일</th>
			      <th width="60" style="color: #787878;">조회수</th>
			  </tr>
			 
			 <c:forEach var="dto" items="${list}">
			  <tr align="center" height="35" style="border-bottom: 1px solid #cccccc;"> 
			      <td>${dto.listNum}</td>
			      <td align="left" style="padding-left: 10px; display: flex; padding-top: 8px;">
			      <p class="title-style">
			      	<c:forEach var="n" begin="1" end="${dto.depth}">&nbsp;&nbsp;</c:forEach>
			      
			      	<c:if test="${dto.depth!=0}">
			      	<span style="color:black;"> └ </span>
			      	<c:choose>
			            <c:when test="${dto.memberClass == 0}">
			                <span style="color:#FF9933;"> 🤴 관리자</span>
			            </c:when>
			            <c:when test="${dto.memberClass==1}">
			                <span style="color:green;">🙇‍♀️  뺀질이</span>
			            </c:when>
			            <c:when test="${dto.memberClass ==2}">
			                <span style="color:blue;">👨‍💻  코인물</span>
			            </c:when>
		            </c:choose>
		            <a href="${articleUrl}&boardNum=${dto.boardNum}">${dto.subject}</a>
           			</c:if >
           			<c:if test="${dto.depth==0}">
           			<a href="${articleUrl}&boardNum=${dto.boardNum}">${dto.subject}</a>
           			</c:if>
					</p>
					<p>
			      	<c:if test="${dto.gap<=1 }">
			     			<img src="${pageContext.request.contextPath}/resource/images/new.gif" style="width: 15px; height: 10px;">
			     	</c:if> 
			     	</p>
			      </td>
			     
			      <td>
			      
			       <c:choose>
			            <c:when test="${dto.memberClass == 0}">
			                <span>🤴 </span>
			            </c:when>
			            <c:when test="${dto.memberClass==1}">
			                <span>🙇‍♀️</span>
			            </c:when>
			            <c:when test="${dto.memberClass ==2}">
			                <span>👨‍💻</span>
			            </c:when>
		           </c:choose>
			      ${dto.userName}
			      </td>
			      
			      <td>${dto.created}</td>
			      <td>${dto.hitCount}</td>
			  </tr>
			  </c:forEach>
			</table>
			 </form>
			 
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			   <tr height="35">
				<td align="center">
			        ${dataCount==0?"등록된 게시물이 없습니다.":paging}
				</td>
			   </tr>
			</table>
			
			<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			   <tr height="40">
			      <td align="left" width="100">
			          <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/error_board/list.do';">새로고침</button>
			      </td>
			      <td align="center">
			          <form name="searchForm" action="${pageContext.request.contextPath}/error_board/list.do" method="post">
			              <select name="condition" class="selectField">
			                  <option value="all"      ${condition=="all"?"selected='selected'":""}>제목+내용</option>
			                  <option value="subject"  ${condition=="subject"?"selected='selected'":""}>제목</option>
			                  <option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
			                  <option value="content"  ${condition=="content"?"selected='selected'":""}>내용</option>
			                  <option value="created"  ${condition=="created"?"selected='selected'":""}>등록일</option>
			            </select>
			            <input type="text" name="keyword" class="boxTF">
			            <button type="button" class="btn" onclick="searchList()">검색</button>
			        </form>
			      </td>
			      <td align="right" width="100">
			          <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/error_board/created.do';">글올리기</button>
			      </td>
			   </tr>
			</table>
        </div>
    </div>
</div>
</div>
</div>
</div>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>