require 'openssl'
require 'base32'

module TOTP

  # Generate a random secret
  def self.secret
    return Base32.encode((0...10).map { rand(255).chr }.join)
  end

  # Return whether or not the key is valid for the given secret
  def self.valid?(secret, pass, time = Time.now)
    return self.passwords(secret, time).include?(pass)
  end

  def self.totp(hmac, time)
    bytes = [time].pack('>q').reverse

    hmac.reset
    hmac.update(bytes)

    code = hmac.digest
    offs = code[-1].ord & 0x0F
    hash = code[offs...offs + 4]

    pass = hash.reverse.unpack('L')[0]
    pass &= 0x7FFFFFFF
    pass %= 1000000

    return pass
  end

  # Generate passwords based on the secret and time
  def self.passwords(secret, time = Time.now)

    interval = time.to_i / 30

    hmac = OpenSSL::HMAC.new(
      Base32.decode(secret),
      OpenSSL::Digest::SHA1.new,
    )

    # Cover three 30 second intervals
    return [
      totp(hmac, interval.pred),
      totp(hmac, interval),
      totp(hmac, interval.succ),
    ]
  end
end
