require "#{Rails.root}/app/models/stories"
 
class Tasks::UpdatePV
  def self.execute
    Rails.logger.debug("Update PV ------ now --------")
    User.delete_all("hogehoge")
  end
 
end
