<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="/resources/css/notice.css" rel="stylesheet">
<jsp:include page="../include/header.jsp" />

<main class="notice-main">
<div class="notice-wrap">

	<div class="term-select">
		<div class="notice-title">공지사항</div>
	</div>

	<div class="notice-toolbar">

		<div class="notice-search">

			<a id="searchBtn"
				href="javascript:void(0);"
				class="iq-bg-primary"
				aria-label="검색">

				<svg class="notice-search-icon"
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

			<input id="noticeQ"
				type="search"
				placeholder="검색"
				value="${cri.keyword}" />

		</div>

		<c:if test="${loginUser.authority eq 'A'}">
			<button class="notice-btn"
				type="button"
				onclick="location.href='/notice/register'">
				등록
			</button>
		</c:if>

	</div>

	<table class="notice-table"
		aria-label="공지사항 목록">

		<thead>
			<tr>
				<th class="col-no">No.</th>
				<th>제목</th>
				<th class="col-date">날짜</th>
				<th class="col-views">조회수</th>
			</tr>
		</thead>

		<tbody>

			<c:if test="${not empty list}">

				<c:forEach items="${list}"
					var="notice"
					varStatus="status">

					<tr>

						<td class="col-no">
							${pageMaker.totalCount
								- ((pageMaker.cri.page - 1)
								* pageMaker.cri.perPageNum
								+ status.index)}
						</td>

						<td class="col-title">

							<a href="<c:url value='/notice/read'>
								<c:param name='noticeNum'
									value='${notice.noticeNum}'/>
							</c:url>">

								<c:choose>
									<c:when test="${notice.category eq 'A'}">
										[전체]
									</c:when>
									<c:when test="${notice.category eq 'M'}">
										[멘토]
									</c:when>
									<c:when test="${notice.category eq 'S'}">
										[멘티]
									</c:when>
								</c:choose>

								<c:out value="${notice.title}" />

							</a>

						</td>

						<td class="col-date">
							<fmt:formatDate
								pattern="yyyy-MM-dd"
								value="${notice.regDate}" />
						</td>

						<td class="col-views">
							<c:out value="${notice.viewCount}" />
						</td>

					</tr>

				</c:forEach>

			</c:if>

			<c:if test="${empty list}">
				<tr>
					<td colspan="4">
						내역이 없습니다.
					</td>
				</tr>
			</c:if>

		</tbody>

	</table>

	<c:if test="${not empty list}">

		<nav class="notice-pager"
			aria-label="페이지네이션">

			<button class="pager-chev"
				type="button"
				aria-label="이전 페이지"
				${pageMaker.prev ? "" : "disabled"}
				onclick="${pageMaker.prev
					? "location.href='list"
					+= pageMaker.makeSearch(pageMaker.startPage - 1)
					+= "'"
					: ""}">
				&lt;
			</button>

			<c:forEach begin="${pageMaker.startPage}"
				end="${pageMaker.endPage}"
				var="idx">

				<button
					class="pager-page ${pageMaker.cri.page == idx ? 'is-active' : ''}"
					type="button"
					onclick="location.href='list${pageMaker.makeSearch(idx)}'">
					${idx}
				</button>

			</c:forEach>

			<button class="pager-chev"
				type="button"
				aria-label="다음 페이지"
				${pageMaker.next && pageMaker.endPage > 0 ? "" : "disabled"}
				onclick="${pageMaker.next && pageMaker.endPage > 0
					? "location.href='list"
					+= pageMaker.makeSearch(pageMaker.endPage + 1)
					+= "'"
					: ""}">
				&gt;
			</button>

		</nav>

	</c:if>

</div>
</main>
</div>
<script>
	const searchBtn = document.getElementById('searchBtn');
	const noticeQ = document.getElementById('noticeQ');

	function searchNotice() {

		const keyword = noticeQ.value.trim();

		const url = new URL(
			'<c:url value="/notice/list"/>',
			window.location.origin
		);

		if (keyword) {
			url.searchParams.set('keyword', keyword);
		}

		url.searchParams.set('page', '1');

		window.location.href = url.toString();
	}

	searchBtn.addEventListener('click', function(e) {
		e.preventDefault();
		searchNotice();
	});

	noticeQ.addEventListener('keydown', function(e) {

		if (e.key === 'Enter') {
			e.preventDefault();
			searchNotice();
		}

	});
</script>

<jsp:include page="../include/footer.jsp" />