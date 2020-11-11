<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>spring</title>
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

#video{
	margin:30px auto;
	width: 700px;
	height: 400px;
	background: none;
	 overflow-y: scroll;
}
</style>

<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
			f.submit();
	}
	
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
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/bbs_know/list.do">책추천 게시판</a></li>
		      <li class="sidenav__list-item"><a href="${pageContext.request.contextPath}/bbs_lecture/list.do">유용한 강의공유</a></li>
		    </ul>
		  </aside>
		  
</div>

<div class="section" style="background: url('${pageContext.request.contextPath}/resource/img/container1.png');">
<div class="container">
    <div class="body-container" style="width: 700px;height:1200px;">
      <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/know_logo.png" style="width: 50px; height: 37.5px;">강의공유 게시판 </h3>
        </div>
        <div id="video">
	        <c:forEach var="vo" items="${list }">
	        	<div style="text-align: center;font-family: 'Jua', sans-serif; font-size: 15px; min-height: 50px;" >
					<hr>
	        		<p style="font-size: 20px;" onclick="article('${vo.num}');">${vo.subject}</p>
					<hr>
					<div style="width: 100%;">
					<span  style="float: left;">작성자 : ${vo.userName}</span>  <span style="float: right;">조회수 : ${vo.hitCount }</span>
					</div>
					<hr>
					${vo.url }
					<hr>
					
	        	</div>
	        	<div style="height: 15px;">&nbsp;</div>
	        </c:forEach>
	       </div>
	              <table style="width: 100%; border-spacing: 0;">
            <tr height="35">
            <td style="width: 33%;"></td>
            <td align="center" style="width: 33%;">
                 ${dataCount==0?"등록된 게시물이 없습니다." : paging}
            </td>
            <td  style="width: 33%;" align="right" >
		  <button type="button" class="btn" style="font-family: 'Jua', sans-serif;" onclick="javascript:location.href='${pageContext.request.contextPath}/bbs_lecture/created.do?rows=${rows}';">글올리기</button>
            
            </td>
            </tr>
         </table>
			<div style="clear: both;">
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