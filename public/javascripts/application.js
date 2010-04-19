// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
  $('.more').live("click", function() {
    alink = $(this);
    var ultimo = $("#go li:last").attr("id");
    $.getJSON(alink.attr("href"), function(data) {
      if (data.users.length > 0) {
        $.each(data.users, function(i, item) {
          tweet = "<li class=\"" + item.user.activity + "\" id=\"" + item.user.id + "\">"
          if (item.user.twitter_profile != null) {
            tweet = tweet + "<img src=\""+item.user.twitter_image+"\" alt=\""+item.user.name+"\" style=\"float:left\" />"
          }
          if (item.user.site != null) {
            tweet = tweet + "<h2><a href=\""+item.user.site+"\">"+item.user.name+"</a></h2>"
          } else {
            tweet = tweet + "<h2>"+item.user.name+"</h2>"
          }
          if (item.user.bio) {
            tweet = tweet + "<p>"+item.user.bio+"</p>"
          }
          if (item.user.twitter_profile != null) {
            tweet = tweet + "<p>Siga no Twitter: <a href=\"http://twitter.com/"+item.user.twitter_profile+"\">@"+item.user.twitter_profile+"</a></p>"
          }
          tweet = tweet + "</li>"
          $("#go").append(tweet);
        });
      } else {
        $(".more").hide();
      }
      $('.more').attr('href', "/?page="+data.next_page);
      $("#" + ultimo).css("border-bottom", "1px solid #aaa");
      $.scrollTo($("#" + ultimo), 800);
    });
    return false;
  });
});
