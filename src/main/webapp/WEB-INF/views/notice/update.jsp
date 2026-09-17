<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link href="/resources/css/noticeUpdate.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<jsp:include page="../include/header.jsp" />

<main class="notice-update">
<div class="notice-update__container">

	<div class="notice-update__title">공지사항 수정</div>
	<div class="notice-update__divider"></div>

	<form action="/notice/update"
		name="frm"
		class="notice-update__form"
		method="post">

		<input type="hidden"
			name="noticeNum"
			value="${notice.noticeNum}">

		<!-- 제목 -->
		<div class="notice-update__row">

			<label class="notice-update__label" for="title">
				제목
			</label>

			<div class="notice-update__field">
				<input id="title"
					name="title"
					class="notice-update__input"
					value="${notice.title}"
					type="text">
			</div>

		</div>

		<!-- 대상 -->
		<div class="notice-update__row">

			<label class="notice-update__label" for="category">
				대상
			</label>

			<div class="notice-update__field">

				<div class="notice-update__select-wrap">

					<select id="category"
						name="category"
						class="notice-update__select">

						<option value="">선택</option>

						<option value="A"
							<c:if test="${notice.category eq 'A'}">selected</c:if>>
							전체
						</option>

						<option value="M"
							<c:if test="${notice.category eq 'M'}">selected</c:if>>
							멘토
						</option>

						<option value="S"
							<c:if test="${notice.category eq 'S'}">selected</c:if>>
							멘티
						</option>

					</select>

					<span class="notice-update__caret">▼</span>

				</div>

			</div>

		</div>

		<!-- 내용 -->
		<div class="notice-update__row">

			<label class="notice-update__label" for="content">
				내용
			</label>

			<div class="notice-update__field">
				<textarea id="content"
					name="content"
					class="notice-update__textarea">${notice.content}</textarea>
			</div>

		</div>

		<!-- 첨부파일 -->
		<div class="notice-update__row">

			<div class="notice-update__label">
				파일
			</div>

			<div class="notice-update__field">

				<div class="notice-update__file-row">

					<label for="fileUpload"
						class="notice-update__file-btn">
						파일선택
					</label>

					<input type="hidden"
						id="uploadCount"
						value="${fn:length(files)}">

					<input id="fileUpload"
						type="file"
						class="notice-update__file-input"
						multiple>

				</div>

				<!-- 기존 첨부파일 -->
				<div id="existingFileList">

					<c:forEach var="file" items="${files}">

						<div class="row align-items-center existing-file-row">

							<div class="col-auto">

								<a href="javascript:void(0);"
									onclick="location.href='/displayFile?fileName=' + encodeURIComponent('${file.files}')"
									style="padding-left: 5px;">
									<c:out value="${file.fileName}" />
								</a>

							</div>

							<div class="col-auto">

								<a href="javascript:void(0);"
									class="btn btn-default btn-xs pull-right btn_onlyFileDelete"
									data-file-num="${file.fileNum}">
									<i class="far fa-trash-alt"></i>
								</a>

							</div>

						</div>

					</c:forEach>

				</div>

				<!-- 새로 추가한 첨부파일 -->
				<ul class="dropzone-previews clearfix uploadedList"></ul>

			</div>

		</div>

		<!-- 버튼 -->
		<div class="notice-update__actions">

			<button type="button"
				class="notice-update__btn notice-update__btn--primary"
				onclick="updateNotice()">
				수정
			</button>

			<button type="button"
				class="notice-update__btn notice-update__btn--ghost"
				onclick="location.href='/notice/read?noticeNum=${notice.noticeNum}'">
				취소
			</button>

		</div>

	</form>

