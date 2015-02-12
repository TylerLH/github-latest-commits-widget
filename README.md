UNOFFICIAL GITHUB LATEST COMMITS WIDGET
=========================

Show the latest commit activity on your repo, keeping the community updated and giving users more incentive to contribute to your project with this widget.

Inspired by https://github.com/mdo/github-buttons

Check out a demo of the widget in action @ http://tylerlh.github.com/github-latest-commits-widget/?username=plataformatec&repo=devise&limit=10


Usage
-----

This widget is hosted via GitHub Pages, meaning all you need to do is include an iframe in your html and you're good to go. There are 4 params at the moment: username, repo, branch, and limit.

``` html
<iframe src="http://tylerlh.github.com/github-latest-commits-widget/?username=USERNAME&repo=REPO&limit=LIMIT"
  allowtransparency="true" frameborder="0" scrolling="no" width="502px" height="252px"></iframe>
```

### Parameters

`username`<br>
GitHub username that owns the repo (required)<br>

`repo`<br>
GitHub repository to check for activity (required)

`branch`<br>
Branch to pull commits from (default: master)

`limit`<br>
The maximum number of results to list (default: 10)


Things to Note
-----------

+ Width and height are hardcoded. Be sure to specify the default values (500x250) in your iframe and overload those values in the css if you want to change them.

+ The widget currently depends on jquery and jquery.timeago at the moment.



Bug tracker
-----------

Have a bug? Open a new issue at https://github.com/tylerlh/github-latest-commits-widget/issues



Authors
-------

**Tyler Hughes**

+ http://twitter.com/iampbt
+ http://github.com/tylerlh



Copyright and license
---------------------

Copyright 2012-2015 Tyler Hughes.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this work except in compliance with the License.
You may obtain a copy of the License in the LICENSE file, or at:

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.