require 'test_helper'

class TenantTest < ActiveSupport::TestCase
  test 'initialize' do
    tenant = Tenant.create!(name: 'Tenant 5')
    assert_match(/[0-9a-f]{32}/i, tenant.api_key)
  end

  test 'throttled?' do
    tenant = Tenant.find(1)
    assert_equal(0, tenant.calls_today)
    assert_equal(0, tenant.calls_lifetime)
    assert_nil(tenant.last_call)
    assert_not(tenant.throttled?)
    assert_equal(1, tenant.calls_today)
    assert_equal(1, tenant.calls_lifetime)
    assert(tenant.last_call > Time.new - 1.second)

    tenant = Tenant.find(2)
    assert_equal(200, tenant.calls_today)
    assert_equal(1000, tenant.calls_lifetime)
    assert(tenant.last_call < Time.new - 20.seconds)
    assert_not(tenant.throttled?)
    assert_equal(201, tenant.calls_today)
    assert_equal(1001, tenant.calls_lifetime)
    assert(tenant.last_call > Time.new - 1.second)
    assert(tenant.throttled?)
  end

  test 'throttled? simulation from 0' do
    tenant = Tenant.find(3)
    assert_equal(0, tenant.calls_today)
    assert_equal(0, tenant.calls_lifetime)
    assert_nil(tenant.last_call)
    (1..100).each do |request|
      assert_not(tenant.throttled?)
      assert_equal(request, tenant.calls_today)
    end
    assert(tenant.throttled?)
  end

  test 'throttled? simulation from 200' do
    tenant = Tenant.find(4)
    assert_equal(200, tenant.calls_today)
    assert_equal(1000, tenant.calls_lifetime)
    assert(tenant.last_call < Time.new - 20.seconds)
    assert_not(tenant.throttled?)
    assert_equal(201, tenant.calls_today)
    assert_equal(1001, tenant.calls_lifetime)
    assert(tenant.last_call > Time.new - 1.second)
    assert(tenant.throttled?)
    (1..10).each do |second|
      sleep 1
      next assert(tenant.throttled?) if second < 10

      assert_not(tenant.throttled?)
    end
    assert_equal(202, tenant.calls_today)
    assert_equal(1002, tenant.calls_lifetime)
    assert(tenant.last_call > Time.new - 1.second)
    assert(tenant.throttled?)
  end
end
