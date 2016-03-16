module ProgressJob
  class ProgressController < ActionController::Base

    def show
      begin
        @delayed_job = Delayed::Job.find(params[:job_id])
        percentage = -1
        if @delayed_job.progress_max && @delayed_job.progress_current
          percentage = !@delayed_job.progress_max.zero? ? @delayed_job.progress_current / @delayed_job.progress_max.to_f * 100 : 0
        end
        render json: @delayed_job.attributes.merge!(percentage: percentage).to_json
      rescue
        render json: 'none'.to_json
      end

    end

  end
end