$(function(){
  function buildHTML(message) {
    if ( message.image ) {
      let html =
        `<div class="Messages" data-message-id=${message.id}>
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
        `<div class="Messages" data-message-id=${message.id}>
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

  let reloadMessages = function() {
    let last_message_id = $('.Messages:last').data("message-id") || 0;
    $.ajax({
      url: "api/messages",
      type: 'get',
      dataType: 'json',
      data: {id: last_message_id}
    })
    .done(function(messages) {
      if (messages.length !== 0) {
        let insertHTML = '';
        $.each(messages, function(i, message) {
          insertHTML += buildHTML(message)
        });
        $('.Main-chat__messages--list').append(insertHTML);
        $('.Main-chat__messages--list').animate({ scrollTop: $('.Main-chat__messages--list')[0].scrollHeight});
      }
    })
    .fail(function() {
      alert('error');
    });
  };
  setInterval(reloadMessages, 7000);
});

