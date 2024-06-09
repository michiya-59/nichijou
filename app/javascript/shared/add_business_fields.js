document.addEventListener("DOMContentLoaded", function() {
  var business_hours_container = document.getElementById('business-hours-fields');

  // 初期ロード時に最初の削除ボタンを非表示にする
  var firstRemoveButton = document.querySelector('.remove-business-hours');
  if (firstRemoveButton) {
    firstRemoveButton.style.display = 'none';
  }

  document.querySelector('.add-business-hours').addEventListener('click', function(e) {
    e.preventDefault();

    // 営業時間のグループを取得、存在しない場合は新たに作成
    var lastGroup = document.querySelector('.business-hours-group:last-child');
    var newFieldGroup;
    if (lastGroup) {
      newFieldGroup = lastGroup.cloneNode(true);
    } else {
      // 新規作成の場合、テンプレートから新しいグループを作成する
      newFieldGroup = createNewBusinessHoursGroup();  // この関数は適切なテンプレートをクローンして返す
    }

    var formIndex = document.querySelectorAll('.business-hours-group').length;
    newFieldGroup.setAttribute('data-index', formIndex);
    newFieldGroup.innerHTML = newFieldGroup.innerHTML.replace(/\[\d+\]/g, '[' + formIndex + ']');

    resetFormInputs(newFieldGroup);

    // 新しいグループに削除ボタンを表示
    var removeButton = newFieldGroup.querySelector('.remove-business-hours');
    if (removeButton) {
      removeButton.style.display = 'inline-block';
      removeButton.addEventListener('click', function(e) {
        e.preventDefault();
        var fieldGroup = e.target.closest('.business-hours-group');
        fieldGroup.querySelector('input[name*="_destroy"]').value = '1';
        fieldGroup.style.display = 'none';  // 実際には削除せずに隠す
      });
    }

    business_hours_container.appendChild(newFieldGroup);
  });

  function resetFormInputs(group) {
    // フォームの削除ボタンと _destroy の隠しフィールドをリセット
    group.querySelector('input[name*="_destroy"]').value = '';
    
    // 他のフィールドリセット処理
    Array.from(group.querySelectorAll('input, select')).forEach(function(input) {
      if (input.type === 'checkbox' || input.type === 'radio') {
        input.checked = false;
      } else {
        input.value = '';
      }
    });
  }

  // 既存の削除ボタンにイベントリスナーを適用
  document.querySelectorAll('.remove-business-hours').forEach(function(button, index) {
    if (index === 0) {
      // 最初の削除ボタンは非表示にする
      button.style.display = 'none';
    }
    button.addEventListener('click', function(e) {
      e.preventDefault();
      var fieldGroup = e.target.closest('.business-hours-group');
      fieldGroup.querySelector('input[name*="_destroy"]').value = '1';
      fieldGroup.style.display = 'none';  // 実際には削除せずに隠す
    });
  });
});
