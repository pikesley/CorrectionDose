class LongtermController < ApplicationController
  before_action :require_login

  def index
    @metrics = [
      GlycatedHaemoglobin.all,
      BloodPressure.all
    ]

#    @datas = [
#      ControllerHelpers.for_table(GlycatedHaemoglobin.all),
#      ControllerHelpers.for_table(BloodPressure.all)
#    ]

    @no_picker = true;
    @with_year = true;
  end
end
