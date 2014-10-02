class Admin::SortAndFilterData

  def initialize(model, params)
    @model = model
    @params = params
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    all_or_searched_users
  end

  def params
    @params
  end

  private

  def all_or_searched_users
    unless params[:search].nil?
      @model.where('email ~* :pattern', pattern: params[:search]) 
    else
      get_sorted_users
    end
  end

  def sort_column
    params[:sort] if @model.column_names.include?(params[:sort])
  end

  def sort_direction
    params[:direction] if %{asc desc}.include?(params[:direction])
  end

  
  def get_sorted_users
    unless sort_column.nil?
      return @model.order(sort_column + " " + sort_direction)
    else
      return @model.all
    end
  end
end
