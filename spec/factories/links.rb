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
FactoryBot.define do
  factory :link do
    url { "https://lavanderia60minutos.com.br" }
    slug { "lav60min" }
    click_count { 1 }

    factory :invalid_link do
      url { "lavanderia60minutos.com.br" }
      slug { "" }
    end

  end

end
