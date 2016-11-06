module Instant2FA
  module Errors
    class Instant2FAError < StandardError
    end

    class MFANotEnabled < Instant2FAError
    end

    class ValidationError < Instant2FAError
    end

    class VerificationMismatch < Instant2FAError
    end

    class VerificationFailed < Instant2FAError
    end
  end
end
