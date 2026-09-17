<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link href="/resources/css/mentoringList.css" rel="stylesheet">

<jsp:include page="../include/header.jsp" />

<main class="mentoring-main">
	<div class="mentoring-wrap">

		<!-- 상단 -->
		<div class="mentoring-top">
			<h2 class="mentoring-title">${team.teamName}</h2>

			<c:if test="${loginUser.authority eq 'A' or loginUser.authority eq 'M'}">
				<c:url var="weekRegisterUrl" value="/weekly/register">
					<c:param name="teamNum" value="${team.teamNum}" />
				</c:url>

				<a class="week-add-btn" href="${weekRegisterUrl}">주차등록</a>
			</c:if>
		</div>


		<!-- 팀 소개 -->
		<section class="m-card" id="teamCard">

			<div class="m-card-head">
				<div class="m-card-title">팀 소개</div>

				<c:if test="${loginUser.authority eq 'A' or loginUser.authority eq 'M'}">
					<button class="edit-icon"
						type="button"
						id="teamEditBtn"
						aria-label="팀 소개 수정">

						<svg width="18"
							height="18"
							viewBox="0 0 24 24"
							fill="none"
							aria-hidden="true">

							<path d="M12 20h9"
								stroke="currentColor"
								stroke-width="2"
								stroke-linecap="round" />

							<path d="M16.5 3.5a2.1 2.0 0 0 1 3 3L8 18l-4 1 1-4L16.5 3.5Z"
								stroke="currentColor"
								stroke-width="2"
								stroke-linejoin="round" />
						</svg>
					</button>
				</c:if>
			</div>

			<!-- 팀 소개 조회 -->
			<div class="m-card-body team-view">
				<p class="m-desc">
					<c:out value="${team.intro}" />
				</p>
			</div>

			<!-- 팀 소개 수정 -->
			<form class="m-card-body team-edit"
				method="post"
				action="<c:url value='/team/teamUpdate'/>">

				<input type="hidden"
					name="teamNum"
					value="${team.teamNum}" />

				<textarea class="m-textarea"
					id="intro"
					name="intro"
					rows="5">${fn:trim(team.intro)}</textarea>

				<div class="team-edit-actions">

					<button class="btn-save" type="submit">
						저장
					</button>

					<button class="btn-cancel"
						type="button"
						id="teamCancelBtn">
						취소
					</button>

				</div>
			</form>

		</section>


		<!-- 멘토/멘티 소개 -->
		<section class="m-acc">

			<button class="m-acc-head"
				type="button"
				id="peopleBtn"
				aria-expanded="false">

				<span>멘토&멘티 소개</span>
				<span class="m-acc-caret" aria-hidden="true">▼</span>

			</button>

			<div class="m-acc-body" id="peopleBody">

				<div class="m-people-box">

					<c:forEach var="member" items="${teamMember}">
						<div class="m-people-item">

							<strong>
								${member.part eq 'M' ? '멘토' : '멘티'}
							</strong>

							${member.name}

						</div>
					</c:forEach>

					<c:if test="${empty teamMember}">
						<div class="m-people-item">
							팀원이 없습니다.
						</div>
					</c:if>

				</div>

			</div>

		</section>


		<!-- 주차 선택 -->
		<div class="week-dots" aria-label="주차 선택">

			<button type="button"
				class="w-dot w-dot-active"
				data-week="all">
				전체
			</button>

			<c:forEach var="w" items="${weeklyList}">

				<button type="button"
					class="w-dot"
					data-week="${w.weekName}">
					${w.weekName}
				</button>

			</c:forEach>

		</div>


		<!-- 주차 없음 -->
		<c:if test="${empty weeklyList}">
			<p class="empty-msg">
				등록된 주차가 없습니다.
			</p>
		</c:if>


		<!-- 주차별 멘토링 -->
		<c:forEach var="w" items="${weeklyList}">

			<c:url var="weekEditUrl" value="/weekly/update">
				<c:param name="teamNum" value="${team.teamNum}" />
				<c:param name="weeklyNum" value="${w.weeklyNum}" />
			</c:url>

			<c:url var="mentoringRegisterUrl" value="/mentoring/register">
				<c:param name="teamNum" value="${team.teamNum}" />
				<c:param name="weeklyNum" value="${w.weeklyNum}" />
			</c:url>

			<c:set var="weekActivities"
				value="${mentoringByWeek[w.weekName]}" />


			<section class="week-card"
				data-week="${w.weekName}">

				<!-- 주차 제목 -->
				<div class="week-head"
					data-week="${w.weekName}"
					aria-expanded="${w.open}">

					<div class="week-title">

						${w.weekName}주차 -
						<c:out value="${w.activityName}" />

					</div>


					<div class="week-actions">

						<c:if test="${loginUser.authority eq 'A' or loginUser.authority eq 'M'}">

							<a class="week-btn"
								href="${weekEditUrl}">
								주차수정
							</a>

						</c:if>


						<a class="week-btn"
							href="${mentoringRegisterUrl}">
							글쓰기
						</a>


						<span class="week-caret"
							aria-hidden="true">
							${w.open ? '▲' : '▼'}
						</span>

					</div>

				</div>


				<!-- 주차 내용 -->
				<div class="week-body ${w.open ? 'open' : ''}">

					<div class="week-frame">

						<div class="img-grid">


							<!-- 게시글 없음 -->
							<c:if test="${empty weekActivities}">

								<p class="empty-week">
									등록된 활동이 없습니다.
								</p>

							</c:if>


							<!-- 게시글 -->
							<c:forEach var="a" items="${weekActivities}">

								<c:url var="activityDetailUrl"
									value="/mentoring/read">

									<c:param name="mentoringNum"
										value="${a.mentoringNum}" />

								</c:url>


								<a class="img-cell"
									href="${activityDetailUrl}">


									<!-- 대표 이미지 -->
									<c:choose>

										<c:when test="${not empty a.thumbFileName}">

											<img
												src="/displayFile?fileName=${fn:replace(a.thumbFileName, '\\', '/')}&type=image"
												alt="대표 이미지"
												loading="lazy"
												onerror="this.onerror=null; this.src='<c:url value='/resources/img.png'/>';" />

										</c:when>


										<c:otherwise>

											<img
												src="/resources/img.png"
												alt="기본 이미지"
												loading="lazy" />

										</c:otherwise>

									</c:choose>


									<!-- Hover -->
									<div class="img-overlay">

										<div class="img-ov-title">
											<c:out value="${a.title}" />
										</div>


										<div class="img-ov-meta">

											<!-- 반응 -->
											<span class="meta-item">

												<svg class="meta-icon heart"
													viewBox="0 0 24 24"
													aria-hidden="true">

													<path
														d="M20.8 4.6c-1.8-1.6-4.5-1.5-6.2.2L12 7.4 9.4 4.8C7.7 3.1 5 3 3.2 4.6 1 6.6 1 10.2 3.4 12.6l8.6 8.6 8.6-8.6c2.4-2.4 2.4-6 0.2-8z"
														fill="none"
														stroke="currentColor"
														stroke-width="2"
														stroke-linejoin="round"
														stroke-linecap="round" />

												</svg>

												<span class="meta-count">
													${reactionCountMap[a.mentoringNum]}
												</span>

											</span>


											<!-- 댓글 -->
											<span class="meta-item">

												<svg class="meta-icon chat"
													viewBox="0 0 24 24"
													aria-hidden="true">

													<path
														d="M21 15a4 4 0 0 1-4 4H8l-5 3V7a4 4 0 0 1 4-4h10a4 4 0 0 1 4 4z"
														fill="none"
														stroke="currentColor"
														stroke-width="2"
														stroke-linejoin="round" />

												</svg>

												<span class="meta-count">
													${comtCountMap[a.mentoringNum]}
												</span>

											</span>

										</div>

									</div>

								</a>

							</c:forEach>

						</div>

					</div>

				</div>

			</section>

		</c:forEach>

	</div>
