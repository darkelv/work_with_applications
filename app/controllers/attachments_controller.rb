class AttachmentsController < ApplicationController
  before_action :set_attachment, only: :destroy

  def destroy
    @attachment.purge
    redirect_back(fallback_location: user_request_path(@attachment.record))
  end

  private

  def set_attachment
    @attachment = ActiveStorage::Attachment.find(params[:id])
  end
end

