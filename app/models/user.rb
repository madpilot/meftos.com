class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.act_like_restful_authentication = true
    c.transition_from_restful_authentication = true
  end
end
