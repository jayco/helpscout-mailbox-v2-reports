# frozen_string_literal: true

RSpec.describe Helpscout::Mailbox::V2::Reports do
  it 'has a version number' do
    expect(Helpscout::Mailbox::V2::Reports::VERSION).not_to be nil
  end

  it 'has a client class' do
    expect(Helpscout::Mailbox::V2::Reports::Client).not_to be nil
  end

  it 'raises an error if initialisation fails' do
    expect do
      stub_request(:post, 'https://api.helpscout.net/v2/oauth2/token').to_raise(StandardError)
      client = Helpscout::Mailbox::V2::Reports::Client.new(client_id: 'some id', client_secret: 'keep it secret')
    end.to raise_error(StandardError)
  end

  it 'OAuths on initialisation' do
    body = URI.encode_www_form(client_id: 'some id', client_secret: 'keep it secret', grant_type: 'client_credentials')

    stub_request(:post, 'https://api.helpscout.net/v2/oauth2/token')
      .with(body: body, headers: { 'Content-Type': 'application/x-www-form-urlencoded' })
      .to_return(body: { expires_in: '1', access_token: 'some_token' }.to_json)

    Helpscout::Mailbox::V2::Reports::Client.new(client_id: 'some id', client_secret: 'keep it secret')
  end

  context 'endpoints' do
    before do
      body = URI.encode_www_form(client_id: 'some id', client_secret: 'keep it secret', grant_type: 'client_credentials')
      stub_request(:post, 'https://api.helpscout.net/v2/oauth2/token')
        .with(body: body, headers: { 'Content-Type': 'application/x-www-form-urlencoded' })
        .to_return(body: { expires_in: '1', access_token: 'some_token' }.to_json)

      @client = Helpscout::Mailbox::V2::Reports::Client.new(client_id: 'some id', client_secret: 'keep it secret')
      @test_id = '1234'
    end

    context 'company' do
      context 'get_company' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/company?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_company dates
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/company?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_company
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_company_customers_helped' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/company/customers-helped?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.v2_reports_company_customers_helped
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/company/customers-helped?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_company_customers_helped
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_company_drilldown' do
        it 'raises an error' do
          expect do
            stub_request(:get, "https://api.helpscout.net/v2/reports/company/drilldown?end=#{dates[:end]}&start=#{dates[:start]}&range=responseTime").to_raise(StandardError)
            response = @client.get_company_drilldown
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/company/drilldown?end=#{dates[:end]}&start=#{dates[:start]}&range=responseTime")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_company_drilldown
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end
    end

    context 'conversations' do
      before do
        body = URI.encode_www_form(client_id: 'some id', client_secret: 'keep it secret', grant_type: 'client_credentials')
        stub_request(:post, 'https://api.helpscout.net/v2/oauth2/token')
          .with(body: body, headers: { 'Content-Type': 'application/x-www-form-urlencoded' })
          .to_return(body: { expires_in: '1', access_token: 'some_token' }.to_json)

        @client = Helpscout::Mailbox::V2::Reports::Client.new(client_id: 'some id', client_secret: 'keep it secret')
        @test_id = '1234'
      end

      context 'get_conversations' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/conversations?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_conversations
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/conversations?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_conversations
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_conversations_busiest_times' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/conversations/busy-times?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_conversations_busiest_times
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/conversations/busy-times?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_conversations_busiest_times
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_conversations_drilldown' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/conversations/drilldown?end=#{dates[:end]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_conversations_drilldown
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/conversations/drilldown?end=#{dates[:end]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_conversations_drilldown
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_conversations_drilldown_by_field' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/conversations/fields-drilldown?end=#{dates[:end]}&field=customerid&fieldid=1&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_conversations_drilldown_by_field
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/conversations/fields-drilldown?end=#{dates[:end]}&field=customerid&fieldid=1&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_conversations_drilldown_by_field
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_conversations_channel_volumes' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/conversations/volume-by-channel?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_conversations_channel_volumes
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/conversations/volume-by-channel?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_conversations_channel_volumes
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_conversations_new_conversations_drilldown' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/conversations/new-drilldown?end=#{dates[:end]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_conversations_new_conversations_drilldown
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/conversations/new-drilldown?end=#{dates[:end]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_conversations_new_conversations_drilldown
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_conversations_received_message_stats' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/conversations/received-messages?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_conversations_received_message_stats
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/conversations/received-messages?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_conversations_received_message_stats
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end
    end

    context 'docs' do
      context 'get_docs' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/docs?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_docs
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/docs?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_docs
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end
    end

    context 'happiness' do
      context 'get_happiness' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/happiness?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_happiness
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/happiness?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_happiness
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_happiness_ratings' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/happiness/ratings?end=#{dates[:end]}&sortField=rating&sortOrder=ASC&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_happiness_ratings
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/happiness/ratings?end=#{dates[:end]}&sortField=rating&sortOrder=ASC&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_happiness_ratings
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end
    end

    context 'productivity' do
      context 'get_productivity' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/productivity?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_productivity
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/productivity?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_productivity
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_productivity_first_response_time' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/productivity/first-response-time?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_productivity_first_response_time
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/productivity/first-response-time?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_productivity_first_response_time
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_productivity_replies_sent' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/productivity/replies-sent?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_productivity_replies_sent
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/productivity/replies-sent?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_productivity_replies_sent
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_productivity_resolution_time' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/productivity/resolution-time?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_productivity_resolution_time
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/productivity/resolution-time?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_productivity_resolution_time
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_productivity_resolved' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/productivity/resolved?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_productivity_resolved
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/productivity/resolved?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_productivity_resolved
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_productivity_response_time' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/productivity/response-time?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_productivity_response_time
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/productivity/response-time?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_productivity_response_time
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end
    end

    context 'user' do
      context 'get_user' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/user?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}&user=1").to_raise(StandardError)
            response = @client.get_user
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/user?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}&user=1")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_user
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_user_conversation_history' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/user/conversation-history?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&sortField=number&sortOrder=ASC&start=#{dates[:start]}&user=1").to_raise(StandardError)
            response = @client.get_user_conversation_history
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/user/conversation-history?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&sortField=number&sortOrder=ASC&start=#{dates[:start]}&user=1")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_user_conversation_history
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_user_customers_helped' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/user/customers-helped?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}&user=1").to_raise(StandardError)
            response = @client.get_user_customers_helped
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/user/customers-helped?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}&user=1")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_user_customers_helped
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_user_drilldown' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/user/drilldown?end=#{dates[:end]}&start=#{dates[:start]}&user=1").to_raise(StandardError)
            response = @client.get_user_drilldown
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/user/drilldown?end=#{dates[:end]}&start=#{dates[:start]}&user=1")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_user_drilldown
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_user_happiness' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/user/happiness?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}&user=1").to_raise(StandardError)
            response = @client.get_user_happiness
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/user/happiness?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}&user=1")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_user_happiness
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_user_happiness_drilldown' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/user/ratings?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&sortField=number&sortOrder=ASC&start=#{dates[:start]}&user=1").to_raise(StandardError)
            response = @client.get_user_happiness_drilldown
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/user/ratings?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&sortField=number&sortOrder=ASC&start=#{dates[:start]}&user=1")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_user_happiness_drilldown
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_user_replies' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/user/replies?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}&user=1").to_raise(StandardError)
            response = @client.get_user_replies
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/user/replies?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}&user=1")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_user_replies
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end

      context 'get_user_resolutions' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/user/resolutions?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}&user=1").to_raise(StandardError)
            response = @client.get_user_resolutions
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/user/resolutions?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}&user=1")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_user_resolutions
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end
    end

    context 'chat' do
      context 'get_chat' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/chat?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_chat
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/chat?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_chat
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end
    end

    context 'email' do
      context 'get_email' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/email?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_email
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/email?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_email
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end
    end

    context 'phone' do
      context 'get_phone' do
        it 'raises an error' do
          expect do
            dates = @client.get_defaults
            stub_request(:get, "https://api.helpscout.net/v2/reports/phone?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}").to_raise(StandardError)
            response = @client.get_phone
          end.to raise_error(StandardError)
        end

        it 'should return value' do
          dates = @client.get_defaults
          stub_request(:get, "https://api.helpscout.net/v2/reports/phone?end=#{dates[:end]}&previousEnd=#{dates[:previous_end]}&previousStart=#{dates[:previous_start]}&start=#{dates[:start]}")
            .with(headers: { 'Authorization': 'Bearer some_token' })
            .to_return(body: { id: @test_id }.to_json)

          response = @client.get_phone
          expect(response.body).to eql({ id: @test_id }.to_json)
        end
      end
    end
  end
end
