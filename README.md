# Google Ajax Crawler

[![Build Status](https://travis-ci.org/benkitzelman/google-ajax-crawler.png)](https://travis-ci.org/benkitzelman/google-ajax-crawler)
[![Gem Version](https://badge.fury.io/rb/google_ajax_crawler.png)](http://badge.fury.io/rb/google_ajax_crawler)

Rack Middleware adhering to the Google Ajax Crawling Scheme, using a headless browser to render JS heavy pages and serve a dom snapshot of the rendered state to a requesting search engine.

Details of the scheme can be found at: https://developers.google.com/webmasters/ajax-crawling/docs/getting-started

## Using

install

``` ruby
gem install google_ajax_crawler
```

In your config.ru

``` ruby
require 'google_ajax_crawler'

use GoogleAjaxCrawler::Crawler do |config|
  config.page_loaded_test = lambda {|driver| driver.page.evaluate_script('document.getElementById("loading") == null') }
end

app = lambda {|env| [200, {'Content-Type' => 'text/plain'}, "b" ] }
run app

```

## Examples

In the examples folder, each driver has a rackup file, which can be launched:

`rackup examples/[driver_name].ru`

then open a browser to http://localhost:9292/#!test and view source.... This is how a search engine will see your page. *NOTE:* don't look at the markup through a web inspector as it will most likely display dom elements rendered on the fly by js.

Change the url to http://localhost:9292/?_escaped_fragment_=test , and then again view source to see how the DOM state has been captured

## Configuration Options

### page_loaded_test

Tell the crawler when your page has finished loading / rendering. As determining when a page has completed rendering can depend on a number of qualitative factors (i.e. all ajax requests have responses, certain content has been displayed, or even when there are no loaders / spinners visible on the page), the page loaded test allows you to specify when the crawler should decide that your page has finished loading / rendering and to return a snapshot of the rendered dom at that time.

The current crawler driver is passed to the lambda to allow querying of the current page's dom state.

A good pattern is to test your page state in a js function returning a boolean, accessible from the window context.. i.e.

```ruby

use GoogleAjaxCrawler::Crawler do |config|
  config.page_loaded_test = lambda {|driver| driver.page.evaluate_script('myApp.isPageLoaded()') }
end

```

### timeout

The max time the crawler should wait before returning a response

### driver

The configured google ajax crawler driver used to query the current page state. Presently there is only one driver (now taking pull requests!); CapybaraWebkit

### poll_interval

How often (in seconds) to test the page state with the configured page_loaded_test

### response_headers

What response headers shoudl be returned with the dom snapshot. Default headers specify the content-type text/html

## License

All free - Use, modify, fork to your hearts content...
See LICENSE.txt for further details.

