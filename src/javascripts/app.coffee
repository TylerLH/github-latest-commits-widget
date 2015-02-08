params        = do require './params'
React         = require 'react'
LatestCommits = require './components/LatestCommits'

# config parameters
username = params.username
repo = params.repo
limit = params.limit || 10
branch = params.branch

React.render <LatestCommits username={username} repo={repo} limit={limit} branch={branch} />,
  document.getElementById 'app'
