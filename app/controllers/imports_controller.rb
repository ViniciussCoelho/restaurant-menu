class ImportsController < ApplicationController
  def upload
    if params[:file].blank?
      return render json: { error: 'No file provided' }, status: :bad_request
    end

    result = UseCases::ImportJsonData.new(params[:file]).execute

    render json: {
      message: result[:message],
      results: result[:results]
    }, status: result[:status]
  end
end
