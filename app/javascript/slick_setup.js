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
        breakpoint: 1881, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 6.2, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 1701, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 5.7, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 1591, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 5.3, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 1499, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 5, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 1380, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 4.6, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 1300, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 4.3, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 1201, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 4, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 1125, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 3.8, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 1025, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 5, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 980, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 4.5, // 1度に表示するスライド数を3に変更
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
        breakpoint: 767, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 5, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 764, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 4.5, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 668, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 4, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 620, // タブレットの場合のブレークポイント
        settings: {
          slidesToShow: 4.2, // 1度に表示するスライド数を3に変更
        }
      },
      {
        breakpoint: 599, // スマートフォンの場合のブレークポイント
        settings: {
          slidesToShow: 3, // 1度に表示するスライド数を1に変更
        }
      },
      {
        breakpoint: 415, // スマートフォンの場合のブレークポイント
        settings: {
          slidesToShow: 2.8, // 1度に表示するスライド数を1に変更
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