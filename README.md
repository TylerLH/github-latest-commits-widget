UNOFFICIAL GITHUB LATEST COMMITS WIDGET
=========================

Show the latest commit activity on your repo, keeping the community updated and giving users more incentive to contribute to your project with this widget.

Inspired by https://github.com/mdo/github-buttons

Check out a demo of the widget in action @ http://tylerlh.github.com/github-latest-commits-widget/?username=twbs&repo=bootstrap&limit=10


Usage
-----

This widget is hosted via GitHub Pages, meaning all you need to do is include an iframe in your html and you're good to go. There are only 3 params at the moment: username, repo, and limit.

``` html
<iframe src="http://tylerlh.github.com/github-latest-commits-widget/?username=USERNAME&repo=REPO&limit=LIMIT"
  allowtransparency="true" frameborder="0" scrolling="no" width="502px" height="252px"></iframe>
```

### Parameters

`username`<br>
GitHub username that owns the repo<br>

`repo`<br>
GitHub repository to check for activity

`limit`<br>
The maximum number of results to list (default: 10)


Things to Note
-----------

+ Width and height are hardcoded. Be sure to specify the default values (500x250) in your iframe and overload those values in the css if you want to change them.



Bug tracker
-----------

Have a bug? Open a new issue at https://github.com/tylerlh/github-latest-commits-widget/issues


Development
-----------------

If you want to contribute to this project or fork it, the tips below should help you get started.

These steps assume you have Node.js and [Gulp](http://gulpjs.com/) installed.

1. Clone the project &mdash; `git clone https://github.com/TylerLH/github-latest-commits-widget.git`
2. Install dependencies &mdash; `npm install`
3. Run the development server using `gulp watch`
4. Build the project for production using `gulp --type production`

Contributions and suggestions are welcome.



Authors
-------

**Tyler Hughes**

+ http://twitter.com/iamstyxxx
+ http://github.com/tylerlh



Copyright and license
---------------------

Copyright 2012-2014 Tyler Hughes.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this work except in compliance with the License.
You may obtain a copy of the License in the LICENSE file, or at:

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.