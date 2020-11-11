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
	width:300px;
	padding:0 5px;
	overflow:hidden; 
	text-overflow:ellipsis;
	white-space:nowrap;

}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery.min.js"></script>
<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
</script>
</head>
<body>
<div class="container">
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
<div class="content">
<div class="aside">
		  <aside class="sidenav" style="background-image: url('${pageContext.request.contextPath}/resource/img/aside3.png');">
		    <div class="sidenav__close-icon">
		      <i class="fas fa-times sidenav__brand-close"></i>
		    </div>
		    <ul class="sidenav__list">
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/code/clist.do"> c언어 </a></li>
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/code/c++list.do"> c++언어 </a></li>
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/code/javalist.do"> JAVA </a></li>
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/code/html/csslist.do"> Http/Css</a></li>
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/code/javascriptlist.do"> Javascript</a></li>
		      
		      
		    </ul>
		  </aside>
</div>
<div class="section" style="background: url('${pageContext.request.contextPath}/resource/img/container1.png');">

<div class="container">
    <div class="body-container" style="width: 1000px;">
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/source_logo.png" style="width: 50px; height: 37.5px;"> ${category} 게시판 </h3>
        </div>
        
        <div>
			<table style="width: 100%; margin-top: 20px; border-spacing: 0; font-family: 'Jua', sans-serif;">
			   <tr height="35">
			      <td align="left" width="50%">
			          ${dataCount}개(${page}/${total_page} 페이지)
			      </td>
			      <td align="right">
			          &nbsp;
			      </td>
			   </tr>
			</table>
			
			<table style="width: 700px; border-spacing: 0; border-collapse: collapse; font-family: 'Jua', sans-serif;">
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
			      <td align="left" style="padding-left: 10px; display: flex; padding-top: 8px; ">
			          <p class="title-style"> <a href="${articleUrl}&num=${dto.num}&category=${category}">${dto.subject}</a>
			          
			          <p>
			     		<c:if test="${dto.gap<=1 }">
			     			<p><img src="${pageContext.request.contextPath}/resource/images/new.gif" style="width: 15px; height: 10px;"><p>
			     		</c:if>
			      </td>
			      <td>${dto.userId}</td>
			      <td>${dto.register_date}</td>
			      <td>${dto.hitCount}</td>
			  </tr>
			 </c:forEach>

			</table>
			 
			<table style="width: 700px; margin: 0px ; border-spacing: 0px; font-family: 'Jua', sans-serif;">
			   <tr height="35">
				<td align="center">
					${dataCount!=0?paging:"등록된 게시물이 없습니다."}
				</td>
			   </tr>
			</table>
			
			<table style="width: 650px; margin: 10px; border-spacing: 0px; font-family: 'Jua', sans-serif;">
			   <tr height="40">
			      <td align="left" width="100">
			          <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/code/${category}list.do';" style="font-family: 'Jua', sans-serif;">새로고침</button>
			      </td>
			      <td align="center">
			          <form name="searchForm" action="${pageContext.request.contextPath}/code/${category}list.do" method="post">
			              <select name="condition" class="selectField" style="font-family: 'Jua', sans-serif;">
			                  <option value="all"  ${condition=="all"?"selected='selected'":""}>제목+내용</option>
			                  <option value="subject"  ${condition=="subject"?"selected='selected'":""}>제목</option>
			                  <option value="userId" ${condition=="userId"?"selected='selected'":""}>작성자</option>
			                  <option value="content"  ${condition=="content"?"selected='selected'":""}>내용</option>
			                  <option value="created"  ${condition=="created"?"selected='selected'":""}>등록일</option>
			            </select>
			            <input type="text" name="keyword" class="boxTF" value="${keyword}" style="font-family: 'Jua', sans-serif;">
			            <button type="button" class="btn" onclick="searchList()" style="font-family: 'Jua', sans-serif;">검색</button>
			        </form>
			      </td>
			      <td align="right" width="100">
			          <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/code/created.do?category=${category }';" style="font-family: 'Jua', sans-serif;">글올리기</button>
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