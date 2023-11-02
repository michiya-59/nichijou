import { marked } from "marked";

// ページの読み込みが完了したら、以下の処理を実行
document.addEventListener('DOMContentLoaded', function() {
  // プレビューボタンと編集に戻るボタン（上部と下部の両方）の要素を取得
  const markdownPreviewButtonTop = document.getElementById('markdown-preview');
  const markdownEditButtonTop = document.getElementById('markdown-edit');
  const markdownPreviewButtonBottom = document.getElementById('markdown-preview-bottom');
  const markdownEditButtonBottom = document.getElementById('markdown-edit-bottom');
  
  // テキストエリアの要素を取得
  const textarea = document.getElementById('note_explanation');
  
  // プレビュー表示用のdiv要素を作成
  const previewArea = document.createElement('div');
  previewArea.setAttribute('id', 'markdown-preview-area');
  previewArea.style.display = 'none'; // 初期状態では非表示にする
  textarea.parentNode.insertBefore(previewArea, textarea.nextSibling); // テキストエリアの後に挿入

  function switchToPreview(e) {
    e.preventDefault();  // デフォルトの動作をキャンセル
    // テキストエリアの内容を取得
    const content = textarea.value;
    // テキストエリアの内容（Markdown形式）をHTMLに変換してプレビュー表示用のdivに挿入
    previewArea.innerHTML = marked(content);
    
    // プレビュー表示/非表示の切り替え
    textarea.style.display = 'none';
    previewArea.style.display = 'block';
    markdownPreviewButtonTop.style.display = 'none';
    markdownEditButtonTop.style.display = 'block';
    markdownPreviewButtonBottom.style.display = 'none';
    markdownEditButtonBottom.style.display = 'block';
  }

  function switchToEdit(e) {
    e.preventDefault();  // デフォルトの動作をキャンセル
    // プレビューから編集モードに戻る時の表示/非表示の切り替え
    textarea.style.display = 'block';
    previewArea.style.display = 'none';
    markdownPreviewButtonTop.style.display = 'block';
    markdownEditButtonTop.style.display = 'none';
    markdownPreviewButtonBottom.style.display = 'block';
    markdownEditButtonBottom.style.display = 'none';
  }

  // プレビュー/編集ボタンがクリックされたときのイベントリスナーを追加
  markdownPreviewButtonTop.addEventListener('click', switchToPreview);
  markdownPreviewButtonBottom.addEventListener('click', switchToPreview);
  markdownEditButtonTop.addEventListener('click', switchToEdit);
  markdownEditButtonBottom.addEventListener('click', switchToEdit);


  const fileInput = document.getElementById("top_image_file");

  if (fileInput) {
    fileInput.addEventListener("change", function(event) {
      const file = event.target.files[0];
      
      if (!file) return; // ファイルが選択されていない場合は何もしない
      
      // 1MBをバイト単位で定義
      const ONE_MB = 1 * 1024 * 1024;
      
      // ファイルサイズのバリデーション
      if (file.size > ONE_MB) {
        alert("画像は1MB以下のものをアップロードしてください。");
        event.target.value = '';  // ファイルの選択をクリア
        return;
      }
      
      // ファイルタイプのバリデーション
      const acceptableTypes = ["image/jpeg", "image/png", "image/jpg"];
      if (!acceptableTypes.includes(file.type)) {
        alert("画像はJPEGまたはPNG形式でアップロードしてください。");
        event.target.value = '';  // ファイルの選択をクリア
        return;
      }
    });
  }
});


