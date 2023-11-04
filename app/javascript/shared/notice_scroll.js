// DOMが完全に読み込まれた後に関数を実行します。
document.addEventListener("DOMContentLoaded", function() {
  // URLからクエリパラメータを解析します。
  var queryParams = new URLSearchParams(window.location.search);
  var noticeId = queryParams.get('id'); // 'id'パラメータを取得します。
  if (noticeId) {
    var element = document.getElementById('notice_' + noticeId);
    if (element) {
      // 要素が見つかればその位置までスムーズにスクロールします。
      element.scrollIntoView({behavior: "smooth", block: "start"});
    }
  }
});