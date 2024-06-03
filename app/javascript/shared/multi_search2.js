document.addEventListener("DOMContentLoaded", function() {
  const barInner = document.getElementById('bar_inner');
  const searchOverlay = document.getElementById('search-overlay');
  const closeSearch = document.getElementById('close-search');

  barInner.addEventListener('click', function() {
    searchOverlay.style.display = 'block';  // 検索フォームを表示
  });

  closeSearch.addEventListener('click', function() {
    searchOverlay.style.display = 'none';  // 検索フォームを非表示
  });

  searchOverlay.addEventListener('click', function(event) {
    if (event.target === searchOverlay) {
      searchOverlay.style.display = 'none';  // 背景クリックで検索フォームを非表示
    }
  });
});
