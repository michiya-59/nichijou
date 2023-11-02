import $ from 'jquery';
import 'slick-carousel';

$(document).ready(function(){
  $('.slider').slick({
    autoplay: true, //自動でスクロール
    autoplaySpeed: 0, //自動再生のスライド切り替えまでの時間を設定
    speed: 6000, //スライドが流れる速度を設定
    cssEase: "linear", //スライドの流れ方を等速に設定
    slidesToShow: 5, //表示するスライドの数
    swipe: false, // 操作による切り替えはさせない
    arrows: false, //矢印非表示
    pauseOnFocus: false, //スライダーをフォーカスした時にスライドを停止させるか
    pauseOnHover: false, //スライダーにマウスホバーした時にスライドを停止させるか
    responsive: [
      {
        breakpoint: 1281, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 5.5, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 1025, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 5, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 920, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 4, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 900, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 4, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 769, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 3.6, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 668, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 3.2, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 620, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 3, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 599, // スマートフォンの場合のブレークポイント
        settings: {
          slidesToShow: 3, // 1度に表示するスライド数を1に変更
        }
      },
      {
        breakpoint: 400, // スマートフォンの場合のブレークポイント
        settings: {
          slidesToShow: 2.7, // 1度に表示するスライド数を1に変更
        }
      },
      {
        breakpoint: 378, // スマートフォンの場合のブレークポイント
        settings: {
          slidesToShow: 2.5, // 1度に表示するスライド数を1に変更
        }
      },
      {
        breakpoint: 365, // スマートフォンの場合のブレークポイント
        settings: {
          slidesToShow: 2.3, // 1度に表示するスライド数を1に変更
        }
      },

      {
        breakpoint: 290, // スマートフォンの場合のブレークポイント
        settings: {
          slidesToShow: 1.8, // 1度に表示するスライド数を1に変更
        }
      },
    ]
  });
});