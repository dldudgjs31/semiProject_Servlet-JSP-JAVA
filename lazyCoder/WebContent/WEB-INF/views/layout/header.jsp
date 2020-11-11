<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
   padding: 15px 0;
}

.header {
   height: 100px;
   background-color: none;
   display: flex;
   margin: 0 auto;
   margin-bottom: 15px;
}

.header-box1 {
   width: 33%;
   margin: 0 auto;
}

.header-box2 {
   width: 33%;
   margin: 0 auto;
   text-align: center;
}

.header-box3 {
   width: 40%;
   margin: 0 auto;
   line-height: 100px;
   text-align: right;
   font-family: 'Jua', sans-serif;
}

.nav {
   height: 30px;
   display: flex;
   margin: 0 auto; /* 중앙정렬 */
   border-bottom: 3px solid silver;
   padding-bottom: 13px;
   margin-bottom: 10px;
}

/* Navigation
--------------------------------------------------------------------------------------------------------------- */
nav ul, nav ol {
   margin: 0;
   padding: 0;
   list-style: none;
}

#mainav, #breadcrumb, .sidebar nav {
   line-height: normal;
}

#mainav .drop::after, #mainav li li .drop::after, #breadcrumb li a::after,
   .sidebar nav a::after {
   position: absolute;
   font-family: "FontAwesome";
   font-size: 14px;
   line-height: 10px;
}

/* Top Navigation */
#mainav {
   border: solid;
   border-width: 1px 0;
   font-family: 'Jua', sans-serif;
}

#mainav ul {
   text-transform: uppercase;
   text-align: center;
}

#mainav ul ul {
   z-index: 9999;
   position: absolute;
   width: 160px;
   text-transform: none;
   text-align: left;
}

#mainav ul ul ul {
   left: 160px;
   top: 0;
}

#mainav li {
   display: inline-block;
   position: relative;
   margin: 0 30px 0 0;
   padding: 0;
}

#mainav li:last-child {
   margin-right: 0;
}

#mainav li li {
   width: 100%;
   margin: 0;
}

#mainav li a {
   display: block;
   padding: 20px 0;
}

#mainav li li a {
   border: solid;
   border-width: 0 0 1px 0;
}

#mainav .drop {
   padding-left: 30px;
   font-size: 15px;
}

#mainav li li a, #mainav li li .drop {
   display: block;
   margin: 0;
   padding: 10px 15px;
}


#mainav ul ul {
   visibility: hidden;
   opacity: 0;
}

#mainav ul li:hover>ul {
   visibility: visible;
   opacity: 1;
}

#mainav form {
   display: none;
   margin: 0;
   padding: 20px 0;
}

#mainav form select, #mainav form select option {
   display: block;
   cursor: pointer;
   outline: none;
}

#mainav form select {
   width: 100%;
   padding: 5px;
   border: 1px solid;
}

#mainav form select option {
   margin: 5px;
   padding: 0;
   border: none;
}

/* Navigation */
#mainav li a {
   color: inherit;
}

#mainav .active a, #mainav a:hover, #mainav li:hover>a {
   color: #FFA41F;
   background-color: inherit;
}

#mainav li li a, #mainav .active li a {
   color: #FFFFFF;
   background-color: rgba(0, 0, 0, .6);
   border-color: rgba(0, 0, 0, .3);
}

#mainav li li:hover>a, #mainav .active .active>a {
   color: #FFFFFF;
   background-color: #FFA41F;
}

#mainav form select {
   color: #FFFFFF;
   background-color: #000000;
   border-color: rgba(255, 255, 255, .3);
}

