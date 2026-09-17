<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/header.jsp" />

<link href="/resources/css/mentoList.css" rel="stylesheet">

<main class="mento-main">
	<div class="mento-wrap">

		<div class="term-select">
			<div class="mento-title">멘티 목록</div>
		</div>

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

			<c:if test="${loginUser.authority eq 'A'}">
				<button class="mento-btn"
					type="button"
					onclick="location.href='/member/mentiRegister'">
					등록
				</button>
			</c:if>

		</div>

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
								<a href="/member/read?userId=${user.userId}">
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

		<c:if test="${not empty list}">

			<nav class="mento-pager" aria-label="페이지네이션">

				<c:choose>

					<c:when test="${pageMaker.prev}">
						<button class="pager-chev"
							type="button"
							aria-label="이전 페이지"
							onclick="location.href='/member/mentiList${pageMaker.makeSearch(pageMaker.startPage - 1)}'">
							&lt;
						</button>
					</c:when>

					<c:otherwise>
						<button class="pager-chev"
							type="button"
							aria-label="이전 페이지"
							disabled>
							&lt;
						</button>
					</c:otherwise>

				</c:choose>

				<c:forEach begin="${pageMaker.startPage}"
					end="${pageMaker.endPage}"
					var="idx">

					<button
						class="pager-page ${pageMaker.cri.page == idx ? 'is-active' : ''}"
						type="button"
						onclick="location.href='/member/mentiList${pageMaker.makeSearch(idx)}'">
						${idx}
					</button>

				</c:forEach>

				<c:choose>

					<c:when test="${pageMaker.next && pageMaker.endPage > 0}">
						<button class="pager-chev"
							type="button"
							aria-label="다음 페이지"
							onclick="location.href='/member/mentiList${pageMaker.makeSearch(pageMaker.endPage + 1)}'">
							&gt;
						</button>
					</c:when>

					<c:otherwise>
						<button class="pager-chev"
							type="button"
							aria-label="다음 페이지"
							disabled>
							&gt;
						</button>
					</c:otherwise>

				</c:choose>

			</nav>

		</c:if>

	</div>
</main>
</div>

<script>
	(function() {

		const searchBtn = document.getElementById("searchBtn");
		const input = document.getElementById("mentoQ");

		function goSearch() {

			const keyword = input.value.trim();

			const url = new URL(
				window.location.origin + "/member/mentiList"
			);

			url.searchParams.set("page", "1");

			if (keyword !== "") {
				url.searchParams.set("keyword", keyword);
			}

			window.location.href = url.toString();
		}

		searchBtn.addEventListener("click", goSearch);

		input.addEventListener("keydown", function(e) {

			if (e.key === "Enter") {
				e.preventDefault();
				goSearch();
			}

		});

	})();
</script>

<jsp:include page="../include/footer.jsp" />