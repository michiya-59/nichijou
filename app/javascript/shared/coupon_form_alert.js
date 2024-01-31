document.addEventListener('DOMContentLoaded', function () {
  const form = document.getElementById('coupon_form');
  form.addEventListener('submit', function (event) {
    const usageTerms = form.querySelector('[name="coupon[usage_terms]"]').value;
    const presentationTerms = form.querySelector('[name="coupon[presentation_terms]"]').value;

    if (!usageTerms.includes(',') || !presentationTerms.includes(',')) {
      const isConfirmed = confirm('カンマ(,)が含まれていませんが本当によろしいですか？');
      if (!isConfirmed) {
        event.preventDefault(); // ユーザーがキャンセルを選択した場合、フォームの送信を阻止
      }
    }
  });
});