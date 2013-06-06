$(document).ready(function() {
  var today = new Date();
  var twomonths = new Date(today.setMonth(today.getMonth()+2));

  var date_picker = $( "input[id=appt_date]" ).pickadate({
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
      var selectedDuration = $(":radio[name=duration]:checked").val();
      var user_id = $(':input[name="appointment[user_id]"]').val();

      var ajax_prefix = "/appointments/new";
      if (window.location.pathname.indexOf("/admin/appointments") == 0) {
        ajax_prefix = "/admin/appointments/new";
      }
      var apptURL = ajax_prefix + "?date=" + selectedDate + "&duration=" + selectedDuration + "&user_id=" + user_id;

      jQuery.getJSON(apptURL, function(open_slots) {

        var destination = $("#open-slot-results");
        destination.html("");

        var openSlotsTemplate = $("#openSlotsView").html();
        var multi_slot_template = Handlebars.compile(openSlotsTemplate);

        destination.append(multi_slot_template({open_slots: open_slots}));

      });
    }
  });

  $(":radio[name=duration]").on("click", function() {
    $(".appt-date-wrapper").show();

    var selectedDate = date_picker.pickadate('picker').get();
    if (selectedDate) {
      date_picker.pickadate('picker').set();
    }
  });

  $( "input[id=appt_start]" ).pickatime({
    clear: '',
    interval: 60,
    min: [9,0],
    max: [17,0]
  });

  $(document).on("click", ":radio[name=appt_slot]", function() {
      $(".appt-submit").show();
  });
});