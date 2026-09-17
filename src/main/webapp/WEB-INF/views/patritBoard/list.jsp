<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link href="/resources/css/patritList.css" rel="stylesheet">
<jsp:include page="../include/header.jsp" />

<main class="patrit-main">
<div class="patrit-wrap">

	<div class="term-select">
		<div class="patrit-title">패트릿 보드</div>
	</div>

	<div class="patrit-toolbar">
		<div class="patrit-dropdown" id="termDropdown">

			<button class="patrit-term-btn" type="button" id="termBtn"
				aria-haspopup="listbox" aria-expanded="false">

				<span id="termLabel"> <c:out value="${year}" />년 <c:out
						value="${term}" />학기
				</span> <span class="patrit-arrow" aria-hidden="true">▼</span>
			</button>

			<ul class="patrit-menu" id="termMenu" role="listbox"
				aria-label="학기 선택">

				<c:forEach var="yt" items="${yearTermList}">
					<c:set var="selected"
						value="${(yt.year eq year) and (yt.term eq term)}" />

					<li role="option" tabindex="${selected ? '0' : '-1'}"
						aria-selected="${selected ? 'true' : 'false'}"
						data-year="${yt.year}" data-term="${yt.term}"><c:out
							value="${yt.year}" />년 <c:out value="${yt.term}" />학기</li>
				</c:forEach>

			</ul>
		</div>

		<c:if test="${canWrite}">
			<button type="button" class="patrit-write" id="openPatritModal"
				aria-label="글 등록">

				<svg width="22" height="22" viewBox="0 0 24 24" fill="none"
					aria-hidden="true">

					<path d="M12 20h9" stroke="currentColor" stroke-width="2"
						stroke-linecap="round" />

					<path d="M16.5 3.5a2.1 2.0 0 0 1 3 3L8 18l-4 1 1-4L16.5 3.5Z"
						stroke="currentColor" stroke-width="2" stroke-linejoin="round" />
				</svg>

			</button>
		</c:if>
	</div>

	<section class="patrit-grid" aria-label="패트릿 카드 그리드">

		<c:if test="${empty list}">
			<p class="tile-text">내역이 없습니다.</p>
		</c:if>

		<c:if test="${not empty list}">

			<c:forEach var="p" items="${list}" varStatus="var">

				<article class="patrit-tile">

					<div class="tile-top">

						<span class="tile-role"> <c:choose>
								<c:when test="${p.authority eq 'M'}">
									멘토
								</c:when>

								<c:when test="${p.authority eq 'S'}">
									멘티
								</c:when>

								<c:otherwise>
									<c:out value="${p.authority}" />
								</c:otherwise>
							</c:choose>
						</span> <span class="tile-name"> <c:out value="${p.name}" />
						</span>

						<c:if
							test="${p.userId eq loginUser.userId or loginUser.authority eq 'A'}">

							<div class="tile-actions">

								<button type="button" class="tile-kebab js-kebab"
									aria-haspopup="menu" aria-expanded="false" title="더보기">⋯</button>

								<div class="tile-menu" role="menu" aria-hidden="true">

									<c:if test="${p.userId eq loginUser.userId}">
										<button type="button" class="tile-menu__item js-edit"
											role="menuitem" data-id="${p.patritNum}"
											data-content="${fn:escapeXml(p.content)}">수정</button>
									</c:if>

									<button type="button"
										class="tile-menu__item tile-menu__item--danger js-delete"
										role="menuitem" data-id="${p.patritNum}">삭제</button>

								</div>

							</div>

						</c:if>

					</div>

					<p class="tile-text">
						<c:out value="${p.content}" escapeXml="true" />
					</p>

					<div class="tile-char" aria-hidden="true">
						<img src="/resources/emo${var.count}.png" alt="이미지">
					</div>

				</article>

			</c:forEach>

		</c:if>

	</section>

	<c:url var="patritListUrl" value="/patritBoard/list" />

	<c:if test="${not empty list}">

		<nav class="patrit-pager" aria-label="페이지네이션">

			<c:choose>

				<c:when test="${pageMaker.prev}">
					<button type="button" class="patrit-chev js-page"
						data-href="${patritListUrl}?page=${pageMaker.startPage - 1}&perPageNum=${pageMaker.cri.perPageNum}&year=${year}&term=${term}">
						&lt;</button>
				</c:when>

				<c:otherwise>
					<button type="button" class="patrit-chev" disabled>&lt;</button>
				</c:otherwise>

			</c:choose>

			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
				var="pno">

				<button type="button"
					class="patrit-page js-page ${pageMaker.cri.page == pno ? 'is-active' : ''}"
					data-href="${patritListUrl}?page=${pno}&perPageNum=${pageMaker.cri.perPageNum}&year=${year}&term=${term}">
					${pno}</button>

			</c:forEach>

			<c:choose>

				<c:when test="${pageMaker.next && pageMaker.endPage > 0}">
					<button type="button" class="patrit-chev js-page"
						data-href="${patritListUrl}?page=${pageMaker.endPage + 1}&perPageNum=${pageMaker.cri.perPageNum}&year=${year}&term=${term}">
						&gt;</button>
				</c:when>

				<c:otherwise>
					<button type="button" class="patrit-chev" disabled>&gt;</button>
				</c:otherwise>

			</c:choose>

		</nav>

	</c:if>

