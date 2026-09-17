<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link href="/resources/css/mentoringRead.css" rel="stylesheet">

<jsp:include page="../include/header.jsp" />

<main class="mentoring-read">
	<div class="mentoring-read__container">

		<h1 class="mentoring-read__title">멘토링</h1>

		<!-- 게시글 -->
		<form action="/mentoring/delete"
			method="post"
			id="deleteForm">

			<input type="hidden"
				name="mentoringNum"
				value="${mentoring.mentoringNum}">

			<input type="hidden"
				name="teamNum"
				value="${mentoring.teamNum}">

			<section class="mentoring-read__card">

				<!-- 제목 / 작성자 / 날짜 / 메뉴 -->
				<div class="mentoring-read__headline">

					<div class="mentoring-read__headline-left">
						<h2 class="mentoring-read__subject">
							<c:out value="${mentoring.title}" />
						</h2>
					</div>

					<div class="mentoring-read__headline-right">

						<div class="mentoring-read__meta">

							<span class="mentoring-read__writer">
								<c:out value="${mentoring.name}" />
							</span>

							<span class="mentoring-read__meta-label">
								날짜
							</span>

							<time>
								<fmt:formatDate
									pattern="yyyy-MM-dd"
									value="${mentoring.regDate}" />
							</time>

						</div>

						<!-- 작성자 또는 관리자 -->
						<c:if test="${loginUser.userId eq mentoring.userId or loginUser.authority eq 'A'}">

							<button type="button"
								class="mentoring-read__kebab"
								id="postKebabBtn"
								aria-label="게시글 메뉴">
								⋮
							</button>

							<div class="mentoring-read__kebab-menu"
								id="kebabMenu">

								<!-- 작성자만 수정 -->
								<c:if test="${loginUser.userId eq mentoring.userId}">

									<button type="button"
										class="mentoring-read__kebab-item"
										onclick="location.href='/mentoring/update?mentoringNum=${mentoring.mentoringNum}'">
										수정
									</button>

								</c:if>

								<button type="submit"
									class="mentoring-read__kebab-item mentoring-read__kebab-item--danger">
									삭제
								</button>

							</div>

						</c:if>

					</div>

				</div>

				<div class="mentoring-read__bottom-rule"></div>


				<!-- 일반 첨부파일 -->
				<!-- 일반 첨부파일 -->
		<c:set var="nonImgCount" value="0" />

			<!-- 첨부파일 (이미지 제외) -->
			<div class="mentoring-read__files">
				<ul class="uploadedList">
					<li>
						<div class="card">
							<div class="p-2">
								<div class="row">
									<div class="col pl-0">
										<c:if test="${!empty files}">
											<c:forEach items="${files}" var="file">
												<c:set var="lowerName"
													value="${fn:toLowerCase(file.fileName)}" />
												<c:set var="isImage"
													value="${fn:endsWith(lowerName,'.png') or fn:endsWith(lowerName,'.jpg') or fn:endsWith(lowerName,'.jpeg') or fn:endsWith(lowerName,'.gif') or fn:endsWith(lowerName,'.webp')}" />

												<!-- 이미지 파일은 아래 캐러셀에서 보여줄 거라 여기서는 제외 -->
												<c:if test="${!isImage}">
													<c:set var="nonImgCount" value="${nonImgCount + 1}" />

													<div class="p-1 text-start">
														<a href="javascript:void(0);"
															onclick="location.href='/displayFile?fileName=' + encodeURIComponent('${file.files}')"
															style="padding-left: 5px;"> ${file.fileName} </a>
													</div>
												</c:if>
											</c:forEach>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>

			<!-- 일반 파일(이미지 제외)이 있을 때만 구분선 -->
			<c:if test="${nonImgCount > 0}">
				<div class="mentoring-read__files-rule"></div>
			</c:if>


				<!-- 이미지 개수 -->
				<c:set var="imgCount" value="0" />

				<c:forEach items="${files}" var="file">

					<c:set var="lowerName"
						value="${fn:toLowerCase(file.fileName)}" />

					<c:if test="${fn:endsWith(lowerName,'.png')
						or fn:endsWith(lowerName,'.jpg')
						or fn:endsWith(lowerName,'.jpeg')
						or fn:endsWith(lowerName,'.gif')
						or fn:endsWith(lowerName,'.webp')}">

						<c:set var="imgCount"
							value="${imgCount + 1}" />

					</c:if>

				</c:forEach>


				<!-- 이미지 갤러리 -->
				<c:if test="${imgCount > 0}">

					<div class="mentoring-read__gallery">

						<c:if test="${imgCount >= 3}">

							<button type="button"
								class="mentoring-read__nav mentoring-read__nav--prev"
								aria-label="이전 이미지"
								onclick="moveGallery(-1)">
								&lt;
							</button>

						</c:if>


						<div class="mentoring-read__gallery-track"
							id="galleryTrack">

							<c:forEach items="${files}"
								var="file"
								varStatus="status">

								<c:set var="lowerName"
									value="${fn:toLowerCase(file.fileName)}" />

								<c:set var="isImage"
									value="${fn:endsWith(lowerName,'.png')
										or fn:endsWith(lowerName,'.jpg')
										or fn:endsWith(lowerName,'.jpeg')
										or fn:endsWith(lowerName,'.gif')
										or fn:endsWith(lowerName,'.webp')}" />

								<c:if test="${isImage}">

									<div class="mentoring-read__slide">

										<img
											src="/displayFile?fileName=${file.files}"
											alt="첨부 이미지 ${status.count}"
											class="mentoring-read__img">

									</div>

								</c:if>

							</c:forEach>

						</div>


						<c:if test="${imgCount >= 3}">

							<button type="button"
								class="mentoring-read__nav mentoring-read__nav--next"
								aria-label="다음 이미지"
								onclick="moveGallery(1)">
								&gt;
							</button>

						</c:if>

					</div>

				</c:if>


				<!-- 본문 -->
				<div class="mentoring-read__body">
					<p><c:out value="${mentoring.content}" /></p>
				</div>

			</section>

		</form>


		<!-- 목록 -->
		<div class="mentoring-read__listbar">

			<button type="button"
				class="mentoring-read__listbtn"
				onclick="location.href='/mentoring/mentoringList?teamNum=${mentoring.teamNum}'">
				목록
			</button>

		</div>

		<div class="mentoring-read__footerbar"></div>


		<!-- 반응 초기값 -->
		<input type="hidden"
			id="myReactionType"
			value="${myReactionType}">

		<input type="hidden"
			id="reactionInitTotal"
			value="${reactionTotal}">


		<!-- 반응 / 댓글 수 -->
		<div class="mentoring-read__socialbar">

			<div class="mentoring-read__social">

				<!-- 반응 -->
				<div class="reaction-wrap">

					<button type="button"
						class="meta-item meta-item--btn"
						id="reactionTrigger"
						aria-label="반응">

						<span class="reaction-selected"
							id="reactionSelected"
							aria-hidden="true"
							style="display:none;">
						</span>

						<span class="reaction-empty"
							id="reactionEmpty"
							aria-hidden="true">

							<span class="reaction-plus">+</span>
							<span class="reaction-face">😊</span>

						</span>

						<span class="meta-count"
							id="reactionTotal">
							${reactionTotal}
						</span>

					</button>


					<!-- 반응 선택 -->
					<div id="reactionBar"
						class="reaction-bar"
						aria-hidden="true">

						<button type="button"
							class="reaction-ic"
							data-type="1">

							<img src="/resources/emo1.png"
								class="reaction-img"
								alt="반응 1">

							<span class="reaction-num">
								${empty countEmo1 ? 0 : countEmo1}
							</span>

						</button>

						<button type="button"
							class="reaction-ic"
							data-type="2">

							<img src="/resources/emo2.png"
								class="reaction-img"
								alt="반응 2">

							<span class="reaction-num">
								${empty countEmo2 ? 0 : countEmo2}
							</span>

						</button>

						<button type="button"
							class="reaction-ic"
							data-type="3">

							<img src="/resources/emo3.png"
								class="reaction-img"
								alt="반응 3">

							<span class="reaction-num">
								${empty countEmo3 ? 0 : countEmo3}
							</span>

						</button>

						<button type="button"
							class="reaction-ic"
							data-type="4">

							<img src="/resources/emo4.png"
								class="reaction-img"
								alt="반응 4">

							<span class="reaction-num">
								${empty countEmo4 ? 0 : countEmo4}
							</span>

						</button>

						<button type="button"
							class="reaction-ic"
							data-type="5">

							<img src="/resources/emo5.png"
								class="reaction-img"
								alt="반응 5">

							<span class="reaction-num">
								${empty countEmo5 ? 0 : countEmo5}
							</span>

						</button>

						<button type="button"
							class="reaction-ic"
							data-type="6">

							<img src="/resources/emo6.png"
								class="reaction-img"
								alt="반응 6">

							<span class="reaction-num">
								${empty countEmo6 ? 0 : countEmo6}
							</span>

						</button>

						<button type="button"
							class="reaction-ic"
							data-type="7">

							<img src="/resources/emo7.png"
								class="reaction-img"
								alt="반응 7">

							<span class="reaction-num">
								${empty countEmo7 ? 0 : countEmo7}
							</span>

						</button>

						<span class="reaction-tail"
							aria-hidden="true">
						</span>

					</div>

				</div>


				<!-- 댓글 수 -->
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

					<span class="meta-count"
						id="commentCount">
						${countComt}
					</span>

				</span>

			</div>

		</div>


		<!-- 댓글 입력 -->
		<form id="commentForm"
			class="mentoring-read__commentbox mentoring-read__commentbox--photo"
			onsubmit="return false;">

			<input type="hidden"
				id="mentoringNum"
				value="${mentoring.mentoringNum}">

			<input type="hidden"
				id="loginUserId"
				value="${loginUser.userId}">

			<textarea
				id="newReplyText"
				class="mentoring-read__commentinput mentoring-read__commentinput--photo"
				placeholder="댓글을 입력해주세요."
				required></textarea>

			<button type="button"
				id="commentAddBtn"
				class="mentoring-read__commentbtn mentoring-read__commentbtn--photo">
				등록
			</button>

		</form>

		<div class="mentoring-read__social-rule"></div>


		<!-- 댓글 목록 -->
		<div class="mentoring-read__comments"
			id="replyList">
		</div>

	</div>
