<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="/resources/css/noticeRegister.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<jsp:include page="../include/header.jsp" />

<main class="notice-register">
	<div class="notice-register__container">

		<div class="notice-register__title">멘토링 게시글 등록</div>
		<div class="notice-register__divider"></div>

		<form action="/mentoring/register"
			role="form"
			name="frm"
			class="notice-register__form"
			method="post">

			<input type="hidden" name="userId" value="${loginUser.userId}" />
			<input type="hidden" name="weeklyNum" value="${weekly.weeklyNum}" />
			<input type="hidden" name="teamNum" value="${team.teamNum}" />

			<!-- 주차 -->
			<div class="notice-register__row">
				<label class="notice-register__label" for="weekName">주차</label>

				<div class="notice-register__field">
					<input id="weekName"
						class="notice-register__input"
						type="text"
						value="${weekly.weekName}주차"
						readonly />
				</div>
			</div>

			<!-- 활동명 -->
			<div class="notice-register__row">
				<label class="notice-register__label" for="activityName">활동명</label>

				<div class="notice-register__field">
					<input id="activityName"
						class="notice-register__input"
						type="text"
						value="${weekly.activityName}"
						readonly />
				</div>
			</div>

			<!-- 제목 -->
			<div class="notice-register__row">
				<label class="notice-register__label" for="title">제목</label>

				<div class="notice-register__field">
					<input id="title"
						name="title"
						class="notice-register__input"
						type="text"
						placeholder="제목을 입력해주세요." />
				</div>
			</div>

			<!-- 내용 -->
			<div class="notice-register__row">
				<label class="notice-register__label" for="content">내용</label>

				<div class="notice-register__field">
					<textarea id="content"
						name="content"
						class="notice-register__textarea"
						placeholder="내용을 입력해주세요."></textarea>
				</div>
			</div>

			<!-- 파일 -->
			<div class="notice-register__row">
				<div class="notice-register__label">파일</div>

				<div class="notice-register__field">

					<div class="notice-register__file-row">

						<label for="fileUpload"
							class="notice-register__file-btn">
							파일선택
						</label>

						<input type="hidden"
							id="uploadCount"
							value="0" />

						<input id="fileUpload"
							type="file"
							class="notice-register__file-input"
							multiple />

					</div>

					<ul class="dropzone-previews clearfix uploadedList"></ul>

				</div>
			</div>

			<!-- 버튼 -->
			<div class="notice-register__actions">

				<button type="submit"
					class="notice-register__btn notice-register__btn--primary">
					등록
				</button>

				<button type="button"
					class="notice-register__btn notice-register__btn--ghost"
					onclick="location.href='/mentoring/mentoringList?teamNum=${team.teamNum}'">
					취소
				</button>

			</div>

		</form>

	</div>
</main>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script src="/resources/upload.js"></script>


<!-- 첨부파일 미리보기 -->
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
$(document).ready(function() {

	const form = $("form[role='form']");
	const template = Handlebars.compile($("#template").html());


	/* =========================
	   게시글 등록
	   ========================= */

	form.on("submit", function(event) {

		event.preventDefault();

		const title = $("#title").val().trim();
		const content = $("#content").val().trim();

		// 제목 검사
		if (title === "") {
			alert("제목을 입력해주세요.");
			$("#title").focus();
			return;
		}

		// 내용 검사
		if (content === "") {
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return;
		}

		if (!confirm("등록하시겠습니까?")) {
			return;
		}


		// 업로드된 첨부파일 정보를 hidden input으로 추가
		$(".uploadedList .delbtn").each(function() {

			$("<input>")
				.attr("type", "hidden")
				.attr("name", "files")
				.val($(this).attr("href"))
				.appendTo(form);
		});


		// 실제 폼 제출
		this.submit();
	});


	/* =========================
	   첨부파일 업로드
	   ========================= */

	$("#fileUpload").on("change", function() {

		let uploaded = parseInt($("#uploadCount").val() || "0", 10);
		const files = this.files;


		// 최대 5개
		if (uploaded + files.length > 5) {

			alert("첨부파일은 최대 5개까지 업로드할 수 있습니다.");

			$(this).val("");

			return;
		}


		for (let i = 0; i < files.length; i++) {

			const formData = new FormData();

			formData.append("file", files[i]);


			$.ajax({

				url: "/uploadAjax",
				type: "POST",

				data: formData,

				dataType: "text",

				processData: false,
				contentType: false,

				success: function(data) {

					const fileInfo = getFileInfo(data);
					const html = template(fileInfo);

					$(".uploadedList").append(html);

					uploaded++;

					$("#uploadCount").val(uploaded);
				},

				error: function() {
					alert("파일 업로드 중 오류가 발생했습니다.");
				}

			});
		}


		// 같은 파일 다시 선택 가능
		$(this).val("");
	});


	/* =========================
	   첨부파일 삭제
	   ========================= */

	$(".uploadedList").on("click", ".delbtn", function(event) {

		event.preventDefault();

		const button = $(this);

		$.ajax({

			url: "/deleteFile",
			type: "POST",

			data: {
				fileName: button.attr("href")
			},

			dataType: "text",

			success: function(result) {

				if (result === "deleted") {

					button.closest("li").remove();

					let uploaded = parseInt(
						$("#uploadCount").val() || "0",
						10
					);

					uploaded = Math.max(0, uploaded - 1);

					$("#uploadCount").val(uploaded);
				}
			},

			error: function() {
				alert("파일 삭제 중 오류가 발생했습니다.");
			}

		});
	});

});
</script>

<jsp:include page="../include/footer.jsp" />