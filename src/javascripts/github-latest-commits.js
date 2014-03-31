
/*
 Helper to parse query string params
 */
$.extend({
  getUrlVars: function() {
    var hash, hashes, i, vars;
    vars = [];
    hash = void 0;
    hashes = window.location.href.slice(window.location.href.indexOf("?") + 1).split("&");
    i = 0;
    while (i < hashes.length) {
      hash = hashes[i].split("=");
      vars.push(hash[0]);
      vars[hash[0]] = hash[1];
      i++;
    }
    return vars;
  },
  getUrlVar: function(name) {
    return $.getUrlVars()[name];
  }
});

$(function() {
  var branch, callback, container, limit, params, repo, url, username;
  params = $.getUrlVars();
  username = params.username;
  repo = params.repo;
  limit = params.limit;
  branch = params.branch;
  container = $('#latest-commits-widget');
  callback = function(response) {
    var index, items, result, ul, _results;
    items = response.data;
    ul = $('#commit-history');
    ul.empty();
    _results = [];
    for (index in items) {
      result = items[index];
      _results.push((function(index, result) {
        if (result.author != null) {
          return ul.append("<li class=\"clearfix\">\n  <div class=\"left\">\n    <img class=\"commit-avatar\" src=\"" + result.author.avatar_url + "\">\n  </div>\n  <div class=\"commit-author-info left\">\n      <a href=\"https://github.com/" + result.author.login + "\"><b class=\"commit-author\">" + result.author.login + "</b></a>\n      <br />\n      <b class=\"commit-date\">" + ($.timeago(result.commit.committer.date)) + "</b><br /><i class=\"commit-sha\">SHA: " + result.sha + "</i>\n      <br />\n      <a class=\"commit-message\" href=\"https://github.com/" + username + "/" + repo + "/commit/" + result.sha + "\" target=\"_blank\">" + result.commit.message + "</a>\n  </div>\n</li>");
        }
      })(index, result));
    }
    return _results;
  };
  container.find('h4').text("Latest Commits to " + username + "/" + repo);
  url = "https://api.github.com/repos/" + username + "/" + repo + "/commits?callback=callback";
  if (params.branch != null) {
    url += "&sha=" + branch;
  }
  return $.ajax(url, {
    data: {
      per_page: limit
    },
    dataType: "jsonp",
    type: "get"
  }).success(function(response) {
    return callback(response);
  });
});