</main>

</div>

<jsp:include page="../include/footer.jsp" />


<script>

/* =========================
   게시글 삭제
========================= */

$("#deleteForm").on("submit", function () {

	return confirm("게시글을 삭제하시겠습니까?");
});


/* =========================
   댓글
========================= */

$(function () {

	var mentoringNum = $("#mentoringNum").val();
	var loginUserId = $("#loginUserId").val();


	function escapeHtml(str) {

		return String(str == null ? "" : str)
			.replace(/&/g, "&amp;")
			.replace(/</g, "&lt;")
			.replace(/>/g, "&gt;")
			.replace(/"/g, "&quot;")
			.replace(/'/g, "&#39;");
	}


	function formatDate(date) {

		if (!date) {
			return "";
		}

		var value = String(date).trim();

		if (/^\d+$/.test(value)) {

			var number = Number(value);
			var milliseconds =
				value.length === 10 ? number * 1000 : number;

			var numericDate = new Date(milliseconds);

			if (!isNaN(numericDate.getTime())) {

				var year = numericDate.getFullYear();

				var month = String(
					numericDate.getMonth() + 1
				).padStart(2, "0");

				var day = String(
					numericDate.getDate()
				).padStart(2, "0");

				return year + "-" + month + "-" + day;
			}
		}

		var parsedDate = new Date(value);

		if (!isNaN(parsedDate.getTime())) {

			var year = parsedDate.getFullYear();

			var month = String(
				parsedDate.getMonth() + 1
			).padStart(2, "0");

			var day = String(
				parsedDate.getDate()
			).padStart(2, "0");

			return year + "-" + month + "-" + day;
		}

		return value.length >= 10
			? value.substring(0, 10)
			: value;
	}


	function setCommentCount(count) {
		$("#commentCount").text(Number(count || 0));
	}


	function getReplies() {

		if (!mentoringNum) {
			return;
		}

		$.getJSON(
			"/mentoringComt/all/" + mentoringNum,
			function (data) {

				if (!data || data.length === 0) {

					$("#replyList").html(
						"<div class='mentoring-read__comment'>" +
						"댓글이 없습니다." +
						"</div>"
					);

					setCommentCount(0);

					return;
				}

				setCommentCount(data.length);

				var html = "";

				$.each(data, function () {

					var writer =
						escapeHtml(this.name || this.userId);

					var date =
						escapeHtml(formatDate(this.regDate));

					var content =
						escapeHtml(this.content);

					var comtNum = this.comtNum;

					var kebab = "";

					if (this.userId === loginUserId) {

						kebab =
							"<div class='reply-kebab'>" +
								"<button type='button' " +
									"class='reply-kebab__btn' " +
									"aria-label='댓글 메뉴'>⋮</button>" +

								"<div class='reply-kebab__menu'>" +

									"<button type='button' " +
										"class='reply-kebab__item reply-kebab__item--danger js-reply-del' " +
										"data-comtnum='" + comtNum + "'>" +
										"삭제" +
									"</button>" +

								"</div>" +

							"</div>";
					}

					html +=
						"<div class='mentoring-read__comment' " +
							"data-comtnum='" + comtNum + "'>" +

							"<div class='mentoring-read__comment-head'>" +

								"<div class='mentoring-read__comment-meta'>" +

									"<strong class='mentoring-read__comment-writer'>" +
										writer +
									"</strong>" +

									"<span class='mentoring-read__comment-date'>" +
										date +
									"</span>" +

								"</div>" +

								kebab +

							"</div>" +

							"<div class='mentoring-read__comment-body'>" +
								content +
							"</div>" +

						"</div>";
				});

				$("#replyList").html(html);
			}
		).fail(function () {

			$("#replyList").html(
				"<div class='mentoring-read__comment'>" +
					"댓글 목록 조회에 실패했습니다." +
				"</div>"
			);
		});
	}


	// 최초 댓글 조회
	getReplies();


	// 댓글 메뉴
	$(document).on(
		"click",
		".reply-kebab__btn",
		function (event) {

			event.stopPropagation();

			var $kebab =
				$(this).closest(".reply-kebab");

			$(".reply-kebab")
				.not($kebab)
				.removeClass("is-open");

			$kebab.toggleClass("is-open");
		}
	);


	// 메뉴 외부 클릭
	$(document).on("click", function () {
		$(".reply-kebab").removeClass("is-open");
	});


	// 댓글 등록
	$("#commentAddBtn").on("click", function () {

		var content =
			$("#newReplyText").val().trim();

		if (!content) {

			alert("내용을 입력해주세요.");

			$("#newReplyText").focus();

			return;
		}

		$.ajax({

			type: "POST",
			url: "/mentoringComt/new",

			contentType:
				"application/json; charset=UTF-8",

			dataType: "text",

			data: JSON.stringify({
				mentoringNum: mentoringNum,
				userId: loginUserId,
				content: content
			}),

			success: function (result) {

				if ((result || "").trim() === "SUCCESS") {

					$("#newReplyText").val("");

					getReplies();
				}
			},

			error: function () {
				alert("댓글 등록에 실패했습니다.");
			}
		});
	});


	// 댓글 삭제
	$(document).on(
		"click",
		".js-reply-del",
		function (event) {

			event.stopPropagation();

			var comtNum =
				$(this).data("comtnum");

			if (!confirm("댓글을 삭제하시겠습니까?")) {
				return;
			}

			$.ajax({

				type: "DELETE",
				url: "/mentoringComt/" + comtNum,
				dataType: "text",

				success: function (result) {

					if ((result || "").trim() === "SUCCESS") {
						getReplies();
					}
				},

				error: function () {
					alert("댓글 삭제에 실패했습니다.");
				}
			});
		}
	);

});


/* =========================
   게시글 메뉴
========================= */

$("#postKebabBtn").on("click", function (event) {

	event.stopPropagation();

	$("#kebabMenu").toggleClass("is-open");
});


$(document).on("click", function (event) {

	if (
		!$(event.target).closest(
			"#kebabMenu, #postKebabBtn"
		).length
	) {
		$("#kebabMenu").removeClass("is-open");
	}
});


/* =========================
   이미지 갤러리
========================= */

function moveGallery(direction) {

	var track =
		document.getElementById("galleryTrack");

	if (!track) {
		return;
	}

	var slide =
		track.querySelector(
			".mentoring-read__slide"
		);

	if (!slide) {
		return;
	}

	var gap = 18;

	var slideWidth =
		slide.getBoundingClientRect().width;

	var step =
		(slideWidth + gap) * 2;

	track.scrollBy({
		left: direction * step,
		behavior: "smooth"
	});
}


/* =========================
   반응
========================= */

$(function () {

	var $bar = $("#reactionBar");
	var $trigger = $("#reactionTrigger");
	var $empty = $("#reactionEmpty");
	var $selected = $("#reactionSelected");

	var emojiMap = {
		"1": "/resources/emo1.png",
		"2": "/resources/emo2.png",
		"3": "/resources/emo3.png",
		"4": "/resources/emo4.png",
		"5": "/resources/emo5.png",
		"6": "/resources/emo6.png",
		"7": "/resources/emo7.png"
	};


	function openReactionBar() {

		$bar
			.addClass("is-open")
			.attr("aria-hidden", "false");
	}


	function closeReactionBar() {

		$bar
			.removeClass("is-open")
			.attr("aria-hidden", "true");
	}


	function showSelectedEmoji(type) {

		var key =
			type == null
				? ""
				: String(type).trim();

		var src = emojiMap[key];

		if (src) {

			$selected
				.html(
					"<img src='" + src +
					"' class='reaction-selected-img' " +
					"alt='선택한 반응'>"
				)
				.show();

			$empty.hide();

		} else {

			$selected.empty().hide();

			$empty.show();
		}
	}


	function setReactionCount(type, count) {

		$bar
			.find(
				".reaction-ic[data-type='" +
				type +
				"'] .reaction-num"
			)
			.text(
				Math.max(
					0,
					Number(count || 0)
				)
			);
	}


	function applyReactionCounts(data) {

		setReactionCount("1", data.countEmo1);
		setReactionCount("2", data.countEmo2);
		setReactionCount("3", data.countEmo3);
		setReactionCount("4", data.countEmo4);
		setReactionCount("5", data.countEmo5);
		setReactionCount("6", data.countEmo6);
		setReactionCount("7", data.countEmo7);
	}


	// 초기 반응 상태
	var currentType =
		($("#myReactionType").val() || "").trim();

	var initialTotal =
		$("#reactionInitTotal").val();

	$("#reactionTotal").text(
		Number(initialTotal || 0)
	);


	if (currentType) {

		$bar
			.find(
				".reaction-ic[data-type='" +
					currentType +
				"']"
			)
			.addClass("is-on");

		showSelectedEmoji(currentType);

	} else {

		showSelectedEmoji(null);
	}


	// 반응창 열기 / 닫기
	$trigger.on("click", function (event) {

		event.preventDefault();
		event.stopPropagation();

		if ($bar.hasClass("is-open")) {
			closeReactionBar();
		} else {
			openReactionBar();
		}
	});


	$bar.on("click", function (event) {
		event.stopPropagation();
	});


	var processing = false;


	// 반응 선택
	$bar.on(
		"click",
		".reaction-ic",
		function (event) {

			event.preventDefault();
			event.stopPropagation();

			if (processing) {
				return;
			}

			var mentoringNum =
				$("#mentoringNum").val();

			var relateType =
				String(
					$(this).data("type") || ""
				).trim();

			if (!mentoringNum) {
				return;
			}

			processing = true;


			$.ajax({

				type: "POST",
				url: "/mentoring/relate/toggle",
				dataType: "json",

				data: {
					mentoringNum: mentoringNum,
					relateType: relateType
				},

				success: function (data) {

					if (!data || data.success !== true) {

						if (
							data &&
							data.message === "login_required"
						) {
							alert("로그인이 필요합니다.");
						}

						return;
					}


					var newType =
						data.currentType
							? String(
								data.currentType
							).trim()
							: "";


					// 반응별 개수
					applyReactionCounts(data);


					// 선택 상태
					$bar
						.find(".reaction-ic")
						.removeClass("is-on");


					if (newType) {

						$bar
							.find(
								".reaction-ic[data-type='" +
									newType +
								"']"
							)
							.addClass("is-on");

						showSelectedEmoji(newType);

					} else {

						showSelectedEmoji(null);
					}


					// 전체 반응 수
					$("#reactionTotal").text(
						Number(data.total || 0)
					);


					// 현재 사용자 반응
					currentType = newType;

					$("#myReactionType")
						.val(newType);


					closeReactionBar();
				},

				error: function () {
					alert("반응 처리에 실패했습니다.");
				},

				complete: function () {
					processing = false;
				}
			});
		}
	);


	// 외부 클릭 시 반응창 닫기
	$(document).on("click", function (event) {

		if (
			$(event.target)
				.closest(
					"#reactionBar, #reactionTrigger"
				)
				.length
		) {
			return;
		}

		closeReactionBar();
	});

});

</script>