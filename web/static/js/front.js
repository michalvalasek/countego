import "phoenix_html"
import "bootstrap-sass"
import "flipclock/compiled/flipclock"

import initialize_plugins from "./front/bootstrap_init"

$(function(){
  initialize_plugins();
  console.log('front ready');

  if ($('#counter').length) {
    var $c = $('#counter')
    var initialCount = parseInt( $c.data('initial-count') );
    var url = $c.data('url');

    var fc = $('#counter').FlipClock(initialCount, {
  		clockFace: 'Counter'
  	});

    var updateCounter = function(data) {
      console.log('updated');
      if (data && data.likes) {
        var newCount = parseInt(data.likes);
        // var oldCount = parseInt(fc.getTime().time);
        fc.setTime(newCount);
      }
    }

	  window.clearInterval(window.fetchLikesInterval);
    window.fetchLikesInterval = window.setInterval(function(){
      // $.getJSON(url, updateCounter);
      console.log('do ajax');
      $.ajax({
        url: url,
        method: 'get',
        dataType: 'json',
        success: updateCounter
      });
    }, 5000);
  }
})
