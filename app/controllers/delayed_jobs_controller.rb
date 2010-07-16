class DelayedJobsController < ApplicationController

  def index
    @delayed_job_count = DelayedJob.count
    render :text => "#{@delayed_job_count} jobs queued."
  end
  
end
