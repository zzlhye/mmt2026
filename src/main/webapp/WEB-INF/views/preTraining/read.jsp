<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="../include/header.jsp" />

<link href="/resources/css/preTrainingRead.css" rel="stylesheet">

<main class="preTraining-read">
<div class="preTraining-read__container">

	<h1 class="preTraining-read__title">사전교육</h1>

	<form action="/preTraining/delete" method="post" name="removefrm">
		<input type="hidden" name="preNum" value="${preTraining.preNum}">

		<!-- 영상 파일 찾기 -->
		<c:set var="videoFile" value="${null}" />

		<c:forEach items="${files}" var="file">

			<c:if test="${empty videoFile}">

				<c:set var="fileName" value="${fn:toLowerCase(file.fileName)}" />

				<c:set var="fileLength" value="${fn:length(fileName)}" />

				<c:set var="ext4"
					value="${fileLength >= 4
						? fn:substring(fileName, fileLength - 4, fileLength)
						: ''}" />

				<c:set var="ext5"
					value="${fileLength >= 5
						? fn:substring(fileName, fileLength - 5, fileLength)
						: ''}" />

				<c:if
					test="${ext4 eq '.mp4'
						or ext4 eq '.mov'
						or ext4 eq '.m4v'
						or ext4 eq '.ogg'
						or ext5 eq '.webm'}">

					<c:set var="videoFile" value="${file}" />

				</c:if>

			</c:if>

		</c:forEach>


		<!-- 영상 URL -->
		<c:if test="${not empty videoFile}">
			<c:url value="/displayVideo" var="videoUrl">
				<c:param name="fileName" value="${videoFile.files}" />
			</c:url>
		</c:if>


		<section
			class="preTraining-read__card ${not empty videoFile ? 'has-video' : ''}">

			<!-- 제목 + 날짜 -->
			<div class="preTraining-read__headline">

				<h2 class="preTraining-read__subject">

					<c:choose>
						<c:when test="${preTraining.category eq 'A'}">[전체]</c:when>
						<c:when test="${preTraining.category eq 'M'}">[멘토]</c:when>
						<c:when test="${preTraining.category eq 'S'}">[멘티]</c:when>
					</c:choose>

					${preTraining.title}

				</h2>

				<div class="preTraining-read__meta">

					<span class="preTraining-read__meta-label"> 날짜 </span>

					<time>
						<fmt:formatDate pattern="yyyy-MM-dd"
							value="${preTraining.regDate}" />
					</time>

				</div>

			</div>

			<div class="preTraining-read__rule"></div>


			<!-- 영상 -->
			<c:if test="${not empty videoFile}">

				<div class="preTraining-read__video">

					<div class="preTraining-read__videoBox" id="preVideoBox"
						onclick="playPreTrainingVideo()" role="button" tabindex="0"
						aria-label="영상 재생">

						<svg class="preTraining-read__playSvg" viewBox="0 0 100 100"
							aria-hidden="true">

								<circle cx="50" cy="50" r="46" fill="none" stroke="#1f1f1f"
								stroke-width="6" />

								<polygon points="42,30 72,50 42,70" fill="#1f1f1f" />

							</svg>

					</div>

					<div class="preTraining-read__videoPlayer" id="preVideoPlayer"
						style="display: none;">

						<video id="preTrainingVideo" controls playsinline
							preload="metadata">

							<source src="${videoUrl}">

							브라우저가 video 태그를 지원하지 않습니다.

						</video>

					</div>

				</div>

			</c:if>


			<!-- 본문 -->
			<div class="preTraining-read__body">
				<p>${preTraining.content}</p>
			</div>


			<div class="preTraining-read__bottom-rule"></div>


			<!-- 첨부파일 -->
			<c:if test="${not empty files}">

				<div class="preTraining-read__files">

					<ul class="uploadedList">

						<li>

							<div class="card">

								<div class="p-2">

									<div class="row">

										<div class="col pl-0">

											<c:forEach items="${files}" var="file">

												<c:set var="fileName"
													value="${fn:toLowerCase(file.fileName)}" />

												<c:set var="fileLength" value="${fn:length(fileName)}" />

												<c:set var="ext4"
													value="${fileLength >= 4
														? fn:substring(fileName, fileLength - 4, fileLength)
														: ''}" />

												<c:set var="ext5"
													value="${fileLength >= 5
														? fn:substring(fileName, fileLength - 5, fileLength)
														: ''}" />

												<c:if
													test="${not (
														ext4 eq '.mp4'
														or ext4 eq '.mov'
														or ext4 eq '.m4v'
														or ext4 eq '.ogg'
														or ext5 eq '.webm'
													)}">

													<c:url value="/displayFile" var="fileUrl">

														<c:param name="fileName" value="${file.files}" />

													</c:url>

													<div class="p-1 text-start">

														<a href="${fileUrl}" style="padding-left: 5px;">
															${file.fileName} </a>

													</div>

												</c:if>

											</c:forEach>

										</div>

									</div>

								</div>

							</div>

						</li>

					</ul>

				</div>

			</c:if>


			<!-- 버튼 -->
			<div class="preTraining-read__actions">

				<c:if test="${loginUser.authority eq 'A'}">

					<button type="button"
						class="preTraining-read__btn preTraining-read__btn--edit"
						onclick="location.href='/preTraining/update?preNum=${preTraining.preNum}'">
						수정</button>

					<button type="submit"
						class="preTraining-read__btn preTraining-read__btn--delete" onclick="deletePreTraining()">
						삭제</button>

				</c:if>

				<button type="button"
					class="preTraining-read__btn preTraining-read__btn--close"
					onclick="location.href='/preTraining/list'">닫기</button>

			</div>

		</section>

	</form>

</div>
</main>

</div>


<script>
	function playPreTrainingVideo() {

		var box = document.getElementById("preVideoBox");
		var player = document.getElementById("preVideoPlayer");
		var video = document.getElementById("preTrainingVideo");

		if (!box || !player || !video) {
			return;
		}

		box.style.display = "none";
		player.style.display = "block";

		video.play();
	}
</script>

<script>
	function deletePreTraining() {
		if (confirm("해당 사전교육을 삭제하시겠습니까?")) {
			document.forms["removefrm"].submit();
		}
	}
</script>

<jsp:include page="../include/footer.jsp" />