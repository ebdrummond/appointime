$(document).ready(function() {
  var today = new Date();
  var twomonths = new Date(today.setMonth(today.getMonth()+2));

  $( "input[id=appt_date]" ).pickadate({
    format: 'dddd, mmmm d, yyyy',
    today: '',
    clear: 'Clear selection',
    min: 1,
    max: twomonths,
    disable: [
        1, 7
    ]
  });

  $( "input[id=appt_start]" ).pickatime({
    clear: '',
    interval: 60,
    min: [9,0],
    max: [17,0]
  });
});