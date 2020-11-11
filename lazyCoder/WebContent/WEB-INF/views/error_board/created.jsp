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
    function sendOk() {
        var f = document.boardForm;
    	var str = f.subject.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.subject.focus();
            return;
        }
    	str = f.content.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return;
        }
   		f.action="${pageContext.request.contextPath}/error_board/${mode}_ok.do";
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
        
        <c:if test ="${mode == 'update'}">
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; ">게시글 수정</h3>
        </div>
       </c:if>
       
       <c:if test ="${mode == 'created'}">
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; ">게시글 작성</h3>
        </div>
       </c:if>
       
      <c:if test="${mode=='reply'}">
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; ">댓글 등록</h3>
        </div>
       </c:if>
       
        <div>
			<form name="boardForm" method="post">
			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse; font-family:  'Jua', sans-serif;" >
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding-left:10px;"> 
			       <c:if test="${mode=='reply'}">
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="Re : ${dto.subject}">
			        </c:if>
			        <c:if test="${mode == 'created' || mode == 'update'}">
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.subject}">
			        </c:if>
			      </td>
			  </tr>
			
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
			      <td style="padding-left:10px;"> 
			          ${sessionScope.member.userName}
			      </td>
			  </tr>
			
			<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">에러 종류</td>
			      <td style="padding-left:10px;"> 
			          <p style="margin-top: 1px; margin-bottom: 5px;">
			            <select class="selectField" id="category" name="category">
			                <option value="">선  택</option>
			                <option value="404/500" ${dto.category=="404/500" ? "selected='selected'" : ""}>404/500 에러</option>
			                <option value="NullPointer" ${dto.category=="NullPointer" ? "selected='selected'" : ""}>NullPointer 에러</option>
			                <option value="Exception" ${dto.category=="Exception" ? "selected='selected'" : ""}>Exception 에러</option>
			                <option value="Etc." ${dto.category=="Etc." ? "selected='selected'" : ""}>기타</option>
			            </select>
			        </p>
			      </td>
			  </tr>
			
			
			
			
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
			      </td>
			  </tr>
			  </table>
			
			  <table style="width: 100%; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			      	<c:if test="${mode=='update'}">
			      		<input type="hidden" name="boardNum" value="${dto.boardNum}">
			      		<input type="hidden" name="page" value="${page}">
			      		<input type="hidden" name="condition" value="${condition}">
			      		<input type="hidden" name="keyword" value="${keyword}">
			      		<input type="hidden" name="category" value="${dto.category}">
			      	</c:if>
			      	
			      	<c:if test="${mode=='reply'}">
			      		<input type="hidden" name="groupNum" value="${dto.groupNum}">
			      		<input type="hidden" name="orderNo" value="${dto.orderNo}">
			      		<input type="hidden" name="depth" value="${dto.depth}">
			      		<input type="hidden" name="parent" value="${dto.boardNum}">
			      		<input type="hidden" name="page" value="${page}">
			      		<input type="hidden" name="category" value="${dto.category}">
			      	</c:if>
			      	
			        <button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/error_board/list.do';">${mode=='update'?'수정취소':'등록취소'}</button>
			      </td>
			    </tr>
			  </table>
			</form>
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