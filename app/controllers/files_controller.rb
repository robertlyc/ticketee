class FilesController < ApplicationController
  before_action :require_signin!
  
  def show
    asset = Asset.find(params[:id])
    if can?(:view, asset.ticket.project)
      send_file asset.asset.path, filename: asset.id.to_s, content_type: asset.content_type
    else
      flash[:alert] = "The asset you were looking for could not be found."
      redirect_to root_path
    end
  end
end
