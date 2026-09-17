<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<link href="/resources/css/footer.css" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">

<footer>
    <nav class="footer-links" aria-label="푸터 링크">
      <a href="#">개인정보처리방침</a>
      <a href="#">대학정보공시</a>
      <a href="#">정보공개</a>
      <a href="#">이메일무단수집거부</a>
      <a href="#">찾아오시는길</a>
      <a href="#">교내홈페이지안내</a>
    </nav>
    <div class="footer-meta">
      (30019) 세종특별자치시 세종로 2511 고려대학교 세종캠퍼스 · Tel: 044-860-1114 · Fax: 044-860-1048<br/>
      Copyright © 2024 KOREA University Sejong Campus. All Rights Reserved
    </div>
  </footer>

 <script>
(function(){
  // 중복 include 대비 (페이지 이동/리렌더 때도 안전)
  if (window.__headerBound === true) return;
  window.__headerBound = true;

  const mq = window.matchMedia('(max-width: 860px)');
  const isMobile = () => mq.matches;

  function toggleSidebar(){
    console.log('[header] hamburger click'); // ✅ 눌림 확인용
    if (isMobile()){
      $('body').toggleClass('sb-open');
    } else {
      $('body').removeClass('sb-open').toggleClass('sb-collapsed');
    }
  }

  function closeSidebarMobile(){
    $('body').removeClass('sb-open');
  }

  function syncState(){
    if (isMobile()){
      $('body').removeClass('sb-open');
    } else {
      $('body').removeClass('sb-open');
    }
  }

  // ✅ 핵심: 문서 위임 (버튼이 나중에 생겨도 무조건 잡힘)
  $(document)
    .off('click.header', '#menuBtn')
    .on('click.header', '#menuBtn', function(e){
      e.preventDefault();
      toggleSidebar();
    })
    .off('click.header', '#overlay')
    .on('click.header', '#overlay', function(e){
      e.preventDefault();
      closeSidebarMobile();
    })
    .off('click.header', '#userBtn')
    .on('click.header', '#userBtn', function(e){
      e.preventDefault();
      e.stopPropagation();
      $('#userWrap').toggleClass('open');
      this.setAttribute('aria-expanded', $('#userWrap').hasClass('open') ? 'true' : 'false');
    })
    .on('click.header', function(e){
      const wrap = document.getElementById('userWrap');
      if (wrap && !wrap.contains(e.target)) {
        $('#userWrap').removeClass('open');
        const btn = document.getElementById('userBtn');
        if (btn) btn.setAttribute('aria-expanded', 'false');
      }
    });

  $(document).on('keydown.header', function(e){
    if (e.key === 'Escape'){
      $('#userWrap').removeClass('open');
      $('body').removeClass('sb-open');
    }
  });

  if (mq.addEventListener) mq.addEventListener('change', syncState);
  else window.addEventListener('resize', syncState);

  syncState();
})();
</script>

</body>
</html>