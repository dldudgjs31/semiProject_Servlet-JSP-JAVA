<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/img/titlelogo.png">
<title>뺀질코딩-책추천게시판</title>

<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resource/css/style.css"
   type="text/css">
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resource/css/layout.css"
   type="text/css">
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resource/jquery/css/smoothness/jquery-ui.min.css"
   type="text/css">

<style type="text/css">
.blind {
  position: absolute;
  overflow: hidden;
  margin: -1px;
  padding: 0;
  width: 1px;
  height: 1px;
  border: none;
  clip: rect(0, 0, 0, 0);
}

.startRadio {
  display: inline-block;
  overflow: hidden;
  height: 40px;
  &:after {
    content: "";
    display: block;
    position: relative;
    z-index: 10;
    height: 40px;
    background: url("data:image/png;base64,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")
      repeat-x 0 0;
    background-size: contain;
    pointer-events: none;
  }
  &__box {
    position: relative;
    z-index: 1;
    float: left;
    width: 20px;
    height: 40px;
    cursor: pointer;
    input {
      opacity: 0 !important;
      height: 0 !important;
      width: 0 !important;
      position: absolute !important;

      &:checked + .startRadio__img {
        background-color: #0084ff;
      }
    }
  }
  &__img {
    display: block;
    position: absolute;
    right: 0;
    width: 500px;
    height: 40px;
    pointer-events: none;
  }
}

