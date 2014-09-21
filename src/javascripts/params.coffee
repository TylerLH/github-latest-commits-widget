url = require 'url'

getQueryParams = ->
  params = {}
  hashes = window.location.href.slice(window.location.href.indexOf("?") + 1).split("&")
  for param in hashes
    hash = param.split "="
    params[hash[0]] = hash[1]
  params

module.exports = getQueryParams