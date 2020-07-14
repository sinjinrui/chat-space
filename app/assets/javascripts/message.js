$(function(){

  function buildHTML(message) {
    if(message.image) {
      let html = 
        `<div class="Messages">
          <div class="Messages__user">
            <div class="Messages__user--name">
              ${message.user_name}
            </div>
            <div class="Messages__user--date">
              ${message.created_at}
            </div>
          </div>
          <div class="Messages__list">
            <p class="Messages__list--text">
              ${message.text}
            </p>
            <img class="Messages__image" src="${message.image}">
          </div>
        </div>`
      return html;
    } else {
      let html = 
        `<div class="Messages">
          <div class="Messages__user">
            <div class="Messages__user--name">
              ${message.user_name}
            </div>
            <div class="Messages__user--date">
              ${message.created_at}
            </div>
          </div>
          <div class="Messages__list">
            <p class="Messages__list--text">
              ${message.text}
            </p>
          
          </div>
        </div>`
      return html;
    };
  }

  $('.Input-message__form').on('submit', function(e) {
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
      let html = buildHTML(data);
      $('.Main-chat__messages--list').append(html);
      $('.Main-chat__messages--list').animate({ scrollTop: $('.Main-chat__messages--list')[0].scrollHeight});
      $('form')[0].reset();
      $('.Input-message__btn').prop('disabled', false);
    })
    .fail(function() {
      alert('メッセージ送信に失敗しました');
    })
  });
});