.star {font-size:0; letter-spacing:-4px;}
.star a {
    font-size:22px;
    letter-spacing:0;
    display:inline-block;
    margin-left:3px;
    color:#cccccc;
    text-decoration:none;
}
.star a:first-child {margin-left:0;}
.star a.on {color:#F2CB61;}

</style>

<script type="text/javascript"
   src="${pageContext.request.contextPath}/resource/js/util.js"></script>
<script type="text/javascript"
   src="${pageContext.request.contextPath}/resource/jquery/js/jquery.min.js"></script>
<script type="text/javascript">
   function sendOk() {
      var f = document.boardForm;

      var str = f.bookName.value;
      if (!str) {
         alert("책제목을 입력하세요. ");
         f.bookName.focus();
         return;
      }
      
      var str = f.bookInfo.value;
      if (!str) {
         alert("저자를 입력하세요. ");
         f.bookInfo.focus();
         return;
      }

      var str = f.content.value;
      if (!str) {
         alert("내용을 입력하세요. ");
         f.content.focus();
         return;
      }
     
      var mode = "${mode}";
      if (mode == "created" && !f.selectFile.value) {
         alert("이미지 파일을 선택하세요.");
         f.selectFile.focus();
         return;
      }

      f.action = "${pageContext.request.contextPath}/bbs_know/${mode}_ok.do";

      f.submit();
   }
   
   <c:if test="${mode=='update'}">
      $(function(){ //jQuery 대화상자
         $("#myPhoto").click(function(){ //<img id="myPhoto"...를 클릭하면
            var viewer=$("#imageLayout");
            var s="<img src='${pageContext.request.contextPath}/uploads/bbs_know/${dto.imageFilename}' width='570' height='450'>" 
            viewer.html(s);
            
            $("#photoDialog").dialog({
               title:"이미지",
               width:600,
               height:520,
               modal:true
            });
         });
      });
   </c:if>
   
</script>

<script type="text/javascript">
$(function(){
	$( ".star a" ).click(function() {
		var b=$(this).hasClass("on");
	    $(this).parent().children("a").removeClass("on");
	    $(this).addClass("on").prevAll("a").addClass("on");
	    if(b) $(this).removeClass("on");
	    
	    var s=$(".star .on").length;
	    $("#rating").val(s);
	});
});
</script>
</head>
<body>


      <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>


   <div class="container">
      <div class="body-container" style="width: 700px;">
         <div class="body-title">
 
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/know_logo.png" style="width: 50px; height: 37.5px;">책 추천 게시판 </h3>
      
         </div>

         <div>
            <form name="boardForm" method="post" enctype="multipart/form-data">
               <table
                  style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse; font-family: 'Jua', sans-serif; ">
                  <tr align="left" height="40"
                     style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
                     <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
                     <td style="padding-left: 10px;"><input type="text"
                        name="bookName" maxlength="100" class="boxTF" style="width: 95%;"
                        value="${dto.bookName}"></td>
                  </tr>
                  
                  <tr align="left" height="40"
                     style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
                     <td width="100" bgcolor="#eeeeee" style="text-align: center;">저&nbsp;&nbsp;&nbsp;&nbsp;자</td>
                     <td style="padding-left: 10px;"><input type="text"
                        name="bookInfo" maxlength="100" class="boxTF" style="width: 95%;"
                        value="${dto.bookInfo}"></td>
                  </tr>
                  
                  
                  

                  <tr align="left" height="40"
                     style="border-bottom: 1px solid #cccccc;">
                     <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
                     <td style="padding-left: 10px;">
                        ${sessionScope.member.userName}</td>
                  </tr>
                  
                   

                  <tr align="left" style="border-bottom: 1px solid #cccccc;">
                     <td width="100" bgcolor="#eeeeee"
                        style="text-align: center; padding-top: 5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
                     <td valign="top" style="padding: 5px 0px 5px 10px;"><textarea
                           name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
                     </td>
                     
                     
                  </tr>

                  <tr align="left" height="40"
                     style="border-bottom: 1px solid #cccccc;">
                     <td width="100" bgcolor="#eeeeee" style="text-align: center;">이미지</td>
                     <td style="padding-left: 10px;">
                        <!-- file 객체는 value속성으로 초기화가 불가능하다. + (password도 안먹음) --> <input
                        type="file" name="selectFile" accept="image/*" class="boxTF"
                        size="53" style="height: 25px;">
                     </td>
                  </tr>

                  <c:if test="${mode == 'update' }">
                     <tr align="left" height="40"
                        style="border-bottom: 1px solid #cccccc;">
                        <td width="100" bgcolor="#eeeeee" style="text-align: center;">이미지</td>
                        <td style="padding-left: 10px;"><img id="myPhoto"
                           src="${pageContext.request.contextPath}/uploads/photo/${dto.imageFilename}"
                           width="30" height="30" style="cursor: pointer;"></td>
                     </tr>
                  </c:if>
                  
                  <tr align="left" height="40"
                     style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
                     <td width="100" bgcolor="#eeeeee" style="text-align: center;">별&nbsp;&nbsp;&nbsp;&nbsp;점</td>
                     <td style="padding-left: 10px;">
                     	<p class="star">
						    <a href="#">★</a>
						    <a href="#">★</a>
						    <a href="#">★</a>
						    <a href="#">★</a>
						    <a href="#">★</a>
						</p>
					 <input type="hidden" name="rating" id="rating" value="3">
					 </td>
                  </tr>

               </table>

               <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
                  <tr height="45">
                     <td align="center"><c:if test="${mode=='update'}">
                           <input type="hidden" name="page" value="${page}">
                           <input type="hidden" name="num" value="${dto.num}">
                           <input type="hidden" name="imageFilename"
                              value="${dto.imageFilename}">
                           <!-- 이미지파일 안보낼경우도 있어서  -->
                        </c:if>
                        <button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
                        <button type="reset" class="btn">다시입력</button>
                        <button type="button" class="btn"
                           onclick="javascript:location.href='${pageContext.request.contextPath}/bbs_know/list.do';">${mode=='update'?'수정취소':'등록취소'}</button>

                     </td>
                  </tr>
               </table>
            </form>
         </div>

      </div>
   </div>

   <div id="photoDialog">
      <div id="imageLayout"></div>
   </div>

      <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>

   <script type="text/javascript"
      src="${pageContext.request.contextPath}/resource/jquery/js/jquery-ui.min.js"></script>
   <script type="text/javascript"
      src="${pageContext.request.contextPath}/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>