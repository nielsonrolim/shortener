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
class Link < ApplicationRecord
  self.implicit_order_column = 'created_at'

  validates :url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), length: { minimum: 8, maximum: 2048 }
  validates :slug, uniqueness: true, length: { minimum: 3, maximum: 255 }

  before_validation :generate_slug

  def short
    Rails.application.routes.url_helpers.short_url(slug: slug, host: Rails.application.credentials.host)
  end

  private

  def generate_slug
    return if slug.present?

    slug = Array.new(6) { [*0..9, *'A'..'Z', *'a'..'z'].sample }.join
    if Link.exists?(slug: slug)
      generate_slug
    else
      self.slug = slug
    end
  end
  
end
