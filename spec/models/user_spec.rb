require 'rails_helper'

describe User do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @job  = FactoryGirl.create(:job)
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:jobs) }

  it "#email returns a string" do
    expect(@user.email).to match 'test@example.com'
  end

  it "#jobs returns a collection" do
    expect(@user.jobs.first).to be_a Job
    expect(@user.jobs.first.id).to eq(@job.id)
  end
end
