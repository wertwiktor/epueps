class SortedAndFilteredData 

  attr_reader :sort_column, :sort_direction, :search, :object

  def initialize(object, params)
    @object = object
    @sort_column = params[:sort]
    @sort_direction = params[:direction]
    @search = params[:search] 
  end

  def method_missing(method, *args)
    return @object.send(method, *args) if @object.respond_to?(method)
    super
  end
end