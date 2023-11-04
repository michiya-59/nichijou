// ウェブページの読み込みが完了したら実行する関数
window.addEventListener('load', () => {
  // 各ボタンのDOM要素を取得
  const font_bold_btn = document.getElementById('font_bold'); // 太字用ボタン
  const italics_btn = document.getElementById('italics'); // イタリック用ボタン
  const strikethrough_btn = document.getElementById('strikethrough'); // 打ち消し線用ボタン
  const heading_btn = document.getElementById('heading'); // ヘディング用ボタン
  const quote_btn = document.getElementById('quote'); // 引用用ボタン
  const code_btn = document.getElementById('code'); // コード用ボタン
  const link_btn = document.getElementById('link'); // リンク用ボタン
  const list_btn = document.getElementById('list'); // リスト用ボタン
  const number_list_btn = document.getElementById('number_list'); // 番号付きリスト用ボタン
  const dash_btn = document.getElementById('dash'); // 水平線用ボタン

  // テキストエリアのDOM要素を取得
  const textarea = document.getElementById('note_explanation');

  // テキストの挿入をサポートする関数
  // prefix: 前置テキスト、defaultText: デフォルトのテキスト、suffix: 後置テキスト
  function insertText(prefix, defaultText, suffix = '') {
    // 現在選択されているテキストの長さを取得
    const selectedTextLength = window.getSelection().toString().length;
    // 現在のカーソルの位置を取得
    const pos = textarea.selectionStart;
    // 選択終了位置を取得
    const endPos = textarea.selectionEnd;

    // もしテキストが選択されていない場合
    if (selectedTextLength === 0) {
      // カーソル位置までのテキストを取得
      const before = textarea.value.substring(0, pos);
      // カーソル位置からの後ろのテキストを取得
      const after = textarea.value.substring(pos);
      // カーソル位置に指定したテキストを挿入
      textarea.value = before + prefix + defaultText + suffix + after;
      // カーソルを挿入テキストの後ろに移動
      textarea.selectionStart = pos + prefix.length;
      textarea.selectionEnd = pos + prefix.length + defaultText.length;
    } else {
      // 選択開始位置までのテキストを取得
      const before = textarea.value.substring(0, pos);
      // 選択終了位置からの後ろのテキストを取得
      const after = textarea.value.substring(endPos);
      // 選択されているテキストを取得
      const selectedText = textarea.value.substring(pos, endPos);
      // 選択部分に指定したテキストを挿入
      textarea.value = before + prefix + selectedText + suffix + after;
      // カーソルを挿入テキストの後ろに移動
      textarea.selectionStart = pos + prefix.length;
      textarea.selectionEnd = endPos + prefix.length + suffix.length;
    }
    // テキストエリアにフォーカスを戻す
    textarea.focus();
  }

  // 各ボタンがクリックされた時の動作を設定
  font_bold_btn.addEventListener('click', () => insertText("**", "ボールドテキスト", "**"));
  italics_btn.addEventListener('click', () => insertText("_", "イタリックテキスト", "_"));
  strikethrough_btn.addEventListener('click', () => insertText("~~", "打ち消し線", "~~"));
  heading_btn.addEventListener('click', () => insertText("### ", "ヘディングのテキスト"));
  quote_btn.addEventListener('click', () => insertText("> ", "引用テキスト"));
  code_btn.addEventListener('click', () => insertText("```言語名\n", "ソースコードを入力", "\n```"));
  link_btn.addEventListener('click', () => insertText("[", "リンク内容", "](url)"));
  list_btn.addEventListener('click', () => insertText("- ", "リスト"));
  number_list_btn.addEventListener('click', () => insertText("0. ", "番号リスト"));
  dash_btn.addEventListener('click', () => {
    if (window.getSelection().toString().length === 0) {
      insertText("", "---\n", "---");
    } else {
      insertText("", "---\n", "---");
    }
  });

  function validateImage(file) {
    // 1MBをバイト単位で定義
    const ONE_MB = 3 * 1024 * 1024;
    
    // ファイルサイズのバリデーション
    if (file.size > ONE_MB) {
      alert("画像は1MB以下のものをアップロードしてください。");
      return false;
    }
  
    // ファイルタイプのバリデーション
    const acceptableTypes = ["image/jpeg", "image/png", "image/jpg"];
    if (!acceptableTypes.includes(file.type)) {
      alert("画像はJPEGまたはPNG形式でアップロードしてください。");
      return false;
    }
  
    // すべてのバリデーションを通過した場合はtrueを返す
    return true;
  }

  // 画像を挿入するボタンがクリックされたときの動作
  document.getElementById('insert_image').addEventListener('click', function() {
    // 実際の画像ファイルのアップロードをトリガーするために隠れている<input type="file">をクリックする
    document.getElementById('markdown-image-upload').click();
  });

  // 画像が選択されたときの動作
  document.getElementById('markdown-image-upload').addEventListener('change', function(event) {
    // 選択されたファイルを取得
    var file = event.target.files[0];

    // ファイルが選択されている場合のみ、以下の処理を実行
    if (file) {
      // バリデーション
      if (!validateImage(file)) {
        return; // バリデーションエラーがある場合は、それ以上の処理を停止する
      }
      // FormDataを用いてファイルデータを準備する。これは非同期でサーバにファイルを送信するための手段
      var formData = new FormData();
      formData.append('file', file);
      
      // CSRFトークンを取得する。これはセキュリティ上の理由から、サーバにリクエストを送る際に必要
      var token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

      // 非同期でサーバに画像ファイルを送信する
      fetch('/admin_posts/upload_content_image', {
        method: 'POST',
        headers: {
          'X-CSRF-Token': token,
          'Accept': 'application/json'
        },
        body: formData
      })
      .then(response => {
        // サーバからのレスポンスがエラーを含む場合、エラー情報をコンソールに表示
        if (!response.ok) {
          return response.text().then(text => {
            throw new Error('Server Error: ' + text);
          });
        }
        // レスポンスをJSONとして解析
        return response.json();
      })
      .then(data => {
        // テキストエリアを取得
        var textarea = document.getElementById('note_explanation');
        // サーバから返された画像のURLを取得
        var imageUrl = data.url;
        // Markdown形式での画像の表現を作成
        var imageMarkdown = `![Uploaded Image](${imageUrl})`;
        
        // カーソルの現在の位置を取得し、その位置に画像のMarkdownを挿入
        var cursorPosition = textarea.selectionStart;
        textarea.value = textarea.value.substring(0, cursorPosition) + imageMarkdown + textarea.value.substring(cursorPosition);
      })
      .catch(error => {
        // 何らかの理由でエラーが発生した場合、コンソールにエラー情報を表示
        console.error('Error uploading image:', error);
      });
    }
  });
});
