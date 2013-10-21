$(document).ready(function() {
  window.addEventListener("load",function() {
    setTimeout(function(){
      window.scrollTo(0, 1);
    }, 0);
  });

  $('.up').click(function(e) {
    var question = $(this).parents('.question');
    var value = question.find('.value');
    var answer = question.find('.answer');
    var isTime = question.data('time');
    
    var newValue = value;
    if (isTime == null) {
      newValue = parseInt(value.text(), 10) + 1;
      if (newValue > 7) {
        newValue = 7; 
      }
    } else {
      newValue = parseInt(value.text(), 10) + 5;
      newValue = newValue + " min";
    }

    value.text(newValue);
    answer.val(newValue);
  });
  $('.down').click(function(e) {
    var question = $(this).parents('.question');
    var value = question.find('.value');
    var answer = question.find('.answer');
    var isTime = question.data('time');
    
    var newValue = value;
    if (isTime == null) {
      newValue = parseInt(value.text(), 10) - 1;
      if (newValue < 1) {
        newValue = 1; 
      }
    } else {
      newValue = parseInt(value.text(), 10) - 5;
      if (newValue < 1) {
        newValue = 1;
      }
      newValue = newValue + " min";
    }

    value.text(newValue);
    answer.val(newValue);
  });
  $('.next').click(function(e) {
    var row = $(this).parents('.row'); 
    row.removeClass('current')
    row.next().addClass('current')
  });
  $('.prev').click(function(e) {
    var row = $(this).parents('.row'); 
    row.removeClass('current')
    row.prev().addClass('current')
  });
});
