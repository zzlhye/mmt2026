<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, viewport-fit=cover">

<title>멘토 목록</title>

<link href="/resources/css/mentoCheck.css" rel="stylesheet">
</head>

<body>

<main class="mento-main">
	<div class="mento-wrap">

		<!-- 제목 -->
		<div class="term-select">
			<div class="mento-title">멘토 목록</div>
		</div>

		<!-- 검색 -->
		<div class="mento-toolbar">
			<div class="mento-search">

				<a id="searchBtn"
					href="javascript:void(0);"
					class="iq-bg-primary"
					aria-label="검색">

					<svg class="mento-search-icon"
						viewBox="0 0 24 24"
						fill="none"
						aria-hidden="true">

						<path
							d="M10.5 18a7.5 7.5 0 1 1 0-15 7.5 7.5 0 0 1 0 15Z"
							stroke="currentColor"
							stroke-width="2"
							opacity=".7" />

						<path
							d="M16.5 16.5 21 21"
							stroke="currentColor"
							stroke-width="2"
							stroke-linecap="round"
							opacity=".7" />

					</svg>

				</a>

				<input id="mentoQ"
					type="search"
					placeholder="검색"
					value="${cri.keyword}" />

			</div>
		</div>

		<!-- 멘토 목록 -->
		<table class="mento-table">

			<thead>
				<tr>
					<th class="col-no">No.</th>
					<th>이름</th>
					<th class="col-date">학교</th>
					<th class="col-views">생년월일</th>
				</tr>
			</thead>

			<tbody>

				<c:if test="${not empty list}">

					<c:forEach items="${list}"
						var="user"
						varStatus="status">

						<tr>

							<td class="col-no">
								${pageMaker.totalCount
								- ((pageMaker.cri.page - 1)
								* pageMaker.cri.perPageNum
								+ status.index)}
							</td>

							<td class="col-title">
								<a href="javascript:void(0);"
									onclick="selectMento('${user.userId}', '${user.name}'); return false;">
									${user.name}
								</a>
							</td>

							<td class="col-date">
								${user.school}
							</td>

							<td class="col-views">
								<fmt:formatDate
									pattern="yyyy-MM-dd"
									value="${user.jumin}" />
							</td>

						</tr>

					</c:forEach>

				</c:if>

				<c:if test="${empty list}">
					<tr>
						<td colspan="4">내역이 없습니다.</td>
					</tr>
				</c:if>

			</tbody>

		</table>

		<!-- 페이지네이션 -->
		<c:if test="${pageMaker.totalCount > 0}">

			<nav class="mento-pager" aria-label="페이지네이션">

				<!-- 이전 -->
				<c:choose>

					<c:when test="${pageMaker.prev}">
						<button class="pager-chev"
							type="button"
							onclick="location.href='/team/mentoList${pageMaker.makeSearch(pageMaker.startPage - 1)}'">
							&lt;
						</button>
					</c:when>

					<c:otherwise>
						<button class="pager-chev"
							type="button"
							disabled>
							&lt;
						</button>
					</c:otherwise>

				</c:choose>

				<!-- 페이지 번호 -->
				<c:forEach begin="${pageMaker.startPage}"
					end="${pageMaker.endPage}"
					var="idx">

					<button
						class="pager-page ${pageMaker.cri.page == idx ? 'is-active' : ''}"
						type="button"
						onclick="location.href='/team/mentoList${pageMaker.makeSearch(idx)}'">

						${idx}

					</button>

				</c:forEach>

				<!-- 다음 -->
				<c:choose>

					<c:when test="${pageMaker.next}">
						<button class="pager-chev"
							type="button"
							onclick="location.href='/team/mentoList${pageMaker.makeSearch(pageMaker.endPage + 1)}'">
							&gt;
						</button>
					</c:when>

					<c:otherwise>
						<button class="pager-chev"
							type="button"
							disabled>
							&gt;
						</button>
					</c:otherwise>

				</c:choose>

			</nav>

		</c:if>

	</div>
</main>


<script>
	const searchBtn = document.getElementById("searchBtn");
	const searchInput = document.getElementById("mentoQ");

	// 검색
	function goSearch() {

		const keyword = searchInput.value.trim();

		const url = new URL(
			window.location.origin + "/team/mentoList"
		);

		url.searchParams.set("page", "1");

		if (keyword !== "") {
			url.searchParams.set("keyword", keyword);
		}

		window.location.href = url.toString();
	}

	// 돋보기 클릭
	searchBtn.addEventListener("click", function(event) {
		event.preventDefault();
		goSearch();
	});

	// Enter 검색
	searchInput.addEventListener("keydown", function(event) {

		if (event.key === "Enter") {
			event.preventDefault();
			goSearch();
		}

	});


	// 멘토 선택
	function selectMento(userId, name) {

		if (opener && !opener.closed) {
			opener.setMentoId(userId, name);
		}

		window.close();
	}
</script>

</body>
</html>