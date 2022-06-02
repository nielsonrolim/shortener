# frozen_string_literal: true

class Api::V1::LinksController < Api::V1::ApiController
  before_action :set_api_v1_link, only: %i[show update destroy]

  # GET /api/v1/links
  def index
    api_v1_links = LinkBlueprint.render(Link.all, view: :normal)
    render json: api_v1_links
  end

  # GET /api/v1/links/1
  def show
    render json: LinkBlueprint.render(@api_v1_link, view: :extended)
  end

  # POST /api/v1/links
  def create
    api_v1_link = Link.new(api_v1_link_params)

    if api_v1_link.save
      render json: api_v1_link, status: :created, location: api_v1_link_url(api_v1_link)
    else
      render json: api_v1_link.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/links/1
  def update
    if @api_v1_link.update(api_v1_link_params)
      render json: @api_v1_link
    else
      render json: @api_v1_link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/links/1
  def destroy
    @api_v1_link.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_link
    @api_v1_link = Link.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: "404 Not found - #{e.message}", status: :not_found }
  rescue StandardError => e
    render json: { error: "400 Bad Request - #{e.message}", status: 400 }
  end

  # Only allow a trusted parameter "white list" through.
  def api_v1_link_params
    params.require(:link).permit(:url, :slug)
  end
end
