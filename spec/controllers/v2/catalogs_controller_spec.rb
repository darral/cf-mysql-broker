require 'spec_helper'

describe V2::CatalogsController do
  before { authenticate }

  describe '#show' do
    it 'returns the catalog of services' do
      get :show

      expect(response.status).to eq(200)
      catalog = JSON.parse(response.body)

      services = catalog.fetch('services')
      expect(services).to have(1).service

      service = services.first
      expect(service.fetch('name')).to eq('cf-mysql')
      expect(service.fetch('description')).to eq('Cloud Foundry MySQL')
      expect(service.fetch('bindable')).to be_true
      expect(service.fetch('id')).to eq('cf-mysql-1')

      plans = service.fetch('plans')
      expect(plans).to have(1).plan

      plan = plans.first
      expect(plan.fetch('name')).to eq('free')
      expect(plan.fetch('description')).to eq('Free Trial')
      expect(plan.fetch('id')).to eq('cf-mysql-plan-1')
    end
  end
end