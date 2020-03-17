# frozen_string_literal: true

require 'active_support/all'

module Helpscout
  module Mailbox
    module V2
      module Reports
        module Validate
          def camel(value)
            value.to_s.split('_').inject { |m, p| m + p.capitalize }
          end

          def format(args = {})
            res = {}
            args.each { |k, v| res[camel(k)] = v unless v.nil? }
            res
          end

          def valid_date(date_range)
            date_range.each { |_k, v| Time.iso8601(v) }
          end

          def date_range_overlap(date_range)
            (date_range[:start]..date_range[:end]).overlaps?(date_range[:previous_start]..date_range[:previous_end])
          end

          def date_range(date_range, include_previous = false)
            if date_range[:start] > date_range[:end]
              raise 'end date must be after start date'
            end

            return unless include_previous

            if date_range[:previous_start] > date_range[:previous_end]
              raise 'prev end date must be after previous start date'
            end

            if date_range[:end] < date_range[:previous_start]
              raise 'end date must be after previous start date'
            end

            if date_range_overlap(date_range)
              raise 'the date range has overlapping dates'
            end
          end

          def check_dates(start_date, end_date, previous_start_date = nil, previous_end_date = nil)
            if previous_start_date.nil? && previous_end_date.nil?
              date_range = { start: start_date, end: end_date }
              valid_date(date_range)
              date_range(date_range)
              return date_range
            end

            date_range = { start: start_date, end: end_date, previous_start: previous_start_date, previous_end: previous_end_date }
            valid_date(date_range)
            date_range(date_range, true)
            date_range
          end
        end
      end
    end
  end
end
