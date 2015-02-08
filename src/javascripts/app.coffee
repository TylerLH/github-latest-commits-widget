params        = do require './params'
React         = require 'react'
LatestCommits = require './components/LatestCommits'

# for dev tools
window.React = React

# config parameters
username  = params.username
repo      = params.repo
limit     = params.limit || 10
branch    = params.branch

# Render the app component & away we go
React.render <LatestCommits username={username} repo={repo} limit={limit} branch={branch} />,
  document.getElementById 'app'
