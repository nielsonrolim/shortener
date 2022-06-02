class LinkBlueprint < Blueprinter::Base
  identifier :id
    
  view :normal do
    fields :url, :click_count
    field :short_url do |link| 
      link.short 
    end
  end

  view :extended do
    include_view :normal
    fields :slug, :created_at, :updated_at
  end
end