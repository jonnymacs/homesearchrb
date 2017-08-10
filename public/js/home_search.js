$(function () {
  $('#perform_search').click(function(e) {
    e.preventDefault();
    console.log("here");
    var params = { query: $('#search_query').val() };
    console.log(params);
    return $.get('/search', params)
      .success(function(data) {
        $('#display_result').html(data);
      })
      .fail(function(data, status, response) {
        console.log("failed");
      });
  });
});
