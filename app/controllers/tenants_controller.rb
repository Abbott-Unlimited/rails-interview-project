# frozen_string_literal: true

# Controller for the {Tenant} model
class TenantsController < ApplicationController
  def questions
    # Find the calling Tenant
    @tenant = Tenant.find_by(api_key: params[:api_key])

    # If no Tenant was found deny access
    return head :unauthorized if @tenant.blank?

    # Check if the Tenant is throttled
    return head :too_many_requests if @tenant.throttled?

    result = Question.q_and_a(search: params[:search])

    # If there are no results return :no_content
    return head :no_content if result.count == 0

    render json: result, status: :ok
  end
end
