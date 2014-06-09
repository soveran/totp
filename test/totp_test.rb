require_relative "../lib/totp"

test "normal usage" do
  secret = TOTP.secret

  # Secret is a string of size 16
  assert_equal 16, secret.size
  assert_equal String, secret.class

  # Secret should be different on each call
  assert secret != TOTP.secret

  passwords = TOTP.passwords(secret)

  # Passwords should be unique
  assert_equal passwords.size, passwords.uniq.size

  # Passwords should be valid
  passwords.each do |pass|
    assert TOTP.valid?(secret, pass)
  end
end

test "usage with known values" do
  secret = "AAAAAAAAAAAAAAAA"
  time   = 1400000000
  known  = [306281, 553572, 304383]

  # Accepts an optional argument for time
  passwords = TOTP.passwords(secret, time)

  # Accepts an optional argument for time
  assert TOTP.valid?(secret, known[0], time)

  assert_equal known, passwords
end