img {
   width: 173px;
   height: 100px;
}
</style>
</head>
<body>
   <div class="container">
      <div class="header">
         <div class="header-box1"></div>
         <div class="header-box2">
            <a href="${pageContext.request.contextPath}/">
            <img alt="로고이미지"
               src="${pageContext.request.contextPath}/resource/img/logo1.png" 
                onmouseover="this.src='${pageContext.request.contextPath}/resource/img/logo2.png'"
                onmouseout="this.src='${pageContext.request.contextPath}/resource/img/logo1.png'"
                style="cursor: pointer;">
            </a> 
         </div>
         <div class="header-box3">
                     <c:if test="${empty sessionScope.member}">
                <a href="${pageContext.request.contextPath}/member/login.do">로그인</a>
                    &nbsp;|&nbsp;
                <a href="${pageContext.request.contextPath}/member/member.do">회원가입</a>
            </c:if>
            <c:if test="${not empty sessionScope.member}">
               <c:choose>
               <c:when test="${sessionScope.member.userId=='admin'}">
                   <span style="color:#FF9933;">🤴 전지전능한</span>
               </c:when>
               <c:when test="${sessionScope.member.memberClass==1}">
                   <span style="color:green;">🙇 ♀️  뺀질이</span>
               </c:when>
               <c:when test="${sessionScope.member.memberClass==2}">
                   <span style="color:blue;">👨 💻  코인물</span>
               </c:when>
               </c:choose>
                <span style="color:black;">${sessionScope.member.userName}</span>님
                    &nbsp;|&nbsp;
                    <a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
                    &nbsp;|&nbsp;
                    <a href="${pageContext.request.contextPath}/member/update.do">정보수정</a>
                    &nbsp;|&nbsp;
                    
                    <c:if test="${sessionScope.member.userId=='admin'}">
                       <a href="${pageContext.request.contextPath}/member/list.do">회원정보</a>
                    </c:if>
            </c:if>
         </div>
      </div>
      
      
  

      <nav id="mainav">  
         <!-- ################################################################################################ -->
         <ul class="clear">
            <li class="active"><a href="${pageContext.request.contextPath}/">Home</a></li>

            <li><a class="drop" href="${pageContext.request.contextPath}/intro/intro.jsp">what? 뺀질코딩</a>
            </li>
            <li><a class="drop" href="${pageContext.request.contextPath}/bbs_free/list_free.do">커뮤니티</a>
               <ul>
                  <li><a href="${pageContext.request.contextPath}/bbs_free/list_free.do">자유게시판</a></li>
                  <li><a href="${pageContext.request.contextPath}/bbs_best/list.do">HOT게시판</a></li>
                  <li><a href="${pageContext.request.contextPath}/bbs_photo/list.do">사진게시판</a></li>
               </ul></li>

            <li><a class="drop" href="${pageContext.request.contextPath}/code/clist.do">비밀의 소스코드</a>
               <ul>
                  <li><a href="${pageContext.request.contextPath}/code/clist.do">C</a></li>
                  <li><a href="${pageContext.request.contextPath}/code/c++list.do">C++</a></li>
                  <li><a href="${pageContext.request.contextPath}/code/javalist.do">JAVA</a></li>
                  <li><a href="${pageContext.request.contextPath}/code/html/csslist.do">HTML/CSS</a></li>
                  <li><a href="${pageContext.request.contextPath}/code/javascriptlist.do">JAVASCRIPT</a></li>
               </ul></li>
            <li><a class="drop" href="${pageContext.request.contextPath}/bbs_know/list.do">지식인</a>
               <ul>
                  <li><a href="${pageContext.request.contextPath}/bbs_know/list.do">좋은책추천해요</a></li>
                  <li><a href="${pageContext.request.contextPath}/bbs_lecture/list.do">유용한 강의 공유</a></li>
               </ul></li>
            <li><a class="drop" href="${pageContext.request.contextPath}/error_board/list.do">에러떠요!</a>
               <ul>
                  <li><a href="${pageContext.request.contextPath}/error_board/list_404.do">404/500 에러</a></li>
                  <li><a href="${pageContext.request.contextPath}/error_board/list_Null.do">NullPointer 에러</a></li>
                  <li><a href="${pageContext.request.contextPath}/error_board/list_Exception.do">Exception 예외</a></li>
                  <li><a href="${pageContext.request.contextPath}/error_board/list_Etc.do">기타</a></li>
               </ul></li>
            <li><a class="drop" href="${pageContext.request.contextPath}/notice/list.do">공지게시판</a>
               <ul>
                  <li><a href="${pageContext.request.contextPath}/notice/list.do">공지사항</a></li>
                  <li><a href="${pageContext.request.contextPath}/bbs_recruit/list.do">채용공고</a></li>
                  <li><a href="#">출석체크!</a></li>
               </ul></li>
               
            

            


         </ul>
         <!-- ################################################################################################ -->
      </nav>
   </div>




</body>
</html>