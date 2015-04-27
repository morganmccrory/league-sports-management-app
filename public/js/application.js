$(document).ready(function() {

  $("#submitteam").on('click', function(event) {
    event.preventDefault();

    var createTeam = $.ajax({
      url: "/teams",
      method: "POST",
      data: $("#addteam").serialize(),
    });

    createTeam.done(function(response) {
      $(".error").hide();
      $(".all-teams").append("<li><a href='/teams/"+response.team.id+"'><b>"+response.team.name+"</b></a></li>");
      $("#addteam").find("input:text").val("").end()
    });

    createTeam.fail(function() {
      $(".error").show();
    });
  });

  $("#sign-in").on('click', function(event) {
    event.preventDefault();

    var logIn = $.ajax({
      url: "/signin",
      method: "POST",
      data: $("#sign-in-data").serialize()
    });

    logIn.done(function(response) {
      $(".log-in").hide();
      $(".log-out").show();
    });
  });

  $(".log-out").on('click', function(event) {
    event.preventDefault();

    var logOut = $.ajax({
      url: "/logout",
      method: "GET",
    });

    logOut.done(function(response) {
      $(".log-in").show();
      $(".log-out").hide();
    });
  });

  $("#add_form").on('click', function(event) {
    event.preventDefault();
      $(".new_team_form").show();
    });

  $("#create-account").on('click', function(event) {
    event.preventDefault();
    $(".create_account_form").show();
    $(".log-in").hide();
  });
});
