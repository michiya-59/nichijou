# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap
pin "application", preload: true
pin "fontawesome", preload: true
pin "slick_setup", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.6/dist/esm/index.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.1.1/app/assets/javascripts/rails-ujs.esm.js"
# 正しいBootstrapのバージョンのみを保持
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.2/dist/js/bootstrap.esm.js"
pin_all_from "app/javascript/shared", under: "shared"
pin "marked", to: "https://ga.jspm.io/npm:marked@9.1.2/lib/marked.esm.js"
# slickーslider
pin "slick-carousel", to: "https://ga.jspm.io/npm:slick-carousel@1.8.1/slick/slick.js"
pin "slick", to: "slick.js"
# fontawesome
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.4.2/js/fontawesome.js"
pin "@fortawesome/fontawesome-svg-core", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-svg-core@6.4.2/index.mjs"
pin "@fortawesome/free-brands-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-brands-svg-icons@6.4.2/index.mjs"
pin "@fortawesome/free-regular-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-regular-svg-icons@6.4.2/index.mjs"
pin "@fortawesome/free-solid-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-solid-svg-icons@6.4.2/index.mjs"
