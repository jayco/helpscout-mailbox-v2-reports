# frozen_string_literal: true

require 'helpscout/mailbox/v2/client'

module Helpscout
  module Mailbox
    module V2
      module Reports
        class Client < Helpscout::Mailbox::V2::Client::Http
          def initialize(client_id:, client_secret:)
            super(client_id: client_id, client_secret: client_secret)
          end

          def get_company
            # TODO: implement me
            raise NotImplementedError
          end

          def get_company_customers_helped
            # TODO: implement me
            raise NotImplementedError
          end

          def get_company_drilldown
            # TODO: implement me
            raise NotImplementedError
          end

          def get_conversations
            # TODO: implement me
            raise NotImplementedError
          end

          def get_conversations_busiest_times
            # TODO: implement me
            raise NotImplementedError
          end

          def get_conversations_drilldown
            # TODO: implement me
            raise NotImplementedError
          end

          def get_conversations_drilldown_by_field
            # TODO: implement me
            raise NotImplementedError
          end

          def get_conversations_new_conversations
            # TODO: implement me
            raise NotImplementedError
          end

          def get_conversations_new_conversations_drilldown
            # TODO: implement me
            raise NotImplementedError
          end

          def get_conversations_received_message_stats
            # TODO: implement me
            raise NotImplementedError
          end

          def get_docs
            # TODO: implement me
            raise NotImplementedError
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
