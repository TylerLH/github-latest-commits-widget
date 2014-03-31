###
 Helper to parse query string params
###
$.extend
  getUrlVars: ->
    vars = []
    hash = undefined
    hashes = window.location.href.slice(window.location.href.indexOf("?") + 1).split("&")
    i = 0

    while i < hashes.length
      hash = hashes[i].split("=")
      vars.push hash[0]
      vars[hash[0]] = hash[1]
      i++
    vars

  getUrlVar: (name) ->
    $.getUrlVars()[name]

$ ->
  params = $.getUrlVars()
  # config parameters
  username = params.username
  repo = params.repo
  limit = params.limit
  branch = params.branch
  container = $('#latest-commits-widget')

  callback = (response) ->
    items = response.data
    ul = $('#commit-history') # the ul element for results
    ul.empty()
    for index, result of items
      do (index, result) ->
        if result.author?
          ul.append("""
              <li class="clearfix">
                <div class="left">
                  <img class="commit-avatar" src="#{result.author.avatar_url}">
                </div>
                <div class="commit-author-info left">
                    <a href="https://github.com/#{result.author.login}"><b class="commit-author">#{result.author.login}</b></a>
                    <br />
                    <b class="commit-date">#{$.timeago(result.commit.committer.date)}</b><br /><i class="commit-sha">SHA: #{result.sha}</i>
                    <br />
                    <a class="commit-message" href="https://github.com/#{username}/#{repo}/commit/#{result.sha}" target="_blank">#{result.commit.message}</a>
                </div>
              </li>
          """)
  
  container.find('h4').text("Latest Commits to #{username}/#{repo}")

  url = "https://api.github.com/repos/#{username}/#{repo}/commits?callback=callback"
  if params.branch?
    url += "&sha=#{branch}"

  $.ajax(
      url
      data:
          per_page: limit
      dataType: "jsonp"
      type: "get"
  ).success (response) ->
      callback(response)
