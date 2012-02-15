# == Schema Information
#
# Table name: activities
#
#  id               :integer(4)      not null, primary key
#  company_id       :integer(4)
#  context_type     :string(255)
#  context_id       :integer(4)
#  user_id          :integer(4)
#  action           :string(255)
#  target_type      :string(255)
#  target_id        :integer(4)
#  link_object_type :string(255)
#  link_object_id   :integer(4)
#  note             :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

# what happened             | where        | what   | whom     | about          |
#                           | context_type | action | target   | link_object    |
# new user                  | company      | create | user     | nil            |
# new group                 | company      | create | group    | nil            |
# post                      | user         | create | comment  | nil            |
# comment on post of user a | user a       | create | comment  | comment_source |
# start conversation        | group        | create | comment  | nil            |
# comment on conversation   | group        | create | comment  | comment_source |
# a watch user b            | user b       | create | watching | nil            |
# a watch group c           | group        | create | watching | nil            |


class Activity < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :company
  belongs_to :context, :polymorphic => true
  belongs_to :target, :polymorphic => true
  belongs_to :link_object, :polymorphic => true
  
  scope :in_company, lambda {|company| where(:company_id => company.id )}
  scope :of_user, lambda {|user| where(:user_id => user.id )}
  scope :in_context, lambda {|context| where(:context_id => context.id, :context_type => context.class.to_s )}
  scope :in_target, lambda {|target| where(:target_id => target.id, :target_type => target.class.to_s )}
  
  scope :type_of, lambda{|type| where(:target_type => type.to_s )}
  
  def self.log(context, target, action, user)
    
    activity = Activity.new(
      :context => context,
      :user => user,
      :target => target,
      :action => action
    )
    
    if target.is_a? Comment
      activity.link_object = target.commentable
    end
    
    activity.created_at = case action
      when 'create'
        target.try(:created_at)
      when 'edit'
        target.try(:updated_at)
      when 'delete'
        target.try(:deleted_at) || target.try(:updated_at)
      end || target.try(:created_at) || Time.now
      
    activity.save
    activity
  end
  
end
