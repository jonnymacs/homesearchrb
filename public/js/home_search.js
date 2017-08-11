$(function () {
  $('#perform_search').click(function(e) {
    e.preventDefault();

    var params = { query: $('#query').val() };

    return $.get('/search', params)
      .success(function(data) {
        $('#display_result').html(data);
      })
      .fail(function(data, status, response) {
        console.log("failed");
      });
  });
});
