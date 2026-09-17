<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="/resources/css/teamRegister.css" rel="stylesheet">

<jsp:include page="../include/header.jsp" />

<main class="mento-register">
	<div class="mento-register__container">

		<div class="mento-register__title">팀 수정</div>
		<div class="mento-register__divider"></div>

		<form action="/team/update"
			class="mento-register__form"
			method="post">

			<input type="hidden"
				name="teamNum"
				value="${team.teamNum}" />

			<!-- 연도 -->
			<div class="mento-register__row">
				<label class="mento-register__label" for="year">연도</label>

				<div class="mento-register__field">
					<input id="year"
						name="year"
						type="text"
						class="mento-register__input"
						value="${team.year}" />
				</div>
			</div>

			<!-- 학기 -->
			<div class="mento-register__row">
				<label class="mento-register__label" for="term">학기</label>

				<div class="mento-register__field">
					<input id="term"
						name="term"
						type="text"
						class="mento-register__input"
						value="${team.term}" />
				</div>
			</div>

			<!-- 팀명 -->
			<div class="mento-register__row">
				<label class="mento-register__label" for="teamName">팀명</label>

				<div class="mento-register__field">
					<input id="teamName"
						name="teamName"
						type="text"
						class="mento-register__input"
						value="${team.teamName}" />
				</div>
			</div>

			<!-- 멘토 -->
			<div class="mento-register__row">
				<label class="mento-register__label">멘토</label>

				<div class="mento-register__field mento-register__field--inline">

					<input id="mentoId"
						name="mentoId"
						type="hidden"
						value="${team.userId}" />

					<input id="mentoName"
						type="text"
						class="mento-register__input"
						value="${team.name}"
						readonly />

					<button type="button"
						class="mento-register__id-check-btn"
						onclick="openMentoPopup()">
						선택
					</button>

				</div>
			</div>

			<!-- 멘티 -->
			<div class="mento-register__row">
				<label class="mento-register__label">멘티</label>

				<div class="mento-register__field">

					<div id="mentiContainer" class="menti-stack">

						<c:set var="hasMenti" value="false" />

						<c:forEach items="${teamMember}" var="member">

							<c:if test="${member.part eq 'S'}">

								<c:set var="hasMenti" value="true" />

								<div class="menti-line">

									<input name="mentiId"
										type="hidden"
										value="${member.userId}" />

									<input type="text"
										class="mento-register__input menti-name"
										value="${member.name}"
										readonly />

									<button type="button"
										class="mento-register__id-check-btn"
										onclick="openMentiPopup(this)">
										선택
									</button>

									<button type="button"
										class="menti-remove-x"
										onclick="removeMentiLine(this)">
										×
									</button>

								</div>

							</c:if>

						</c:forEach>

						<!-- 기존 멘티가 없는 경우 -->
						<c:if test="${not hasMenti}">

							<div class="menti-line">

								<input name="mentiId"
									type="hidden" />

								<input type="text"
									class="mento-register__input menti-name"
									readonly />

								<button type="button"
									class="mento-register__id-check-btn"
									onclick="openMentiPopup(this)">
									선택
								</button>

								<button type="button"
									class="menti-remove-x is-hidden"
									tabindex="-1">
									×
								</button>

							</div>

						</c:if>

					</div>

					<button type="button"
						class="menti-add-btn"
						onclick="addMentiLine()">
						+ 멘티추가
					</button>

				</div>
			</div>

			<!-- 버튼 -->
			<div class="mento-register__actions">

				<button type="submit"
					class="mento-update__btn mento-update__btn--primary">
					수정
				</button>

				<button type="button"
					class="mento-register__btn mento-register__btn--ghost"
					onclick="location.href='/team/read?teamNum=${team.teamNum}'">
					취소
				</button>

			</div>

		</form>

	</div>
</main>

</div>


