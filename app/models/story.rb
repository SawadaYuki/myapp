class Story < ActiveRecord::Base
  belongs_to :user
  has_many :englishcomments, dependent: :destroy
  has_many :many_englishcomment,:through => :englishcomments
  accepts_nested_attributes_for :englishcomments, allow_destroy: true 


  #presence: true 空はだめ
  validates :title,presence: true,uniqueness: true
  validates :situation,presence: true
  validates :humantype1,presence: true
  validates :story_ja,presence: true,uniqueness: true


  serialize :story_ja
  serialize :story_en

  is_impressionable # PV

  #validates_acceptance_of :confirming
  #after_validation :check_confirming


  #scope :unfinished, ->{ where(done: false)}

  #attr_accessor :flag

  #def flag=(val)
  #	@flag=val
  #end

  # as: :adminを付けたattr_accessibleメゾットを記述することで管理者が変更できる属性を指定
  # attr_accessible :title,:situation,:humantype1,:humantype2,:story_ja,:story_en,as: :admin

end
