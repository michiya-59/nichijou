document.addEventListener("DOMContentLoaded", function() {
  // すべてのフォームに対して処理を行う
  const forms = document.querySelectorAll('.pc_search_form, .sp_search_form');

  forms.forEach(form => {
    const prefectureSelect = form.querySelector('#prefecture');
    const citySelect = form.querySelector('#city');
    const categorySelect = form.querySelector('#category');
    const resetButton = form.querySelector('#reset-button');

    function updateCities(prefecture, selectedCity) {
      if (!prefecture) {  // 都道府県が未選択の場合
        citySelect.innerHTML = '';
        citySelect.appendChild(new Option('都道府県を選択してください', ''));
        return;  // この場合は以降の処理を行わない
      }

      fetch(`/areas/cities?prefecture_name=${prefecture}`)
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .then(data => {
          citySelect.innerHTML = '';
          citySelect.appendChild(new Option('選択してください', ''));
          data.forEach(function(city) {
            const option = new Option(city, city);
            if (city === selectedCity) {
              option.setAttribute('selected', 'selected'); // ここでselected属性を設定
            }
            citySelect.appendChild(option);
          });
        })
        .catch(error => {
          console.error('Error:', error);
          citySelect.innerHTML = '';
          citySelect.appendChild(new Option('データの取得に失敗しました', ''));
        });
    }

    if (prefectureSelect.value) {
      let url_string = window.location.href;
      let url = new URL(url_string);
      let selectedCity = url.searchParams.get("city");
      updateCities(prefectureSelect.value, selectedCity);
    }

    prefectureSelect.addEventListener('change', function() {
      updateCities(this.value, '');
    });

    form.addEventListener('submit', function(event) {
      event.preventDefault(); // デフォルトの送信を防止
      const prefecture = prefectureSelect.value;
      const city = citySelect.value;
      const category = categorySelect.value;

      let queryParams = new URLSearchParams({
        prefecture: prefecture,
        city: city,
        category: category
      }).toString();

      window.location.href = `/articles/multi_search?${queryParams}`;
    });

    resetButton.addEventListener('click', function (){
      prefectureSelect.value = '';
      citySelect.innerHTML = '<option value="">都道府県を選択してください</option>';
      categorySelect.value = '';
    });
  });
});
