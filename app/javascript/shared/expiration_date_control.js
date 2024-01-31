document.addEventListener('DOMContentLoaded', function () {
  const dateField = document.getElementById('expiration_date');
  const unlimitedCheckbox = document.getElementById('unlimited');

  // 日付フィールドに入力があるときは、無期限チェックボックスを無効化
  dateField.addEventListener('input', function () {
    if (this.value) {
      unlimitedCheckbox.checked = false;
      unlimitedCheckbox.disabled = true;
    } else {
      unlimitedCheckbox.disabled = false;
    }
  });

  // 無期限チェックボックスが選択されたときは、日付フィールドを無効化
  unlimitedCheckbox.addEventListener('change', function () {
    if (this.checked) {
      dateField.value = '';
      dateField.disabled = true;
    } else {
      dateField.disabled = false;
    }
  });
});