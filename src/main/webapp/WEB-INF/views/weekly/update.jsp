<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link href="/resources/css/weekly.css" rel="stylesheet">

<jsp:include page="../include/header.jsp" />

<main class="weekly-register">
	<div class="weekly-register__container">

		<div class="weekly-register__title">주차 수정</div>
		<div class="weekly-register__divider"></div>

		<form id="updateForm"
			action="/weekly/update"
			class="weekly-register__form"
			method="post">

			<input type="hidden"
				name="teamNum"
				value="${weekly.teamNum}" />

			<input type="hidden"
				name="weeklyNum"
				value="${weekly.weeklyNum}" />


			<div class="weekly-register__row weekly-register__row--inline">
				<label class="weekly-register__label" for="weekName">
					주차
				</label>

				<div class="weekly-register__field">
					<input id="weekName"
						name="weekName"
						class="weekly-register__input weekly-register__input--week"
						type="text"
						value="${weekly.weekName}" />

					<span class="weekly-register__suffix">주차</span>
				</div>
			</div>


			<div class="weekly-register__row">
				<label class="weekly-register__label" for="activityName">
					활동명
				</label>

				<div class="weekly-register__field">
					<input id="activityName"
						name="activityName"
						class="weekly-register__input"
						type="text"
						value="${weekly.activityName}" />
				</div>
			</div>


			<div class="weekly-register__row">
				<label class="weekly-register__label" for="startDate">
					날짜
				</label>

				<div class="weekly-register__field">

					<fmt:formatDate
						value="${weekly.startDate}"
						pattern="yyyy-MM-dd"
						var="startDateFmt" />

					<fmt:formatDate
						value="${weekly.endDate}"
						pattern="yyyy-MM-dd"
						var="endDateFmt" />

					<input id="startDate"
						name="startDate"
						type="date"
						class="weekly-register__input"
						value="${startDateFmt}" />

					~

					<input id="endDate"
						name="endDate"
						type="date"
						class="weekly-register__input"
						value="${endDateFmt}" />

				</div>
			</div>


			<div class="weekly-register__actions">

				<button type="button"
					class="weekly-read__btn weekly-read__btn--delete"
					onclick="deleteWeekly()">
					삭제
				</button>

				<button type="button"
					class="weekly-register__btn weekly-register__btn--ghost"
					onclick="location.href='/mentoring/mentoringList?teamNum=${weekly.teamNum}'">
					취소
				</button>

				<button type="button"
					class="weekly-register__btn weekly-update__btn--primary"
					onclick="updateWeekly()">
					수정
				</button>

			</div>

		</form>


		<form id="deleteForm"
			action="/weekly/delete"
			method="post">

			<input type="hidden"
				name="weeklyNum"
				value="${weekly.weeklyNum}" />

			<input type="hidden"
				name="teamNum"
				value="${weekly.teamNum}" />

		</form>

	</div>
</main>
</div>

<script>
	function updateWeekly() {
		if (confirm("해당 주차 정보를 수정하시겠습니까?")) {
			document.getElementById("updateForm").submit();
		}
	}

	function deleteWeekly() {
		if (confirm("해당 주차를 삭제하시겠습니까?")) {
			document.getElementById("deleteForm").submit();
		}
	}
</script>

<jsp:include page="../include/footer.jsp" />