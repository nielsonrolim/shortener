# frozen_string_literal: true

# == Schema Information
#
# Table name: links
#
#  id          :bigint           not null, primary key
#  url         :text
#  slug        :string
#  click_count :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Link, type: :model do
  let(:link) { FactoryBot.create(:link) }

  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should allow_value("http://mysite.com").for(:url) }
    it { should_not allow_value("foo").for(:url) }
    it { should validate_length_of(:url).is_at_least(8).is_at_most(2048).on(:create) }
    it { should validate_uniqueness_of(:slug) }
    it { should validate_length_of(:slug).is_at_least(3).is_at_most(255).on(:create) }
  end

  it 'should generate correct short URL' do
    expect(link.short).to eq("#{Rails.application.credentials.host}/#{link.slug}")
  end

  it 'should generate a slug if none is passed' do
    new_link = FactoryBot.create(:link, slug: nil)
    expect(link.slug).not_to be_empty
  end
end