</div>
</main>
</div>
<!-- 등록/수정 모달 -->
<div class="patrit-modal" id="patritModal" aria-hidden="true">

	<div class="patrit-modal__backdrop" id="patritModalBackdrop"></div>

	<div class="patrit-modal__panel" role="dialog" aria-modal="true"
		aria-labelledby="patritModalTitle">

		<div class="patrit-modal__header">

			<h2 id="patritModalTitle">패트릿 보드 메시지 남기기</h2>

			<button type="button" class="patrit-modal__close"
				id="closePatritModal" aria-label="닫기">✕</button>

		</div>

		<form id="patritModalForm">

			<input type="hidden" id="patritNum" value="">

			<div class="patrit-modal__field">

				<label for="patritContent">내용</label>

				<textarea id="patritContent" name="content" rows="5" maxlength="500"
					required placeholder="후기를 메시지로 남겨주세요."></textarea>

			</div>

			<div class="patrit-modal__actions">

				<button type="submit" class="patrit-btn patrit-btn--primary"
					id="submitPatritModal">등록</button>

				<button type="button" class="patrit-btn patrit-btn--ghost"
					id="cancelPatritModal">취소</button>

			</div>

			<p class="patrit-modal__msg" id="patritModalMsg" aria-live="polite"></p>

		</form>

	</div>

</div>

<script>
	const termDropdown = document.getElementById('termDropdown');
	const termBtn = document.getElementById('termBtn');
	const termMenu = document.getElementById('termMenu');
	const termLabel = document.getElementById('termLabel');

	function openTermMenu() {
		termDropdown.classList.add('open');
		termBtn.setAttribute('aria-expanded', 'true');

		(termMenu.querySelector('[aria-selected="true"]')
			|| termMenu.querySelector('li'))?.focus();
	}

	function closeTermMenu() {
		termDropdown.classList.remove('open');
		termBtn.setAttribute('aria-expanded', 'false');
	}

	function toggleTermMenu() {
		const isOpen = termDropdown.classList.contains('open');

		if (isOpen) {
			closeTermMenu();
		} else {
			openTermMenu();
		}
	}

	termBtn.addEventListener('click', (e) => {
		e.stopPropagation();
		toggleTermMenu();
	});

	termBtn.addEventListener('keydown', (e) => {

		if (e.key === 'ArrowDown'
				|| e.key === 'Enter'
				|| e.key === ' ') {

			e.preventDefault();
			openTermMenu();
		}

	});

	function goYearTerm(y, t) {

		const url = new URL(window.location.href);

		url.pathname = '${patritListUrl}';
		url.searchParams.set('year', y);
		url.searchParams.set('term', t);
		url.searchParams.set('page', '1');

		const per = '${pageMaker.cri.perPageNum}';

		if (per) {
			url.searchParams.set('perPageNum', per);
		}

		window.location.href = url.toString();
	}

	termMenu.querySelectorAll('li').forEach(li => {

		li.addEventListener('click', (e) => {

			e.stopPropagation();

			const y = li.dataset.year;
			const t = li.dataset.term;

			termLabel.textContent = li.textContent;

			closeTermMenu();
			goYearTerm(y, t);

		});

		li.addEventListener('keydown', (e) => {

			const items =
				Array.from(termMenu.querySelectorAll('li'));

			const idx = items.indexOf(li);

			if (e.key === 'Enter' || e.key === ' ') {

				e.preventDefault();

				const y = li.dataset.year;
				const t = li.dataset.term;

				termLabel.textContent = li.textContent;

				closeTermMenu();
				goYearTerm(y, t);
			}

			if (e.key === 'ArrowDown'
					|| e.key === 'ArrowUp') {

				e.preventDefault();

				const nextIdx =
					e.key === 'ArrowDown'
						? Math.min(idx + 1, items.length - 1)
						: Math.max(idx - 1, 0);

				items[nextIdx].focus();
			}

		});

	});

	document.addEventListener('click', (e) => {

		if (!termDropdown.contains(e.target)) {
			closeTermMenu();
		}

	});

	document.addEventListener('keydown', (e) => {

		if (e.key === 'Escape') {
			closeTermMenu();
		}

	});
