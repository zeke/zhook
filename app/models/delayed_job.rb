class DelayedJob < ActiveRecord::Base
end


# == Schema Info
# Schema version: 20090124015220
#
# Table name: delayed_jobs
#
#  id         :integer(4)      not null, primary key
#  attempts   :integer(4)      default(0)
#  handler    :text
#  last_error :string(255)
#  locked_by  :string(255)
#  priority   :integer(4)      default(0)
#  created_at :datetime
#  failed_at  :datetime
#  locked_at  :datetime
#  run_at     :datetime
#  updated_at :datetime