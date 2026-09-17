<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="/resources/css/mentoringTeamList.css" rel="stylesheet">

<jsp:include page="../include/header.jsp" />

<main class="patrit-main">
	<div class="patrit-wrap">

		<!-- 제목 -->
		<div class="term-select">
			<div class="patrit-title">
				<c:choose>
					<c:when test="${loginUser.authority eq 'A'}">
						멘토링 관리
					</c:when>
					<c:otherwise>
						멘토링
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<!-- 연도/학기 선택 -->
		<div class="patrit-toolbar">

			<div class="patrit-dropdown" id="termDropdown">

				<button class="patrit-term-btn"
					type="button"
					id="termBtn"
					aria-expanded="false">

					<span>
						${selectedYear}년 ${selectedTerm}학기
					</span>

					<span class="patrit-arrow">▼</span>

				</button>

				<ul class="patrit-menu" id="termMenu">

					<c:forEach var="yt" items="${yearTermList}">

						<li data-year="${yt.year}"
							data-term="${yt.term}"
							class="${yt.year eq selectedYear and yt.term eq selectedTerm ? 'is-selected' : ''}">

							${yt.year}년 ${yt.term}학기

						</li>

					</c:forEach>

				</ul>

			</div>

		</div>

		<!-- 팀 목록 -->
		<section class="card-grid">

			<c:forEach var="team" items="${teamList}" varStatus="status">

				<c:url var="mentoringUrl" value="/mentoring/mentoringList">
					<c:param name="teamNum" value="${team.teamNum}" />
				</c:url>

				<a class="activity-card" href="${mentoringUrl}">

					<div class="card-bottom">

						<span class="card-title">
							${team.teamName}
						</span>

						<img class="card-image"
							src="/resources/emo${status.count}.png"
							alt="팀 이미지">

					</div>

				</a>

			</c:forEach>

			<c:if test="${empty teamList}">
				<p class="empty-msg">
					해당 학기에 등록된 멘토링 팀이 없습니다.
				</p>
			</c:if>

		</section>

	</div>
</main>

</div>

<script>
	const termDropdown = document.getElementById("termDropdown");
	const termBtn = document.getElementById("termBtn");
	const termMenu = document.getElementById("termMenu");

	// 연도/학기 드롭다운
	termBtn.addEventListener("click", function(event) {

		event.stopPropagation();

		termDropdown.classList.toggle("open");

		termBtn.setAttribute(
			"aria-expanded",
			termDropdown.classList.contains("open")
		);
	});

	// 연도/학기 선택
	termMenu.querySelectorAll("li").forEach(function(item) {

		item.addEventListener("click", function() {

			const url = new URL(
				window.location.origin + "/mentoring/dashboard"
			);

			url.searchParams.set("year", this.dataset.year);
			url.searchParams.set("term", this.dataset.term);

			window.location.href = url.toString();
		});
	});

	// 바깥 클릭 시 드롭다운 닫기
	document.addEventListener("click", function(event) {

		if (!termDropdown.contains(event.target)) {
			termDropdown.classList.remove("open");
			termBtn.setAttribute("aria-expanded", "false");
		}
	});
</script>

<jsp:include page="../include/footer.jsp" />