class Profile

  AvatarSizes = {
    :micro    => [24, 24],
    :icon    => [48, 48],
    :thumb   => [100, 100],
    :profile  => [278, 500]
  }

  has_attached_file :avatar, 
    :url  => "/system/avatars/:id/:style.png",
    :path => ":rails_root/public/system/avatars/:id/:style.png",
    :styles => AvatarSizes.each_with_object({}) { |(name, size), all|
        all[name] = ["%dx%d%s" % [size[0], size[1], size[0] < size[1] ? '>' : '#'], :png]
      },
    :default_url => "missing_:style.png"

  attr_accessible :avatar, :avatar_destroy

  validates_attachment_size :avatar, :less_than => 2.megabytes
  validates_attachment_content_type :avatar,
    :content_type => %w[image/jpeg image/pjpeg image/png image/x-png image/gif]
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end
  
  def avatar_url(size= :thumb, secure = false)
    avatar.url(size).tap do |url|
      url.sub! 'http:', 'https:' if secure
    end
  end
  
  def avatar_destroy
    false
  end
  
  def avatar_destroy=(value)
    self.avatar = nil if value and value != '0'
  end

end
