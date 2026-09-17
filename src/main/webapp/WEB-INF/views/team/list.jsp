<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="/resources/css/actList.css" rel="stylesheet">

<jsp:include page="../include/header.jsp" />

<main class="activity-main">
<div class="activity-wrap">

	<div class="term-select">
		<div class="activity-title">팀 관리</div>
	</div>

	<!-- 연도/학기 선택 -->
	<div class="activity-toolbar">

		<div class="activity-dropdown" id="termDropdown">

			<button class="activity-term-btn" type="button" id="termBtn"
				aria-expanded="false">

				<span> <c:out value="${year}" />년 <c:out value="${term}" />학기
				</span> <span class="activity-arrow">▼</span>
			</button>

			<ul class="activity-menu" id="termMenu">

				<c:forEach var="yt" items="${yearTermList}">

					<li data-year="${yt.year}" data-term="${yt.term}"
						class="${yt.year eq year and yt.term eq term ? 'is-selected' : ''}">

						<c:out value="${yt.year}" />년 <c:out value="${yt.term}" />학기

					</li>

				</c:forEach>

			</ul>

		</div>

	</div>

	<!-- 검색 + 등록 -->
	<div class="activity-toolbar activity-toolbar--search">

		<div class="activity-search">

			<input id="activityQ" type="search" placeholder="검색"
				value="${cri.keyword}" /> <a id="searchBtn"
				href="javascript:void(0);" class="iq-bg-primary" aria-label="검색">

				<svg class="activity-search-icon" viewBox="0 0 24 24" fill="none"
					aria-hidden="true">

		<path d="M10.5 18a7.5 7.5 0 1 1 0-15 7.5 7.5 0 0 1 0 15Z"
						stroke="currentColor" stroke-width="2" opacity=".7" />

		<path d="M16.5 16.5 21 21" stroke="currentColor" stroke-width="2"
						stroke-linecap="round" opacity=".7" />

	</svg>

			</a>

		</div>

		<button class="activity-btn" type="button"
			onclick="location.href='/team/register'">등록</button>

	</div>

	<!-- 팀 목록 -->
	<table class="activity-table">

		<thead>
			<tr>
				<th class="col-no">No.</th>
				<th>팀명</th>
				<th class="col-views">멘토</th>
				<th class="col-date">연도</th>
				<th class="col-date">학기</th>
			</tr>
		</thead>

		<tbody>

			<c:if test="${not empty list}">

				<c:forEach items="${list}" var="team" varStatus="status">

					<tr>

						<td class="col-no">${pageMaker.totalCount
								- ((pageMaker.cri.page - 1)
								* pageMaker.cri.perPageNum
								+ status.index)}
						</td>

						<td class="col-title"><a
							href="/team/read?teamNum=${team.teamNum}"> ${team.teamName} </a>
						</td>

						<td class="col-views">${team.name}</td>

						<td class="col-date">${team.year}</td>

						<td class="col-date">${team.term}</td>

					</tr>

				</c:forEach>

			</c:if>

			<c:if test="${empty list}">
				<tr>
					<td colspan="5">내역이 없습니다.</td>
				</tr>
			</c:if>

		</tbody>

	</table>

	<!-- 페이지네이션 -->
	<c:if test="${pageMaker.totalCount > 0}">

		<nav class="activity-pager" aria-label="페이지네이션">

			<!-- 이전 -->
			<c:choose>

				<c:when test="${pageMaker.prev}">
					<button class="activity-chev" type="button"
						onclick="goPage(${pageMaker.startPage - 1})">&lt;</button>
				</c:when>

				<c:otherwise>
					<button class="activity-chev" type="button" disabled>&lt;
					</button>
				</c:otherwise>

			</c:choose>

			<!-- 페이지 번호 -->
			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
				var="pno">

				<button
					class="activity-page ${pageMaker.cri.page == pno ? 'is-active' : ''}"
					type="button" onclick="goPage(${pno})">${pno}</button>

			</c:forEach>

			<!-- 다음 -->
			<c:choose>

				<c:when test="${pageMaker.next}">
					<button class="activity-chev" type="button"
						onclick="goPage(${pageMaker.endPage + 1})">&gt;</button>
				</c:when>

				<c:otherwise>
					<button class="activity-chev" type="button" disabled>&gt;
					</button>
				</c:otherwise>

			</c:choose>

		</nav>

	</c:if>

</div>
</main>

</div>

<script>
	const termDropdown = document.getElementById("termDropdown");
	const termBtn = document.getElementById("termBtn");
	const termMenu = document.getElementById("termMenu");
	const searchBtn = document.getElementById("searchBtn");
	const searchInput = document.getElementById("activityQ");

	// 연도/학기 드롭다운
	termBtn.addEventListener("click", function(event) {

		event.stopPropagation();

		termDropdown.classList.toggle("open");

		termBtn.setAttribute(
			"aria-expanded",
			termDropdown.classList.contains("open")
		);
	});

	termMenu.querySelectorAll("li").forEach(function(item) {

		item.addEventListener("click", function() {

			const url = new URL(
				window.location.origin + "/team/list"
			);

			url.searchParams.set("year", this.dataset.year);
			url.searchParams.set("term", this.dataset.term);
			url.searchParams.set("page", "1");

			window.location.href = url.toString();
		});
	});

	document.addEventListener("click", function(event) {

		if (!termDropdown.contains(event.target)) {
			termDropdown.classList.remove("open");
			termBtn.setAttribute("aria-expanded", "false");
		}
	});

	// 검색
	function goSearch() {

		const keyword = searchInput.value.trim();

		const url = new URL(
			window.location.origin + "/team/list"
		);

		url.searchParams.set("year", "${year}");
		url.searchParams.set("term", "${term}");
		url.searchParams.set("page", "1");

		if (keyword !== "") {
			url.searchParams.set("keyword", keyword);
		}

		window.location.href = url.toString();
	}

	searchBtn.addEventListener("click", goSearch);

	searchInput.addEventListener("keydown", function(event) {

		if (event.key === "Enter") {
			event.preventDefault();
			goSearch();
		}
	});

	// 페이지 이동
	function goPage(page) {

		const url = new URL(
			window.location.origin + "/team/list"
		);

		url.searchParams.set("page", page);
		url.searchParams.set(
			"perPageNum",
			"${pageMaker.cri.perPageNum}"
		);
		url.searchParams.set("year", "${year}");
		url.searchParams.set("term", "${term}");

		const keyword = "${cri.keyword}";

		if (keyword !== "") {
			url.searchParams.set("keyword", keyword);
		}

		window.location.href = url.toString();
	}
</script>

<jsp:include page="../include/footer.jsp" />