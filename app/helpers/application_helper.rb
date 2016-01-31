module ApplicationHelper
  def date_sift measurements
    h = {}
    measurements.sort_by { |m| m.datetime }.reverse.each do |m|
      date = m.datetime.strftime '%Y-%m-%d'
      begin
        h[date] << m
      rescue NoMethodError
        h[date] = [m]
      end
    end

    h
  end

  def models
    [
      GlucoseMeasurement,
      CarbohydrateIntake,
      MedicationEvent,
      PhysicalExercise
    ]
  end

  def class_name instance
    begin
      return instance.name.constantize
    rescue Exception => e
      return instance.class.name.constantize if e.message.match /undefined method `name' for/
    end
  end

  def get_type metric, field
    metric.class.columns.map { |m|
      {
        m.name => m.type
      }
    }.select { |p|
      p.keys[0] == field
    }[0].values[0]
  end

  def intervals
    [ 36, 48, 72]
  end
end
