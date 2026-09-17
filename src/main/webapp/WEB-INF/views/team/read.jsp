<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="/resources/css/teamRead.css" rel="stylesheet">

<jsp:include page="../include/header.jsp" />

<main class="mento-read">
<div class="mento-read__container">

	<div class="mento-read__title">${team.teamName}</div>

	<div class="mento-read__divider"></div>

	<form action="/team/delete" method="post" name="removefrm">
		<input type="hidden" name="teamNum" value="${team.teamNum}">

		<!-- 활동 학기 -->
		<div class="mento-read__row">
			<label class="mento-read__label">활동 학기</label>

			<div class="mento-read__field">
				<input class="mento-read__input"
					type="text"
					value="${team.year}년 ${team.term}학기"
					readonly>
			</div>
		</div>

		<!-- 팀 소개 -->
		<div class="mento-read__row">
			<label class="mento-read__label">팀 소개</label>

			<div class="mento-read__field">
				<textarea class="mento-read__textarea"
					readonly>${team.intro}</textarea>
			</div>
		</div>

		<!-- 팀원 목록 -->
		<div class="mento-read__row">
			<label class="mento-read__label">팀원</label>

			<div class="mento-read__field">
				<div class="team-table">

					<c:set var="menteeNo" value="0" />

					<c:forEach var="member" items="${teamMember}">

						<c:if test="${member.part eq 'S'}">
							<c:set var="menteeNo" value="${menteeNo + 1}" />
						</c:if>

						<div class="team-table__row">

							<!-- 역할 -->
							<div class="team-table__role">
								<c:choose>
									<c:when test="${member.part eq 'M'}">
										멘토
									</c:when>
									<c:otherwise>
										멘티${menteeNo}
									</c:otherwise>
								</c:choose>
							</div>

							<!-- 이름 -->
							<input class="team-table__input team-table__name"
								type="text"
								value="${member.name}"
								readonly>

							<!-- 학교 -->
							<div class="team-table__k">학교</div>

							<input class="team-table__input team-table__school"
								type="text"
								value="${member.school}"
								readonly>

							<!-- 생년월일 -->
							<div class="team-table__k">생년월일</div>

							<input class="team-table__input team-table__birth"
								type="text"
								value="<fmt:formatDate value='${member.jumin}' pattern='yyyyMMdd'/>"
								readonly>

						</div>

					</c:forEach>

				</div>
			</div>
		</div>

		<div class="mento-read__divider"></div>

		<!-- 버튼 -->
		<div class="mento-read__actions">

			<button type="button"
				class="mento-read__btn mento-read__btn--edit"
				onclick="location.href='/team/update?teamNum=${team.teamNum}'">
				수정
			</button>

			<button type="button"
				class="mento-read__btn mento-read__btn--delete"
				onclick="deleteTeam()">
				삭제
			</button>

			<button type="button"
				class="mento-read__btn mento-read__btn--close"
				onclick="location.href='/team/list'">
				확인
			</button>

		</div>

	</form>

</div>
</main>

</div>

<script>
	function deleteTeam() {
		if (confirm("해당 팀을 삭제하시겠습니까?")) {
			document.forms["removefrm"].submit();
		}
	}
</script>

<jsp:include page="../include/footer.jsp" />