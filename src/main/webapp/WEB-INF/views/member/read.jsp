<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="/resources/css/userRead.css" rel="stylesheet">

<jsp:include page="../include/header.jsp" />

<main class="mento-read">
<div class="mento-read__container">

	<div class="mento-read__title">
		<c:choose>
			<c:when test="${user.authority eq 'M'}">
					멘토 조회
				</c:when>
			<c:when test="${user.authority eq 'S'}">
					멘티 조회
				</c:when>
		</c:choose>
	</div>

	<div class="mento-read__divider"></div>

	<form action="/member/delete" id="deleteForm" class="mento-read__form"
		method="post">

		<input type="hidden" name="userId" value="${user.userId}"> <input
			type="hidden" name="authority" value="${user.authority}">

		<div class="mento-read__row">
			<label class="mento-read__label" for="name">이름</label>

			<div class="mento-read__field">
				<input id="name" class="mento-read__input" type="text"
					value="${user.name}" readonly />
			</div>
		</div>

		<div class="mento-read__row">
			<label class="mento-read__label" for="userId">아이디</label>

			<div class="mento-read__field mento-read__field--inline">
				<input id="userId" class="mento-read__input" type="text"
					value="${user.userId}" readonly />
			</div>
		</div>

		<div class="mento-read__row">
			<label class="mento-read__label" for="jumin">생년월일</label>

			<div class="mento-read__field">
				<fmt:formatDate var="juminDate" pattern="yyyy - MM - dd"
					value="${user.jumin}" />

				<input id="jumin" class="mento-read__input" type="text"
					value="${juminDate}" readonly />
			</div>
		</div>

		<div class="mento-read__row">
			<label class="mento-read__label" for="school">학교</label>

			<div class="mento-read__field">
				<input id="school" class="mento-read__input" type="text"
					value="${user.school}" readonly />
			</div>
		</div>

		<div class="mento-read__row">
			<label class="mento-read__label" for="grade">학년</label>

			<div class="mento-read__field">
				<input id="grade" class="mento-read__input" type="text"
					value="${user.grade}" readonly />
			</div>
		</div>

		<div class="mento-read__row">
			<label class="mento-read__label" for="phone">전화번호</label>

			<div class="mento-read__field">
				<input id="phone" class="mento-read__input" type="text"
					value="${user.phone}" readonly />
			</div>
		</div>

		<div class="mento-read__row">
			<label class="mento-read__label" for="email">이메일</label>

			<div class="mento-read__field">
				<input id="email" class="mento-read__input" type="text"
					value="${(user.email1 != null and user.email2 != null)
							? user.email1.concat('@').concat(user.email2)
							: ''}"
					readonly />
			</div>
		</div>

		<div class="mento-read__actions">

			<button type="button" class="mento-read__btn mento-read__btn--edit"
				onclick="location.href='/member/update?userId=${user.userId}'">
				수정</button>

			<button type="button" class="mento-read__btn mento-read__btn--delete"
				onclick="deleteUser()">삭제</button>

			<button type="button" class="mento-read__btn mento-read__btn--close"
				onclick="location.href='/member/backToList?userId=${user.userId}'">
				확인</button>

		</div>

	</form>
</div>
</main>
</div>

<script>
	function deleteUser() {
		if (confirm("해당 회원을 삭제하시겠습니까?")) {
			document.getElementById("deleteForm").submit();
		}
	}
</script>
<jsp:include page="../include/footer.jsp" />