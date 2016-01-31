class WelcomeController < ApplicationController
  def index
    @hours = 36
    if params[:hours]
      @hours = hours(params[:hours]) ? hours(params[:hours]) : @hours
    end

    @metrics = []
    [
      GlucoseMeasurement,
      CarbohydrateIntake,
      MedicationEvent
    ].each do |model|
      @metrics.concat model.where(datetime: (Time.now - @hours.hours)..Time.now)
    end

    @widest = widest @metrics
  end

  private

  def widest metrics
    metrics.map { |m| m.class }.uniq.map { |u| u.fields.count }.max
  end

  def hours parameter
    return parameter.to_i if parameter.to_i > 0
  end
end
