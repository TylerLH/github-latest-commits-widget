React   = require 'react'
request = require 'superagent'
_       = require 'lodash'
Commit  = require './Commit'

module.exports = React.createClass
  displayName: 'LatestCommits'

  propTypes:
    username: React.PropTypes.string.isRequired
    repo: React.PropTypes.string.isRequired
    branch: React.PropTypes.string
    limit: React.PropTypes.number

  getDefaultProps: ->
    props =
      limit: 10

  getInitialState: ->
    state =
      error: null
      commits: []
      currentPage: 1
    state

  loadCommits: ->
    url = "https://api.github.com/repos/#{@props.username}/#{@props.repo}/commits?per_page=#{@props.limit}"
    url += "&sha=#{@props.branch}" if @props.branch?
    request
      .get url
      .end (err, response) =>
        return @setState error: err if err?
        @setState commits: response.body

  componentDidMount: ->
    @loadCommits()

  render: ->
    commits = _.map _.filter(@state.commits, 'author'), (commit, i) =>
      <Commit {...@props} key={i} data={commit}/>

    username = @props.username
    repo = @props.repo

    <div className="latest-commits-widget">
      <div className="latest-commits-header">
        <i className="fa fa-github gh-icon"></i>
        <h4 className="widget-title">
          Latest Commits to <a href={"//github.com/#{username}/#{repo}"}>{username}/{repo}</a>
        </h4>
      </div>
      <ul className="commit-history">{commits}</ul>
    </div>