document.addEventListener("DOMContentLoaded", function() {
  const prefectureSelect = document.querySelector('.pc_search_form #prefecture');
  const citySelect = document.querySelector('.pc_search_form #city');
  const categorySelect = document.querySelector('.pc_search_form #category');
  const form = document.querySelector('.pc_search_form');

  // 市区町村の更新を行う関数
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

  // 都道府県が既に選択されている場合、関連する市区町村を自動的に更新
  if (prefectureSelect.value) {
    let url_string = window.location.href;
    let url = new URL(url_string);
    let selectedCity = url.searchParams.get("city");
    updateCities(prefectureSelect.value, selectedCity);
  }

  // 都道府県の変更イベントリスナー
  prefectureSelect.addEventListener('change', function() {
    updateCities(this.value, '');
  });

  // フォーム送信イベント
  form.addEventListener('submit', function(event) {
    event.preventDefault(); // デフォルトの送信を防止
    const prefecture = prefectureSelect.value;
    const city = citySelect.value;
    const category = categorySelect.value;

    // クエリパラメータを組み立ててURLに遷移
    let queryParams = new URLSearchParams({
      prefecture: prefecture,
      city: city,
      category: category
    }).toString();

    window.location.href = `/articles/multi_search?${queryParams}`;
  });
});