</script>

<script>
	document.addEventListener('click', (e) => {

		const btn = e.target.closest('.js-page');

		if (!btn) {
			return;
		}

		const href = btn.dataset.href;

		if (href) {
			window.location.href = href;
		}

	});
</script>

<script>
	function closeAllTileMenus() {

		document
			.querySelectorAll('.tile-actions.is-open')
			.forEach(wrap => {

				wrap.classList.remove('is-open');

				const btn =
					wrap.querySelector('.js-kebab');

				const menu =
					wrap.querySelector('.tile-menu');

				btn?.setAttribute(
					'aria-expanded', 'false');

				menu?.setAttribute(
					'aria-hidden', 'true');

			});
	}

	document.addEventListener('click', (e) => {

		const kebab = e.target.closest('.js-kebab');

		if (!kebab) {
			closeAllTileMenus();
			return;
		}

		e.stopPropagation();

		const wrap =
			kebab.closest('.tile-actions');

		const isOpen =
			wrap.classList.contains('is-open');

		closeAllTileMenus();

		if (!isOpen) {

			wrap.classList.add('is-open');

			kebab.setAttribute(
				'aria-expanded', 'true');

			wrap.querySelector('.tile-menu')
				?.setAttribute(
					'aria-hidden', 'false');
		}

	});

	document.addEventListener('keydown', (e) => {

		if (e.key === 'Escape') {
			closeAllTileMenus();
		}

	});
</script>

