var updateClientView = function (searchTerm) {

  var clientsURL = "/clients?query=" + searchTerm;

  jQuery.getJSON(clientsURL, function(clients) {

    var destination = $("#client-results");
    destination.html("");

    var clientsTemplate = $("#clientsView").html();
    var multi_client_template = Handlebars.compile(clientsTemplate);

    destination.append(multi_client_template({clients: clients}));

  });

};