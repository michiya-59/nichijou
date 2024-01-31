document.addEventListener('DOMContentLoaded', function () {
  // 各フィールドの要素を取得
  const titleField = document.querySelector('#coupon_form [name="coupon[title]"]');
  const usageTermsField = document.querySelector('#coupon_form [name="coupon[usage_terms]"]');
  const presentationTermsField = document.querySelector('#coupon_form [name="coupon[presentation_terms]"]');
  const expirationDateField = document.querySelector('#coupon_form [name="coupon[expiration_date]"]');
  const unlimitedCheckbox = document.querySelector('#unlimited');

  // クーポンプレビューの対応する部分を取得
  const previewTitle = document.querySelector('.left_top h3');
  const previewUsageTerms = document.querySelectorAll('.left_bottom_right')[0];
  const previewPresentationTerms = document.querySelectorAll('.left_bottom_right')[1];
  const previewExpirationDate = document.querySelector('.date p');

  // タイトルフィールドの値をプレビューに反映
  titleField.addEventListener('input', function () {
    previewTitle.textContent = this.value;
  });

  // 利用条件の値をプレビューに反映
  usageTermsField.addEventListener('input', function () {
    previewUsageTerms.textContent = this.value.replace(/,/g, ' / ');
  });

  // 提示条件の値をプレビューに反映
  presentationTermsField.addEventListener('input', function () {
    previewPresentationTerms.textContent = this.value.replace(/,/g, ' / ');
  });

  // 有効期限の値をプレビューに反映する関数
  function updateExpirationDate() {
    if (unlimitedCheckbox.checked) {
      previewExpirationDate.textContent = '無期限';
      expirationDateField.disabled = true; // 日付フィールドを無効化
    } else {
      expirationDateField.disabled = false; // 日付フィールドを有効化
      if (expirationDateField.value) {
        const date = new Date(expirationDateField.value);
        const formattedDate = date.getFullYear() + '年' + (date.getMonth() + 1) + '月' + date.getDate() + '日';
        previewExpirationDate.textContent = formattedDate;
      } else {
        previewExpirationDate.textContent = ''; // 日付が入力されていない場合は何も表示しない
      }
    }
  }

  // 有効期限フィールドと無期限チェックボックスの変更イベントにリスナーを設定
  expirationDateField.addEventListener('input', updateExpirationDate);
  unlimitedCheckbox.addEventListener('change', updateExpirationDate);

  // ページロード時にも一度実行して、初期状態を設定
  updateExpirationDate();
});
