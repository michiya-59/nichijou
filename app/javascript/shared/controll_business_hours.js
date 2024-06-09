document.addEventListener("DOMContentLoaded", function() {
  const salesFlg1 = document.querySelector('input[name="store[sales_flg]"][value="1"]');
  const salesFlg2 = document.querySelector('input[name="store[sales_flg]"][value="2"]');
  const salesFlg1Content = document.getElementById('salse_flg_1');
  const salesFlg2Content = document.getElementById('salse_flg_2');

  function toggleSalesContent() {
    if (salesFlg1.checked) {
      salesFlg1Content.style.display = '';
      salesFlg2Content.style.display = 'none';
      disableFormElements(salesFlg2Content, true);
      disableFormElements(salesFlg1Content, false);
    } else if (salesFlg2.checked) {
      salesFlg1Content.style.display = 'none';
      salesFlg2Content.style.display = '';
      disableFormElements(salesFlg1Content, true);
      disableFormElements(salesFlg2Content, false);
    }
  }

  function disableFormElements(section, disable) {
    section.querySelectorAll('input, select, textarea').forEach(element => {
      element.disabled = disable;
    });
  }

  salesFlg1.addEventListener('change', toggleSalesContent);
  salesFlg2.addEventListener('change', toggleSalesContent);

  toggleSalesContent();
});