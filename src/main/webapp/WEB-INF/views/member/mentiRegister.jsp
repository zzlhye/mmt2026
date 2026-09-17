<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link href="/resources/css/mentoRegister.css" rel="stylesheet">

<jsp:include page="../include/header.jsp" />

<main class="mento-register">
	<div class="mento-register__container">

		<div class="mento-register__title">멘티 등록</div>
		<div class="mento-register__divider"></div>

		<form action="/member/mentiRegister"
			name="frm"
			class="mento-register__form"
			method="post"
			onsubmit="return joinCheck();">

			<div class="mento-register__row">
				<label class="mento-register__label" for="name">이름</label>

				<div class="mento-register__field">
					<input id="name"
						name="name"
						class="mento-register__input"
						type="text" />
				</div>
			</div>

			<div class="mento-register__row">
				<label class="mento-register__label" for="userId">아이디</label>

				<div class="mento-register__field mento-register__field--inline">

					<input id="userId"
						name="userId"
						class="mento-register__input"
						type="text" />

					<button type="button"
						class="mento-register__id-check-btn"
						onclick="checkUserId()">
						중복확인
					</button>

				</div>
			</div>

			<div class="mento-register__row">
				<div></div>

				<div class="mento-register__id-msg"
					id="idCheckMsg">
				</div>
			</div>

			<div class="mento-register__row">
				<label class="mento-register__label" for="jumin">생년월일</label>

				<div class="mento-register__field">
					<input id="jumin"
						name="jumin"
						class="mento-register__input"
						type="date" />
				</div>
			</div>

			<div class="mento-register__row">
				<label class="mento-register__label" for="school">학교</label>

				<div class="mento-register__field">
					<input id="school"
						name="school"
						class="mento-register__input"
						type="text" />
				</div>
			</div>

			<div class="mento-register__row">
				<label class="mento-register__label" for="grade">학년</label>

				<div class="mento-register__field">
					<input id="grade"
						name="grade"
						class="mento-register__input"
						type="text" />
				</div>
			</div>

			<div class="mento-register__actions">

				<button type="submit"
					class="mento-register__btn mento-register__btn--primary">
					등록
				</button>

				<button type="button"
					class="mento-register__btn mento-register__btn--ghost"
					onclick="location.href='/member/mentiList'">
					취소
				</button>

			</div>

		</form>
	</div>
</main>
</div>
<script>
	let isIdChecked = false;

	function checkUserId() {

		const userId = document.getElementById("userId").value.trim();
		const msgEl = document.getElementById("idCheckMsg");

		if (userId === "") {
			msgEl.textContent = "아이디를 입력해주세요.";
			msgEl.className =
				"mento-register__id-msg mento-register__id-msg--fail";

			isIdChecked = false;
			return;
		}

		fetch("/member/id-check?userId=" + encodeURIComponent(userId))
			.then(res => res.json())
			.then(data => {

				if (data.available) {

					msgEl.textContent = "사용 가능한 아이디입니다.";
					msgEl.className =
						"mento-register__id-msg mento-register__id-msg--ok";

					isIdChecked = true;

				} else {

					msgEl.textContent = "이미 사용 중인 아이디입니다.";
					msgEl.className =
						"mento-register__id-msg mento-register__id-msg--fail";

					isIdChecked = false;
				}
			})
			.catch(() => {

				msgEl.textContent = "중복 체크 중 오류가 발생했습니다.";
				msgEl.className =
					"mento-register__id-msg mento-register__id-msg--fail";

				isIdChecked = false;
			});
	}

	document.getElementById("userId").addEventListener("input", () => {

		isIdChecked = false;

		const msgEl = document.getElementById("idCheckMsg");
		msgEl.textContent = "";
	});

	function joinCheck() {

		if (document.frm.name.value.trim() === "") {
			alert("이름을 입력해주세요.");
			document.frm.name.focus();
			return false;
		}

		if (document.frm.userId.value.trim() === "") {
			alert("아이디를 입력해주세요.");
			document.frm.userId.focus();
			return false;
		}

		if (!isIdChecked) {
			alert("아이디 중복 체크를 해주세요.");
			document.frm.userId.focus();
			return false;
		}

		if (document.frm.jumin.value === "") {
			alert("생년월일을 입력해주세요.");
			document.frm.jumin.focus();
			return false;
		}

		if (document.frm.school.value.trim() === "") {
			alert("학교를 입력해주세요.");
			document.frm.school.focus();
			return false;
		}

		if (document.frm.grade.value.trim() === "") {
			alert("학년을 입력해주세요.");
			document.frm.grade.focus();
			return false;
		}

		return confirm("등록하시겠습니까?");
	}
</script>

<jsp:include page="../include/footer.jsp" />