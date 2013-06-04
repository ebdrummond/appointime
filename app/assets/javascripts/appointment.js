$(document).ready(function() {
  $(":radio[name=duration]").on("click", function() {
    $(".appt-date-wrapper").show();
  });

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
    ],
    onSet: function() {
      var selectedDate = this.get();
      console.log(selectedDate)
      var selectedDuration = $(":radio[name=duration]:checked").val();
      console.log(selectedDuration)

      var apptURL = window.location + "&date=" + selectedDate + "&duration=" + selectedDuration;
      jQuery.getJSON(apptURL, function(open_slots) {

        var destination = $("#open-slot-results");
        destination.html("");

        var openSlotsTemplate = $("#openSlotsView").html();
        var multi_slot_template = Handlebars.compile(openSlotsTemplate);

        destination.append(multi_slot_template({open_slots: open_slots}));

      });
    }
  });

  $( "input[id=appt_start]" ).pickatime({
    clear: '',
    interval: 60,
    min: [9,0],
    max: [17,0]
  });
});