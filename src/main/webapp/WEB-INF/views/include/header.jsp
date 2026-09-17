<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>ESD 체인지 메이커 : 멘토링 프로젝트</title>

<link href="/resources/css/header.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

<header class="topbar">
  <button class="hamburger" aria-label="메뉴" id="menuBtn" type="button">
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" aria-hidden="true">
      <path d="M4 7h16M4 12h16M4 17h16"
            stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
    </svg>
  </button>

  <div class="brand">
    <a href="/home" class="brand-link" aria-label="홈으로 이동">

      <span class="brand-main-wrap">
        <img src="/resources/logo.png" alt="ESD 로고" class="brand-logo"> 
      </span>

      <span class="brand-sub">ESD 체인지 메이커 : 멘토링 프로젝트</span>

    </a>
  </div>

  <div class="user-wrap" id="userWrap">
    <button class="user-btn" id="userBtn" type="button" aria-haspopup="menu" aria-expanded="false">
      ${loginUser.name}님 <span class="chev" aria-hidden="true">▼</span>
    </button>

    <div class="dropdown" id="userMenu" role="menu" aria-label="사용자 메뉴">
      <c:if test="${loginUser.authority eq 'M' or loginUser.authority eq 'S'}">
        <a href="/mypage/myInfo" role="menuitem">마이페이지</a>
        <div class="sep"></div>
      </c:if>
      <a href="/logout" role="menuitem">로그아웃</a>
    </div>
  </div>
</header>

<!-- 모바일 오버레이 -->
<div class="overlay" id="overlay" aria-hidden="true"></div>

<!-- ✅ home.jsp가 </div>로 닫고 있으니 header에서 열어둔다 -->
<div class="app">
  <aside class="sidebar" aria-label="사이드바 메뉴">
    <nav>
      <ul>

        <!-- ===================== 멘토/멘티(M,S) 메뉴 ===================== -->
        <c:if test="${loginUser.authority eq 'M' or loginUser.authority eq 'S'}">

          <li>
            <a href="/notice/list">
              <!-- 공지 -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M4 4h16v12H4z" stroke="currentColor" stroke-width="2"/>
                <path d="M8 20h8" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>공지사항</span>
            </a>
          </li>

          <li>
            <a href="/preTraining/list">
              <!-- 교육 -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M3 6l9-4 9 4-9 4-9-4z" stroke="currentColor" stroke-width="2"/>
                <path d="M21 10v6l-9 4-9-4v-6" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>사전교육</span>
            </a>
          </li>

          <li>
            <a href="/mentoring/dashboard">
              <!-- 멘토링(대화) -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M4 4h16v10H7l-3 3z" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>멘토링</span>
            </a>
          </li>

          <li>
            <a href="#">
              <!-- 성찰/활동(문서) -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M6 2h9l5 5v15H6z" stroke="currentColor" stroke-width="2"/>
                <path d="M8 12h8M8 16h6" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>성찰일지&활동보고서</span>
            </a>
          </li>

          <li>
            <a href="surveyList.html">
              <!-- 설문 -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M4 4h16v16H4z" stroke="currentColor" stroke-width="2"/>
                <path d="M8 10l2 2 4-4" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>만족도 조사</span>
            </a>
          </li>

          <li>
            <a href="/patritBoard/list">
              <!-- 게시판 -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <rect x="3" y="4" width="18" height="16" rx="2" stroke="currentColor" stroke-width="2"/>
                <path d="M7 8h10M7 12h6" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>패트릿 보드</span>
            </a>
          </li>

        </c:if>

        <!-- ===================== 관리자(A) 메뉴 ===================== -->
        <c:if test="${loginUser.authority eq 'A'}">

          <li>
            <a href="/member/mentoList">
              <!-- 멘토(사람) -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <circle cx="12" cy="8" r="4" stroke="currentColor" stroke-width="2"/>
                <path d="M4 20c0-4 4-6 8-6s8 2 8 6" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>멘토 관리</span>
            </a>
          </li>

          <li>
            <a href="/member/mentiList">
              <!-- 멘티(그룹) -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <circle cx="9" cy="8" r="3" stroke="currentColor" stroke-width="2"/>
                <circle cx="17" cy="8" r="3" stroke="currentColor" stroke-width="2"/>
                <path d="M2 20c0-3 3-5 7-5" stroke="currentColor" stroke-width="2"/>
                <path d="M14 15c4 0 7 2 7 5" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>멘티 관리</span>
            </a>
          </li>

          <li>
            <a href="/team/list">
              <!-- 팀 -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <rect x="3" y="4" width="18" height="14" rx="2" stroke="currentColor" stroke-width="2"/>
                <path d="M8 20h8" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>팀 관리</span>
            </a>
          </li>

          <li>
            <a href="/mentoring/dashboard">
              <!-- 멘토링 -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M4 4h16v10H7l-3 3z" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>멘토링 관리</span>
            </a>
          </li>

          <li>
            <a href="/notice/list">
              <!-- 공지 -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M4 4h16v12H4z" stroke="currentColor" stroke-width="2"/>
                <path d="M8 20h8" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>공지사항 관리</span>
            </a>
          </li>

          <li>
            <a href="/preTraining/list">
              <!-- 교육 -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M3 6l9-4 9 4-9 4-9-4z" stroke="currentColor" stroke-width="2"/>
                <path d="M21 10v6l-9 4-9-4v-6" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>사전교육 관리</span>
            </a>
          </li>
          
          <li>
  			<a href="/preTraining/completeList">
    		<!-- 사전교육 이수관리 (체크/수료 아이콘 느낌) -->
    			<svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
      				<path d="M4 4h16v16H4z" stroke="currentColor" stroke-width="2"/>
      				<path d="M7 12l3 3 7-7" stroke="currentColor" stroke-width="2"/>
    			</svg>
    			<span>사전교육 이수 관리</span>
  			</a>
		  </li>

          <li>
            <a href="/patritBoard/list">
              <!-- 게시판 -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <rect x="3" y="4" width="18" height="16" rx="2" stroke="currentColor" stroke-width="2"/>
                <path d="M7 8h10M7 12h6" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>패트릿 보드</span>
            </a>
          </li>

          <li>
            <a href="/reflec/list">
              <!-- 성찰일지 -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M6 2h9l5 5v15H6z" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>성찰일지 관리</span>
            </a>
          </li>

          <li>
            <a href="/activity/list">
              <!-- 활동보고서 -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M4 20V4h16v16" stroke="currentColor" stroke-width="2"/>
                <path d="M8 12l3-3 3 3 4-4" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>활동보고서 관리</span>
            </a>
          </li>

          <li>
            <a href="/survey/totalList">
              <!-- 설문 -->
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M4 4h16v16H4z" stroke="currentColor" stroke-width="2"/>
                <path d="M8 10l2 2 4-4" stroke="currentColor" stroke-width="2"/>
              </svg>
              <span>만족도 조사 관리</span>
            </a>
          </li>

        </c:if>
      </ul>
    </nav>
  </aside>

