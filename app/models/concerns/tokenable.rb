module Tokenable
  extend ActiveSupport::Concern
  BASE58_ALPHABET = ('0'..'9').to_a  + ('A'..'Z').to_a + ('a'..'z').to_a - ['0', 'O', 'I', 'l']

  module ClassMethods
    def has_secure_token(attribute = :token)
      # Load securerandom only when has_secure_token is used.
      require 'securerandom'
      define_method("regenerate_#{attribute}") { update! attribute => self.class.generate_unique_secure_token(24) }
      before_create { self.send("#{attribute}=", self.class.generate_unique_secure_token(24)) unless self.send("#{attribute}?")}

    end

    def generate_unique_secure_token(n = 16)
      SecureRandom.random_bytes(n).unpack("C*").map do |byte|
        idx = byte % 64
        idx = SecureRandom.random_number(58) if idx >= 58
        BASE58_ALPHABET[idx]
      end.join
    end
  end
end