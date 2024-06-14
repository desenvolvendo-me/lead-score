class InternalController < InheritedResources::Base
  layout 'internal'

  before_action :authenticate_user!
end
