<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="/resources/css/noticeRead.css" rel="stylesheet">
<jsp:include page="../include/header.jsp" />

<main class="notice-read">
<div class="notice-read__container">

	<h1 class="notice-read__title">공지사항</h1>

	<form action="/notice/delete" method="post" name="removefrm">
		<input type="hidden" name="noticeNum" value="${notice.noticeNum}">

		<section class="notice-read__card">

			<!-- 제목 + 날짜 -->
			<div class="notice-read__headline">

				<h2 class="notice-read__subject">
					<c:choose>
						<c:when test="${notice.category eq 'A'}">[전체]</c:when>
						<c:when test="${notice.category eq 'M'}">[멘토]</c:when>
						<c:when test="${notice.category eq 'S'}">[멘티]</c:when>
					</c:choose>

					<c:out value="${notice.title}" />
				</h2>

				<div class="notice-read__meta">
					<span class="notice-read__meta-label">날짜</span>

					<time>
						<fmt:formatDate
							pattern="yyyy-MM-dd"
							value="${notice.regDate}" />
					</time>
				</div>

			</div>

			<div class="notice-read__rule"></div>

			<!-- 본문 -->
			<div class="notice-read__body">
				<p><c:out value="${notice.content}" /></p>
			</div>

			<div class="notice-read__bottom-rule"></div>

			<!-- 첨부파일 -->
			<c:if test="${not empty files}">
				<div class="notice-read__files">

					<ul class="uploadedList">
						<li>
							<div class="card">
								<div class="p-2">
									<div class="row">
										<div class="col pl-0">

											<c:forEach items="${files}" var="file">
												<div class="p-1 text-start">
													<a href="javascript:void(0);"
														onclick="location.href='/displayFile?fileName=' + encodeURIComponent('${file.files}')"
														style="padding-left: 5px;">
														<c:out value="${file.fileName}" />
													</a>
												</div>
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
			<div class="notice-read__actions">

				<c:if test="${loginUser.authority eq 'A'}">

					<button type="button"
						class="notice-read__btn notice-read__btn--edit"
						onclick="location.href='/notice/update?noticeNum=${notice.noticeNum}'">
						수정
					</button>

					<button type="button"
						class="notice-read__btn notice-read__btn--delete"
						onclick="deleteNotice()">
						삭제
					</button>

				</c:if>

				<button type="button"
					class="notice-read__btn notice-read__btn--close"
					onclick="location.href='/notice/list'">
					닫기
				</button>

			</div>

		</section>

	</form>

</div>
</main>
</div>
<script>
	function deleteNotice() {
		if (confirm("해당 공지사항을 삭제하시겠습니까?")) {
			document.forms["removefrm"].submit();
		}
	}
</script>

<jsp:include page="../include/footer.jsp" />