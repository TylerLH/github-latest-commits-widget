React   = require 'react'
timeago = require 'timeago'
_       = require 'lodash'

module.exports = React.createClass
  displayName: 'Commit'
  render: ->

    authorLogin = @props.data.author.login
    authorURL = "https://github.com/#{@props.data.author.login}"
    timestamp = timeago @props.data.commit.committer.date

    <li className="commit clearfix">
      <div className="left">
        <a href={authorURL} title={"#{authorLogin} on Github"}>
          <img className="commit-avatar vertical-center" src={@props.data.author.avatar_url} />
        </a>
      </div>
      <div className="commit-author-info left">
          <a href={"https://github.com/#{authorLogin}"}>
            <b className="commit-author">{authorLogin}</b>
          </a>
          <br/>
          <b className="commit-date">{timestamp}</b><br/>
          <p>
            <a
              className="commit-message"
              href={"https://github.com/#{@props.username}/#{@props.repo}/commit/#{@props.data.sha}"}
              target="_blank"
            >
              {@props.data.commit.message}
            </a>
          </p>
          <i className="commit-sha">SHA: {@props.data.sha}</i>
      </div>
    </li>