<script>
	const openBtn =
		document.getElementById('openPatritModal');

	const modal =
		document.getElementById('patritModal');

	const backdrop =
		document.getElementById('patritModalBackdrop');

	const closeBtn =
		document.getElementById('closePatritModal');

	const cancelBtn =
		document.getElementById('cancelPatritModal');

	const form =
		document.getElementById('patritModalForm');

	const msg =
		document.getElementById('patritModalMsg');

	const contentEl =
		document.getElementById('patritContent');

	const patritNumEl =
		document.getElementById('patritNum');

	const titleEl =
		document.getElementById('patritModalTitle');

	const submitBtn =
		document.getElementById('submitPatritModal');

	let mode = 'create';

	function setModeCreate() {

		mode = 'create';

		if (titleEl) {
			titleEl.textContent =
				'패트릿 보드 메시지 남기기';
		}

		if (submitBtn) {
			submitBtn.textContent = '등록';
		}

		if (contentEl) {
			contentEl.value = '';
		}

		if (patritNumEl) {
			patritNumEl.value = '';
			patritNumEl.removeAttribute('name');
		}

	}

	function setModeEdit(id, content) {

		mode = 'edit';

		if (titleEl) {
			titleEl.textContent =
				'패트릿 보드 메시지 수정';
		}

		if (submitBtn) {
			submitBtn.textContent = '수정';
		}

		if (patritNumEl) {
			patritNumEl.setAttribute(
				'name', 'patritNum');

			patritNumEl.value = id || '';
		}

		if (contentEl) {
			contentEl.value = content || '';
		}

	}

	function openModal() {

		if (!modal) {
			return;
		}

		modal.classList.add('is-open');
		modal.setAttribute(
			'aria-hidden', 'false');

		if (msg) {
			msg.textContent = '';
		}

		setTimeout(
			() => contentEl && contentEl.focus(),
			0
		);

	}

	function closeModal() {

		if (!modal) {
			return;
		}

		modal.classList.remove('is-open');
		modal.setAttribute(
			'aria-hidden', 'true');

	}

	openBtn?.addEventListener('click', () => {
		setModeCreate();
		openModal();
	});

	backdrop?.addEventListener(
		'click', closeModal);

	closeBtn?.addEventListener(
		'click', closeModal);

	cancelBtn?.addEventListener(
		'click', closeModal);

	document.addEventListener('keydown', (e) => {

		if (e.key === 'Escape'
				&& modal
				&& modal.classList.contains('is-open')) {

			closeModal();
		}

	});

	document.addEventListener('click', (e) => {

		const editBtn =
			e.target.closest('.js-edit');

		if (!editBtn) {
			return;
		}

		e.stopPropagation();
		closeAllTileMenus();

		const id =
			editBtn.dataset.id;

		const content =
			editBtn.dataset.content || '';

		setModeEdit(id, content);
		openModal();

	});

	document.addEventListener('click', async (e) => {

		const delBtn =
			e.target.closest('.js-delete');

		if (!delBtn) {
			return;
		}

		e.stopPropagation();
		closeAllTileMenus();

		const id =
			delBtn.dataset.id;

		const ok =
			window.confirm('정말 삭제하시겠습니까?');

		if (!ok) {
			return;
		}

		try {

			const res = await fetch(
				'<c:url value="/patritBoard/deleteAjax"/>',
				{
					method: 'POST',
					headers: {
						'Content-Type':
							'application/x-www-form-urlencoded; charset=UTF-8'
					},
					body:
						'patritNum='
						+ encodeURIComponent(id)
				}
			);

			if (!res.ok) {
				throw new Error(
					'HTTP ' + res.status);
			}

			const data =
				await res.json();

			if (!data.success) {
				alert(
					data.message
					|| '삭제에 실패했습니다.'
				);

				return;
			}

			window.location.reload();

		} catch (err) {

			console.error(err);

			alert(
				'오류가 발생했습니다. 잠시 후 다시 시도해 주세요.'
			);
		}

	});

	form?.addEventListener('submit', async (e) => {

		e.preventDefault();

		const content =
			contentEl?.value?.trim();

		if (!content) {

			if (msg) {
				msg.textContent =
					'내용을 입력해 주세요.';
			}

			contentEl?.focus();

			return;
		}

		const ok = window.confirm(
			mode === 'edit'
				? '수정하시겠습니까?'
				: '등록하시겠습니까?'
		);

		if (!ok) {
			return;
		}

		const fd =
			new FormData(form);

		const url =
			mode === 'edit'
				? '<c:url value="/patritBoard/updateAjax"/>'
				: '<c:url value="/patritBoard/registerAjax"/>';

		try {

			const res =
				await fetch(url, {
					method: 'POST',
					body: fd
				});

			if (!res.ok) {
				throw new Error(
					'HTTP ' + res.status);
			}

			const data =
				await res.json();

			if (!data.success) {

				if (msg) {
					msg.textContent =
						data.message
						|| (mode === 'edit'
							? '수정에 실패했습니다.'
							: '등록에 실패했습니다.');
				}

				return;
			}

			closeModal();
			window.location.reload();

		} catch (err) {

			console.error(err);

			if (msg) {
				msg.textContent =
					'오류가 발생했습니다. 잠시 후 다시 시도해 주세요.';
			}

		}

	});
</script>

<jsp:include page="../include/footer.jsp" />