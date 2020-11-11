<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/img/titlelogo.png">
<title>뺀질코딩</title>
<link
	href="https://fonts.googleapis.com/css2?family=Jua&family=Pathway+Gothic+One&family=Roboto+Condensed&display=swap"
	rel="stylesheet">
<%-- <link
	href="${pageContext.request.contextPath}/resource/styles/layout.css"
	rel="stylesheet" type="text/css" media="all"> --%>
<style type="text/css">
.container {
	width: 1080px;
	margin: 0 auto; /* 중앙정렬 */
	font-family: 'Jua', sans-serif;
}

.bbs {
	height: 200px;
	background-color: none;
	margin-bottom: 10px;
	margin-top: 20px;
}

<!--
상단 광고 이미지 슬라이드 style 코드 -->ul, li {
	list-style: none;
}

#slide {
	height: 400px;
	position: relative;
	overflow: hidden;
}

#slide ul {
	width: 400%;
	height: 100%;
	transition: 1s;
	list-style: none;
	padding: 0;
}

#slide ul:after {
	content: "";
	display: block;
	clear: both;
}

#slide li {
	float: left;
	width: 25%;
	height: 100%;
}

/* #slide li:nth-child(1) {
	background:
		url("${pageContext.request.contextPath}/resource/img/main1.jpg");
	background-size: cover;
}

#slide li:nth-child(2) {
	background:
		url("${pageContext.request.contextPath}/resource/img/main2.jpg");
	background-size: cover;
}

#slide li:nth-child(3) {
	background:
		url("${pageContext.request.contextPath}/resource/img/main1.jpg");
	background-size: cover;
}

#slide li:nth-child(4) {
	background:
		url("${pageContext.request.contextPath}/resource/img/main2.jpg");
	background-size: cover;
} */

#slide input {
	display: none;
}

#slide label {
	display: inline-block;
	vertical-align: middle;
	width: 10px;
	height: 10px;
	border: 2px solid #666;
	background: #fff;
	transition: 0.3s;
	border-radius: 50%;
	cursor: pointer;
}

#slide .pos {
	text-align: center;
	position: absolute;
	bottom: 10px;
	left: 0;
	width: 100%;
	text-align: center;
}

#pos1:checked ~ul{
	margin-left: 0%;
}

#pos2:checked ~ul{
	margin-left: -100%;
}

#pos3:checked ~ul{
	margin-left: -200%;
}

#pos4:checked ~ul{
	margin-left: -300%;
}

#pos1:checked ~.pos>label:nth-child(1) {
	background: #666;
}

#pos2:checked ~.pos>label:nth-child(2) {
	background: #666;
}

#pos3:checked ~.pos>label:nth-child(3) {
	background: #666;
}

#pos4:checked ~.pos>label:nth-child(4) {
	background: #666;
}

#main-test {
	padding-top: 100px;
	padding-left: 100px;
	color: white;
	font-size: 20px;
}

.main-button {
	font-family: 'Jua', sans-serif;
	font-size: 14px;
	font-weight: bold;
	line-height: 2;
	border: none;
	border-radius: 10px;
	text-align: center;
	cursor: pointer;
	background: white;
	color: black;
	-webkit-transition-duration: 0.4s;
	transition-duration: 0.4s;
}

.main-button:hover {
	color: #fff;
}

.hover1:hover {
	box-shadow: 200px 0 0 0 rgba(0, 0, 0, 0, 5) inset;
	background-color: skyblue;
	border: none;
}

.menu {
	display: flex;
	margin: 0 auto;
	width: 100%;
}

#main-test {
	font-family: 'Jua', sans-serif;
	font-size: 40px;
}

.menu-item {
	width: 18%;
	height: 150px;
	background: none;
	margin: 1%;
	text-align: center;
	font-family: 'Jua', sans-serif;
}

