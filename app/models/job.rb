class Job < ActiveRecord::Base

  validates_presence_of :title
  validates_presence_of :job_type
  validates_presence_of :company_name
  validates_presence_of :occupation
  validates_presence_of :location
  validates_presence_of :description
  validates_presence_of :apply_information
  validates_presence_of :owner

  validates_format_of :description, with: /(ruby|rails)/i, message: "Doesn't seem to be a Ruby or Rails related job"

  JOB_TYPE   = ['Full-time', 'Part-time', 'Contract', 'Internship', 'Other']
  OCCUPATION = ['Web back-end', 'Web front-end', 'Web-design', 'QA/Testing', 'Other']

  validates_inclusion_of :job_type, in: JOB_TYPE
  validates_inclusion_of :occupation, in: OCCUPATION

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  before_validation :set_aasm_state, on: :create
  before_validation :set_deadline

  scope :published, -> { where(aasm_state: 'published') }
  scope :online,    -> { published.where('deadline is NULL or deadline > ?', Date.today) }
  scope :recent,    -> { order(id: :desc) }

  def open
    self.aasm_state = 'published'
  end

  def close
    self.aasm_state = 'closed'
  end

  def closed?
    aasm_state == 'closed'
  end

  def to_param
    "#{id}-#{title} #{company_name}".to_slug.normalize.to_s
  end

  def social_link_url
    CGI.escape "http://jobs.ruby.tw/jobs/#{to_param}"
  end

  def social_link_title
    CGI.escape title
  end

  def social_link_content
    "#{social_link_title} #{social_link_url}"
  end

  def deadline_forever
    @deadline_forever ||= !deadline
  end

  def owned_by?(user)
    user && owner == user
  end

  private

  def set_deadline
    self.deadline = nil if deadline_forever == '1'
  end

  def set_aasm_state
    self.aasm_state = 'published'
  end

end
