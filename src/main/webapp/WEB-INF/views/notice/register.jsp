<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link href="/resources/css/noticeRegister.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<jsp:include page="../include/header.jsp" />

<main class="notice-register">
<div class="notice-register__container">

	<div class="notice-register__title">공지사항 등록</div>
	<div class="notice-register__divider"></div>

	<form action="/notice/register"
		name="frm"
		class="notice-register__form"
		method="post">

		<!-- 제목 -->
		<div class="notice-register__row">

			<label class="notice-register__label" for="title">
				제목
			</label>

			<div class="notice-register__field">
				<input id="title"
					name="title"
					class="notice-register__input"
					type="text"
					placeholder="제목을 입력해주세요.">
			</div>

		</div>

		<!-- 대상 -->
		<div class="notice-register__row">

			<label class="notice-register__label" for="category">
				대상
			</label>

			<div class="notice-register__field">

				<div class="notice-register__select-wrap">

					<select id="category"
						name="category"
						class="notice-register__select">

						<option value="">선택</option>
						<option value="A">전체</option>
						<option value="M">멘토</option>
						<option value="S">멘티</option>

					</select>

					<span class="notice-register__caret">▼</span>

				</div>

			</div>

		</div>

		<!-- 내용 -->
		<div class="notice-register__row">

			<label class="notice-register__label" for="content">
				내용
			</label>

			<div class="notice-register__field">
				<textarea id="content"
					name="content"
					class="notice-register__textarea"
					placeholder="내용을 입력해주세요."></textarea>
			</div>

		</div>

		<!-- 첨부파일 -->
		<div class="notice-register__row">

			<div class="notice-register__label">
				파일
			</div>

			<div class="notice-register__field">

				<div class="notice-register__file-row">

					<label for="fileUpload"
						class="notice-register__file-btn">
						파일선택
					</label>

					<input type="hidden"
						id="uploadCount"
						value="0">

					<input id="fileUpload"
						type="file"
						class="notice-register__file-input"
						multiple>

				</div>

				<ul class="dropzone-previews clearfix uploadedList"></ul>

			</div>

		</div>

		<!-- 버튼 -->
		<div class="notice-register__actions">

			<button type="button"
				class="notice-register__btn notice-register__btn--primary"
				onclick="registerNotice()">
				등록
			</button>

			<button type="button"
				class="notice-register__btn notice-register__btn--ghost"
				onclick="location.href='/notice/list'">
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

	function registerNotice() {

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

		if (confirm("공지사항을 등록하시겠습니까?")) {

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

	$(".uploadedList").on("click", ".delbtn", function(event) {

		event.preventDefault();

		var that = $(this);

		$.ajax({
			url : "/deleteFile",
			type : "POST",
			data : {
				fileName : that.attr("href")
			},
			dataType : "text",

			success : function(result) {

				if (result == "deleted") {

					that.closest("li").remove();

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