<script>
	let currentMentiLine = null;

	// 멘토 선택 팝업
	function openMentoPopup() {
		window.open(
			"/team/mentoList",
			"멘토선택",
			"width=300,height=400"
		);
	}

	// 선택한 멘토 적용
	function setMentoId(userId, name) {

		const mentiIds = document.querySelectorAll(
			"input[name='mentiId']"
		);

		// 이미 멘티로 선택된 사람인지 확인
		for (const input of mentiIds) {

			if (input.value === userId) {
				alert("이미 멘티로 선택된 사용자입니다.");
				return;
			}
		}

		document.getElementById("mentoId").value = userId;
		document.getElementById("mentoName").value = name;
	}


	// 멘티 입력 줄 추가
	function addMentiLine() {

		const container = document.getElementById("mentiContainer");
		const line = document.createElement("div");

		line.className = "menti-line";

		line.innerHTML = `
			<input name="mentiId" type="hidden" />

			<input type="text"
				class="mento-register__input menti-name"
				readonly />

			<button type="button"
				class="mento-register__id-check-btn"
				onclick="openMentiPopup(this)">
				선택
			</button>

			<button type="button"
				class="menti-remove-x"
				onclick="removeMentiLine(this)">
				×
			</button>
		`;

		container.appendChild(line);
	}


	// 멘티 입력 줄 삭제
	function removeMentiLine(button) {
		button.closest(".menti-line").remove();
	}


	// 멘티 선택 팝업
	function openMentiPopup(button) {

		currentMentiLine = button.closest(".menti-line");

		window.open(
			"/team/mentiList",
			"멘티선택",
			"width=300,height=400"
		);
	}


	// 선택한 멘티 적용
	function setMentiId(userId, name) {

		if (!currentMentiLine) {
			return;
		}

		const mentoId = document.getElementById("mentoId").value;

		// 멘토와 동일한 사람인지 확인
		if (mentoId === userId) {
			alert("멘토로 선택된 사용자는 멘티로 선택할 수 없습니다.");
			return;
		}

		const currentIdInput = currentMentiLine.querySelector(
			"input[name='mentiId']"
		);

		const mentiIds = document.querySelectorAll(
			"input[name='mentiId']"
		);

		// 이미 다른 줄에 선택된 멘티인지 확인
		for (const input of mentiIds) {

			if (
				input !== currentIdInput &&
				input.value === userId
			) {
				alert("이미 선택된 멘티입니다.");
				return;
			}
		}

		currentIdInput.value = userId;

		currentMentiLine.querySelector(
			".menti-name"
		).value = name;

		currentMentiLine = null;
	}


	// 수정 유효성 검사
	document.querySelector(".mento-register__form")
		.addEventListener("submit", function(event) {

			const yearInput = document.getElementById("year");
			const termInput = document.getElementById("term");
			const teamNameInput = document.getElementById("teamName");
			const mentoId = document.getElementById("mentoId").value;

			const year = yearInput.value.trim();
			const term = termInput.value.trim();
			const teamName = teamNameInput.value.trim();

			// 연도
			if (year === "") {
				alert("연도를 입력해주세요.");
				yearInput.focus();
				event.preventDefault();
				return;
			}

			// 연도 형식
			if (!/^\d{4}$/.test(year)) {
				alert("연도는 4자리 숫자로 입력해주세요.");
				yearInput.focus();
				event.preventDefault();
				return;
			}

			// 학기
			if (term === "") {
				alert("학기를 입력해주세요.");
				termInput.focus();
				event.preventDefault();
				return;
			}

			// 학기 형식
			if (term !== "1" && term !== "2") {
				alert("학기는 1 또는 2로 입력해주세요.");
				termInput.focus();
				event.preventDefault();
				return;
			}

			// 팀명
			if (teamName === "") {
				alert("팀명을 입력해주세요.");
				teamNameInput.focus();
				event.preventDefault();
				return;
			}

			// 멘토
			if (mentoId === "") {
				alert("멘토를 선택해주세요.");
				event.preventDefault();
				return;
			}

			// 수정 확인
			if (!confirm("팀 정보를 수정하시겠습니까?")) {
				event.preventDefault();
			}
		});
</script>

<jsp:include page="../include/footer.jsp" />