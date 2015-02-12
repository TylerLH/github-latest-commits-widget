React   = require 'react/addons'
TimeAgo = require 'react-smart-time-ago'
_       = require 'lodash'

module.exports = React.createClass
  displayName: 'Commit'
  render: ->

    authorLogin = @props.data.author.login

    <li className="commit clearfix">
      <div className="left">
        <a href={@props.data.author.html_url} title={"#{authorLogin} on Github"}>
          <img className="commit-avatar vertical-center" src={@props.data.author.avatar_url} />
        </a>
      </div>
      <div className="commit-author-info left">
          <a href={@props.data.author.html_url}>
            <b className="commit-author">{authorLogin}</b>
          </a>
          <br/>
          <TimeAgo value={@props.data.commit.committer.date} className="commit-date"/><br/>
          <p>
            <a className="commit-message" href={@props.data.html_url} target="_blank">
              {@props.data.commit.message}
            </a>
          </p>
          <i className="commit-sha">SHA: {@props.data.sha}</i>
      </div>
    </li>