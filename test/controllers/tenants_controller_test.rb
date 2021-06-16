# frozen_string_literal: true

require 'test_helper'

class TenantsControllerTest < ActionController::TestCase
  test 'questions without API key' do
    get(:questions)
    assert_response(:unauthorized)
  end

  test 'questions with invalid API key' do
    get(:questions, params: { api_key: '1234' })
    assert_response(:unauthorized)
  end

  test 'questions with API Key' do
    get(:questions, params: { api_key: 'c20a66d5e9b41801578c295375d609d3' })
    assert_response(:ok)
    response = JSON.parse(@response.body)
    assert_instance_of(Array, response)
    assert_equal(2, response.count)
    assert_equal('id, title, user_id, user, answers', response[0].keys.join(', '))
    # rest is tested in Question#q_and_a
  end

  test 'questions with API key and search' do
    get(:questions, params: { api_key: 'c20a66d5e9b41801578c295375d609d3', search: '1' })
    assert_response(:ok)
    response = JSON.parse(@response.body)
    assert_instance_of(Array, response)
    assert_equal(1, response.count)
    assert_equal(1, response[0]['id'])
    # rest is tested in Question#q_and_a
  end

  test 'questions with no content' do
    # Search for 3 and it will not return since it is private
    get(:questions, params: { api_key: 'c20a66d5e9b41801578c295375d609d3', search: '3' })
    assert_response(:no_content)
  end

  test 'questions with throttle' do
    # Use Tenant 4 to test throttle
    get(:questions, params: { api_key: '0d6b95d6205725a52811518810c94987' })
    assert_response(:ok)
    get(:questions, params: { api_key: '0d6b95d6205725a52811518810c94987' })
    assert_response(:too_many_requests)
  end
end
