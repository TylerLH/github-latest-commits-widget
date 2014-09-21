(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var timeago;

timeago = require('timeago');


/*
 Helper to parse query string params
 */

$.extend({
  getUrlVars: function() {
    var hash, hashes, vars;
    vars = [];
    hashes = window.location.href.slice(window.location.href.indexOf("?") + 1).split("&");
    while (i < hashes.length) {
      hash = hashes[i].split("=");
      vars.push(hash[0]);
      vars[hash[0]] = hash[1];
      i++;
    }
    return vars;
  },
  getUrlVar: function(name) {
    return $.getUrlVars()[name];
  }
});

$(function() {
  var branch, callback, container, limit, params, repo, url, username;
  params = $.getUrlVars();
  username = params.username;
  repo = params.repo;
  limit = params.limit;
  branch = params.branch;
  container = $('#latest-commits-widget');
  callback = function(response) {
    var index, items, result, ul, _results;
    items = response.data;
    ul = $('#commit-history');
    ul.empty();
    _results = [];
    for (index in items) {
      result = items[index];
      _results.push((function(index, result) {
        if (result.author != null) {
          return ul.append("<li class=\"clearfix\">\n  <div class=\"left\">\n    <img class=\"commit-avatar\" src=\"" + result.author.avatar_url + "\">\n  </div>\n  <div class=\"commit-author-info left\">\n      <a href=\"https://github.com/" + result.author.login + "\"><b class=\"commit-author\">" + result.author.login + "</b></a>\n      <br />\n      <b class=\"commit-date\">" + (timeago(result.commit.committer.date)) + "</b><br /><i class=\"commit-sha\">SHA: " + result.sha + "</i>\n      <br />\n      <a class=\"commit-message\" href=\"https://github.com/" + username + "/" + repo + "/commit/" + result.sha + "\" target=\"_blank\">" + result.commit.message + "</a>\n  </div>\n</li>");
        }
      })(index, result));
    }
    return _results;
  };
  container.find('h4').text("Latest Commits to " + username + "/" + repo);
  url = "https://api.github.com/repos/" + username + "/" + repo + "/commits?callback=callback";
  if (params.branch != null) {
    url += "&sha=" + branch;
  }
  return $.ajax(url, {
    data: {
      per_page: limit
    },
    dataType: "jsonp",
    type: "get"
  }).success(function(response) {
    return callback(response);
  });
});



},{"timeago":2}],2:[function(require,module,exports){
/*
 * node-timeago
 * Cam Pedersen
 * <diffference@gmail.com>
 * Oct 6, 2011
 * Timeago is a jQuery plugin that makes it easy to support automatically
 * updating fuzzy timestamps (e.g. "4 minutes ago" or "about 1 day ago").
 *
 * @name timeago
 * @version 0.10.0
 * @requires jQuery v1.2.3+
 * @author Ryan McGeary
 * @license MIT License - http://www.opensource.org/licenses/mit-license.php
 *
 * For usage and examples, visit:
 * http://timeago.yarp.com/
 *
 * Copyright (c) 2008-2011, Ryan McGeary (ryanonjavascript -[at]- mcgeary [*dot*] org)
 */
module.exports = function (timestamp) {
  if (timestamp instanceof Date) {
    return inWords(timestamp);
  } else if (typeof timestamp === "string") {
    return inWords(parse(timestamp));
  }
};

var settings = {
  allowFuture: false,
  strings: {
    prefixAgo: null,
    prefixFromNow: null,
    suffixAgo: "ago",
    suffixFromNow: "from now",
    seconds: "less than a minute",
    minute: "about a minute",
    minutes: "%d minutes",
    hour: "about an hour",
    hours: "about %d hours",
    day: "a day",
    days: "%d days",
    month: "about a month",
    months: "%d months",
    year: "about a year",
    years: "%d years",
    numbers: []
  }
};

var $l = settings.strings;

module.exports.settings = settings;

$l.inWords = function (distanceMillis) {
  var prefix = $l.prefixAgo;
  var suffix = $l.suffixAgo;
  if (settings.allowFuture) {
    if (distanceMillis < 0) {
      prefix = $l.prefixFromNow;
      suffix = $l.suffixFromNow;
    }
  }

  var seconds = Math.abs(distanceMillis) / 1000;
  var minutes = seconds / 60;
  var hours = minutes / 60;
  var days = hours / 24;
  var years = days / 365;

  function substitute (stringOrFunction, number) {
    var string = typeof stringOrFunction === 'function' ? stringOrFunction(number, distanceMillis) : stringOrFunction;
    var value = ($l.numbers && $l.numbers[number]) || number;
    return string.replace(/%d/i, value);
  }

  var words = seconds < 45 && substitute($l.seconds, Math.round(seconds)) ||
    seconds < 90 && substitute($l.minute, 1) ||
    minutes < 45 && substitute($l.minutes, Math.round(minutes)) ||
    minutes < 90 && substitute($l.hour, 1) ||
    hours < 24 && substitute($l.hours, Math.round(hours)) ||
    hours < 48 && substitute($l.day, 1) ||
    days < 30 && substitute($l.days, Math.floor(days)) ||
    days < 60 && substitute($l.month, 1) ||
    days < 365 && substitute($l.months, Math.floor(days / 30)) ||
    years < 2 && substitute($l.year, 1) ||
    substitute($l.years, Math.floor(years));

  return [prefix, words, suffix].join(" ").toString().trim();
};

function parse (iso8601) {
  if (!iso8601) return;
  var s = iso8601.trim();
  s = s.replace(/\.\d\d\d+/,""); // remove milliseconds
  s = s.replace(/-/,"/").replace(/-/,"/");
  s = s.replace(/T/," ").replace(/Z/," UTC");
  s = s.replace(/([\+\-]\d\d)\:?(\d\d)/," $1$2"); // -04:00 -> -0400
  return new Date(s);
}

$l.parse = parse;

function inWords (date) {
  return $l.inWords(distance(date));
}

function distance (date) {
  return (new Date().getTime() - date.getTime());
}

},{}]},{},[1]);
