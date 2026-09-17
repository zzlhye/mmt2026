<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link href="/resources/css/weekly.css" rel="stylesheet">

<jsp:include page="../include/header.jsp" />

<main class="weekly-register">
	<div class="weekly-register__container">

		<div class="weekly-register__title">주차 등록</div>
		<div class="weekly-register__divider"></div>

		<form id="registerForm"
			action="/weekly/register"
			class="weekly-register__form"
			method="post">

			<input type="hidden"
				name="teamNum"
				value="${teamNum}" />


			<!-- 주차 -->
			<div class="weekly-register__row weekly-register__row--inline">
				<label class="weekly-register__label" for="weekName">
					주차
				</label>

				<div class="weekly-register__field">
					<input id="weekName"
						name="weekName"
						class="weekly-register__input weekly-register__input--week"
						type="text"
						placeholder="주차를 입력해주세요." />

					<span class="weekly-register__suffix">주차</span>
				</div>
			</div>


			<!-- 활동명 -->
			<div class="weekly-register__row">
				<label class="weekly-register__label" for="activityName">
					활동명
				</label>

				<div class="weekly-register__field">
					<input id="activityName"
						name="activityName"
						class="weekly-register__input"
						type="text"
						placeholder="활동명을 입력해주세요." />
				</div>
			</div>


			<!-- 날짜 -->
			<div class="weekly-register__row">
				<label class="weekly-register__label" for="startDate">
					날짜
				</label>

				<div class="weekly-register__field">
					<input id="startDate"
						name="startDate"
						class="weekly-register__input"
						type="date" />

					~

					<input id="endDate"
						name="endDate"
						class="weekly-register__input"
						type="date" />
				</div>
			</div>


			<!-- 버튼 -->
			<div class="weekly-register__actions">

				<button type="button"
					class="weekly-register__btn weekly-register__btn--ghost"
					onclick="location.href='/mentoring/mentoringList?teamNum=${teamNum}'">
					취소
				</button>

				<button type="button"
					class="weekly-register__btn weekly-register__btn--primary"
					onclick="registerWeekly()">
					등록
				</button>

			</div>

		</form>

	</div>
</main>
	</div>

<script>
	function registerWeekly() {
		if (confirm("해당 주차를 등록하시겠습니까?")) {
			document.getElementById("registerForm").submit();
		}
	}
</script>

<jsp:include page="../include/footer.jsp" />