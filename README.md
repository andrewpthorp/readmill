## As of March 28, 2014, Readmill is no longer in existence. You can read more about this in their [epilogue](http://readmill.com/).

## Ruby Wrapper for the Readmill API

### Quick Start

Install via RubyGems

    gem install readmill
    
Or, add it to your Gemfile

    gem 'readmill'
    
### Making Requests against the API

    Readmill.configure do |c|
      c.client_id = 'your_client_id_here'
    end
    
    client = Readmill::Client.new # Shortcut with Readmill.new
    client.readings # Returns the 20 most readings
    
### API Parameters

Most endpoints in the [Readmill API](http://developers.readmill.com/api/docs/v2/) take similar parameters (`count`, `offset`, etc). These are passed into the client requests as an options hash. For example:

    client.readings(count: 50, offset: 100) # Get 50 readings offset by 100
    
### What is Readmill?

> Readmill is a beautiful ebook reader for iOS and Android that lets you read and share great books.

You can view their API docs [here.](http://developers.readmill.com/api/docs/v2/)

### TODO

- Wrap authenticated (OAuth) endpoints

### Copyright

Copyright (c) 2013 Andrew Thorp. See [LICENSE][] for details.

[license]: LICENSE.md

