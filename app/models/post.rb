class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false
  field :tags, type: String

  validates_presence_of :body, :title

  belongs_to :user
  has_many :comments

  default_scope ne(archived: true)

  def archive!
    update_attribute :archived, true
  end

  def tags_array
    tags.split(',').map &:strip if tags
  end

end
