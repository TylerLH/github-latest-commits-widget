params        = do require './params'
React         = require 'react/addons'
LatestCommits = require './components/LatestCommits'

# config parameters
username  = params.username
repo      = params.repo
limit     = params.limit || 10
branch    = params.branch

# Render the app component & away we go
React.render <LatestCommits username={username} repo={repo} limit={limit} branch={branch} />,
  document.getElementById 'app'
