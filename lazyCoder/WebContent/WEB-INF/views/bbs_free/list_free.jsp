<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	height: 200px;
	background-color: skyblue;
	width: 25%;
	float :left;
}
.section {
	float :right;
	height: 200px;
	background-color: yellow;
	width: 65%;
	
}


</style>
</head>
<body>


<div class="header">
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
	
<div class="container">
    <div class="body-container" style="width: 700px;">
        <div class="body-title">
            <h3><span style="font-family: Webdings">2</span> 게시판 </h3>
        </div>
        
        <div>
			<table style="width: 100%; margin-top: 20px; border-spacing: 0;">
			   <tr height="35">
			      <td align="left" width="50%">
			          ${dataCount}개(${page}/${total_page} 페이지)
			      </td>
			      <td align="right">
			          &nbsp;
			      </td>
			   </tr>
			</table>
			
			<table style="width: 100%; border-spacing: 0; border-collapse: collapse;">
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
			      <td align="left" style="padding-left: 10px;">
			           <a href="${articleUrl}&num=${dto.num}">${dto.subject}</a>
			           
			           <c:if test="${dto.gap<1}">
			           <!-- new 한시간까지만 보여주게 함 -->
			           	
			           	<img src="${pageContext.request.contextPath}/resource/images/new.gif" style="width: 15px; height: 10px;">
			           </c:if>
			      </td>
			      <td>${dto.userName}</td>
			      <td>${dto.created}</td>
			      <td>${dto.hitCount}</td>
			  </tr>
			 </c:forEach>

			</table>
			 
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
			          <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/bbs_free/list_free.do';">새로고침</button>
			      </td>
			      <td align="center">
			          <form name="searchForm" action="${pageContext.request.contextPath}/bbs_free/list_free.do" method="post">
			              <select name="condition" class="selectField">
			                  <option value="all"  ${condition=="all"?"selected='selected'":""}>제목+내용</option>
			                  <option value="subject"  ${condition=="subject"?"selected='selected'":""}>제목</option>
			                  <option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
			                  <option value="content"  ${condition=="content"?"selected='selected'":""}>내용</option>
			                  <option value="created"  ${condition=="created"?"selected='selected'":""}>등록일</option>
			            </select>
			            <input type="text" name="keyword" class="boxTF" value="${keyword}">
			            <button type="button" class="btn" onclick="searchList()">검색</button>
			        </form>
			      </td>
			      <td align="right" width="100">
			          <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/bbs_free/created.do';">글올리기</button>
			      </td>
			   </tr>
			</table>
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