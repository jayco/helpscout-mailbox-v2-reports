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

[Company Reports](#Company-Reports)

- [get_company](#get_company)
- [get_company_customers_helped](#get_company_customers_helped)
- [get_company_drilldown](#get_company_drilldown)

[Conversation Reports](#Conversation-Reports)

- [get_conversations](#get_conversations)
- [get_conversations_new_conversations](#get_conversations_new_conversations)
- [get_conversations_channel_volumes](#get_conversations_channel_volumes)
- [get_conversations_busiest_times](#get_conversations_busiest_times)
- [get_conversations_drilldown](#get_conversations_drilldown)
- [get_conversations_drilldown_by_field](#get_conversations_drilldown_by_field)
- [get_conversations_new_conversations_drilldown](#get_conversations_new_conversations_drilldown)
- [get_conversations_received_message_stats](#get_conversations_received_message_stats)

[Doc Reports](#Doc-Reports)

- [get_docs](#get_docs)

[Happiness Reports](#Happiness-Reports)

- [get_happiness](#get_happiness)
- [get_happiness_ratings](#get_happiness_ratings)

[Productivity Reports](#Productivity-Reports)

- [get_productivity](#get_productivity)
- [get_productivity_first_response_time](#get_productivity_first_response_time)
- [get_productivity_replies_sent](#get_productivity_replies_sent)
- [get_productivity_resolution_time](#get_productivity_resolution_time)

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

### Company Reports

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

### Conversation Reports

#### get_conversations

The conversations report provides statistics about conversation volume over a given time range. You may optionally specify two time ranges to see how conversation volume changed between the two ranges.

Maps to [Conversations Overall Report](https://developer.helpscout.com/mailbox-api/endpoints/reports/conversations/reports-conversations-overall)

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
response = client.get_conversations

# =>
# {
#   "filterTags" : [ {
#     "name" : "tag a",
#     "id" : 2
#   }, {
#     "name" : "tag b",
#     "id" : 3
#   } ],
#   "busiestDay" : {
#     "day" : 3,
#     "hour" : 0,
#     "count" : 411
#   },
#   "busyTimeStart" : 11,
#   "busyTimeEnd" : 13,
#   "current" : {
#     "startDate" : "2015-01-01T00:00:00Z",
#     "endDate" : "2015-01-31T23:59:59Z",
#     "totalConversations" : 1816,
#     "conversationsCreated" : 1698,
#     "newConversations" : 1698,
#     "customers" : 1302,
#     "conversationsPerDay" : 60
#   },
#   "previous" : {
#     "startDate" : "2014-01-01T00:00:00Z",
#     "endDate" : "2014-01-01T23:59:59Z",
#     "totalConversations" : 2080,
#     "conversationsCreated" : 1976,
#     "newConversations" : 1976,
#     "customers" : 1479,
#     "conversationsPerDay" : 67
#   },
#   "deltas" : {
#     "newConversations" : -14.068825910931,
#     "totalConversations" : -12.692307692308,
#     "customers" : -11.967545638945,
#     "conversationsCreated" : -14.068825910931,
#     "conversationsPerDay" : -10.44776119403
#   },
#   "tags" : {
#     "count" : 351,
#     "top" : [ {
#       "id" : 1,
#       "count" : 1465,
#       "previousCount" : 1651,
#       "percent" : 80.671806167401,
#       "previousPercent" : 79.375,
#       "deltaPercent" : 1.2968061674009
#     }, {
#       "name" : "tag a",
#       "id" : 2,
#       "count" : 51,
#       "previousCount" : 63,
#       "percent" : 2.8083700440529,
#       "previousPercent" : 3.0288461538462,
#       "deltaPercent" : -0.22047610979329
#     }, {
#       "name" : "tag b",
#       "id" : 406031,
#       "count" : 24,
#       "previousCount" : 20,
#       "percent" : 1.3215859030837,
#       "previousPercent" : 0.96153846153846,
#       "deltaPercent" : 0.36004744154524
#     } ]
#   },
#   "customers" : {
#     "count" : 1816,
#     "top" : [ {
#       "count" : 31,
#       "deltaPercent" : 0.31281768891901,
#       "id" : 1,
#       "name" : "John Smith",
#       "percent" : 1.7070484581498,
#       "previousCount" : 29,
#       "previousPercent" : 1.3942307692308
#     }, {
#       "count" : 12,
#       "deltaPercent" : -0.10843781768892,
#       "id" : 2,
#       "name" : "Mary Jones",
#       "percent" : 0.66079295154185,
#       "previousCount" : 16,
#       "previousPercent" : 0.76923076923077
#     } ]
#   },
#   "replies" : {
#     "count" : 109,
#     "top" : [ {
#       "name" : "Saved Reply 1",
#       "id" : 1,
#       "mailboxId" : 1,
#       "count" : 16,
#       "previousCount" : 9,
#       "percent" : 0.88105726872247,
#       "previousPercent" : 0.43269230769231,
#       "deltaPercent" : 0.44836496103016
#     }, {
#       "name" : "Saved Reply 2",
#       "id" : 2,
#       "mailboxId" : 1,
#       "count" : 13,
#       "previousCount" : 12,
#       "percent" : 0.715859030837,
#       "previousPercent" : 0.57692307692308,
#       "deltaPercent" : 0.13893595391393
#     } ]
#   },
#   "workflows" : {
#     "count" : 240,
#     "top" : [ {
#       "name" : "Workflow 1",
#       "id" : 1,
#       "count" : 90,
#       "previousCount" : 82,
#       "percent" : 4.9559471365639,
#       "previousPercent" : 3.9423076923077,
#       "deltaPercent" : 1.0136394442562
#     }, {
#       "name" : "Workflow 2",
#       "id" : 2,
#       "count" : 75,
#       "previousCount" : 91,
#       "percent" : 4.1299559471366,
#       "previousPercent" : 4.375,
#       "deltaPercent" : -0.24504405286344
#     } ]
#   },
#   "customFields" : {
#     "count" : 1,
#     "fields" : [ {
#       "id" : 8,
#       "name" : "Account Type",
#       "mailboxId" : 1234,
#       "values" : [ {
#         "name" : "Paying Customer",
#         "id" : 7,
#         "count" : 1442,
#         "percent" : 55.12232415902141
#       }, {
#         "name" : "Trial Customer",
#         "id" : 11,
#         "count" : 273,
#         "percent" : 10.435779816513762
#       } ],
#       "summary" : {
#         "total" : 2616,
#         "totalAnswered" : 2241,
#         "previousTotal" : null,
#         "previousTotalAnswered" : null,
#         "unansweredDelta" : 14.3348623853211,
#         "unansweredPreviousPercent" : 0,
#         "unansweredPercent" : 14.3348623853211
#       }
#     } ]
#   }
# }
```

#### get_conversations_new_conversations

The new conversations report provides a summary of new conversation volume over a given time range.

Maps to [Conversations - New Conversations](https://developer.helpscout.com/mailbox-api/endpoints/reports/conversations/reports-conversations-new)

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
response = client.get_conversations_new_conversations
# => "{\"current\":[{\"start\":\"2020-03-09T13:30:00Z\",\"count\":62}],\"previous\":[{\"start\":\"2020-02-24T13:30:00Z\",\"count\":69}]}"
```

#### get_conversations_channel_volumes

This report shows conversation volumes split by chat, phone and email channels.

Maps to [All Channels - Volumes by Channel](https://developer.helpscout.com/mailbox-api/endpoints/reports/conversations/reports-conversations-volume-by-channel/)

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
response = client.get_conversations_channel_volumes
# => "{\"current\":[{\"date\":\"2020-03-09T13:30:00Z\",\"chat\":0,\"email\":62,\"phone\":0}],\"previous\":[{\"date\":\"2020-02-24T13:30:00Z\",\"chat\":0,\"email\":69,\"phone\":0}]}"
```

#### get_conversations_busiest_times

The busiest time of day report provides a summary of which days and times had the highest coversation volume. Days/hours are reported using the company’s time zone.

Maps to [Conversations - Busiest Time of Day](https://developer.helpscout.com/mailbox-api/endpoints/reports/conversations/reports-conversations-busy-times/)

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
response = client.get_conversations_busiest_times
# =>
# [ {
#   "day" : 1,
#   "hour" : 0,
#   "count" : 3
# }, {
#   "day" : 1,
#   "hour" : 1,
#   "count" : 2
# }, {
#   "day" : 7,
#   "hour" : 22,
#   "count" : 12
# }, {
#   "day" : 7,
#   "hour" : 23,
#   "count" : 4
# } ]
```

#### get_conversations_drilldown

This report is similar to the Conversations Report, but instead of returning statistics about conversation volume, it drills down and returns the conversation data that makes up the Conversations Report.

Maps to [Conversations - Drilldown](https://developer.helpscout.com/mailbox-api/endpoints/reports/conversations/reports-conversations-drilldown/)

| Parameter    | Type          | Description                                                                                      | Example                                  |
| :----------- | :------------ | :----------------------------------------------------------------------------------------------- | :--------------------------------------- |
| `start_date` | `utc.iso8601` | Start of the interval **Defaults 1.week.ago.beginning_of_day.utc.iso8601**                       | `start_date: 2020-03-09T13:30:00Z`       |
| `end_date`   | `utc.iso8601` | End of the interval **DateTime.now.beginning_of_day.utc.iso8601**                                | `end_date: 2020-03-16T13:30:00Z`         |
| `page`       | `number`      | The page number                                                                                  | `page: 2`                                |
| `rows`       | `number`      | Number of result to return per page; defaults to 25; maximum is 50                               | `rows: 30`                               |
| `tags`       | `number`      | List of comma separated ids to filter on tags                                                    | `tags:99787 or tags:5666 99787`          |
| `types`      | `enumeration` | List of comma separated conversation types to filter on, valid values are _email, chat or phone_ | `types: email or types:chat,email,phone` |
| `folders`    | `number`      | List of comma separated folder ids to filter on folders                                          | `folders: 991 or folders: 991,99`        |

```ruby
response = client.get_conversations_drilldown
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

#### get_conversations_drilldown_by_field

This report is similar to the Conversations Report, but instead of returning statistics about conversation volume, it drills down and returns the conversation data (by conversation field) that makes up the Conversations Report.

Maps to [Conversations - Drilldown by Field](https://developer.helpscout.com/mailbox-api/endpoints/reports/conversations/reports-conversations-field-drilldown/)

| Parameter    | Type          | Description                                                                                                                                                                       | Example                                  |
| :----------- | :------------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------- |
| `start_date` | `utc.iso8601` | Start of the interval **Defaults 1.week.ago.beginning_of_day.utc.iso8601**                                                                                                        | `start_date: 2020-03-09T13:30:00Z`       |
| `end_date`   | `utc.iso8601` | End of the interval **DateTime.now.beginning_of_day.utc.iso8601**                                                                                                                 | `end_date: 2020-03-16T13:30:00Z`         |
| `page`       | `number`      | The page number                                                                                                                                                                   | `page: 2`                                |
| `rows`       | `number`      | Number of result to return per page; defaults to 25; maximum is 50                                                                                                                | `rows: 30`                               |
| `tags`       | `number`      | List of comma separated ids to filter on tags                                                                                                                                     | `tags:99787 or tags:5666 99787`          |
| `types`      | `enumeration` | List of comma separated conversation types to filter on, valid values are _email, chat or phone_                                                                                  | `types: email or types:chat,email,phone` |
| `folders`    | `number`      | List of comma separated folder ids to filter on folders                                                                                                                           | `folders: 991 or folders: 991,99`        |
| `field`      | `enumeration` | Field to drill down; valid values: _tagid (for tags), replyid (for saved replies), workflowid (for workflows), customerid (for most active customers)_ **Defaults to customerid** | `field: customerid`                      |
| `field_id`   | `number`      | The identifier on which to drill down; can be an identifier representing a tag, saved reply, workflow, or customer                                                                | `field_id: 2`                            |

```ruby
response = client.get_conversations_drilldown_by_field
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

#### get_conversations_new_conversations_drilldown

This report is similar to the New Conversations Report, but instead of returning statistics about new conversation volume, it drills down and returns the actual new conversations that makes up the New Conversations Report.

Maps to [Conversations - New Conversations Drilldown](https://developer.helpscout.com/mailbox-api/endpoints/reports/conversations/reports-conversations-new-drilldown/)

| Parameter    | Type          | Description                                                                                      | Example                                  |
| :----------- | :------------ | :----------------------------------------------------------------------------------------------- | :--------------------------------------- |
| `start_date` | `utc.iso8601` | Start of the interval **Defaults 1.week.ago.beginning_of_day.utc.iso8601**                       | `start_date: 2020-03-09T13:30:00Z`       |
| `end_date`   | `utc.iso8601` | End of the interval **DateTime.now.beginning_of_day.utc.iso8601**                                | `end_date: 2020-03-16T13:30:00Z`         |
| `page`       | `number`      | The page number                                                                                  | `page: 2`                                |
| `rows`       | `number`      | Number of result to return per page; defaults to 25; maximum is 50                               | `rows: 30`                               |
| `tags`       | `number`      | List of comma separated ids to filter on tags                                                    | `tags:99787 or tags:5666 99787`          |
| `types`      | `enumeration` | List of comma separated conversation types to filter on, valid values are _email, chat or phone_ | `types: email or types:chat,email,phone` |
| `folders`    | `number`      | List of comma separated folder ids to filter on folders                                          | `folders: 991 or folders: 991,99`        |

```ruby
response = client.get_conversations_new_conversations_drilldown
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

#### get_conversations_received_message_stats

The received messages report provides a summary of the volume of received messages over a given time range. Only messages from customers are counted.

Maps to [Conversations - Received Messages Statistics](https://developer.helpscout.com/mailbox-api/endpoints/reports/conversations/reports-conversations-received-messages/)

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
response = client.get_conversations_received_message_stats
# => "{\"current\":[{\"date\":\"2020-03-09T13:30:00Z\",\"messages\":126}],\"previous\":[{\"date\":\"2020-02-24T13:30:00Z\",\"messages\":146}]}"
```

### Doc Reports

#### get_docs

The Docs report provides statistics about Docs usage (searches, top articles, etc.) over a given time range. You may optionally specify two time ranges to see how usage changed between the two ranges.

Maps to [Docs Overall Report](https://developer.helpscout.com/mailbox-api/endpoints/reports/docs/reports-docs-overall/)

| Parameter             | Type          | Description                                                                          | Example                                                                                      |
| :-------------------- | :------------ | :----------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------- |
| `start_date`          | `utc.iso8601` | Start of the interval **Defaults 1.week.ago.beginning_of_day.utc.iso8601**           | `start_date: 2020-03-09T13:30:00Z`                                                           |
| `end_date`            | `utc.iso8601` | End of the interval **DateTime.now.beginning_of_day.utc.iso8601**                    | `end_date: 2020-03-16T13:30:00Z`                                                             |
| `previous_start_date` | `utc.iso8601` | Start of the previous interval **Defaults 3.weeks.ago.beginning_of_day.utc.iso8601** | `previous_start_date: 2020-02-24T13:30:00Z`                                                  |
| `previous_end_date`   | `utc.iso8601` | End of the previous interval **Defaults 2.weeks.ago.beginning_of_day.utc.iso8601**   | `previous_end_date: 2020-03-02T13:30:00Z`                                                    |
| `sites`               | `string`      | List of comma separated docs site IDs                                                | `sites: 5215163545667acd25394b5c or sites:5215163545667acd25394b5c,5214c77c45667acd25394b51` |

```ruby
response = client.get_docs
# =>
# {
#   "current" : {
#     "visitors" : 10723,
#     "browseAction" : 88.94575230296827,
#     "sentAnEmailResult" : 0.3450526904784109,
#     "foundAnAnswerResult" : 72.93667816842301,
#     "searchAction" : 11.05424769703173,
#     "failedResult" : 26.71826914109857,
#     "docsViewedPerVisit" : 0.9329443525211182
#   },
#   "popularSearches" : [ {
#     "count" : 22,
#     "id" : "pricing",
#     "results" : 4
#   }, {
#     "count" : 21,
#     "id" : "beacon",
#     "results" : 9
#   } ],
#   "failedSearches" : [ {
#     "count" : 2,
#     "id" : "knowlege"
#   }, {
#     "count" : 1,
#     "id" : "auto-advance"
#   } ],
#   "topArticles" : [ {
#     "count" : 2295,
#     "name" : "Email commands ",
#     "siteId" : "52244cc53e3e9bd67a3dc68c",
#     "id" : "524db929e400c2199a391f39",
#     "collectionId" : "524491b4e4b0145597daf4e4"
#   } ],
#   "topCategories" : [ {
#     "count" : 1153,
#     "name" : "Productivity",
#     "siteId" : "52444cc53e3e9bd67a3dc28c",
#     "id" : "52b5a3b6e4b0a3b4e5ec64d3",
#     "articles" : 20
#   }, {
#     "count" : 790,
#     "name" : "Copying Email to Help Scout",
#     "siteId" : "52444cc53e3e9bd67b3dc68c",
#     "id" : "52548414e4b0772073dac6d0",
#     "articles" : 17
#   } ],
#   "deltas" : {
#     "failedResult" : 2.4021178109331593,
#     "docsViewedPerVisit" : 2.561943903720043,
#     "foundAnAnswerResult" : -2.7056392137487535,
#     "visitors" : -14.622392395035643,
#     "browseAction" : -2.154856275773497,
#     "searchAction" : 2.1548562757735183,
#     "sentAnEmailResult" : 0.30352140281560414
#   }
# }
```

### Happiness Reports

#### get_happiness

The happiness report provides information about how many Great, Okay, and Not Good ratings your company received for each period in a specified time range. You may optionally specify two time ranges to see how happiness ratings changed between the two time ranges.

Maps to [Happiness Overall Report](https://developer.helpscout.com/mailbox-api/endpoints/reports/happiness/reports-happiness-overall/)

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
response = client.get_happiness
# =>
# {
#   "current" : {
#     "ratingsPercent" : 35.77981651376147,
#     "okay" : 30.909090909090907,
#     "great" : 37.27272727272727,
#     "happinessScore" : 5.454545454545457,
#     "okayCount" : 34,
#     "totalCustomersWithRatings" : 39,
#     "notGoodCount" : 35,
#     "ratingsCount" : 110,
#     "notGood" : 31.818181818181817,
#     "greatCount" : 41,
#     "totalCustomers" : 109
#   },
#   "previous" : {
#     "ratingsPercent" : 32.03047366677708,
#     "great" : 31.65735567970205,
#     "okay" : 36.49906890130354,
#     "happinessScore" : -0.1862197392923619,
#     "okayCount" : 392,
#     "totalCustomersWithRatings" : 967,
#     "notGoodCount" : 342,
#     "ratingsCount" : 1074,
#     "notGood" : 31.843575418994412,
#     "greatCount" : 340,
#     "totalCustomers" : 3019
#   },
#   "deltas" : {
#     "okay" : -5.589977992212631,
#     "great" : 5.615371593025223,
#     "okayCount" : -91.3265306122449,
#     "happinessScore" : 5.640765193837819,
#     "notGoodCount" : -89.76608187134502,
#     "notGood" : -0.02539360081259545,
#     "greatCount" : -87.94117647058823
#   }
# }
```

#### get_happiness_ratings

The happiness ratings report provides a company’s ratings for over a specified time range.

Maps to [Happiness Ratings Report](https://developer.helpscout.com/mailbox-api/endpoints/reports/happiness/reports-happiness-ratings/)

| Parameter    | Type          | Description                                                                                      | Example                                  |
| :----------- | :------------ | :----------------------------------------------------------------------------------------------- | :--------------------------------------- |
| `start_date` | `utc.iso8601` | Start of the interval **Defaults 1.week.ago.beginning_of_day.utc.iso8601**                       | `start_date: 2020-03-09T13:30:00Z`       |
| `end_date`   | `utc.iso8601` | End of the interval **DateTime.now.beginning_of_day.utc.iso8601**                                | `end_date: 2020-03-16T13:30:00Z`         |
| `tags`       | `number`      | List of comma separated ids to filter on tags                                                    | `tags:99787 or tags:5666 99787`          |
| `types`      | `enumeration` | List of comma separated conversation types to filter on, valid values are _email, chat or phone_ | `types: email or types:chat,email,phone` |
| `page`       | `number`      | The page number                                                                                  | `page: 2`                                |
| `sort_field` | `enumeration` | Must be one of _number, modifiedAt, rating_ **Defaults to rating**                               | `sortField: rating`                      |
| `sort_order` | `enumeration` | Must be one of _ASC or DESC_ **Defaults to ASC**                                                 | `sortOrder: ASC`                         |
| `rating`     | `enumeration` | Rating to filter on, valid values are: _great, ok, all, not-good_                                | `rating: great`                          |
| `folders`    | `number`      | List of comma separated folder ids to filter on folders                                          | `folders: 991 or folders: 991,99`        |

```ruby
response = client.get_happiness_ratings
# =>
# {
#   "results" : [ {
#     "number" : 222043,
#     "threadid" : 1169815634,
#     "threadCreatedAt" : "2017-09-15T11:57:14Z",
#     "id" : 432207336,
#     "type" : "email",
#     "ratingId" : 1,
#     "ratingCustomerId" : 121198824,
#     "ratingComments" : "Thanks for the clear reply, Amanda!",
#     "ratingCreatedAt" : "2017-09-15T12:26:53Z",
#     "ratingCustomerName" : "Alexander the Great",
#     "ratingUserId" : 69013,
#     "ratingUserName" : "Amanda Herrington"
#   }, {
#     "number" : 226983,
#     "threadid" : 1169298612,
#     "threadCreatedAt" : "2017-09-15T03:52:30Z",
#     "id" : 432031326,
#     "type" : "email",
#     "ratingId" : 1,
#     "ratingCustomerId" : 121972376,
#     "ratingComments" : "Super helpful!",
#     "ratingCreatedAt" : "2017-09-15T14:54:27Z",
#     "ratingCustomerName" : "Mikey Mikelson",
#     "ratingUserId" : 76859,
#     "ratingUserName" : "Shawna Herring"
#   } ],
#   "page" : 1,
#   "count" : 100,
#   "pages" : 2
# }
```

### Productivity Reports

#### get_productivity

The productivity report provides a snapshot of productivity over a given time range. You may optionally specify two time ranges to see how productivity changed between the two ranges.

If you would like to see the conversation data that make up this report, please use the Company Drilldown endpoint

Maps to [Productivity Overall Report](https://developer.helpscout.com/mailbox-api/endpoints/reports/productivity/reports-productivity-overall/)

| Parameter             | Type          | Description                                                                                                                                                                    | Example                                     |
| :-------------------- | :------------ | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------ |
| `start_date`          | `utc.iso8601` | Start of the interval **Defaults 1.week.ago.beginning_of_day.utc.iso8601**                                                                                                     | `start_date: 2020-03-09T13:30:00Z`          |
| `end_date`            | `utc.iso8601` | End of the interval **DateTime.now.beginning_of_day.utc.iso8601**                                                                                                              | `end_date: 2020-03-16T13:30:00Z`            |
| `previous_start_date` | `utc.iso8601` | Start of the previous interval **Defaults 3.weeks.ago.beginning_of_day.utc.iso8601**                                                                                           | `previous_start_date: 2020-02-24T13:30:00Z` |
| `previous_end_date`   | `utc.iso8601` | End of the previous interval **Defaults 2.weeks.ago.beginning_of_day.utc.iso8601**                                                                                             | `previous_end_date: 2020-03-02T13:30:00Z`   |
| `tags`                | `number`      | List of comma separated ids to filter on tags                                                                                                                                  | `tags:99787 or tags:5666 99787`             |
| `types`               | `enumeration` | List of comma separated conversation types to filter on, valid values are _email, chat or phone_                                                                               | `types: email or types:chat,email,phone`    |
| `folders`             | `number`      | List of comma separated folder ids to filter on folders                                                                                                                        | `folders: 991 or folders: 991,99`           |
| `office_hours`        | `boolean`     | Whether to take office hours into consideration in the report (defaults to false); office hours must be enabled if true is passed, otherwise the default of false will be used | `office_hours: true`                        |

```ruby
response = client.get_productivity
# =>
# {
#   "filterTags" : [ {
#     "id" : 123,
#     "name" : "sample-tag"
#   } ],
#   "current" : {
#     "startDate" : "2015-01-01T00:00:00Z",
#     "endDate" : "2015-01-31T23:59:59Z",
#     "totalConversations" : 1,
#     "resolutionTime" : 2278004.0,
#     "repliesToResolve" : 2.0,
#     "responseTime" : 2278004,
#     "firstResponseTime" : 2278004,
#     "resolved" : 1,
#     "resolvedOnFirstReply" : 0,
#     "closed" : 94,
#     "repliesSent" : 62,
#     "handleTime" : 6,
#     "percentResolvedOnFirstReply" : 0.0
#   },
#   "previous" : {
#     "startDate" : "2014-01-01T00:00:00Z",
#     "endDate" : "2014-01-31T23:59:59Z",
#     "totalConversations" : 14,
#     "resolutionTime" : 6531211.714285715,
#     "repliesToResolve" : 2.2142857142857144,
#     "responseTime" : 4850412,
#     "firstResponseTime" : 5138913,
#     "resolved" : 14,
#     "resolvedOnFirstReply" : 5,
#     "closed" : 49,
#     "repliesSent" : 636,
#     "handleTime" : 0,
#     "percentResolvedOnFirstReply" : 0.35714285714285715
#   },
#   "deltas" : {
#     "totalConversations" : -92.85714285714286,
#     "repliesSent" : -90.25157232704403,
#     "firstResponseTime" : -55.67148149813006,
#     "resolved" : -92.85714285714286,
#     "repliesToResolve" : -9.677419354838712,
#     "closed" : 91.83673469387755,
#     "resolvedOnFirstReply" : -100.0,
#     "responseTime" : -53.03483497896673,
#     "handleTime" : 0.0,
#     "resolutionTime" : -65.12126539984419
#   },
#   "responseTime" : {
#     "count" : 1,
#     "previousCount" : 14,
#     "ranges" : [ {
#       "id" : 10,
#       "count" : 1,
#       "previousCount" : 12,
#       "percent" : 100.0,
#       "previousPercent" : 85.71428571428571
#     } ]
#   },
#   "handleTime" : {
#     "count" : 1,
#     "previousCount" : 14,
#     "ranges" : [ {
#       "id" : 1,
#       "count" : 1,
#       "previousCount" : 14,
#       "percent" : 100.0,
#       "previousPercent" : 100.0
#     } ]
#   },
#   "firstResponseTime" : {
#     "count" : 1,
#     "previousCount" : 14,
#     "ranges" : [ {
#       "id" : 10,
#       "count" : 1,
#       "previousCount" : 12,
#       "percent" : 100.0,
#       "previousPercent" : 85.71428571428571
#     } ]
#   },
#   "repliesToResolve" : {
#     "count" : 1,
#     "previousCount" : 14,
#     "ranges" : [ {
#       "id" : 2,
#       "count" : 1,
#       "previousCount" : 4,
#       "percent" : 100.0,
#       "previousPercent" : 28.57142857142857,
#       "resolutionTime" : 2278004
#     } ]
#   }
# }
```

#### get_productivity_first_response_time

This report provides average first response times for each period in a specified time range. You may optionally specify two time ranges to see how first response time changed between the two ranges.

Maps to [Productivity - First Response Time](https://developer.helpscout.com/mailbox-api/endpoints/reports/productivity/reports-productivity-first-response-time/)

| Parameter             | Type          | Description                                                                                                                                                                    | Example                                     |
| :-------------------- | :------------ | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------ |
| `start_date`          | `utc.iso8601` | Start of the interval **Defaults 1.week.ago.beginning_of_day.utc.iso8601**                                                                                                     | `start_date: 2020-03-09T13:30:00Z`          |
| `end_date`            | `utc.iso8601` | End of the interval **DateTime.now.beginning_of_day.utc.iso8601**                                                                                                              | `end_date: 2020-03-16T13:30:00Z`            |
| `previous_start_date` | `utc.iso8601` | Start of the previous interval **Defaults 3.weeks.ago.beginning_of_day.utc.iso8601**                                                                                           | `previous_start_date: 2020-02-24T13:30:00Z` |
| `previous_end_date`   | `utc.iso8601` | End of the previous interval **Defaults 2.weeks.ago.beginning_of_day.utc.iso8601**                                                                                             | `previous_end_date: 2020-03-02T13:30:00Z`   |
| `tags`                | `number`      | List of comma separated ids to filter on tags                                                                                                                                  | `tags:99787 or tags:5666 99787`             |
| `types`               | `enumeration` | List of comma separated conversation types to filter on, valid values are _email, chat or phone_                                                                               | `types: email or types:chat,email,phone`    |
| `folders`             | `number`      | List of comma separated folder ids to filter on folders                                                                                                                        | `folders: 991 or folders: 991,99`           |
| `office_hours`        | `boolean`     | Whether to take office hours into consideration in the report (defaults to false); office hours must be enabled if true is passed, otherwise the default of false will be used | `office_hours: true`                        |
| `view_by`             | `enumeration` | Represents the resolution at which data is returned; valid values are: _day, week or month_                                                                                    | `view_by: day`                              |

```ruby
response = client.get_productivity_first_response_time
# => "{\"current\":[{\"date\":\"2020-03-09T13:30:00Z\",\"time\":77134}],\"previous\":[{\"date\":\"2020-02-24T13:30:00Z\",\"time\":160951}]}"
```

#### get_productivity_replies_sent

This report provides the number of replies sent for each period in a specified time range. You may optionally specify two time ranges to see how the number of replies sent changed between the two ranges.

Maps to [Productivity - Replies Sent](https://developer.helpscout.com/mailbox-api/endpoints/reports/productivity/reports-productivity-replies-sent/)

| Parameter             | Type          | Description                                                                                                                                                                    | Example                                     |
| :-------------------- | :------------ | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------ |
| `start_date`          | `utc.iso8601` | Start of the interval **Defaults 1.week.ago.beginning_of_day.utc.iso8601**                                                                                                     | `start_date: 2020-03-09T13:30:00Z`          |
| `end_date`            | `utc.iso8601` | End of the interval **DateTime.now.beginning_of_day.utc.iso8601**                                                                                                              | `end_date: 2020-03-16T13:30:00Z`            |
| `previous_start_date` | `utc.iso8601` | Start of the previous interval **Defaults 3.weeks.ago.beginning_of_day.utc.iso8601**                                                                                           | `previous_start_date: 2020-02-24T13:30:00Z` |
| `previous_end_date`   | `utc.iso8601` | End of the previous interval **Defaults 2.weeks.ago.beginning_of_day.utc.iso8601**                                                                                             | `previous_end_date: 2020-03-02T13:30:00Z`   |
| `tags`                | `number`      | List of comma separated ids to filter on tags                                                                                                                                  | `tags:99787 or tags:5666 99787`             |
| `types`               | `enumeration` | List of comma separated conversation types to filter on, valid values are _email, chat or phone_                                                                               | `types: email or types:chat,email,phone`    |
| `folders`             | `number`      | List of comma separated folder ids to filter on folders                                                                                                                        | `folders: 991 or folders: 991,99`           |
| `office_hours`        | `boolean`     | Whether to take office hours into consideration in the report (defaults to false); office hours must be enabled if true is passed, otherwise the default of false will be used | `office_hours: true`                        |
| `view_by`             | `enumeration` | Represents the resolution at which data is returned; valid values are: _day, week or month_                                                                                    | `view_by: day`                              |

```ruby
response = client.get_productivity_replies_sent
# => "{\"current\":[{\"date\":\"2020-03-09T13:30:00Z\",\"replies\":86}],\"previous\":[{\"date\":\"2020-02-24T13:30:00Z\",\"replies\":109}]}"
```

#### get_productivity_resolution_time

This report provides the number of replies sent for each period in a specified time range. You may optionally specify two time ranges to see how the number of replies sent changed between the two ranges.

Maps to [Productivity - Replies Sent](https://developer.helpscout.com/mailbox-api/endpoints/reports/productivity/reports-productivity-replies-sent/)

| Parameter             | Type          | Description                                                                                                                                                                    | Example                                     |
| :-------------------- | :------------ | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------ |
| `start_date`          | `utc.iso8601` | Start of the interval **Defaults 1.week.ago.beginning_of_day.utc.iso8601**                                                                                                     | `start_date: 2020-03-09T13:30:00Z`          |
| `end_date`            | `utc.iso8601` | End of the interval **DateTime.now.beginning_of_day.utc.iso8601**                                                                                                              | `end_date: 2020-03-16T13:30:00Z`            |
| `previous_start_date` | `utc.iso8601` | Start of the previous interval **Defaults 3.weeks.ago.beginning_of_day.utc.iso8601**                                                                                           | `previous_start_date: 2020-02-24T13:30:00Z` |
| `previous_end_date`   | `utc.iso8601` | End of the previous interval **Defaults 2.weeks.ago.beginning_of_day.utc.iso8601**                                                                                             | `previous_end_date: 2020-03-02T13:30:00Z`   |
| `tags`                | `number`      | List of comma separated ids to filter on tags                                                                                                                                  | `tags:99787 or tags:5666 99787`             |
| `types`               | `enumeration` | List of comma separated conversation types to filter on, valid values are _email, chat or phone_                                                                               | `types: email or types:chat,email,phone`    |
| `folders`             | `number`      | List of comma separated folder ids to filter on folders                                                                                                                        | `folders: 991 or folders: 991,99`           |
| `office_hours`        | `boolean`     | Whether to take office hours into consideration in the report (defaults to false); office hours must be enabled if true is passed, otherwise the default of false will be used | `office_hours: true`                        |
| `view_by`             | `enumeration` | Represents the resolution at which data is returned; valid values are: _day, week or month_                                                                                    | `view_by: day`                              |

```ruby
response = client.get_productivity_resolution_time
# => "{\"current\":[{\"date\":\"2020-03-09T13:30:00Z\",\"time\":423588}],\"previous\":[{\"date\":\"2020-02-24T13:30:00Z\",\"time\":642356}]}"
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
