<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover" />
  <title>ESD 체인지 메이커 : 멘토링 프로젝트</title>

  <link href="/resources/css/login.css" rel="stylesheet" />
</head>

<body>
  <header class="topbar">
    <div class="brand">
      <a href="/" class="brand-link" aria-label="홈으로 이동">
        <span class="brand-main-wrap">
          <img src="/resources/logo.png" alt="ESD 로고" class="brand-logo">
        </span>

        <span class="brand-sub">ESD 체인지 메이커 : 멘토링 프로젝트</span>
      </a>
    </div>
  </header>

  <main class="page">
    <section class="login" aria-label="로그인 영역">
      <h1 class="login-title">로그인</h1>

      <p class="login-desc">
        'ESD 체인지 메이커 : 멘토링 프로젝트'에 오신 것을 환영합니다.
      </p>

      <form action="/loginPost" method="post" class="login-form">
        <div class="form-group">
          <label for="userId">아이디</label>

          <input
            id="userId"
            name="userId"
            type="text"
            placeholder="아이디를 입력하세요"
            autocomplete="username"
            required
          />
        </div>

        <div class="form-group">
          <label for="userPw">비밀번호</label>

          <input
            id="userPw"
            name="userPw"
            type="password"
            placeholder="비밀번호를 입력하세요"
            autocomplete="current-password"
            required
          />
        </div>

        <div class="form-actions">
          <button class="btn-primary" type="submit">로그인</button>
        </div>
      </form>
    </section>
  </main>

  <footer class="site-footer">
    <nav class="footer-links" aria-label="푸터 링크">
      <a href="#">개인정보처리방침</a>
      <a href="#">대학정보공시</a>
      <a href="#">정보공개</a>
      <a href="#">이메일무단수집거부</a>
      <a href="#">찾아오시는길</a>
      <a href="#">교내홈페이지안내</a>
    </nav>

    <div class="footer-meta">
      (30019) 세종특별자치시 세종로 2511 고려대학교 세종캠퍼스 ·
      Tel: 044-860-1114 · Fax: 044-860-1048<br/>
      Copyright © 2024 KOREA University Sejong Campus. All Rights Reserved
    </div>
  </footer>

  <c:if test="${not empty msg}">
    <script>
      alert("${msg}");
    </script>
  </c:if>
</body>
</html>