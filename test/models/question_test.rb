# frozen_string_literal: true

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test 'self.q_and_a no private questions and no search' do
    result = Question.q_and_a
    assert_instance_of(Array, result)
    assert_equal(2, result.count)
    assert_equal('id, title, user_id, user, answers', result[0].keys.join(', '))
    assert_equal(2, result[0]['answers'].count)
    assert_equal('id, body, user_id, user', result[0]['answers'][0].keys.join(', '))
    assert_equal(1, result[0]['id'])
    assert_equal(1, result[0]['answers'][0]['id'])
  end

  test 'self.q_and_a with private questions and no search' do
    result = Question.q_and_a(include_private: true)
    assert_instance_of(Array, result)
    assert_equal(3, result.count)
    assert_equal('id, title, user_id, user, answers', result[0].keys.join(', '))
    assert_equal(1, result[-1]['answers'].count)
    assert_equal('id, body, user_id, user', result[0]['answers'][0].keys.join(', '))
    assert_equal(3, result[-1]['id'])
    assert_equal(5, result[-1]['answers'][-1]['id'])
  end

  test 'self.q_and_a no private questions and search' do
    result = Question.q_and_a(search: '1')
    assert_instance_of(Array, result)
    assert_equal(1, result.count)
    assert_equal('id, title, user_id, user, answers', result[0].keys.join(', '))
    assert_equal(2, result[0]['answers'].count)
    assert_equal('id, body, user_id, user', result[0]['answers'][0].keys.join(', '))
    assert_equal(1, result[0]['id'])
    assert_equal(1, result[0]['answers'][0]['id'])

    # Search for 3 which is private and should not be shown
    result = Question.q_and_a(search: '3')
    assert_instance_of(Array, result)
    assert_equal(0, result.count)
  end

  test 'self.q_and_a with private questions and search' do
    result = Question.q_and_a(include_private: true, search: '1')
    assert_instance_of(Array, result)
    assert_equal(1, result.count)
    assert_equal('id, title, user_id, user, answers', result[0].keys.join(', '))
    assert_equal(2, result[0]['answers'].count)
    assert_equal('id, body, user_id, user', result[0]['answers'][0].keys.join(', '))
    assert_equal(1, result[0]['id'])
    assert_equal(1, result[0]['answers'][0]['id'])

    # Search for 3 which is private and will now be shown
    result = Question.q_and_a(include_private: true, search: '3')
    assert_instance_of(Array, result)
    assert_equal(1, result.count)
    assert_equal('id, title, user_id, user, answers', result[0].keys.join(', '))
    assert_equal(1, result[0]['answers'].count)
    assert_equal('id, body, user_id, user', result[0]['answers'][0].keys.join(', '))
    assert_equal(3, result[0]['id'])
    assert_equal(5, result[0]['answers'][0]['id'])
  end

  # answers_with_users is tested within self.q_and_a
end
