<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../include/header.jsp" />
<link href="/resources/css/userUpdate.css" rel="stylesheet">

<main class="mento-update">
	<div class="mento-update__container">

		<div class="mento-update__title">내 정보 수정</div>

		<div class="mento-update__divider"></div>

		<form action="/mypage/update"
			name="frm"
			class="mento-update__form"
			method="post"
			onsubmit="return joinCheck();">

			<div class="mento-update__row">
				<label class="mento-update__label" for="name">이름</label>

				<div class="mento-update__field">
					<input id="name"
						name="name"
						class="mento-update__input"
						type="text"
						value="${user.name}" />
				</div>
			</div>

			<div class="mento-update__row">
				<label class="mento-update__label" for="userId">아이디</label>

				<div class="mento-update__field mento-update__field--inline">
					<input id="userId"
						class="mento-update__input"
						type="text"
						value="${user.userId}"
						readonly />
				</div>
			</div>

			<div class="mento-update__row">
				<label class="mento-update__label" for="userPw">비밀번호</label>

				<div class="mento-update__field">
					<input id="userPw"
						name="userPw"
						class="mento-update__input"
						type="password" />
				</div>
			</div>

			<div class="mento-update__row">
				<label class="mento-update__label" for="userPw_check">
					비밀번호 확인
				</label>

				<div class="mento-update__field">
					<input id="userPw_check"
						name="userPw_check"
						class="mento-update__input"
						type="password" />

					<div id="passwordError"
						class="mento-update__error"></div>
				</div>
			</div>

			<div class="mento-update__row">
				<label class="mento-update__label" for="jumin">생년월일</label>

				<div class="mento-update__field">
					<fmt:formatDate
						var="juminDate"
						pattern="yyyy-MM-dd"
						value="${user.jumin}" />

					<input id="jumin"
						name="jumin"
						class="mento-update__input"
						type="date"
						value="${juminDate}" />
				</div>
			</div>

			<div class="mento-update__row">
				<label class="mento-update__label" for="school">학교</label>

				<div class="mento-update__field">
					<input id="school"
						name="school"
						class="mento-update__input"
						type="text"
						value="${user.school}" />
				</div>
			</div>

			<div class="mento-update__row">
				<label class="mento-update__label" for="grade">학년</label>

				<div class="mento-update__field">
					<input id="grade"
						name="grade"
						class="mento-update__input"
						type="text"
						value="${user.grade}" />
				</div>
			</div>

			<div class="mento-update__row">
				<label class="mento-update__label" for="phone">전화번호</label>

				<div class="mento-update__field">
					<input id="phone"
						name="phone"
						class="mento-update__input"
						type="text"
						value="${user.phone}" />
				</div>
			</div>

			<div class="mento-update__row">
				<label class="mento-update__label" for="email1">이메일</label>

				<div class="mento-update__field mento-update__field--email">

					<div class="mento-update__email-line">

						<input id="email1"
							name="email1"
							class="mento-update__input"
							type="text"
							value="${user.email1}" />

						<span class="mento-update__at">@</span>

						<input type="hidden"
							id="email2"
							name="email2"
							value="${user.email2}" />

						<div class="patrit-dropdown"
							id="emailDomainDropdown">

							<button type="button"
								class="patrit-term-btn"
								id="emailDomainBtn"
								aria-haspopup="listbox"
								aria-expanded="false">

								<span id="emailDomainLabel">
									<c:choose>
										<c:when test="${not empty user.email2}">
											${user.email2}
										</c:when>

										<c:otherwise>
											도메인 선택
										</c:otherwise>
									</c:choose>
								</span>

								<span class="patrit-arrow">▾</span>
							</button>

							<ul class="patrit-menu"
								id="emailDomainMenu"
								role="listbox">

								<li role="option" data-value="naver.com">naver.com</li>
								<li role="option" data-value="gmail.com">gmail.com</li>
								<li role="option" data-value="daum.net">daum.net</li>
								<li role="option" data-value="kakao.com">kakao.com</li>
								<li role="option" data-value="custom">직접입력</li>
							</ul>
						</div>
					</div>

					<input id="email2Custom"
						class="mento-update__input mento-update__input--domain"
						type="text"
						placeholder="직접 입력"
						style="display: none;" />
				</div>
			</div>

			<div class="mento-update__actions">

				<button type="submit"
					class="mento-update__btn mento-update__btn--edit">
					수정
				</button>

				<button type="button"
					class="mento-update__btn mento-update__btn--ghost"
					onclick="location.href='/mypage/myInfo'">
					취소
				</button>
			</div>

		</form>
	</div>
