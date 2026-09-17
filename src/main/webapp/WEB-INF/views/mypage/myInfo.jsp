<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="/resources/css/myInfo.css" rel="stylesheet">

<jsp:include page="../include/header.jsp" />

<main class="myInfo-main">
	<div class="myInfo-wrap">

		<div class="term-select">
			<div class="myInfo-title">마이페이지</div>
		</div>

		<div class="myInfo-divider"></div>

		<section class="myInfo-card">

			<div class="myInfo-term">
				${teamTerm.year}년 ${teamTerm.term}학기
			</div>

			<div class="myInfo-content">

				<div class="myInfo-profile">
					<div class="myInfo-avatar">
						<span class="avatar-head"></span>
						<span class="avatar-body"></span>
					</div>
				</div>

				<div class="myInfo-fields">

					<div class="myInfo-row">
						<div class="myInfo-label">
							<c:choose>
								<c:when test="${user.authority eq 'M'}">멘토</c:when>
								<c:when test="${user.authority eq 'S'}">멘티</c:when>
							</c:choose>
						</div>

						<div class="myInfo-value">
							<c:out value="${user.name}" />
						</div>
					</div>

					<div class="myInfo-row">
						<div class="myInfo-label">소속</div>

						<div class="myInfo-value">
							<c:out value="${user.school}" />
						</div>
					</div>

					<div class="myInfo-row">
						<div class="myInfo-label">학년</div>

						<div class="myInfo-value">
							<c:out value="${user.grade}" />학년
						</div>
					</div>

					<div class="myInfo-row">
						<div class="myInfo-label">연락처</div>

						<div class="myInfo-value">
							<c:out value="${user.phone}" />
						</div>
					</div>

				</div>
			</div>

		</section>

		<div class="myInfo-divider"></div>

		<div class="myInfo-actions">
			<a class="myInfo-btn" href="/mypage/update">내 정보 수정</a>
		</div>

	</div>
</main>
</div>

<jsp:include page="../include/footer.jsp" />