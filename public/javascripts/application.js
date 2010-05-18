// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

html_entry = function(entry) {
  tweet = "<li class=\"" + entry.activity + "\" id=\"" + entry.subscription_id + "\">"
  if (entry.twitter_profile != null) {
    tweet = tweet + "<img src=\""+entry.twitter_image+"\" alt=\""+entry.name+"\" style=\"float:left\" />"
  }
  if (entry.site != null) {
    tweet = tweet + "<h2><a href=\"http://"+entry.site.replace("http://", "")+"\">"+entry.name+"</a></h2>"
  } else {
    tweet = tweet + "<h2>"+entry.name+"</h2>"
  }
  if (entry.bio) {
    tweet = tweet + "<p>"+entry.bio+"</p>"
  }
  if (entry.twitter_profile != null) {
    tweet = tweet + "<p>Siga no Twitter: <a href=\"http://twitter.com/"+entry.twitter_profile+"\">@"+entry.twitter_profile+"</a></p>"
  }
  tweet = tweet + "</li>"
  return tweet;
}

$(document).ready(function() {
  
  $("#go").everyTime(10000, function() {
    var complete = $("#go li:first").attr("id");
    $.getJSON("/?recents="+complete, function(data) {
      $.each(data.users, function(i, item) {
        setTimeout(function() {
          $("#go").prepend(html_entry(item.user));
          $("#go #" + item.subscription_id).hide();
          $("#go #" + item.subscription_id).show("fast");
        }, 1000 * (i + 1));
        if (i == 0) { $("#listing ul #" + item.subscription_id).css("border-bottom", "1px solid #aaa"); }
      });
      $(".total_entries").html("("+data.next_page+" inscritos)");
    });
    complete = "";
    return true;
  });
  
  $('.more').live("click", function() {
    alink = $(this);
    var ultimo = $("#go li:last").attr("id");
    $.getJSON(alink.attr("href"), function(data) {
      if (data.users.length > 0) {
        $.each(data.users, function(i, item) {
          $("#go").append(html_entry(item.user));
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
