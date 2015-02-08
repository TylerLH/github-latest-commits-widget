React   = require 'react/addons'
request = require 'superagent'
_       = require 'lodash'
Commit  = require './Commit'
CSSTransitionGroup = React.addons.CSSTransitionGroup

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
      loading: true
    state

  loadCommits: ->
    @setState loading: true
    url = "https://api.github.com/repos/#{@props.username}/#{@props.repo}/commits"
    query =
      per_page: @props.limit
      page: @state.currentPage
    query.sha = @props.branch if @props.branch?
    request
      .get url
      .query query
      .end (err, response) =>
        return @setState error: err if err?
        commits = @state.commits.concat response.body
        @setState commits: commits, loading: false

  loadNextPage: ->
    @setState currentPage: @state.currentPage+1
    @loadCommits()

  componentDidMount: ->
    @loadCommits()

  render: ->
    loadingIndicator =
      <div className="loading-indicator">
        <span><i className="fa fa-circle-o-notch fa-spin"></i> Loading commits...</span>
      </div>

    commits = _.map _.filter(@state.commits, 'author'), (commit, i) =>
      <Commit {...@props} key={i} data={commit}/>

    nextPageBtnText = if @state.loading then "Loading..." else "Load more commits"

    username = @props.username
    repo = @props.repo

    <div className="latest-commits-widget">
      <div className="latest-commits-header">
        <i className="fa fa-github gh-icon"></i>
        <h4 className="widget-title">
          Latest Commits to <a href={"//github.com/#{username}/#{repo}"}>{username}/{repo}</a>
        </h4>
      </div>
      <div className="latest-commits-content">
        <CSSTransitionGroup transitionName="spinner">{loadingIndicator if @state.loading}</CSSTransitionGroup>
        <ul className="commit-history">
          <CSSTransitionGroup transitionName="commit">{commits}</CSSTransitionGroup>
          <li><button className="next-page" onClick={@loadNextPage}><i className="fa fa-plus"></i> {nextPageBtnText}</button></li>
        </ul>
      </div>
    </div>