</main>

</div>


<script>
document.addEventListener("DOMContentLoaded", function() {

	/* =========================
	   팀 소개 수정
	   ========================= */

	const teamCard = document.getElementById("teamCard");
	const editBtn = document.getElementById("teamEditBtn");
	const cancelBtn = document.getElementById("teamCancelBtn");
	const introInput = document.getElementById("intro");

	const originalIntro = introInput ? introInput.value : "";

	if (editBtn && teamCard) {

		editBtn.addEventListener("click", function() {

			teamCard.classList.add("is-editing");

			if (introInput) {
				introInput.focus();
			}

		});
	}


	if (cancelBtn && teamCard) {

		cancelBtn.addEventListener("click", function() {

			if (introInput) {
				introInput.value = originalIntro;
			}

			teamCard.classList.remove("is-editing");

		});
	}



	/* =========================
	   멘토/멘티 소개
	   ========================= */

	const peopleBtn = document.getElementById("peopleBtn");
	const peopleBody = document.getElementById("peopleBody");

	if (peopleBtn && peopleBody) {

		peopleBtn.addEventListener("click", function() {

			const isOpen = peopleBody.classList.toggle("open");

			peopleBtn.setAttribute("aria-expanded", isOpen);

			const caret = peopleBtn.querySelector(".m-acc-caret");

			if (caret) {
				caret.textContent = isOpen ? "▲" : "▼";
			}

		});
	}



	/* =========================
	   주차 열기/닫기 공통 함수
	   ========================= */

	function setWeekState(card, open) {

		const head = card.querySelector(".week-head");
		const body = card.querySelector(".week-body");
		const caret = card.querySelector(".week-caret");

		if (!head || !body) {
			return;
		}

		if (open) {
			body.classList.add("open");
		} else {
			body.classList.remove("open");
		}

		head.setAttribute("aria-expanded", open);

		if (caret) {
			caret.textContent = open ? "▲" : "▼";
		}
	}



	/* =========================
	   주차 제목 클릭
	   ========================= */

	const weekCards = document.querySelectorAll(".week-card");

	weekCards.forEach(function(card) {

		const head = card.querySelector(".week-head");

		if (!head) {
			return;
		}

		head.addEventListener("click", function(event) {

			// 수정 / 글쓰기 버튼을 눌렀을 때는 펼치기 방지
			if (event.target.closest("a")) {
				return;
			}

			const body = card.querySelector(".week-body");

			if (!body) {
				return;
			}

			const isOpen = body.classList.contains("open");

			setWeekState(card, !isOpen);

		});

	});



	/* =========================
	   상단 전체 / 주차 선택
	   ========================= */

	const dots = document.querySelectorAll(".w-dot");

	dots.forEach(function(dot) {

		dot.addEventListener("click", function() {

			const selectedWeek = this.dataset.week;


			// 선택 표시
			dots.forEach(function(item) {
				item.classList.remove("w-dot-active");
			});

			this.classList.add("w-dot-active");


			// 전체
			if (selectedWeek === "all") {

				weekCards.forEach(function(card) {
					setWeekState(card, true);
				});

				return;
			}


			// 특정 주차
			weekCards.forEach(function(card) {

				const cardWeek = card.dataset.week;

				if (cardWeek === selectedWeek) {
					setWeekState(card, true);
				} else {
					setWeekState(card, false);
				}

			});

		});

	});

});
</script>

<jsp:include page="../include/footer.jsp" />