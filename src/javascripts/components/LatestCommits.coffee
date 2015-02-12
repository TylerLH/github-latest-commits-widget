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
        @setState loading: false
        return @setState error: err if err?
        if response.status is 403
          return @setState error: {message: "API limit exceeded. Please try again later."}
        commits = @state.commits.concat response.body
        @setState commits: commits

  loadNextPage: ->
    @setState currentPage: @state.currentPage+1
    @loadCommits()

  componentDidMount: ->
    @loadCommits()

  handleScroll: (e) ->
    console.log arguments
    console.log [e.target.scrollTop, e.target.offsetHeight]

  logItemPosition: (e) ->
    console.log {top: e.target.offsetTop, left: e.target.offse}

  render: ->
    loadingIndicator =
      <div className="loading-indicator">
        <span><i className="fa fa-circle-o-notch fa-spin"></i> Loading commits...</span>
      </div>

    errorMessage =
      <div className="error-message">
        <strong>{@state.error?.message}</strong>
      </div>

    commits = _.map _.filter(@state.commits, 'author'), (commit, i) =>
      <Commit onClick={@logItemPosition} {...@props} key={i} data={commit}/>

    nextPageBtnText = if @state.loading then "Loading..." else "Show More"

    username = @props.username
    repo = @props.repo

    <div className="latest-commits-widget">
      <div className="latest-commits-header">
        <i className="fa fa-github gh-icon"></i>
        <h4 className="widget-title">
          Latest Commits for <a href={"//github.com/#{username}/#{repo}"}>{username}/{repo}</a>
        </h4>
      </div>
      <div className="latest-commits-content">
        <CSSTransitionGroup transitionName="spinner">{loadingIndicator if @state.loading}</CSSTransitionGroup>
        <ul ref="commits" onScroll={@handleScroll} className="commit-history">
          {errorMessage if @state.error?}
          <CSSTransitionGroup transitionName="commit">
            {commits}
          </CSSTransitionGroup>
          <li><button className="next-page" onClick={@loadNextPage}><i className="fa fa-plus"></i> {nextPageBtnText}</button></li>
        </ul>
      </div>
    </div>