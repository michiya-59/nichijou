document.addEventListener('DOMContentLoaded', function () {
  console.log("DOM fully loaded and parsed");

  var modal = document.getElementById("loginModal");
  var checkbox = document.getElementById("toggleSwitch");
  var closeButton = document.querySelector(".close-button");

  // checkboxが存在する場合のみイベントリスナーを追加
  if (checkbox) {
    checkbox.addEventListener('change', function() {
      if (modal) {
        modal.style.display = this.checked ? "block" : "none";
      }
    });
  }

  // closeButtonが存在する場合のみイベントリスナーを追加
  if (closeButton) {
    closeButton.addEventListener("click", () => {
      if (modal) {
        modal.style.display = "none";
        // チェックボックスのチェックを解除
        checkbox.checked = false;
      }
    });
  }

  // modalの外側をクリックした時にモーダルを閉じる処理
  window.addEventListener("click", (event) => {
    if (event.target == modal) {
      modal.style.display = "none";
      // チェックボックスのチェックを解除
      checkbox.checked = false;
    }
  });
});

// import "@hotwired/turbo-rails"
import "@popperjs/core"
//= require rails-ujs
import "bootstrap"
import jquery from "jquery"
window.$ = jquery
import Rails from "@rails/ujs"
Rails.start()

