class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation, :admin

  attr_accessor :password
  before_save :prepare_password

  has_many :ownerships
  has_many :accounts, :through => :ownerships, :uniq => true

  has_many :moves

  validates :username, :presence => true,
                        :uniqueness => true,
                        :length => { :minimum => 4, :maximum => 20 },
                        :format => { :with => /^[-\w\._@]+$/i }
  validates :password,  :presence => true, :on => :create,
                        :confirmation => true,
                        :length => { :minimum => 4, :maximum => 20 },
                        :allow_blank => true
  validates :email,     :format => { :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i },
                        :allow_blank => true

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end
end
