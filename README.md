# Sapi

Sapi is a Simple Ruby on Rails Sample Api.

**Creator:** José Carrión.

[![Build Status](https://travis-ci.org/joselo/sapi.svg?branch=master)](https://travis-ci.org/joselo/sapi)
[![Maintainability](https://api.codeclimate.com/v1/badges/b3a31ee5fd3c70a3d91b/maintainability)](https://codeclimate.com/github/joselo/sapi/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/b3a31ee5fd3c70a3d91b/test_coverage)](https://codeclimate.com/github/joselo/sapi/test_coverage)

## Install

    $ git clone git@github.com:joselo/sapi.git
    $ cd sapi
    $ bundle install
    $ rails test
    $ rails server

## Api End Points

### POST /api/web-sites
Pick up the contents of an url. `Only h1, h2, h3 and a html tags.`

Example:

    $ curl -X POST http://localhost:3000/api/web-sites -H "Accept: application/vnd.api+json" -H "Content-Type: application/vnd.api+json" -d '{ "data": { "type": "web-sites","attributes": {"url": "https://blog.github.com/"}}}'

### GET /api/web-sites
Get the list of indexed urls with their content.

Example:

    $ curl -X GET http://localhost:3000/api/web-sites -H "Accept: application/vnd.api+json" -H "Content-Type: application/vnd.api+json"

## License

Code is distributed under MIT license, feel free to use it in your proprietary
projects as well.
