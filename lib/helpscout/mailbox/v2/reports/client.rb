# frozen_string_literal: true

require 'helpscout/mailbox/v2/client'
require_relative './validate'

module Helpscout
  module Mailbox
    module V2
      module Reports
        class Client < Helpscout::Mailbox::V2::Client::Http
          include Helpscout::Mailbox::V2::Reports::Validate

          def initialize(client_id:, client_secret:)
            super(client_id: client_id, client_secret: client_secret)
            @start = 1.week.ago.beginning_of_day.utc.iso8601
            @end = DateTime.now.beginning_of_day.utc.iso8601
            @prev_start = 3.weeks.ago.beginning_of_day.utc.iso8601
            @prev_end = 2.weeks.ago.beginning_of_day.utc.iso8601
          end

          def get_defaults
            { start: @start, end: @end, previous_start: @prev_start, previous_end: @prev_end }
          end

          def get_company(start_date: @start, end_date: @end, previous_start_date: @prev_start, previous_end_date: @prev_end, mailboxes: nil, tags: nil, types: nil, folders: nil)
            validated_dates = check_dates(start_date, end_date, previous_start_date, previous_end_date)
            api_map = generate_path(:v2_reports_company, nil)
            request(api_map[:method], api_map[:path], format(validated_dates.merge({ mailboxes: mailboxes, tags: tags, types: types, folders: folders })))
          end

          def get_company_customers_helped(start_date: @start, end_date: @end, previous_start_date: @prev_start, previous_end_date: @prev_end, mailboxes: nil, tags: nil, types: nil, folders: nil, view_by: nil)
            validated_dates = check_dates(start_date, end_date, previous_start_date, previous_end_date)
            api_map = generate_path(:v2_reports_company_customers_helped, nil)
            request(api_map[:method], api_map[:path], format(validated_dates.merge({ mailboxes: mailboxes, tags: tags, types: types, folders: folders, view_by: view_by })))
          end

          def get_company_drilldown(start_date: @start, end_date: @end, mailboxes: nil, tags: nil, types: nil, folders: nil, page: nil, rows: nil, range: 'responseTime', range_id: nil)
            validated_dates = check_dates(start_date, end_date)
            api_map = generate_path(:v2_reports_company_drilldown, nil)
            request(api_map[:method], api_map[:path], format(validated_dates.merge({ mailboxes: mailboxes, tags: tags, types: types, folders: folders, page: page, rows: rows, range: range, range_id: range_id })))
          end

          def get_conversations(start_date: @start, end_date: @end, previous_start_date: @prev_start, previous_end_date: @prev_end, mailboxes: nil, tags: nil, types: nil, folders: nil)
            validated_dates = check_dates(start_date, end_date, previous_start_date, previous_end_date)
            api_map = generate_path(:v2_reports_conversations, nil)
            request(api_map[:method], api_map[:path], format(validated_dates.merge({ mailboxes: mailboxes, tags: tags, types: types, folders: folders })))
          end

          def get_conversations_new_conversations(start_date: @start, end_date: @end, previous_start_date: @prev_start, previous_end_date: @prev_end, mailboxes: nil, tags: nil, types: nil, folders: nil, view_by: nil)
            validated_dates = check_dates(start_date, end_date, previous_start_date, previous_end_date)
            api_map = generate_path(:v2_reports_conversations_new, nil)
            request(api_map[:method], api_map[:path], format(validated_dates.merge({ mailboxes: mailboxes, tags: tags, types: types, folders: folders, view_by: view_by })))
          end

          def get_conversations_channel_volumes(start_date: @start, end_date: @end, previous_start_date: @prev_start, previous_end_date: @prev_end, mailboxes: nil, tags: nil, types: nil, folders: nil, view_by: nil)
            validated_dates = check_dates(start_date, end_date, previous_start_date, previous_end_date)
            api_map = generate_path(:v2_reports_conversations_channel_volume, nil)
            request(api_map[:method], api_map[:path], format(validated_dates.merge({ mailboxes: mailboxes, tags: tags, types: types, folders: folders, view_by: view_by })))
          end

          def get_conversations_busiest_times(start_date: @start, end_date: @end, previous_start_date: @prev_start, previous_end_date: @prev_end, mailboxes: nil, tags: nil, types: nil, folders: nil)
            validated_dates = check_dates(start_date, end_date, previous_start_date, previous_end_date)
            api_map = generate_path(:v2_reports_conversations_busy_times, nil)
            request(api_map[:method], api_map[:path], format(validated_dates.merge({ mailboxes: mailboxes, tags: tags, types: types, folders: folders })))
          end

          def get_conversations_drilldown(start_date: @start, end_date: @end, mailboxes: nil, tags: nil, types: nil, folders: nil, page: nil, rows: nil)
            validated_dates = check_dates(start_date, end_date)
            api_map = generate_path(:v2_reports_conversations_drilldown, nil)
            request(api_map[:method], api_map[:path], format(validated_dates.merge({ mailboxes: mailboxes, tags: tags, types: types, folders: folders, page: page, rows: rows })))
          end

          def get_conversations_drilldown_by_field(start_date: @start, end_date: @end, mailboxes: nil, tags: nil, types: nil, folders: nil, page: nil, rows: nil, field: 'customerid', field_id: 1)
            validated_dates = check_dates(start_date, end_date)
            api_map = generate_path(:v2_reports_conversations_fields_drilldown, nil)
            request(api_map[:method], api_map[:path], format(validated_dates.merge({ mailboxes: mailboxes, tags: tags, types: types, folders: folders, page: page, rows: rows, field: field, fieldid: field_id })))
          end

          def get_conversations_new_conversations_drilldown(start_date: @start, end_date: @end, mailboxes: nil, tags: nil, types: nil, folders: nil, page: nil, rows: nil)
            validated_dates = check_dates(start_date, end_date)
            api_map = generate_path(:v2_reports_conversations_new_drilldown, nil)
            request(api_map[:method], api_map[:path], format(validated_dates.merge({ mailboxes: mailboxes, tags: tags, types: types, folders: folders, page: page, rows: rows })))
          end

          def get_conversations_received_message_stats(start_date: @start, end_date: @end, previous_start_date: @prev_start, previous_end_date: @prev_end, mailboxes: nil, tags: nil, types: nil, folders: nil, view_by: nil)
            validated_dates = check_dates(start_date, end_date, previous_start_date, previous_end_date)
            api_map = generate_path(:v2_reports_conversations_messages_received, nil)
            request(api_map[:method], api_map[:path], format(validated_dates.merge({ mailboxes: mailboxes, tags: tags, types: types, folders: folders, view_by: view_by })))
          end

          def get_docs(start_date: @start, end_date: @end, previous_start_date: @prev_start, previous_end_date: @prev_end, sites: nil)
            validated_dates = check_dates(start_date, end_date, previous_start_date, previous_end_date)
            api_map = generate_path(:v2_reports_docs, nil)
            request(api_map[:method], api_map[:path], format(validated_dates.merge({ sites: sites })))
          end

          def get_happiness
            # TODO: implement me
            raise NotImplementedError
          end

          def get_happiness_ratings
            # TODO: implement me
            raise NotImplementedError
          end

          def get_productivity
            # TODO: implement me
            raise NotImplementedError
          end

          def get_productivity_first_response_time
            # TODO: implement me
            raise NotImplementedError
          end

          def get_productivity_replies_sent
            # TODO: implement me
            raise NotImplementedError
          end

          def get_productivity_resolution_time
            # TODO: implement me
            raise NotImplementedError
          end

          def get_productivity_resolved
            # TODO: implement me
            raise NotImplementedError
          end

          def get_productivity_response_time
            # TODO: implement me
            raise NotImplementedError
          end

          def get_user
            # TODO: implement me
            raise NotImplementedError
          end

          def get_user_conversation_history
            # TODO: implement me
            raise NotImplementedError
          end

          def get_user_customers_helped
            # TODO: implement me
            raise NotImplementedError
          end

          def get_user_drilldown
            # TODO: implement me
            raise NotImplementedError
          end

          def get_user_happiness
            # TODO: implement me
            raise NotImplementedError
          end

          def get_user_happiness_drilldown
            # TODO: implement me
            raise NotImplementedError
          end

          def get_user_replies
            # TODO: implement me
            raise NotImplementedError
          end

          def get_user_resolutions
            # TODO: implement me
            raise NotImplementedError
          end

          def get_chat
            # TODO: implement me
            raise NotImplementedError
          end

          def get_email
            # TODO: implement me
            raise NotImplementedError
          end

          def get_phone
            # TODO: implement me
            raise NotImplementedError
          end
        end
      end
    end
  end
end
