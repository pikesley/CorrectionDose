class GenericController < ApplicationController
  before_action :require_login

  def index
    @hours = 72
    if params[:hours]
      @hours = hours(params[:hours]) ? hours(params[:hours]) : @hours
    end

    @model = find_class
    @metrics = @model.where(datetime: (Time.now - @hours.hours)..Time.now).group_by { |g| g.datetime.strftime "%Y-%m-%d" }
  end

  def show
    @metric = find_class.all.find(params[:id])
  end

  def new
    @metric = find_class.new
  end

  def edit
    @metric = find_class.find(params[:id])
  end

  def create redirect_path = root_path
    @metric = find_class.new(acceptable_params)
    if @metric.save
      redirect_to redirect_path
    else
      render :new
    end
  end

  def update redirect_path = root_path
    @metric = find_class.find(params[:id])

    if @metric.update(acceptable_params)
      redirect_to redirect_path
    else
      render :edit
    end
  end

  def destroy
    @metric = find_class.find(params[:id])
    @metric.destroy

    redirect_to root_path
  end

  private

  def find_class
    params[:controller].classify.constantize
  end

  def metrics_path
    send("#{@metric.class.name.underscore}s_path".to_sym)
  end

  def hours parameter
    return parameter.to_i if parameter.to_i > 0
  end
end
