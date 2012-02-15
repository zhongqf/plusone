class InitialTables < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :permalink
      t.string :logo_file_name
      t.string :logo_content_type
      t.integer :logo_file_size
      t.datetime :logo_updated_at
      t.text :login_instruction
      t.string :default_language
      t.string :default_time_zone
      t.text :description
      t.text :settings
      t.string :domain
      t.timestamps
    end
    
    create_table :groups do |t|
      t.integer :user_id
      t.integer :company_id
      t.string :name
      t.string :permalink
      t.boolean :is_archived
      t.boolean :is_public
      t.text :description
      t.text :settings
      t.timestamps
    end
    
    create_table :users do |t|
      t.string :identity
      #t.boolean :admin, :default => false, :null => false
      
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      
      ## Rememberable
      t.datetime :remember_created_at
      
      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      
      ## Encryptable
      # t.string :password_salt
      
      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable
      
      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at
      
      # Token authenticatable
      # t.string :authentication_token
      
      t.timestamps

    end    
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true

    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true

    create_table :profiles do |t|
      t.integer :user_id
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :name
      t.text :bio
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at

      t.timestamps
    end

    create_table :contact_items do |t|
      t.integer :profile_id
      t.integer :contact_type
      t.string :value
      t.string :note

      t.timestamps
    end

    create_table :people do |t|
      t.integer :user_id
      t.integer :company_id
      t.boolean :is_employee
      t.boolean :is_admin
      
      t.timestamps
    end
    

    
    create_table :members do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :member_type
      t.timestamps
    end

    create_table :activities do |t|
      t.integer :company_id 
      t.string :context_type
      t.integer :context_id
      t.integer :user_id
      t.string :action
      t.string :target_type
      t.integer :target_id
      t.string :link_object_type 
      t.integer :link_object_id
      t.string :note
      t.timestamps
    end

    create_table :conversations do |t|
      t.integer :company_id
      t.integer :user_id
      t.string :context_type
      t.integer :context_id
      t.string :title
      
      t.integer :comments_count
      t.integer :last_comment_id
      
      t.boolean :is_public
      t.boolean :is_simple
      t.timestamps
    end

    
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :context_id
      t.string :context_type
      t.integer :user_id
      t.text :body
      t.text :body_html
      t.boolean :is_public, :default => true, :null => false
      t.text :extrainfo
      t.timestamps
    end
  end
end
