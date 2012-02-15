module Watchable

  def self.included(model)
    #model.before_save :before_save_collection_association
    #model.after_save :update_watchers
    #model.after_update :autosave_associated_records_for_watchers
    #model.after_create :autosave_associated_records_for_watchers, :create_watchers
    #model.after_save :update_private
    
    #model.attr_accessible :watchers_ids, :watcher_ids
    #model.send :attr_writer, :watchers_ids
    
    model.has_many :watcher_tags, :as => :watchable, :class_name => 'Watcher', :dependent => :destroy
    #Make it obvious that autosave is acting here
    model.has_many :watchers, :through => :watcher_tags, :source => :user, :autosave => true
  end
  
  
      
  def add_watcher(user)
    unless user.nil? or has_watcher?(user)
      watcher = Watcher.new(:user_id => user[:id],
                            :context_id => self.context_id,
                            :context_type => self.context_type,
                            :watchable_id => self.id,
                            :watchable_type => self.class.to_s)
      true if watcher.save
    end
  end
  
  def add_watchers(users)
    users.each do |user|
      add_watcher(user)
    end
  end
  
  def has_watcher?(user)
    watchers(true).include? user
  end

  def remove_watcher(user)
    if has_watcher?(user)
      watchers = Watcher.where(:watchable_id => self[:id], :watchable_type => self.class, :user_id => user[:id])
      true if watchers.destroy_all
    end
  end
  
  def users_watching
    User.where(:id => watcher_ids)
  end

  def user_ids_watching
    users_watching.select(:id).map(&:id)
  end
  
end