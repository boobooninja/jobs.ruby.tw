require 'rails_helper'

# RSpec.describe Job, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end


describe Job do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @job  = FactoryGirl.create(:job)
  end

  subject { @job }

  it { should respond_to(:title) }
  it { should respond_to(:job_type) }
  it { should respond_to(:company_name) }
  it { should respond_to(:url) }
  it { should respond_to(:occupation) }
  it { should respond_to(:location) }
  it { should respond_to(:description) }
  it { should respond_to(:apply_information) }
  it { should respond_to(:owner) }
  it { should respond_to(:aasm_state) }

  it "#title returns a string" do
    expect(@job.title).to match 'Ruby Developer'
  end

  it "#aasm_state should be 'published' by default" do
    expect(@job.aasm_state).to eq('published')
  end

  it "#open sets aasm_state to 'published'" do
    @job.open
    expect(@job.aasm_state).to match 'published'
  end

  it "#close sets aasm_state to 'closed'" do
    @job.close
    expect(@job.aasm_state).to match 'closed'
  end

  it "#closed? returns true if aasm_state == 'closed' else false" do
    @job.close
    expect(@job.closed?).to eq(true)
  end

  it "#to_param returns a string" do
    expect(@job.to_param).to eq('1-ruby-developer-acme-corp')
  end

  it "#social_link_url returns an escaped url" do
    expect(@job.social_link_url).to eq('http%3A%2F%2Fjobs.ruby.tw%2Fjobs%2F1-ruby-developer-acme-corp')
  end

  it "#social_link_title returns an escaped title" do
    expect(@job.social_link_title).to eq('Ruby+Developer')
  end

  it "#social_link_content returns a string" do
    expect(@job.social_link_content).to eq('Ruby+Developer http%3A%2F%2Fjobs.ruby.tw%2Fjobs%2F1-ruby-developer-acme-corp')
  end

  it "#deadline_forever returns deadline_forever and / or sets it" do
    expect(@job.deadline_forever).to eq(false)
  end

  it "#owned_by? returns true if user is owner else false" do
    expect(@job.owned_by?(@user)).to eq(true)
    expect(@job.owned_by?(User.new(email: 'test@invalid.com'))).to eq(false)
  end
end
