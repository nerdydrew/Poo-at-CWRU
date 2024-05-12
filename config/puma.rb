require "openssl"

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port        ENV.fetch("PORT") { 3000 }

# Use a self-signed certificate in development. This allows testing CWRU's CAS server,
# which requires requests to come from HTTPS.
certificate_file = "config/certificate/certificate.pem"
private_key_file = "config/certificate/private_key.pem"

# Generate a self-signed certificate if one does not already exist.
unless File.file?(private_key_file) && File.file?(certificate_file)
  key = OpenSSL::PKey::RSA.new 2048
  File.write private_key_file, key.private_to_pem

  certificate = OpenSSL::X509::Certificate.new
  certificate.version = 2
  certificate.serial = 0
  certificate.not_before = Time.now
  certificate.not_after = Time.now + 10.years
  certificate.public_key = key.public_key
  certificate.subject = OpenSSL::X509::Name.parse "/CN=pooatcwru.com"
  extension_factory = OpenSSL::X509::ExtensionFactory.new nil, certificate
  certificate.add_extension \
    extension_factory.create_extension("basicConstraints", "CA:FALSE", true)
  certificate.add_extension \
    extension_factory.create_extension(
      "keyUsage", "keyEncipherment,dataEncipherment,digitalSignature")
  certificate.add_extension \
    extension_factory.create_extension("subjectKeyIdentifier", "hash")
  certificate.issuer = certificate.subject
  certificate.sign key, OpenSSL::Digest.new("SHA256")
  File.write certificate_file, certificate.to_pem
end

ssl_bind "0.0.0.0", 3001, {
  key: private_key_file,
  cert: certificate_file,
  verify_mode: "none"
}

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
