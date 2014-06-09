# Time-based One-Time Passwords

This is an implementation of a Time-Based One-Time Password
Algorithm compatible with Google Authenticator. You can read more
about TOTP at http://tools.ietf.org/html/rfc6238.

## Usage

Passwords are derived from a secret and a time. You can use the
`TOTP.secret` function to obtain a new, random secret.

``` ruby
TOTP.secret #=> "YYZ27CO4WZTPZAYX"
```

This helper is handy if you want to implement 2 factor
authentication in your application.

In order to generate time based one time passwords, you can use
the `TOTP.passwords` function:

``` ruby
# Using the secret "AAAAAAAAAAAAAAAA" and the current time
TOTP.passwords("AAAAAAAAAAAAAAAA") #=> [783743, 17086, 955099]
```

You can also provide a specific time or timestamp:

``` ruby
# Using the same secret and a timestamp
passwords = TOTP.passwords("AAAAAAAAAAAAAAAA", 1400000000)

assert_equal [306281, 553572, 304383], passwords #=> true
```

To check the validity of a given password, you can use the
`TOTP.valid?` function:

``` ruby
TOTP.valid?(secret, password)
```

If you want to check if a password was valid at a particular time,
you can provide a time object or a timestamp as a third argument:

``` ruby
TOTP.valid?(secret, password, time)
```

## Installation

      $ gem install totp

### Acknowledgments

This library is inspired by the following implementations:

- https://gist.github.com/bithive/987839
- https://github.com/nricciar/google_authenticator_auth
