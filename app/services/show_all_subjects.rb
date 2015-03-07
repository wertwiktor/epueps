class ShowAllSubjects 

  def initialize(params, cookies)
    @params = params
    @cookies = cookies
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    save_current_scope
    scope == "popular" ? Subject.published.popular : Subject.published.recent
  end

  private

  def params
    @params
  end

  def cookies
    @cookies
  end

  def scope
    params[:order] || cookies[:order] || "recent"
  end

  def save_current_scope
    @cookies[:order] = scope
  end
end