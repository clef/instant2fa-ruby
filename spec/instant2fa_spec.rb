require "spec_helper"

describe Instant2fa do
  DISTINCT_ID = '12345'

  it "has a version number" do
    expect(Instant2fa::VERSION).not_to be nil
  end

  xit "retrives a hosted settings page for a distinct_id" do
    url = Instant2fa.create_settings(DISTINCT_ID)
    expect(url).to match(/http:\/\/localhost\:4201\/users\//)
  end

  xit "raises an exception if the user has not enabled mfa" do
    expect {
      Instant2fa.create_verification("nomfa")
    }.to raise_error(Instant2fa::Errors::MFANotEnabled)
  end

  xit "retrives a hosted verification page for a distinct_id" do
    url = Instant2fa.create_verification(DISTINCT_ID)
    expect(url).to match(/http:\/\/localhost\:4201\/verification-requests\//)
  end

  xit "confirms a valid verification" do
    result = Instant2fa.confirm_verification(DISTINCT_ID, 'tok_2d4b459bec1f465392310abec379f806')
    expect(result).to be(true)
  end
end
