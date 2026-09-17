<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<link href="/resources/css/noticeUpdate.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<jsp:include page="../include/header.jsp" />




<main class="notice-update">
<div class="notice-update__container">

	<div class="notice-update__title">멘토링 게시글 수정</div>
	<div class="notice-update__divider"></div>

	<form action="/mentoring/update" role="form" name="frm" class="notice-update__form" method="post" enctype="multipart/form-data" id="noticeUpdate">
		<input type="hidden" name="userId" value="${loginUser.userId}" /> 
		<input type="hidden" name="mentoringNum" value="${mentoring.mentoringNum}" />
		<input type="hidden" name="weeklyNum" value="${weekly.weeklyNum}" /> 
		<input type="hidden" name="teamNum" value="${team.teamNum}" />
		
		<div class="notice-update__row">
			<label class="notice-update__label" for="title">주차</label>
			<div class="notice-update__field">
				<input id="title" class="notice-update__input" value="${weekly.weekName}주차" type="text" readonly/>
			</div>
		</div>
		
		<div class="notice-update__row">
			<label class="notice-update__label" for="title">활동명</label>
			<div class="notice-update__field">
				<input id="title" class="notice-update__input" value="${weekly.activityName}" type="text" readonly/>
			</div>
		</div>


		<!-- 제목 -->
		<div class="notice-update__row">
			<label class="notice-update__label" for="title">제목</label>
			<div class="notice-update__field">
				<input id="title" name="title" class="notice-update__input" value="${mentoring.title}" type="text" />
			</div>
		</div>

		<!-- 내용 -->
		<div class="notice-update__row">
			<label class="notice-update__label" for="content">내용</label>
			<div class="notice-update__field">
				<textarea id="content" name="content" class="notice-update__textarea">${mentoring.content}</textarea>
			</div>
		</div>



		<!-- 파일 -->
		<div class="notice-update__row">
			<div class="notice-update__label">파일</div>
			<div class="notice-update__field">
				<div class="notice-update__file-row">
					<label for="fileUpload" class="notice-update__file-btn">파일선택</label>
					<input type="hidden" id="uploadCount" value="${fn:length(files)}">
					<input id="fileUpload" name="fileUpload" type="file" class="notice-update__file-input" multiple /> 
					<span class="notice-update__file-name" id="fileName"></span>
				</div>
				<div id="existingFileList">
				<c:forEach var="file" items="${files}">
					<div class="row align-items-center existing-file-row"
						data-file-num="${file.fileNum}">
						<div class="col-auto">
							<a href="javascript:void(0);"
								onclick="location.href='/displayFile?fileName=' + encodeURIComponent('${file.files}')" style="padding-left: 5px;">${file.fileName}</a>
						</div>
						<div class="col-auto">
							<button type="button" class="btn btn-default btn-xs delbtn btn_onlyFileDelete" data-file-num="${file.fileNum}">
								<i class="far fa-trash-alt"></i>
							</button>
						</div>
					</div>
				</c:forEach>
				</div>
				<div>
					<ul class="dropzone-previews clearfix uploadedList"></ul>
				</div>
			</div>
		</div>

		<!-- 버튼 -->
		<div class="notice-update__actions">
			<button type="submit" class="notice-update__btn notice-update__btn--primary" id="btn_submit">수정</button>
			<button type="button" class="notice-update__btn notice-update__btn--ghost"
				onclick="location.href='/mentoring/read?mentoringNum=${mentoring.mentoringNum}'">취소</button>
		</div>

	</form>
</div>
</main>
</div>



<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript" src="/resources/upload.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="template" type="text/x-handlebars-template">
<li class="dropzone-previews" style="list-style-type: none;">
	<div class="card mt-1 mb-0 shadow-none border dz-processing dz-image-preview dz-success dz-complete">
		<div class="p-2">
			<div class="row align-items-center">
				 <div class="col-auto">
    				<img data-dz-thumbnail="" class="avatar-sm rounded bg-light" src="{{imgsrc}}">
 				 </div>
 				 <div class="col pl-0">
   					<a href="/displayFile?fileName={{fullName}}" class="text-muted font-weight-bold" data-dz-name="">{{fileName}}</a>
 				 </div>
 				 <div class="col-auto">
   					<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn"><i class="far fa-trash-alt"></i></a>
 				 </div>
			</div>
		</div> 
	</div>
</li>
</script>