.menu-items {
	display: flex;
	margin: 0 auto;
	width: 100px;
	height: 100px;
}
#bbs-img{
	width:100%;
	display: flex;
	margin: 0 auto;
	text-align: center;
}
.main-frame{
	width: 30%;
	height:250px;
	margin:2.5%;
	background: none;
	text-align: center;
}
.img-box{
	width: 90%;
	height : 80%;
	margin: 5%;
	border-radius: 20px;
	border: 2px solid silver;
}
.title-style{
	width:80%;
	margin-left:10%;
	text-align:center;
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
function article1(num){
	var url="${articleUrl1}&num="+num;
	location.href=url;
}
function article2(num){
	var url="${articleUrl2}&num="+num;
	location.href=url;
}

</script>



</head>
<body>
	<div class="container">
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />

		<div class="main">

			<div id="slide">
				<input type="radio" name="pos" id="pos1" checked> <input
					type="radio" name="pos" id="pos2"> <input type="radio"
					name="pos" id="pos3"> <input type="radio" name="pos"
					id="pos4">
				<ul>
					<li style="background:url('${pageContext.request.contextPath}/resource/img/main1.jpg'); background-size: cover;">
						<p id="main-test">
							안녕하세요 <br>뺀질코딩입니다.<br>
							<button class="main-button hover1" onclick="location.href='${pageContext.request.contextPath}/intro/intro.jsp'">더 알아보기</button>
						</p>
					</li>
					<li style="background:url('${pageContext.request.contextPath}/resource/img/main2.jpg'); background-size: cover;"></li>
					<li style="background:url('${pageContext.request.contextPath}/resource/img/main1.jpg'); background-size: cover;"></li>
					<li style="background:url('${pageContext.request.contextPath}/resource/img/main2.jpg'); background-size: cover;"></li>
				</ul>
				<p class="pos">
					<label for="pos1"></label> <label for="pos2"></label> <label
						for="pos3"></label> <label for="pos4"></label>
				</p>
			</div>

		</div>
<p style="font-size: 20px;">| 뺀질코딩 카테고리</p>
		<div class="bbs">
			<div class="menu">
				<div class="menu-item">
				<a href="${pageContext.request.contextPath}/bbs_free/list_free.do">
					<img class="menu-items"
						src="${pageContext.request.contextPath}/resource/img/idea.png"
					 onmouseover="this.src='${pageContext.request.contextPath}/resource/img/icon1.png'"
					 onmouseout="this.src='${pageContext.request.contextPath}/resource/img/idea.png'"
					 style="cursor: pointer;">
					<p>커뮤니티</p>
					</a>
				</div>
				<div class="menu-item">
				<a href="${pageContext.request.contextPath}/code/clist.do">
					<img class="menu-items"
						src="${pageContext.request.contextPath}/resource/img/coding1.png"
					 onmouseover="this.src='${pageContext.request.contextPath}/resource/img/icon2.png'"
					 onmouseout="this.src='${pageContext.request.contextPath}/resource/img/coding1.png'"
					 style="cursor: pointer;">
					<p>비밀의 소스코드</p>
					</a>
				</div>
				<div class="menu-item">
				<a href="${pageContext.request.contextPath}/bbs_know/list.do">
					<img class="menu-items"
						src="${pageContext.request.contextPath}/resource/img/book-stack.png"
					 onmouseover="this.src='${pageContext.request.contextPath}/resource/img/icon3.png'"
					 onmouseout="this.src='${pageContext.request.contextPath}/resource/img/book-stack.png'"
					 style="cursor: pointer;">
					<p>지식인</p>
				</a>
				</div>
				<div class="menu-item">
				<a href="${pageContext.request.contextPath}/error_board/list.do">
					<img class="menu-items"
						src="${pageContext.request.contextPath}/resource/img/error404.png"
					 onmouseover="this.src='${pageContext.request.contextPath}/resource/img/icon4.png'"
					 onmouseout="this.src='${pageContext.request.contextPath}/resource/img/error404.png'"
					 style="cursor: pointer;">
					<p>에러떠요!</p>
					</a>
				</div>
				<div class="menu-item">
				<a href="${pageContext.request.contextPath}/notice/list.do">
					<img class="menu-items"
						src="${pageContext.request.contextPath}/resource/img/noticeboard.png"
					 onmouseover="this.src='${pageContext.request.contextPath}/resource/img/icon5.png'"
					 onmouseout="this.src='${pageContext.request.contextPath}/resource/img/noticeboard.png'"
					 style="cursor: pointer;">
					<p>공지게시판</p>
					</a>
				</div>
			</div>
		</div>
		<p style="font-size: 20px;">| 뺀질코더들의 이야기</p>
		<p style="font-size: 18px;">👩‍💻 최근 채용 현황</p>
		
		<div class="bbs" id="bbs-img">
		<c:forEach var="dto" items="${list}" varStatus="status">
		<c:if test="${status.index==0}">
			</c:if>
		<div class="main-frame" onclick="article('${dto.num}');">
			<div class="img-box" style="background: url('${pageContext.request.contextPath}/uploads/bbs_recruit/${dto.imageFilename}');background-position: center;background-size:cover;background-position:center;">
			<div style="margin:0 auto; margin-top:5px; width:140px; background-color:red; ; color: white; border-radius: 10px;">
			<c:choose>
				<c:when test="${dto.leftDate>=10}">
				마감까지 D- ${dto.leftDate} 
				</c:when>
				<c:when test="${dto.leftDate<0}">
				끝난채용 D+ ${-dto.leftDate} 
				</c:when>
				<c:when test="${dto.leftDate<10 && dto.leftDate>0}">
				 마감임박! D- ${dto.leftDate} 
				</c:when>
				<c:when test="${dto.leftDate==0}">
				 오늘마감!
				</c:when>
				</c:choose>
			
			</div>
			</div>
			
			<p class="title-style">${dto.subject}</p>
			<p>
			

				</p>
		</div>
		</c:forEach>
		

		</div>
		
		
		<br><br><br><br><br><br>
	<p style="font-size: 18px;">  📖    코더들의 책추천</p>

	<div class="bbs" id="bbs-img">
		<c:forEach var="dto" items="${list1}">
		
		<div class="main-frame" onclick="article1('${dto.num}');">
			<div class="img-box" style="background: url('${pageContext.request.contextPath}/uploads/photo/${dto.imageFilename}');background-position: center;background-size:cover;background-position:center;">
			
			</div>
			
			<p style="color:gold; font-size: 23px;">
			    <c:choose>
	               	<c:when test="${dto.rating==1}">★</c:when>
	               	<c:when test="${dto.rating==2}">★★</c:when>
	               	<c:when test="${dto.rating==3}">★★★</c:when>
	               	<c:when test="${dto.rating==4}">★★★★</c:when>
	                <c:when test="${dto.rating==5}">★★★★★</c:when>
               </c:choose>
            </p>
			<p class="title-style">${dto.bookName}</p>
		</div>
		</c:forEach>  
		

		

		</div>

<br><br><br><br><br><br><br><br>
	<p style="font-size: 18px;">📷 사진 게시판</p>
		<div class="bbs" id="bbs-img">
		
		<c:forEach var="dto" items="${list2}">
		
		<div class="main-frame" onclick="article2('${dto.num}');">
			<div class="img-box" style="background: url('${pageContext.request.contextPath}/uploads/photo/${dto.fileName}');background-position: center;background-size:cover;background-position:center;">
			
			</div>
			
			<p class="title-style">${dto.subject} </p>
			 <p>
				<c:choose>
					 <c:when test="${dto.memberClass==0}"> <span>🤴 </span></c:when>
					 <c:when test="${dto.memberClass==1}"><span>🙇‍♀️</span></c:when>
					 <c:when test="${dto.memberClass==2}"><span>👨‍💻</span></c:when>
				 </c:choose>
				 ${dto.userName}
			</p>

		</div>
		</c:forEach>  
		

		</div>
		<br><br><br><br><br><br><br><br><br>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</div>




</body>
</html>