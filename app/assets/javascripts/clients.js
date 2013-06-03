var updateClientView = function (searchTerm) {

  var clientsURL = "/admin/clients?query=" + searchTerm;

  jQuery.getJSON(clientsURL, function(clients) {
    console.log("You're great and I got a repsonse for you");
    console.log(clients);

    var destination = $("#client-results");
    destination.html("");

    var clientsTemplate = $("#clientsView").html();
    var multi_client_template = Handlebars.compile(clientsTemplate);

    destination.append(multi_client_template({clients: clients}));

  });

};