<script>
	function validate() {
		var title = $("#title").val().trim();
		var content = $("#content").val().trim();

		if (title === "") {
			alert("제목을 입력해주세요.");
			$("#title").focus();
			return false;
		}

		if (content === "") {
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return false;
		}

		return confirm("수정하시겠습니까?"); 
	}

	$(function() {
		/* var $form = $("#noticeUpdate");

		// 기존에 붙어있는 submit 핸들러 싹 제거 후, 하나만 다시 붙임
		$form.off("submit").on("submit", function(e) {
			e.preventDefault();

			if (!validate())
				return;

			$form.attr("action", "/notice/update");
			$form.attr("method", "post");

			this.submit();
		}); */

		// 기존 파일 삭제 (AJAX)도 중복 바인딩 방지
		$(document).off("click", ".btn_onlyFileDelete").on("click",
				".btn_onlyFileDelete", function(e) {
					e.preventDefault();

					var fileNum = $(this).data("file-num");
					var $row = $(this).closest(".row");
					var uploaded = parseInt($("#uploadCount").val() || "0", 10);

					$.ajax({
						url : "/mentoring/onlyFileDelete",
						type : "post",
						data : {
							fileNum : fileNum
						},
						dataType : "text",
						success : function(result) {
							if (result === "deleted"){
								$row.remove();
								uploaded--;
								$("#uploadCount").attr("value", uploaded);
							
							}else
								alert("파일 삭제 실패");
						},
						error : function() {
							alert("파일 삭제 중 오류 발생");
						}
					});
				});
	});
</script>


<script>
	// 폼 제출 가로 막기 + 유효성 검사 + 파일 히든값 추가
	$(document).ready(
			function() {
				var formObj = $("form[role='form']"); // role="form" 속성이 있는 <form> 태그를 선택해서 formObj라는 변수에 저장

				// formObj 폼이 제출될 때 실행되는 함수
				formObj.submit(function(event) {
					event.preventDefault(); // 폼 기본 제출 막기(=페이지 새로고침, 이동 방지 및 제출 전 유효성 검사, 파일 처리를 먼저 하기 위함)

					//유효성 검사  (별도 정의 필요)
					var val = validate(); // validate()라는 함수를 호출해서 유효성 검사

					// 유효성 검사 통과 시 실행
					if (val) {

						var that = $(this);
						var str = "";

						// 업로드된 파일 목록을 input:hidden으로 만듦
						$(".uploadedList .delbtn").each(
								function(index) {
									str += "<input type='hidden' name='files'"
											+ " value='" + $(this).attr("href")
											+ "'> ";
								});

						that.append(str); // 폼에 숨겨진 input 추가
						console.log(str);

						that.get(0).submit(); // 폼 제출

					}//if문 종료 
				});
			});

	var template = Handlebars.compile($("#template").html());

	//클릭으로 파일 업로드할 때 호출되는 함수
	$("#fileUpload").on("change", function(event) {
		event.preventDefault();

		var uploaded = parseInt($("#uploadCount").val() || "0", 10);
		var files = document.getElementById("fileUpload").files;

		if (uploaded + files.length > 5) {
			alert('첨부파일은 5개 까지 업로드할 수 있습니다.');
			$("#fileUpload").val(""); // 같은 파일 다시 선택 가능
			return;
		}

		// 파일업로드 인풋에서 파일을 받음
		for (var i = 0; i < files.length; i++) {
			var formData = new FormData();
			formData.append("file", files[i]);

			// 새로운 폼데이터를 생성
			// var formData = new FormData();

			// 폼데이터에 파일을 붙임
			// formData.append("file", file);

			// AJAX로 uploadAjax 메소드를 호출해서 파일을 업로드함
			$.ajax({
				url : '/uploadAjax',
				data : formData,
				dataType : 'text',
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {

					var fileInfo = getFileInfo(data);
					var html = template(fileInfo);

					var str = "";

					$(".uploadedList").append(html);

					uploaded++;
					$("#uploadCount").attr("value", uploaded);

					//$(".uploadedList").append(str);
				}
			});
		}

		// ★ 이 줄 추가: 같은 파일 다시 선택 가능하게
		$("#fileUpload").val("");

	});

	//첨부파일 삭제 처리
	$(".uploadedList").on("click", ".delbtn", function(event) {
		event.preventDefault();

		var that = $(this);
		var uploaded = parseInt($("#uploadCount").val() || "0", 10);

		$.ajax({
			url : "/deleteFile",
			type : "post",
			data : {
				fileName : $(this).attr("href")
			},
			dataType : "text",
			success : function(result) {

				if (result == 'deleted') {

					that.closest("li").remove();
					uploaded--;
					$("#uploadCount").attr("value", uploaded);

					$("#fileUpload").val("");

				}
			}

		});

	});

	//파일링크 처리(길이를 줄여줌)
	function getOriginalName(title) {

		if (checkImageType(title)) {
			return;
		}

		var idx = title.indexOf("_") + 1;
		return title.substr(idx);
	}

	//이미지파일 원본 파일 찾기
	function getImageLink(title) {

		if (!checkImageType(title)) {
			return;
		}
		//title.substring(0,12)/년/월/일 경로 추출  
		//title.substring(14) 파일 이름앞의 's_'제거
		var front = title.substr(0, 12);
		var end = title.substr(14);

		return front + end;

	}
</script>




<jsp:include page="../include/footer.jsp" />