</div>
</main>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="/resources/upload.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<script id="template" type="text/x-handlebars-template">
<li class="dropzone-previews" style="list-style-type: none;">
	<div class="card mt-1 mb-0 shadow-none border dz-processing dz-image-preview dz-success dz-complete">
		<div class="p-2">
			<div class="row align-items-center">

				<div class="col-auto">
					<img data-dz-thumbnail=""
						class="avatar-sm rounded bg-light"
						src="{{imgsrc}}">
				</div>

				<div class="col pl-0">
					<a href="/displayFile?fileName={{fullName}}"
						class="text-muted font-weight-bold"
						data-dz-name="">
						{{fileName}}
					</a>
				</div>

				<div class="col-auto">
					<a href="{{fullName}}"
						class="btn btn-default btn-xs pull-right delbtn">
						<i class="far fa-trash-alt"></i>
					</a>
				</div>

			</div>
		</div>
	</div>
</li>
</script>

<script>
	var template = Handlebars.compile($("#template").html());

	// 공지사항 수정
	function updateNotice() {

		var title = $("#title").val().trim();
		var category = $("#category").val();
		var content = $("#content").val().trim();

		if (title == "") {
			alert("제목을 입력해주세요.");
			$("#title").focus();
			return;
		}

		if (category == "") {
			alert("대상을 선택해주세요.");
			$("#category").focus();
			return;
		}

		if (content == "") {
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return;
		}

		if (confirm("해당 공지사항을 수정하시겠습니까?")) {

			// 새로 업로드한 파일 정보 추가
			$(".uploadedList .delbtn").each(function() {

				$("<input>")
					.attr("type", "hidden")
					.attr("name", "files")
					.val($(this).attr("href"))
					.appendTo(document.frm);

			});

			document.frm.submit();
		}
	}

	// 기존 첨부파일 삭제
	$(".btn_onlyFileDelete").on("click", function(event) {

		event.preventDefault();

		var button = $(this);
		var fileNum = button.data("file-num");

		$.ajax({
			url : "/notice/onlyFileDelete",
			type : "POST",
			data : {
				fileNum : fileNum
			},
			dataType : "text",

			success : function(result) {

				if (result == "deleted") {

					button.closest(".existing-file-row").remove();

					var uploaded = parseInt(
						$("#uploadCount").val() || "0", 10
					);

					$("#uploadCount").val(
						Math.max(uploaded - 1, 0)
					);

				} else {
					alert("파일 삭제에 실패했습니다.");
				}
			},

			error : function() {
				alert("파일 삭제 중 오류가 발생했습니다.");
			}
		});
	});

	// 새 첨부파일 업로드
	$("#fileUpload").on("change", function() {

		var uploaded = parseInt(
			$("#uploadCount").val() || "0", 10
		);

		var files = this.files;

		if (uploaded + files.length > 5) {
			alert("첨부파일은 5개까지 업로드할 수 있습니다.");
			$("#fileUpload").val("");
			return;
		}

		for (var i = 0; i < files.length; i++) {

			var formData = new FormData();
			formData.append("file", files[i]);

			$.ajax({
				url : "/uploadAjax",
				data : formData,
				dataType : "text",
				processData : false,
				contentType : false,
				type : "POST",

				success : function(data) {

					var fileInfo = getFileInfo(data);
					var html = template(fileInfo);

					$(".uploadedList").append(html);

					uploaded++;
					$("#uploadCount").val(uploaded);
				}
			});
		}

		$("#fileUpload").val("");
	});

	// 새로 업로드한 첨부파일 삭제
	$(".uploadedList").on("click", ".delbtn", function(event) {

		event.preventDefault();

		var button = $(this);

		$.ajax({
			url : "/deleteFile",
			type : "POST",
			data : {
				fileName : button.attr("href")
			},
			dataType : "text",

			success : function(result) {

				if (result == "deleted") {

					button.closest("li").remove();

					var uploaded = parseInt(
						$("#uploadCount").val() || "0", 10
					);

					$("#uploadCount").val(
						Math.max(uploaded - 1, 0)
					);
				}
			}
		});
	});
</script>

<jsp:include page="../include/footer.jsp" />