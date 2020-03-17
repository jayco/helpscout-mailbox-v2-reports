# Helpscout::Mailbox::V2::Reports

[![Build status](https://badge.buildkite.com/37c6409bd0d3a5b2ba10b4a6c2edd6092ecda4d7704c7ece16.svg)](https://buildkite.com/jayco/helpscout-mailbox-v2-reports)

Simple to use client for interacting with the [Report Endpoints](https://developer.helpscout.com/mailbox-api/endpoints/reports/company/reports-company-overall) for the HelpScout V2 Mailbox API

It uses the following HelpScout gems:

- [Helpscout::Api::Auth](https://github.com/jayco/helpscout-api-auth.git)
- [Helpscout::Mailbox::Paths](https://github.com/jayco/helpscout-mailbox-paths.git)
- [Helpscout::Mailbox::V2::Client](https://github.com/jayco/helpscout-mailbox-v2-client)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'helpscout-mailbox-v2-reports'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install helpscout-mailbox-v2-reports

## Usage

#### Table of Contents

[Initialise](#Initialise)

[Company Reports](#Company)

- [get_company](#get_company)
- [get_company_customers_helped](#get_company_customers_helped)
- [get_company_drilldown](#get_company_drilldown)

### Initialise

Creates a new Client class and authorises the client with HelpScout

| Parameter       | Type     | Description                                                            |
| :-------------- | :------- | :--------------------------------------------------------------------- |
| `client_id`     | `string` | **Required** HelpScout API client id                                   |
| `client_secret` | `string` | **Required** HelpScout API client secret                               |
| `base_url`      | `string` | **Optional** HelpScout API url (defaults to https://api.helpscout.net) |

```ruby
require 'helpscout/mailbox/v2/reports'

client = Helpscout::Mailbox::V2::Reports::Client.new(client_id: 'some id', client_secret: 'keep it secret')
# => 'BMEv1lmcNgDBpOFNHo8TPlODMrF3BG5T'

```

### Company

#### get_company

The company report provides statistics about your company performance over a given time range. You may optionally specify two time ranges to see how performance changed between the two ranges.

Maps to [Company Overall Report](https://developer.helpscout.com/mailbox-api/endpoints/reports/company/reports-company-overall)

| Parameter             | Type          | Description                                                                                      | Example                                     |
| :-------------------- | :------------ | :----------------------------------------------------------------------------------------------- | :------------------------------------------ |
| `start_date`          | `utc.iso8601` | Start of the interval **Defaults 1.week.ago.beginning_of_day.utc.iso8601**                       | `start_date: 2020-03-09T13:30:00Z`          |
| `end_date`            | `utc.iso8601` | End of the interval **DateTime.now.beginning_of_day.utc.iso8601**                                | `end_date: 2020-03-16T13:30:00Z`            |
| `previous_start_date` | `utc.iso8601` | Start of the previous interval **Defaults 3.weeks.ago.beginning_of_day.utc.iso8601**             | `previous_start_date: 2020-02-24T13:30:00Z` |
| `previous_end_date`   | `utc.iso8601` | End of the previous interval **Defaults 2.weeks.ago.beginning_of_day.utc.iso8601**               | `previous_end_date: 2020-03-02T13:30:00Z`   |
| `tags`                | `number`      | List of comma separated ids to filter on tags                                                    | `tags:99787 or tags:5666 99787`             |
| `types`               | `enumeration` | List of comma separated conversation types to filter on, valid values are _email, chat or phone_ | `types: email or types:chat,email,phone`    |
| `folders`             | `number`      | List of comma separated folder ids to filter on folders                                          | `folders: 991 or folders: 991,99`           |

```ruby
response = client.get_company
# =>
# {
#   "filterTags" : [ {
#     "id" : 123,
#     "name" : "sample-tag"
#   } ],
#   "current" : {
#     "startDate" : "2015-01-01T00:00:00Z",
#     "endDate" : "2015-01-31T23:59:59Z",
#     "customersHelped" : 28,
#     "closed" : 94,
#     "totalReplies" : 62,
#     "totalUsers" : 5,
#     "totalDays" : 30,
#     "repliesPerDayPerUser" : 0.41333333333333333,
#     "repliesPerDay" : 2.066666666666667,
#     "resolvedPerDay" : 0.03333333333333333
#   },
#   "previous" : {
#     "startDate" : "2014-01-01T00:00:00Z",
#     "endDate" : "2014-01-31T23:59:59Z",
#     "customersHelped" : 27,
#     "closed" : 49,
#     "totalReplies" : 636,
#     "totalUsers" : 4,
#     "totalDays" : 30,
#     "repliesPerDayPerUser" : 5.3,
#     "repliesPerDay" : 21.2,
#     "resolvedPerDay" : 0.4666666666666667
#   },
#   "deltas" : {
#     "customersHelped" : 3.703703703703698,
#     "totalReplies" : -90.25157232704403,
#     "repliesPerDay" : -90.25157232704403,
#     "closed" : 91.83673469387755,
#     "totalUsers" : 25.0,
#     "repliesPerDayPerUser" : -92.20125786163523
#   },
#   "users" : [ {
#     "customersHelped" : 26,
#     "happinessScore" : 66.66666666666666,
#     "previousCustomersHelped" : 16,
#     "replies" : 58,
#     "name" : "John Smith",
#     "previousHappinessScore" : 23.529411764705884,
#     "previousReplies" : 40,
#     "user" : "1",
#     "previousHandleTime" : 0.0,
#     "handleTime" : 78.96
#   } ]
# }
```

#### get_company_customers_helped

The customers helped report provides statistics about how many customers were helped over a given time range. You may optionally specify two time ranges to see how the number of customers helped changed between the two ranges.

Maps to [Company Customers Helped](https://developer.helpscout.com/mailbox-api/endpoints/reports/company/reports-company-customers-helped/)

| Parameter             | Type          | Description                                                                                      | Example                                     |
| :-------------------- | :------------ | :----------------------------------------------------------------------------------------------- | :------------------------------------------ |
| `start_date`          | `utc.iso8601` | Start of the interval **Defaults 1.week.ago.beginning_of_day.utc.iso8601**                       | `start_date: 2020-03-09T13:30:00Z`          |
| `end_date`            | `utc.iso8601` | End of the interval **DateTime.now.beginning_of_day.utc.iso8601**                                | `end_date: 2020-03-16T13:30:00Z`            |
| `previous_start_date` | `utc.iso8601` | Start of the previous interval **Defaults 3.weeks.ago.beginning_of_day.utc.iso8601**             | `previous_start_date: 2020-02-24T13:30:00Z` |
| `previous_end_date`   | `utc.iso8601` | End of the previous interval **Defaults 2.weeks.ago.beginning_of_day.utc.iso8601**               | `previous_end_date: 2020-03-02T13:30:00Z`   |
| `tags`                | `number`      | List of comma separated ids to filter on tags                                                    | `tags:99787 or tags:5666 99787`             |
| `types`               | `enumeration` | List of comma separated conversation types to filter on, valid values are _email, chat or phone_ | `types: email or types:chat,email,phone`    |
| `folders`             | `number`      | List of comma separated folder ids to filter on folders                                          | `folders: 991 or folders: 991,99`           |
| `view_by`             | `enumeration` | Represents the resolution at which data is returned; valid values are: _day, week or month_      | `view_by: day`                              |

```ruby
response = client.get_company_customers_helped
# => "{\"current\":[{\"date\":\"2020-03-09T13:30:00Z\",\"customers\":58}],\"previous\":[{\"date\":\"2020-02-24T13:30:00Z\",\"customers\":69}]}"
```

#### get_company_drilldown

This report is similar to the Company Report, but instead of returning statistics about the company, it drills down and returns the conversation data that makes up the Company Report.

Maps to [Company Drilldown](https://developer.helpscout.com/mailbox-api/endpoints/reports/company/reports-company-drilldown/)

| Parameter    | Type          | Description                                                                                                                          | Example                                  |
| :----------- | :------------ | :----------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------- |
| `start_date` | `utc.iso8601` | Start of the interval **Defaults 1.week.ago.beginning_of_day.utc.iso8601**                                                           | `start_date: 2020-03-09T13:30:00Z`       |
| `end_date`   | `utc.iso8601` | End of the interval **DateTime.now.beginning_of_day.utc.iso8601**                                                                    | `end_date: 2020-03-16T13:30:00Z`         |
| `page`       | `number`      | The page number                                                                                                                      | `page: 2`                                |
| `rows`       | `number`      | Number of result to return per page; defaults to 25; maximum is 50                                                                   | `rows: 30`                               |
| `tags`       | `number`      | List of comma separated ids to filter on tags                                                                                        | `tags:99787 or tags:5666 99787`          |
| `types`      | `enumeration` | List of comma separated conversation types to filter on, valid values are _email, chat or phone_                                     | `types: email or types:chat,email,phone` |
| `folders`    | `number`      | List of comma separated folder ids to filter on folders                                                                              | `folders: 991 or folders: 991,99`        |
| `range`      | `enumeration` | Range valid values are _replies, firstReplyResolved, resolved responseTime, firstResponseTime, handleTime_ **Defaults responseTime** | `range: replies`                         |
| `range_id`   | `number`      | Range ID details, only valid if range is used                                                                                        | `range_id: 2`                            |

```ruby
response = client.get_company_drilldown
# =>
# {
#   "conversations" : {
#     "pages" : 157,
#     "page" : 1,
#     "count" : 1561,
#     "results" : [ {
#       "id" : 583,
#       "number" : 12345,
#       "type" : "email",
#       "mailboxid" : 2,
#       "attachments" : false,
#       "subject" : "Sample subject",
#       "status" : "active",
#       "threadCount" : 6,
#       "preview" : "This is a preview...",
#       "customerName" : "John Smith",
#       "customerEmail" : "john@example.com",
#       "customerIds" : [ 2 ],
#       "modifiedAt" : "2015-04-24T18:59:49Z",
#       "assignedid" : 4,
#       "tags" : [ {
#         "id" : 123,
#         "name" : "sample-tag",
#         "color" : "none"
#       } ],
#       "assignedName" : "Mary Jones"
#     } ]
#   }
# }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/helpscout-mailbox-v2-reports. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/helpscout-mailbox-v2-reports/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Helpscout::Mailbox::V2::Reports project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/helpscout-mailbox-v2-reports/blob/master/CODE_OF_CONDUCT.md).
