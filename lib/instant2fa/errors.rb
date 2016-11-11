module Instant2fa
  module Errors
    class Instant2faError < StandardError
    end

    class MFANotEnabled < Instant2faError
    end

    class ValidationError < Instant2faError
    end

    class VerificationMismatch < Instant2faError
    end

    class VerificationFailed < Instant2faError
    end

    class BadDistinctID < Instant2faError
    end
  end
end