</main>
</div>

<script>
	const userPw = document.getElementById("userPw");
	const userPwCheck = document.getElementById("userPw_check");
	const passwordError = document.getElementById("passwordError");

	function checkPasswordMatch() {

		if (userPwCheck.value === "") {
			passwordError.textContent = "";
			return true;
		}

		if (userPw.value !== userPwCheck.value) {
			passwordError.textContent = "비밀번호가 일치하지 않습니다.";
			return false;
		}

		passwordError.textContent = "";
		return true;
	}

	userPw.addEventListener("input", checkPasswordMatch);
	userPwCheck.addEventListener("input", checkPasswordMatch);

	function joinCheck() {

		if (document.frm.name.value == "") {
			alert("이름을 입력해주세요.");
			document.frm.name.focus();
			return false;
		}

		if (document.frm.userPw.value == "") {
			alert("비밀번호를 입력해주세요.");
			document.frm.userPw.focus();
			return false;
		}

		if (document.frm.userPw_check.value == "") {
			passwordError.textContent = "비밀번호를 다시 입력해주세요.";
			document.frm.userPw_check.focus();
			return false;
		}

		if (!checkPasswordMatch()) {
			document.frm.userPw_check.focus();
			return false;
		}

		if (document.frm.jumin.value == "") {
			alert("생년월일을 입력해주세요.");
			document.frm.jumin.focus();
			return false;
		}

		if (document.frm.school.value == "") {
			alert("학교를 입력해주세요.");
			document.frm.school.focus();
			return false;
		}

		if (document.frm.grade.value == "") {
			alert("학년을 입력해주세요.");
			document.frm.grade.focus();
			return false;
		}

		return confirm("수정하시겠습니까?");
	}
</script>

<script>
	(function() {

		const main = document.querySelector(".mento-update");
		const dropdown = document.getElementById("emailDomainDropdown");
		const btn = document.getElementById("emailDomainBtn");
		const menu = document.getElementById("emailDomainMenu");
		const label = document.getElementById("emailDomainLabel");

		const hiddenEmail2 = document.getElementById("email2");
		const customInput = document.getElementById("email2Custom");

		const known = [
			"naver.com",
			"gmail.com",
			"daum.net",
			"kakao.com"
		];

		function open() {
			dropdown.classList.add("open");
			btn.setAttribute("aria-expanded", "true");
			main.classList.add("dropdown-open");
		}

		function close() {
			dropdown.classList.remove("open");
			btn.setAttribute("aria-expanded", "false");
			main.classList.remove("dropdown-open");
		}

		function toggle() {
			dropdown.classList.contains("open")
				? close()
				: open();
		}

		btn.addEventListener("click", (e) => {
			e.stopPropagation();
			toggle();
		});

		menu.addEventListener("click", (e) => {

			const li = e.target.closest("li[data-value]");

			if (!li) {
				return;
			}

			const value = li.dataset.value;

			if (value === "custom") {

				label.textContent = "직접입력";
				customInput.style.display = "block";

				customInput.value =
					(!known.includes(hiddenEmail2.value) && hiddenEmail2.value)
						? hiddenEmail2.value
						: "";

				customInput.focus();

			} else {

				label.textContent = value;
				hiddenEmail2.value = value;

				customInput.style.display = "none";
				customInput.value = "";
			}

			close();
		});

		customInput.addEventListener("input", () => {
			hiddenEmail2.value = customInput.value.trim();
		});

		document.addEventListener("click", close);

		const preset = (hiddenEmail2.value || "").trim();

		if (preset && !known.includes(preset)) {
			label.textContent = "직접입력";
			customInput.style.display = "block";
			customInput.value = preset;
		}

	})();
</script>

<jsp:include page="../include/footer.jsp" />