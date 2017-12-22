require 'spec_helper'
require 'capacity_form'

RSpec.describe ActiveModel::Validations::DomainObjectValidator do
  context 'construct by new' do
    it do
      form = CapacityForm.new(work_time_in_minutes: 5 * 60)
      expect(form).to be_valid
    end

    it do
      form = CapacityForm.new(work_time_in_minutes: 9 * 60)
      aggregate_failures do
        expect(form).to_not be_valid
        expect(form.errors[:work_time_in_minutes]).to match_array(['is invalid'])
      end
    end
  end

  context 'construct by from_hours' do
    it do
      form = CapacityForm.new(work_time_in_hours: 5)
      expect(form).to be_valid
    end

    it do
      form = CapacityForm.new(work_time_in_hours: 9)
      aggregate_failures do
        expect(form).to_not be_valid
        expect(form.errors[:work_time_in_hours]).to match_array(['is invalid'])
      end
    end
  end

  context 'invalid options' do
    before { CapacityForm.clear_validators! }
    after { CapacityForm.clear_validators! }

    it do
      expect {
        CapacityForm.validates_domain_object_of(:work_time_in_hours)
      }.to raise_error(ArgumentError)
    end

    it do
      expect {
        CapacityForm.validates_domain_object_of(:work_time_in_hours, object_class: WorkTime, method: :from_jikan)
      }.to raise_error(ArgumentError)
    end
  end
end
