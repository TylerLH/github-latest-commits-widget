window.timeago = require 'timeago'
params         = do require './params'
window._       = require 'lodash'

# config parameters
username = params.username
repo = params.repo
limit = params.limit || 10
branch = params.branch
title = document.querySelector '#widget-title'

window.renderHistory = (response) ->
  items = response.data
  commitTmpl = document.querySelector('#commit-tmpl').innerHTML
  ul = document.querySelector '#commit-history' # the ul element for results
  ul.children = []
  for index, result of items
    if result.author?
      li = document.createElement 'li'
      li.className = 'clearfix'
      data =
        result: result
        username: username
        repo: repo
      li.innerHTML = _.template commitTmpl, data
      ul.appendChild li

title.innerHTML = "Latest Commits to <a href='//github.com/#{username}/#{repo}'>#{username}/#{repo}</a>"

url = "https://api.github.com/repos/#{username}/#{repo}/commits?per_page=#{limit}&callback=renderHistory"
if params.branch?
  url += "&sha=#{branch}"

script = document.createElement 'script'
script.src = url
document.getElementsByTagName('head')[0]
  .appendChild script
